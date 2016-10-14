package apm.controller.user;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import apm.entity.message.MessageEntity;
import apm.entity.message.MessagePage;
import apm.entity.user.User;
import apm.service.message.MessageService;
import apm.service.user.UserService;
import apm.util.EncUtil;

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
	 * 查看系统消息
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/detailMessage", method = RequestMethod.GET)
	public String detailMessage(Model model, @RequestParam int id) {
		//设置为已读
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
	private long getUserIdByName(){
		String loginName = (String) SecurityUtils.getSubject().getPrincipal();
		User user = userService.getUserByName(loginName);
		return user.getId();
	}
	
}
