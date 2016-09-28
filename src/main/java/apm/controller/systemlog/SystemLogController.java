package apm.controller.systemlog;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.systemlog.SystemLogEntity;
import apm.entity.systemlog.SystemLogPage;
import apm.entity.user.User;
import apm.service.systemlog.SystemLogService;
import apm.service.user.UserService;
import apm.util.EncUtil;
import apm.util.Page;

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
