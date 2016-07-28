package apm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.hyperic.sigar.CpuPerc;
import org.hyperic.sigar.FileSystem;
import org.hyperic.sigar.FileSystemUsage;
import org.hyperic.sigar.Mem;
import org.hyperic.sigar.NetInterfaceConfig;
import org.hyperic.sigar.NetInterfaceStat;
import org.hyperic.sigar.ProcState;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SystemController {

	/**
	 * 
	 * @param info
	 * @param mod
	 * @return
	 * @throws IOException 
	 */
	
	@RequestMapping(value = "/ec", method = RequestMethod.GET)
	public String ec(Model model) throws IOException {
		return "ec";
	}
	@RequestMapping(value = "/show", method = RequestMethod.GET)
	public String show(Model model) {
		return "test";
	}
	@RequestMapping(value = "/show1", method = RequestMethod.GET)
	public String show1(Model model) {
		return "test1";
	}
	@RequestMapping(value = "/show2", method = RequestMethod.GET)
	public String show2(Model model) {
		return "test2";
	}
	// private static void printCpuPerc(CpuPerc cpu) {
	//
	// System.out.println("用户使用率 :" + CpuPerc.format(cpu.getUser()));// 用户使用率
	// System.out.println("系统使用率 :" + CpuPerc.format(cpu.getSys()));// 系统使用率
	// System.out.println("当前等待率 :" + CpuPerc.format(cpu.getWait()));// 当前等待率
	// System.out.println("当前空闲率 :" + CpuPerc.format(cpu.getIdle()));// 当前空闲率
	// System.out.println("总的使用率 :" + CpuPerc.format(cpu.getCombined()));//
	// 总的使用率
	//
	// }

	@RequestMapping(value = "/test", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> test() throws SigarException {
		Map<String, Object> map = new HashMap<String, Object>();
		Sigar sigar = new Sigar();
		CpuPerc cpuList[] = null;
		try {
			cpuList = sigar.getCpuPercList();
		} catch (SigarException e) {
			e.printStackTrace();
		}
		// 物理内存信息
		Mem mem = sigar.getMem();

		map.put("user1", CpuPerc.format(cpuList[0].getUser()));
		map.put("sys1", CpuPerc.format(cpuList[0].getSys()));
		map.put("wait1", CpuPerc.format(cpuList[0].getWait()));
		map.put("id1", CpuPerc.format(cpuList[0].getIdle()));
		map.put("com1", CpuPerc.format(cpuList[0].getCombined()));
		map.put("user2", CpuPerc.format(cpuList[1].getUser()));
		map.put("sys2", CpuPerc.format(cpuList[1].getSys()));
		map.put("wait2", CpuPerc.format(cpuList[1].getWait()));
		map.put("id2", CpuPerc.format(cpuList[1].getIdle()));
		map.put("com2", CpuPerc.format(cpuList[1].getCombined()));
		map.put("tmen", mem.getTotal() / 1024L / 1024 + "M");
		map.put("umen", mem.getUsed() / 1024L / 1024 + "M");
		map.put("fmen", mem.getFree() / 1024L / 1024 + "M");
		return map;
	}

	@RequestMapping(value = "/test1", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> test1() throws SigarException {
		Map<String, Object> map = new HashMap<String, Object>();
		Sigar sigar = new Sigar();
		String ifNames[] = sigar.getNetInterfaceList();
		for (String string : ifNames) {
			System.out.println(sigar.getNetInterfaceConfig(string).getAddress());
		}
		String name = ifNames[9];
		NetInterfaceConfig ifconfig = sigar.getNetInterfaceConfig(name);
		NetInterfaceStat ifstat = sigar.getNetInterfaceStat(name);
		map.put("name", name);
		map.put("Address", ifconfig.getAddress());
		map.put("RxPackets", ifstat.getRxPackets());
		map.put("TxPackets", ifstat.getTxPackets());
		map.put("RxBytes", ifstat.getRxBytes());
		map.put("TxBytes", ifstat.getTxBytes());
		map.put("RxErrors", ifstat.getRxErrors());
		map.put("TxErrors", ifstat.getTxErrors());
		map.put("RxDropped", ifstat.getRxDropped());
		map.put("TxDropped", ifstat.getTxDropped());
		return map;
	}

	@RequestMapping(value = "/test2", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> test2() throws SigarException {
		Map<String, Object> map = new HashMap<String, Object>();
		Sigar sigar = new Sigar();
		long[] pids = sigar.getProcList();
		StringBuffer sb = new StringBuffer();
		for (long pid : pids) {
			ProcState prs = sigar.getProcState(pid);
			sb.append(prs.getName()+" pid: " + pid + " name:" + prs.getName()+"\n");
		}
		String str = sb.toString();
		map.put("str", str);
		return map;
	}
	
	@RequestMapping(value = "/test3", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> test3() throws SigarException {
		Map<String, Object> map = new HashMap<String, Object>();
		Sigar sigar = new Sigar();
		FileSystem fslist[] = sigar.getFileSystemList();  
		String dir = System.getProperty("user.home");// 当前用户文件夹路径  
		System.out.println(dir + "   " + fslist.length);  
		for (int i = 0; i < fslist.length; i++) {  
		    System.out.println("\n~~~~~~~~~~" + i + "~~~~~~~~~~");  
		FileSystem fs = fslist[i];  
		// 分区的盘符名称  
		System.out.println("fs.getDevName() = " + fs.getDevName());  
		// 分区的盘符名称  
		System.out.println("fs.getDirName() = " + fs.getDirName());  
		System.out.println("fs.getFlags() = " + fs.getFlags());//  
		// 文件系统类型，比如 FAT32、NTFS  
		System.out.println("fs.getSysTypeName() = " + fs.getSysTypeName());  
		// 文件系统类型名，比如本地硬盘、光驱、网络文件系统等  
		System.out.println("fs.getTypeName() = " + fs.getTypeName());  
		// 文件系统类型  
		System.out.println("fs.getType() = " + fs.getType());  
		FileSystemUsage usage = null;  
		try {  
		    usage = sigar.getFileSystemUsage(fs.getDirName());  
		} catch (SigarException e) {  
		    if (fs.getType() == 2)  
		        throw e;  
		    continue;  
		}  
		switch (fs.getType()) {  
		case 0: // TYPE_UNKNOWN ：未知  
		    break;  
		case 1: // TYPE_NONE  
		    break;  
		case 2: // TYPE_LOCAL_DISK : 本地硬盘  
		    // 文件系统总大小  
		    System.out.println(" Total = " + usage.getTotal() + "KB");  
		    // 文件系统剩余大小  
		    System.out.println(" Free = " + usage.getFree() + "KB");  
		    // 文件系统可用大小  
		    System.out.println(" Avail = " + usage.getAvail() + "KB");  
		    // 文件系统已经使用量  
		    System.out.println(" Used = " + usage.getUsed() + "KB");  
		    double usePercent = usage.getUsePercent() * 100D;  
		    // 文件系统资源的利用率  
		    System.out.println(" Usage = " + usePercent + "%");  
		    break;  
		case 3:// TYPE_NETWORK ：网络  
		    break;  
		case 4:// TYPE_RAM_DISK ：闪存  
		    break;  
		case 5:// TYPE_CDROM ：光驱  
		    break;  
		case 6:// TYPE_SWAP ：页面交换  
		    break;  
		}  
		System.out.println(" DiskReads = " + usage.getDiskReads());  
		System.out.println(" DiskWrites = " + usage.getDiskWrites());  
		}
		return map; 
	}
}
