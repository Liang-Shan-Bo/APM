package apm.listener;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.hyperic.sigar.CpuPerc;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;

import apm.entity.SystemInfo;
import apm.util.PropertiesUtil;

public class SystemListener implements ServletContextListener {

	// 推送消息时间间隔(ms)
	private static int interval = Integer.parseInt(PropertiesUtil.getValue("ws", "websocket.interval"));
	// 消息队列存储数量
	private static int count = Integer.parseInt(PropertiesUtil.getValue("ws", "websocket.count"));
	// 消息队列存储对象
	public static List<SystemInfo> sysInfoList = new LinkedList<SystemInfo>();
	// 定时任务
	private Timer timer = null;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		timer = new Timer(true);
		timer.schedule(task, 0, interval);
	}

	/**
	 * 心跳任务
	 */
	TimerTask task = new TimerTask() {
		public void run() {
			Sigar sigar = new Sigar();
			CpuPerc cpuList[] = null;
			SystemInfo systemInfo = new SystemInfo();
			try {
				cpuList = sigar.getCpuPercList();
			} catch (SigarException e) {
				e.printStackTrace();
			}
			systemInfo.setUser(CpuPerc.format(cpuList[0].getUser()));
			systemInfo.setDate(new Date());
			if (sysInfoList.size() >= count) {
				sysInfoList.remove(0);
			}
			sysInfoList.add(systemInfo);
			sigar.close();
		}
	};

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
}
