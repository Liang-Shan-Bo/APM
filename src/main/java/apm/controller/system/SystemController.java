package apm.controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author 系统监控控制层
 *
 */
@Controller
public class SystemController {

	/**
	 * cpu监控页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/cpuMonitor", method = RequestMethod.GET)
	public String cpuMonitor() {
		return "system/cpu_monitor";
	}
	
	/**
	 * 网络监控页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/netMonitor", method = RequestMethod.GET)
	public String netMonitor() {
		return "system/net_monitor";
	}
	
	/**
	 * 进程监控页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/proMonitor", method = RequestMethod.GET)
	public String proMonitor() {
		return "system/pro_monitor";
	}
	
}
