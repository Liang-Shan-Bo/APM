package apm.controller.user;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.message.MessageEntity;
import apm.entity.message.MessagePage;
import apm.entity.user.User;
import apm.service.message.MessageService;
import apm.service.user.UserService;
import apm.util.Constants;
import apm.util.Page;

/**
 * @author 用户登录控制层
 *
 */
@Controller
public class UserController {

	@Resource
	private MessageService messageService;

	@Resource
	private UserService userService;

	/**
	 * 跳转到系统消息列表
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/messageList", method = RequestMethod.GET)
	public String messageList(Model model, MessagePage page) {
		long userId = getUserIdByName();
		page.setId(userId);
		page = messageService.getMessageList(page);
		int unReadCount = messageService.getUnReadCount(userId);
		model.addAttribute("page", page);
		model.addAttribute("unReadCount", unReadCount);
		return "user/message_list";
	}

	/**
	 * 跳转到修改密码页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/passwordPage", method = RequestMethod.GET)
	public String passwordPage(Model model) {
		long userId = getUserIdByName();
		model.addAttribute("userId", userId);
		return "user/password_update";
	}

	/**
	 * 跳转到用户管理页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model, Page<User> page) {
		page = userService.getUserList(page);
		model.addAttribute("page", page);
		return "user/user_list";
	}
	
	/**
	 * 跳转到新增用户页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createUser", method = RequestMethod.GET)
	public String createUser() {
		return "user/user_create";
	}

	/**
	 * 修改密码
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword(User user) {
		userService.updatePassword(user.getPassword(), user.getId());
		return "user/password_success";
	}

	/**
	 * 查看系统消息
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/detailMessage", method = RequestMethod.GET)
	public String detailMessage(Model model, @RequestParam int id) {
		// 设置为已读
		messageService.setRead(id);
		MessageEntity messageEntity = messageService.getMessageById(id);
		model.addAttribute("messageEntity", messageEntity);
		return "user/message_detail";
	}

	/**
	 * 全部设为已读
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/setAllRead", method = RequestMethod.GET)
	public String setAllRead(Model model) {
		messageService.setReadByUserId(getUserIdByName());
		return "redirect:/messageList";
	}

	/**
	 * 清空所有已读消息
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/clearAllRead", method = RequestMethod.GET)
	public String clearAllRead(Model model) {
		messageService.deleteReadById(getUserIdByName());
		return "redirect:/messageList";
	}

	/**
	 * 获取当前用户ID
	 * 
	 * @return String
	 */
	private long getUserIdByName() {
		String loginName = (String) SecurityUtils.getSubject().getPrincipal();
		User user = userService.getUserByName(loginName);
		return user.getId();
	}

	/**
	 * 校验旧密码是否正确
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkPassword", method = RequestMethod.GET)
	@ResponseBody
	private boolean checkPassword(User user) {
		return userService.checkPassword(user.getPassword(), user.getId());
	}

	/**
	 * 重置密码
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	@ResponseBody
	public boolean resetPassword(int id) {
		userService.updatePassword(Constants.DEFAULT_PASSWORD, id);
		return true;
	}

	/**
	 * 撤销管理员
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/revoke", method = RequestMethod.GET)
	public String revoke(@RequestParam long id) {
		userService.revoke(id);
		return "redirect:/userList";
	}

	/**
	 * 任命管理员
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/appoint", method = RequestMethod.GET)
	public String appoint(@RequestParam long id) {
		userService.appoint(id);
		return "redirect:/userList";
	}

	/**
	 * 启用用户
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/unfreeze", method = RequestMethod.GET)
	public String unfreeze(@RequestParam int id) {
		userService.unfreeze(id);
		return "redirect:/userList";
	}

	/**
	 * 注销用户
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/freeze", method = RequestMethod.GET)
	public String freeze(@RequestParam int id) {
		userService.freeze(id);
		return "redirect:/userList";
	}
	
	/**
	 * 新增用户
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createUser", method = RequestMethod.POST)
	public String createUser(Model model, User user) {
		user.setPassword(Constants.DEFAULT_PASSWORD);
		userService.createUser(user);
		if (user.getRole() == 2) {
			userService.appoint(userService.getUserByName(user.getLoginName()).getId());
		}
		return "redirect:/userList";
	}
	
	/**
	 * 校验用户名是否已存在
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkLoginName", method = RequestMethod.GET)
	@ResponseBody
	private boolean checkLoginName(String loginName) {
		return userService.checkLoginName(loginName);
	}
}
