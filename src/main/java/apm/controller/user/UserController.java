package apm.controller.user;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import apm.entity.user.User;
import apm.service.user.UserService;
import apm.util.EncUtil;

/**
 * @author 用户登录控制层
 *
 */
@Controller
public class UserController {

	@Resource
	private UserService userService;

	/**
	 * 注册
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(User user) {
		user.setPassword(EncUtil.MD5(user.getPassword()));
		userService.createUser(user);
		return "login/login";
	}

}
