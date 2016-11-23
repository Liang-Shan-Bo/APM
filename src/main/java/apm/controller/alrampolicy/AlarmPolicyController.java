package apm.controller.alrampolicy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.user.User;
import apm.service.alrampolicy.AlarmPolicyService;
import apm.service.user.UserService;
import apm.util.Constants;
import apm.util.Page;

/**
 * @author 报警策略
 *
 */
@Controller
public class AlarmPolicyController {

	@Resource
	private AlarmPolicyService alarmPolicyService;
	
	@Resource
	private UserService userService;

	/**
	 * 服务策略列表页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/serviceAlarmPolicyList", method = RequestMethod.GET)
	public String serviceAlarmPolicyList(Model model, Page<AlarmPolicyEntity> page) {
		page = alarmPolicyService.getServiceAlarmPolicyList(page);
		page.setResultList(setAlarmPolicyUsed(page.getResultList()));
		model.addAttribute("page", page);
		return "alarmpolicy/alarmpolicy_service_list";
	}

	/**
	 * 系统策略列表页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemAlarmPolicyList", method = RequestMethod.GET)
	public String systemAlarmPolicyList(Model model, Page<AlarmPolicyEntity> page) {
		List<AlarmPolicyEntity> alarmPolicyEntity = alarmPolicyService.getSystemAlarmPolicyList();
		model.addAttribute("alarmPolicyEntity", alarmPolicyEntity);
		return "alarmpolicy/alarmpolicy_system_list";
	}

	/**
	 * 跳转到添加策略页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createAlarmPolicy", method = RequestMethod.GET)
	public String createPage(Model model) {
		List<User> userList = userService.getAllEnabledUser();
		model.addAttribute("userList", userList);
		return "alarmpolicy/alarmpolicy_create";
	}

	/**
	 * 添加策略
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createAlarmPolicy", method = RequestMethod.POST)
	public String createAlarmPolicy(Model model, AlarmPolicyEntity alarmPolicyEntity) {
		alarmPolicyService.createAlarmPolicy(alarmPolicyEntity);
		return "redirect:/serviceAlarmPolicyList";
	}

	/**
	 * 跳转到修改服务策略页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateServiceAlarmPolicy", method = RequestMethod.GET)
	public String updateServicePage(Model model, @RequestParam int id) {
		AlarmPolicyEntity alarmPolicyEntity = alarmPolicyService.getAlarmPolicyById(id);
		model.addAttribute("alarmPolicyEntity", alarmPolicyEntity);
		List<User> userList = userService.getUserByPolicyId(id);
		model.addAttribute("userList", userList);
		List<User> otherList = userService.getOtherUser(id);
		model.addAttribute("otherList", otherList);
		return "alarmpolicy/alarmpolicy_service_update";
	}

	/**
	 * 跳转到修改系统策略页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateSystemAlarmPolicy", method = RequestMethod.GET)
	public String updateSystemPage(Model model, @RequestParam int id) {
		AlarmPolicyEntity alarmPolicyEntity = alarmPolicyService.getAlarmPolicyById(id);
		model.addAttribute("alarmPolicyEntity", alarmPolicyEntity);
		List<User> userList = userService.getUserByPolicyId(id);
		model.addAttribute("userList", userList);
		List<User> otherList = userService.getOtherUser(id);
		model.addAttribute("otherList", otherList);
		return "alarmpolicy/alarmpolicy_system_update";
	}

	/**
	 * 修改策略
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateAlarmPolicy", method = RequestMethod.POST)
	public String updateAlarmPolicy(Model model, AlarmPolicyEntity alarmPolicyEntity) {
		alarmPolicyService.updateAlarmPolicy(alarmPolicyEntity);
		if (alarmPolicyEntity.getAlarmPolicyType() == Constants.SERVICE_POLICY_TYPE) {
			return "redirect:/serviceAlarmPolicyList";
		} else {
			return "redirect:/systemAlarmPolicyList";
		}

	}
	
	/**
	 * 跳转到策略详细页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/detailAlarmPolicy", method = RequestMethod.GET)
	public String detailAlarmPolicy(Model model, @RequestParam int id) {
		AlarmPolicyEntity alarmPolicyEntity = alarmPolicyService.getAlarmPolicyById(id);
		model.addAttribute("alarmPolicyEntity", alarmPolicyEntity);
		List<User> userList = userService.getUserByPolicyId(id);
		model.addAttribute("userList", userList);
		return "alarmpolicy/alarmpolicy_detail";
	}

	/**
	 * 删除策略
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/deleteAlarmPolicy", method = RequestMethod.GET)
	public String deleteAlarmPolicy(Model model, @RequestParam int id) {
		alarmPolicyService.deleteAlarmPolicy(id);
		return "redirect:/serviceAlarmPolicyList";
	}

	/**
	 * 校验策略名称是否存在
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkPolicyName", method = RequestMethod.POST)
	@ResponseBody
	private boolean checkName(AlarmPolicyEntity alarmPolicyEntity) {
		return alarmPolicyService.checkName(alarmPolicyEntity);
	}

	/**
	 * 设置策略列表使用状态
	 * 
	 * @return boolean
	 */
	private List<AlarmPolicyEntity> setAlarmPolicyUsed(List<AlarmPolicyEntity> list) {
		for (AlarmPolicyEntity alarmPolicyEntity : list) {
			if (alarmPolicyService.isAlarmPolicyUsed(alarmPolicyEntity.getId())) {
				alarmPolicyEntity.setUsed(true);
			} else {
				alarmPolicyEntity.setUsed(false);
			}
		}
		return list;
	}
}
