package apm.controller.option;

import javax.annotation.Resource;

import org.hyperic.sigar.OperatingSystem;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import apm.entity.message.MessagePage;
import apm.entity.option.SystemEntity;
import apm.service.message.MessageService;
import apm.service.user.UserService;

/**
 * @author 系统功能控制层
 *
 */
@Controller
public class OptionController {

	@Resource
	private MessageService messageService;

	@Resource
	private UserService userService;

	/**
	 * 跳转到操作系统信息页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemDetail", method = RequestMethod.GET)
	public String systemDetail(Model model, MessagePage page) {
		Sigar sigar = new Sigar();
		// 取到当前操作系统的名称
		String hostname = "";
		try {
			hostname = sigar.getNetInfo().getHostName();
		} catch (SigarException e) {
			hostname = "";
		}
		// 获取当前操作系统的信息
		OperatingSystem operatingSystem = OperatingSystem.getInstance();
		SystemEntity systemEntity = new SystemEntity(hostname, operatingSystem.getArch(),
				operatingSystem.getCpuEndian(), operatingSystem.getDataModel(), operatingSystem.getDescription(),
				operatingSystem.getName(), operatingSystem.getPatchLevel(), operatingSystem.getVendor(),
				operatingSystem.getVendorCodeName(), operatingSystem.getVendorName(),
				operatingSystem.getVendorVersion(), operatingSystem.getVersion());
		model.addAttribute("systemEntity", systemEntity);
		return "option/system_detail";
	}
	
	/**
	 * 跳转到ping监控页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/ping", method = RequestMethod.GET)
	public String ping() {
		return "option/ping";
	}
	
	/**
	 * 403
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public String ErrorFor403() {
		return "403";
	}

}
