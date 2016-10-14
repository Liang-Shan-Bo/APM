package apm.controller.alarm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.message.MessageEntity;
import apm.entity.user.User;
import apm.service.alarm.AlarmService;
import apm.service.user.UserService;

/**
 * @author 报警信息
 *
 */
@Controller
public class AlarmController {

	@Resource
	private AlarmService alarmService;
	
	@Resource
	private UserService userService;

	/**
	 * 根据登录名获取报警列表
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/getAlarmMessage", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> checkName(String loginName) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = userService.getUserByName(loginName);
		List<MessageEntity> list = alarmService.getAlarmList(user.getId());
		map.put("count", list.size());
		map.put("list", list);
		return map;
	}

}
