package apm.listener;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.hyperic.sigar.CpuPerc;
import org.hyperic.sigar.FileSystem;
import org.hyperic.sigar.FileSystemUsage;
import org.hyperic.sigar.NetInterfaceStat;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;

import apm.entity.system.DiskEntity;
import apm.entity.system.SystemInfo;
import apm.util.PropertiesUtil;

/**
 * @author 操作系统监控
 *
 */
public class SystemListener implements ServletContextListener {

	// 推送消息时间间隔(ms)
	private static int interval = Integer.parseInt(PropertiesUtil.getValue("ws", "websocket.interval"));
	// 消息队列存储数量
	private static int count = Integer.parseInt(PropertiesUtil.getValue("ws", "websocket.count"));
	// 消息队列存储对象
	public static List<SystemInfo> sysInfoList = new CopyOnWriteArrayList<SystemInfo>();
	// 定时任务
	private Timer timer = null;
	// 当前总流量
	private Long bytes = 0L;

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
			SystemInfo systemInfo = new SystemInfo();
			try {
				//CPU
				systemInfo.setUsers(setCpu(sigar));
				//总内存
				systemInfo.setTotalMem(setTotalMem(sigar));
				//已使用内存
				systemInfo.setUseMem(setUseMem(sigar));
				//网络流量
				systemInfo.setTotalBytes(setBytes(sigar));
				//磁盘
				systemInfo.setDisks(setDisk(sigar));
			} catch (SigarException e) {
				e.printStackTrace();
			}
			//设置时间轴
			systemInfo.setTime(new Date().getTime());

			if (sysInfoList.size() >= count) {
				sysInfoList.remove(0);
			}
			sysInfoList.add(systemInfo);
			sigar.close();
		}
	};

	/**
	 * 设置CPU使用率列表(%)
	 * 
	 * @param Sigar
	 * @return List<Double>
	 * @throws SigarException
	 */
	private List<Double> setCpu(Sigar sigar) throws SigarException {
		List<Double> users = new ArrayList<Double>();
		CpuPerc cpuList[] = sigar.getCpuPercList();
		for (CpuPerc cpuPerc : cpuList) {
			users.add(cpuPerc.getUser() * 100D);
		}
		return users;
	}
	
	/**
	 * 设置总内存数(M)
	 * 
	 * @param Sigar
	 * @return Long
	 * @throws SigarException
	 */
	private Long setTotalMem(Sigar sigar) throws SigarException {
		return sigar.getMem().getTotal() / 1024L / 1024;
	}
	
	/**
	 * 设置已使用内存数(M)
	 * 
	 * @param Sigar
	 * @return Long
	 * @throws SigarException
	 */
	private Long setUseMem(Sigar sigar) throws SigarException {
		return sigar.getMem().getUsed() / 1024L / 1024;
	}
	
	/**
	 * 设置单位时间内总流量(K)
	 * 
	 * @param Sigar
	 * @return Long
	 * @throws SigarException
	 */
	private Long setBytes(Sigar sigar) throws SigarException {
		String netName = null;
		String ifNames[] = sigar.getNetInterfaceList();
		for (String string : ifNames) {
			if (!sigar.getNetInterfaceConfig(string).getAddress().equals("0.0.0.0")) {
				netName = string;
				break;
			}
		}
		NetInterfaceStat ifstat = sigar.getNetInterfaceStat(netName);
		long result;
		if (bytes == 0L) {
			result = 0L;
		} else {
			result = ifstat.getRxBytes() + ifstat.getTxBytes() - bytes;
		}
		bytes = ifstat.getRxBytes() + ifstat.getTxBytes();
		return result;
	}
	
	/**
	 * 设置磁盘状态列表(%)
	 * 
	 * @param Sigar
	 * @return List<DiskEntity>
	 * @throws SigarException
	 */
	private List<DiskEntity> setDisk(Sigar sigar) throws SigarException {
		List<DiskEntity> disks = new ArrayList<DiskEntity>();
		FileSystem fslist[] = sigar.getFileSystemList();
		FileSystemUsage usage = null;
		for (FileSystem fs : fslist) {
			try {
				usage = sigar.getFileSystemUsage(fs.getDirName());
				disks.add(new DiskEntity(usage.getUsePercent() * 100D, fs.getDevName()));
			} catch (Exception e) {
				continue;
			}
		}
		return disks;
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}
}
