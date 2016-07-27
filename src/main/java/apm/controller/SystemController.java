package apm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.hyperic.sigar.CpuPerc;
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
}
