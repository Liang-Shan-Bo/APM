package apm.controller.user;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
//
//	/**
//	 * 返回首页
//	 * 
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "/index", method = RequestMethod.GET)
//	public String index(Model model) {
//		return "index";
//	}
//
//	/**
//	 * 登录
//	 * 
//	 * @return String
//	 */
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		try {
//			if (bindingResult.hasErrors()) {
//				return "/login";
//			}
//			// 使用权限工具进行用户登录，登录成功后跳到shiro配置的successUrl中，与下面的return没什么关系！
//			SecurityUtils.getSubject().login(
//					new UsernamePasswordToken(user.getLoginName(), EncUtil.MD5(user.getPassword())));
//			return "redirect:/index";
//		} catch (AuthenticationException e) {
//			redirectAttributes.addFlashAttribute("message", "用户名或密码错误");
//			return "redirect:/login";
//		}
//	}
//
//	/**
//	 * 登出
//	 * 
//	 * @return String
//	 */
//	@RequestMapping(value = "/logout", method = RequestMethod.GET)
//	public String logout(User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		// 使用权限工具进行用户登出
//		SecurityUtils.getSubject().logout();
//		return "redirect:/login";
//	}

}
