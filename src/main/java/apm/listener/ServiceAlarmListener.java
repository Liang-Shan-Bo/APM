package apm.listener;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
			//遍历所有服务
			for (ServiceNorm serviceNorm : list) {
				String serviceUrl = SystemUtil.getJmxUrl(serviceNorm.getServiceAddress(), serviceNorm.getMonitorPort());
				long memoryUsage = getMem(serviceUrl) / 1024L / 1024;
				if (memoryUsage >= serviceNorm.getNormValue()) {
					System.out.println(serviceNorm.getServiceName() + ":" + memoryUsage + "M");
					//添加日志
					Date now = new Date();
					String desc = serviceNorm.getServiceName() + "：内存" + "负载超标,当前指标：" + serviceNorm.getNormValue() + "MB,当前负载：" + memoryUsage + "MB";
					long logId = insertSystemLog(memoryUsage, Constants.SYSTEM_NORM_MEM, now, serviceNorm.getServiceName(), desc);
					//发送报警信息
					alarm(logId, serviceNorm.getAlarmPolicyId(), serviceNorm.getServiceName(), now, desc);
				}
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
			//测试服务是否开启
			jmxConnector = JMXConnectorFactory.connect(new JMXServiceURL(serviceUrl), Constants.map);
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
	 * 向用户报警
	 * 
	 * @param type
	 * @return
	 */
	private void alarm(long alarmLogId, long policyId, String systemName, Date now, String desc) {
		List<Long> list = getUserIds(policyId);
		Date lastDate = getLastAlarmTime(systemName);
		if (lastDate == null || (now.getTime() - lastDate.getTime()) > 600000) {
			for (Long userId : list) {
				insertAlarmMessage(alarmLogId, userId, systemName, now, desc);
			}
		}
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
				       " a.alarm_policy_id," +
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
				       " join apm_norm c on a.norm_id = c.id";
		List<ServiceNorm> list = (List<ServiceNorm>) jdbcTemplate.query(sql,
				new BeanPropertyRowMapper<ServiceNorm>(ServiceNorm.class));
		return list;
	}

	/**
	 * 写入报警日志
	 * 
	 * @param type
	 */
	private long insertSystemLog(double value, int type, Date now, String systemName, String desc) {
		String sql = "insert into apm_alarm_log(" + 
						"id," + 
						"alarm_value," + 
						"alarm_time," + 
						"alarm_type," + 
						"alarm_system_name," + 
						"alarm_desc" + 
						") values(APM_ALARM_LOG_SEQ.Nextval, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, new Object[]{value, now, type, systemName, desc});
		return getSystemLogId(now, systemName);
	}
	
	/**
	 * 获取日志ID
	 * 
	 * @param type
	 */
	private long getSystemLogId(Date now, String systemName) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sql = "select id " +
						"from apm_alarm_log " +
						"where alarm_time=to_date(?,'yyyy-mm-dd hh24:mi:ss') " +
						"and alarm_system_name=?";
		long id = (Long) jdbcTemplate.queryForObject(sql, new Object[]{format.format(now), systemName}, Long.class);
		return id;
	}
	
	/**
	 * 根据策略ID获取发送报警信息角色列表
	 * 
	 * @param type
	 */
	private List<Long> getUserIds(long policyId) {
		String sql = "select a.user_id " + 
						"from apm_alarm_policy t " + 
						"join apm_policy_user a " +
						"on a.alarm_policy_id = t.id " + 
						"where t.id = ?"; 
		List<Long> list = (List<Long>) jdbcTemplate.queryForList(sql, new Object[]{policyId}, Long.class);
		return list;
	}
	
	/**
	 * 写入报警信息
	 * 
	 * @param type
	 */
	private void insertAlarmMessage(long alarmLogId, long userId, String systemName, Date now, String desc) {
		String sql = "insert into apm_alarm_send(" + 
						"id," + 
						"alram_log_id," + 
						"user_id," + 
						"send_time," + 
						"read_flag," + 
						"title," + 
						"message" + 
						") values(APM_ALARM_SEND_SEQ.Nextval, ?, ?, ?, 0, ?, ?)";
		jdbcTemplate.update(sql, new Object[]{alarmLogId, userId, now, systemName + "负载超标", desc});
	}
	
	/**
	 * 获取上次报警时间
	 * 
	 * @param type
	 */
	private Date getLastAlarmTime(String systemName) {
		String sql = "select max(b.alarm_time) " +
						"from apm_alarm_send a " +
						"join apm_alarm_log b on b.id = a.alram_log_id " +
						"where b.alarm_system_name = ?";
		Date date = (Date) jdbcTemplate.queryForObject(sql, new Object[]{systemName}, Date.class);
		return date;
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
	
	public static class ServiceNorm {
		//服务ID
		private Long id;
		//服务名称
		private String serviceName;
		//服务IP地址
		private String serviceAddress;
		//监控端口
		private String monitorPort;
		//报警等级
		private Integer alarmPolicyLevel;
		//策略ID
		private Long alarmPolicyId; 
		//指标
		private Integer normValue;
		
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
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public Long getAlarmPolicyId() {
			return alarmPolicyId;
		}
		public void setAlarmPolicyId(Long alarmPolicyId) {
			this.alarmPolicyId = alarmPolicyId;
		}
	}
}
