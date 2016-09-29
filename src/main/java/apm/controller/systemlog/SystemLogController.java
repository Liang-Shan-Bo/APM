package apm.controller.systemlog;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import apm.entity.systemlog.SystemLogPage;
import apm.service.systemlog.SystemLogService;

/**
 * @author 用户登录控制层
 *
 */
@Controller
public class SystemLogController {

	@Resource
	private SystemLogService systemLogService;

	/**
	 * 监控日志列表
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemLogList", method = RequestMethod.GET)
	public String systemLogList(Model model, SystemLogPage page) {
		page = systemLogService.getSystemLogList(page);
		model.addAttribute("page", page);
		return "systemlog/systemlog_list";
	}

}
