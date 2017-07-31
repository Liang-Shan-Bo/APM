package apm.listener;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.OperatingSystemMXBean;
import java.net.MalformedURLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

import javax.management.MBeanServerConnection;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;

import apm.entity.chart.ChartEntity;
import apm.util.Constants;
import apm.util.SystemUtil;

/**
 * @author 图表统计
 *
 */
public class ChartListener implements ServletContextListener {

	private JdbcTemplate jdbcTemplate;
	// 记录时间间隔(ms)
	private static long interval = 1800000L;
	// 定时任务
	private Timer timer = null;
	// 获取CPU时间间隔
	private static long cpuInterval = 1000L;

	private DecimalFormat df = new DecimalFormat("#0.00");

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(context);
		jdbcTemplate = (JdbcTemplate) ctx.getBean("jdbcTemplate");
		timer = new Timer(true);
		timer.schedule(task, 0, interval);
	}

	/**
	 * 心跳任务
	 */
	TimerTask task = new TimerTask() {
		public void run() {
			List<ChartEntity> list = getAllChartEntity();
			Date now = new Date();
			// 遍历所有服务
			for (ChartEntity chartEntity : list) {
				chartEntity = getValues(chartEntity);
				// 记录统计
				createCharts(chartEntity, now);
			}
		}
	};

	/**
	 * 获取系统统计信息
	 * 
	 * @param info
	 * @param norm
	 * @return
	 * @throws IOException
	 * @throws MalformedURLException
	 */
	private ChartEntity getValues(ChartEntity chartEntity) {
		JMXConnector jmxConnector = null;
		String chartEntityUrl = SystemUtil.getJmxUrl(chartEntity.getServiceAddress(), chartEntity.getMonitorPort());
		try {
			// 测试服务是否开启
			jmxConnector = JMXConnectorFactory.connect(new JMXServiceURL(chartEntityUrl), Constants.map);
			MBeanServerConnection mBeanServerConnection = jmxConnector.getMBeanServerConnection();
			OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.newPlatformMXBeanProxy(
					mBeanServerConnection, ManagementFactory.OPERATING_SYSTEM_MXBEAN_NAME, OperatingSystemMXBean.class);
			// 获取CPU信息
			long start = System.currentTimeMillis();
			long startC = (long) mBeanServerConnection.getAttribute(operatingSystemMXBean.getObjectName(),
					"ProcessCpuTime");
			TimeUnit.MILLISECONDS.sleep(cpuInterval);
			long end = System.currentTimeMillis();
			long endC = (long) mBeanServerConnection.getAttribute(operatingSystemMXBean.getObjectName(),
					"ProcessCpuTime");
			int availableProcessors = operatingSystemMXBean.getAvailableProcessors();
			double ratio = (endC - startC) / 1000000.0 / (end - start) / availableProcessors;
			// 获取内存信息
			MemoryMXBean memoryMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
					ManagementFactory.MEMORY_MXBEAN_NAME, MemoryMXBean.class);
			long mem = memoryMXBean.getHeapMemoryUsage().getUsed() + memoryMXBean.getNonHeapMemoryUsage().getUsed();
			chartEntity.setCpuPercentage(df.format(ratio * 100D));
			chartEntity.setMemoryUsed(mem / 1024L / 1024);
			return chartEntity;
		} catch (Exception e) {
			chartEntity.setCpuPercentage("0.00");
			chartEntity.setMemoryUsed(0L);
			return chartEntity;
		} finally {
			try {
				if (jmxConnector != null) {
					jmxConnector.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 获取所有服务
	 * 
	 * @return List<ChartEntityEntity>
	 */
	public List<ChartEntity> getAllChartEntity() {
		String sql = "select a.id," + 
						" a.service_name," + 
						" a.service_address," + 
						" a.monitor_port" + 
						" from apm_service_info a";
		List<ChartEntity> list = (List<ChartEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<ChartEntity>(
				ChartEntity.class));
		return list;
	}

	/**
	 * 增加统计数据
	 * 
	 * @return List<ChartEntityEntity>
	 */
	public void createCharts(ChartEntity chartEntity, Date now) {
		String sql = "insert into apm_chart(" + 
						"id," + 
						"create_time," + 
						"service_id," + 
						"cpu," + 
						"mem" + 
						") values(APM_CHART_SEQ.Nextval, ?, ?, ?, ?)";
		jdbcTemplate.update(sql,
				new Object[] { now, chartEntity.getId(), chartEntity.getCpuPercentage(), chartEntity.getMemoryUsed() });
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
}
