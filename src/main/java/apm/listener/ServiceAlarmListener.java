package apm.listener;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.net.MalformedURLException;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

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

import apm.util.Constants;
import apm.util.PropertiesUtil;
import apm.util.SystemUtil;

/**
 * @author 服务报警监控
 *
 */
public class ServiceAlarmListener implements ServletContextListener {

	private JdbcTemplate jdbcTemplate;
	// 推送消息时间间隔(ms)
	private static int interval = Integer.parseInt(PropertiesUtil.getValue("alarm", "alarm.interval"));
	// 定时任务
	private Timer timer = null;

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
			List<ServiceNorm> list = getAllService();
			for (ServiceNorm serviceNorm : list) {
				String serviceUrl = SystemUtil.getJmxUrl(serviceNorm.getServiceAddress(), serviceNorm.getMonitorPort());
				long memoryUsage = getMem(serviceUrl) / 1024L / 1024;
				if (memoryUsage >= serviceNorm.getNormValue()) {
					System.out.println(serviceNorm.getServiceName() + ":" + memoryUsage + "M");
					systemLog(memoryUsage, Constants.SYSTEM_NORM_MEM, serviceNorm.getServiceName(), serviceNorm.getNormValue());
				}
				alarm();
			}
		}
	};


	/**
	 * 获取系统已使用内存
	 * 
	 * @param info
	 * @param norm
	 * @return
	 * @throws IOException 
	 * @throws MalformedURLException 
	 */
	private long getMem(String serviceUrl) {
		JMXConnector jmxConnector;
		try {
			jmxConnector = JMXConnectorFactory.connect(new JMXServiceURL(serviceUrl));
		} catch (IOException e) {
			return 0;
		}
		MBeanServerConnection mBeanServerConnection;
		try {
			mBeanServerConnection = jmxConnector.getMBeanServerConnection();
			// 获取内存信息
			MemoryMXBean memoryMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
					ManagementFactory.MEMORY_MXBEAN_NAME, MemoryMXBean.class);
			// 堆内存信息
			MemoryUsage heapMemoryUsage = memoryMXBean.getHeapMemoryUsage();
			// 非堆内存信息
			MemoryUsage nonHeapMemoryUsage = memoryMXBean.getNonHeapMemoryUsage();
			return heapMemoryUsage.getUsed() + nonHeapMemoryUsage.getUsed();
		} catch (IOException e) {
			return 0;
		}
	}


	/**
	 * 添加系统报警日志
	 *
	 * @param value
	 * @param type
	 * @param systemName
	 */
	private void systemLog(double value, int type, String systemName, int norm) {
		String desc = systemName + "：内存" + "负载超标,当前指标：" + norm + "MB,当前负载：" + value + "MB";
		insertSystemLog(value, type, systemName, desc);
	}

	/**
	 * 向用户报警
	 * 
	 * @param type
	 * @return
	 */
	private void alarm() {
	}

	/**
	 * 获取所有服务
	 * 
	 * @return List<ServiceEntity>
	 */
	public List<ServiceNorm> getAllService() {
		String sql = "select a.id," +
			       " a.service_name," +
			       " a.service_address," +
			       " a.monitor_port," +
			       " b.alarm_policy_level," +
			       " (case" +
			       " when b.alarm_policy_level = 1 then" +
			       " c.norm_normal" +
			       " when b.alarm_policy_level = 2 then" +
			       " c.norm_warning" +
			       " else" +
			       "  c.norm_danger" +
			       " end) norm_value" +
			       " from apm_service_info a" +
			       " join apm_alarm_policy b on a.alarm_policy_id = b.id" +
			       " join apm_norm c on a.norm_id = c.id" +
			       " where b.send_flag = 1";
		List<ServiceNorm> list = (List<ServiceNorm>) jdbcTemplate.query(sql,
				new BeanPropertyRowMapper<ServiceNorm>(ServiceNorm.class));
		return list;
	}

	/**
	 * 写入报警日志
	 * 
	 * @param type
	 */
	private void insertSystemLog(double value, int type, String systemName, String desc) {
		String sql = "insert into apm_alarm_log(" + "id," + "alarm_value," + "alarm_time," + "alarm_type,"
				+ "alarm_system_name," + "alarm_desc" + ") values(APM_ALARM_LOG_SEQ.Nextval,?, SYSDATE,?,?,?)";
		jdbcTemplate.update(sql, new Object[]{value, type, systemName, desc});
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
	
	public static class ServiceNorm {
		private Integer id;
		private String serviceName;
		private String serviceAddress;
		private String monitorPort;
		private Integer alarmPolicyLevel;
		private Integer normValue;
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getServiceName() {
			return serviceName;
		}
		public void setServiceName(String serviceName) {
			this.serviceName = serviceName;
		}
		public String getServiceAddress() {
			return serviceAddress;
		}
		public void setServiceAddress(String serviceAddress) {
			this.serviceAddress = serviceAddress;
		}
		public String getMonitorPort() {
			return monitorPort;
		}
		public void setMonitorPort(String monitorPort) {
			this.monitorPort = monitorPort;
		}
		public Integer getAlarmPolicyLevel() {
			return alarmPolicyLevel;
		}
		public void setAlarmPolicyLevel(Integer alarmPolicyLevel) {
			this.alarmPolicyLevel = alarmPolicyLevel;
		}
		public Integer getNormValue() {
			return normValue;
		}
		public void setNormValue(Integer normValue) {
			this.normValue = normValue;
		}
	}
}
