package apm.listener;

import java.text.DecimalFormat;
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
			if (SystemListener.sysInfoList.size() > 0) {
				SystemInfo info = SystemListener.sysInfoList.get(SystemListener.sysInfoList.size() - 1);
				double cpu = checkCpu(info);
				int cpuNorm = getNormByNormType(Constants.SYSTEM_NORM_CPU);
				if (cpu >= cpuNorm) {
					System.out.println("cpu:" + cpu + "%");
					systemLog(cpu, Constants.SYSTEM_NORM_CPU, "system", cpuNorm);
				}
				double mem = checkMem(info);
				int memNorm = getNormByNormType(Constants.SYSTEM_NORM_MEM);
				if (mem >= memNorm) {
					System.out.println("mem:" + mem + "M");
					systemLog(mem, Constants.SYSTEM_NORM_MEM, "system", memNorm);
				}
				double disk = checkDisk(info);
				int diskNorm = getNormByNormType(Constants.SYSTEM_NORM_DIS);
				if (disk >= diskNorm) {
					System.out.println("disk:" + disk + "%");
					systemLog(disk, Constants.SYSTEM_NORM_DIS, "system", diskNorm);
				}
				double net = checkNet(info);
				int netNorm = getNormByNormType(Constants.SYSTEM_NORM_NET);
				if (net >= netNorm) {
					System.out.println("net:" + net + "K");
					systemLog(net, Constants.SYSTEM_NORM_NET, "system", netNorm);
				}
				alarm();
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
	 * 添加系统报警日志
	 *
	 * @param value
	 * @param type
	 * @param systemName
	 */
	private void systemLog(double value, int type, String systemName, int norm) {
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
	private void insertSystemLog(double value, int type, String systemName, String desc) {
		String sql = "insert into apm_alarm_log(" + 
						"id," + 
						"alarm_value," + 
						"alarm_time," + 
						"alarm_type," + 
						"alarm_system_name," + 
						"alarm_desc" + 
						") values(APM_ALARM_LOG_SEQ.Nextval,?, SYSDATE,?,?,?)";
		jdbcTemplate.update(sql, new Object[]{value, type, systemName, desc});
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
}
