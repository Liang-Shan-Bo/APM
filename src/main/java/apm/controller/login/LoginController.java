package apm.controller.login;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.OperatingSystemMXBean;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.management.MBeanServerConnection;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.norm.NormEntity;
import apm.entity.service.ServiceEntity;
import apm.entity.user.User;
import apm.service.alrampolicy.AlarmPolicyService;
import apm.service.norm.NormService;
import apm.service.service.ServiceService;
import apm.service.user.UserService;
import apm.util.Constants;
import apm.util.Page;

/**
 * @author 用户登录控制层
 *
 */
@Controller
public class LoginController {
	
	@Resource
	private UserService userService;

	/**
	 * 登录页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage() {
		return "login/login";
	}
	
	/**
	 * 登录
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user,BindingResult bindingResult,RedirectAttributes redirectAttributes){  
        try {  
            if(bindingResult.hasErrors()){  
                return "/login";  
            }  
            //使用权限工具进行用户登录，登录成功后跳到shiro配置的successUrl中，与下面的return没什么关系！  
            SecurityUtils.getSubject().login(new UsernamePasswordToken(user.getUserName(), user.getPassword()));  
            return "redirect:/index";  
        } catch (AuthenticationException e) {  
            redirectAttributes.addFlashAttribute("message","用户名或密码错误");  
            return "redirect:/login";  
        }  
    }
	
	public String login() {
		return "index";
	}
}
