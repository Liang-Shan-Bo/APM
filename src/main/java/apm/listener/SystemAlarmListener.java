package apm.listener;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;

import apm.entity.system.DiskEntity;
import apm.entity.system.SystemInfo;
import apm.util.Constants;
import apm.util.PropertiesUtil;

/**
 * @author 系统报警监控
 *
 */
public class SystemAlarmListener implements ServletContextListener {

	private JdbcTemplate jdbcTemplate;
	// 推送消息时间间隔(ms)
	private static int interval = Integer.parseInt(PropertiesUtil.getValue("alarm", "alarm.interval"));
	// 发送报警消息时间间隔(ms)
	private static int sendMessage = Integer.parseInt(PropertiesUtil.getValue("alarm", "message.interval"));
	// 定时任务
	private Timer timer = null;
	// 保留小数后2位
	private static DecimalFormat df = new java.text.DecimalFormat("#.00");

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
			// 判断是否报警
			if (isAlarm()) {
				if (SystemListener.sysInfoList.size() > 0) {
					SystemInfo info = SystemListener.sysInfoList.get(SystemListener.sysInfoList.size() - 1);
					double cpu = checkCpu(info);
					int cpuNorm = getNormByNormType(Constants.SYSTEM_NORM_CPU);
					Date now = new Date();
					if (cpu >= cpuNorm) {
						System.out.println("cpu:" + cpu + "%");
						//添加日志
						String desc = setMessage(cpu, Constants.SYSTEM_NORM_CPU, "操作系统", cpuNorm);
						long logId = insertSystemLog(cpu, Constants.SYSTEM_NORM_CPU, now, "操作系统", desc);
						//发送报警信息
						alarm(logId, now, desc);
					}
					double mem = checkMem(info);
					int memNorm = getNormByNormType(Constants.SYSTEM_NORM_MEM);
					if (mem >= memNorm) {
						System.out.println("mem:" + mem + "M");
						//添加日志
						String desc = setMessage(mem, Constants.SYSTEM_NORM_MEM, "操作系统", memNorm);
						long logId = insertSystemLog(mem, Constants.SYSTEM_NORM_MEM, now, "操作系统", desc);
						//发送报警信息
						alarm(logId, now, desc);
					}
					double disk = checkDisk(info);
					int diskNorm = getNormByNormType(Constants.SYSTEM_NORM_DIS);
					if (disk >= diskNorm) {
						System.out.println("disk:" + disk + "%");
						//添加日志
						String desc = setMessage(disk, Constants.SYSTEM_NORM_DIS, "操作系统", diskNorm);
						long logId = insertSystemLog(disk, Constants.SYSTEM_NORM_DIS, now, "操作系统", desc);
						//发送报警信息
						alarm(logId, now, desc);
					}
					double net = checkNet(info);
					int netNorm = getNormByNormType(Constants.SYSTEM_NORM_NET);
					if (net >= netNorm) {
						System.out.println("net:" + net + "K");
						//添加日志
						String desc = setMessage(net, Constants.SYSTEM_NORM_NET, "操作系统", netNorm);
						long logId = insertSystemLog(net, Constants.SYSTEM_NORM_NET, now, "操作系统", desc);
						//发送报警信息
						alarm(logId, now, desc);
					}
				}
			}
		}
	};

	/**
	 * 获取当前CPU参数
	 * 
	 * @param info
	 * @param norm
	 * @return
	 */
	private double checkCpu(SystemInfo info) {
		double total = 0D;
		List<Double> list = info.getUsers();
		for (Double cpuPer : list) {
			total += cpuPer;
		}
		return Double.parseDouble(df.format(total / list.size()));
	}

	/**
	 * 获取当前内存参数
	 * 
	 * @param info
	 * @param norm
	 * @return
	 */
	private double checkMem(SystemInfo info) {
		return info.getUseMem();
	}

	/**
	 * 获取当前磁盘参数
	 * 
	 * @param info
	 * @param norm
	 * @return
	 */
	private double checkDisk(SystemInfo info) {
		double disk = 0D;
		List<DiskEntity> list = info.getDisks();
		for (DiskEntity diskEntity : list) {
			disk += diskEntity.getUsePercent();
		}
		return Double.parseDouble(df.format(disk / list.size()));
	}

	/**
	 * 获取当前网络参数
	 * 
	 * @param info
	 * @param norm
	 * @return
	 */
	private double checkNet(SystemInfo info) {
		return info.getTotalBytes() / 1024;
	}
	
	/**
	 * 详细信息
	 *
	 * @param value
	 * @param type
	 * @param systemName
	 */
	private String setMessage(double value, int type, String systemName, int norm) {
		String desc = "";
		switch (type) {
			case 1 :
				desc = systemName + "：CPU" + "负载超标,当前指标：" + norm + "%,当前负载：" + value + "%";
				break;
			case 2 :
				desc = systemName + "：内存" + "负载超标,当前指标：" + norm + "MB,当前负载：" + value + "MB";
				break;
			case 3 :
				desc = systemName + "：磁盘" + "负载超标,当前指标：" + norm + "%,当前负载：" + value + "%";
				break;
			case 4 :
				desc = systemName + "：网络" + "负载超标,当前指标：" + norm + "KB,当前负载：" + value + "KB";
				break;
		}
		return desc;
	}

	/**
	 * 向用户报警
	 * 
	 * @param type
	 * @return
	 */
	private void alarm(long alarmLogId, Date now, String desc) {
		List<Long> list = getUserIds();
		Date lastDate = getLastAlarmTime();
		if (lastDate == null || (now.getTime() - lastDate.getTime()) > sendMessage) {
			for (Long userId : list) {
				insertAlarmMessage(alarmLogId, userId, now, desc);
			}
		}
	}

	/**
	 * 获取指标
	 * 
	 * @param type
	 * @return
	 */
	private Integer getNormByNormType(int type) {
		String sql = "select (case " + 
						"when (select t.alarm_policy_level " + 
						"from apm_alarm_policy t " + 
						"where t.alarm_policy_type = 2) = 1 then " + 
						"norm_normal " + 
						"when (select t.alarm_policy_level " + 
						"from apm_alarm_policy t " + 
						"where t.alarm_policy_type = 2) = 2 then " + 
						"norm_warning " + 
						"else " + 
						"norm_danger " + 
						"end) " + 
						"from apm_norm " + 
						"where norm_type = ? " + 
						"and service_type = 2";
		return jdbcTemplate.queryForObject(sql, new Object[]{type}, Integer.class);
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
	 * 获取发送报警信息角色列表
	 * 
	 * @param type
	 */
	private List<Long> getUserIds() {
		String sql = "select a.user_id " + 
						"from apm_alarm_policy t " + 
						"join apm_policy_user a " +
						"on a.alarm_policy_id = t.id " + 
						"where t.alarm_policy_type = 2"; 
		List<Long> list = (List<Long>) jdbcTemplate.queryForList(sql, Long.class);
		return list;
	}
	
	/**
	 * 写入报警信息
	 * 
	 * @param type
	 */
	private void insertAlarmMessage(long alarmLogId, long userId, Date now, String desc) {
		String sql = "insert into apm_alarm_send(" + 
						"id," + 
						"alram_log_id," + 
						"user_id," + 
						"send_time," + 
						"read_flag," + 
						"title," + 
						"message" + 
						") values(APM_ALARM_SEND_SEQ.Nextval, ?, ?, ?, 0, ?, ?)";
		jdbcTemplate.update(sql, new Object[]{alarmLogId, userId, now, "操作系统负载超标", desc});
	}
	
	/**
	 * 获取上次报警时间
	 * 
	 * @param type
	 */
	private Date getLastAlarmTime() {
		String sql = "select max(b.alarm_time) " +
						"from apm_alarm_send a " +
						"join apm_alarm_log b on b.id = a.alram_log_id " +
						"where b.alarm_system_name = '操作系统'";
		Date date = (Date) jdbcTemplate.queryForObject(sql, Date.class);
		return date;
	}
	
	/**
	 * 判断是否发送报警消息
	 * 
	 * @param type
	 */
	private boolean isAlarm() {
		String sql = "select t.send_flag from apm_alarm_policy t where t.alarm_policy_type = 2 ";
		int sendFlag = jdbcTemplate.queryForObject(sql, Integer.class);
		if (sendFlag == 1) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
}
