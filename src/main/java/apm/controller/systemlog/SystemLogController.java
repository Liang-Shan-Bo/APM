package apm.controller.systemlog;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import apm.entity.systemlog.AlarmStatiticsEntity;
import apm.entity.systemlog.SystemLogPage;
import apm.service.alarm.AlarmService;
import apm.service.systemlog.SystemLogService;
import apm.util.Constants;

/**
 * @author 报警日志控制层
 *
 */
@Controller
public class SystemLogController {

	@Resource
	private SystemLogService systemLogService;
	
	@Resource
	private AlarmService alarmService;

	/**
	 * 监控日志列表
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemLogList", method = RequestMethod.POST)
	public String systemLogList(Model model, SystemLogPage page) {
		page = systemLogService.getSystemLogList(page);
		model.addAttribute("page", page);
		return "systemlog/systemlog_list";
	}
	
	/**
	 * 跳转到监控日志列表
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemLogList", method = RequestMethod.GET)
	public String systemLogPage(Model model, SystemLogPage page) {
		page = systemLogService.getSystemLogList(page);
		model.addAttribute("page", page);
		return "systemlog/systemlog_list";
	}
	
	/**
	 * 报警统计页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/alarmList", method = RequestMethod.GET)
	public String alarmList(Model model) {
		List<AlarmStatiticsEntity> alarmOfMonth = alarmService.getLogStatistics(Constants.MONTH_TIME);
		List<AlarmStatiticsEntity> logOfMonth = systemLogService.getLogStatistics(Constants.MONTH_TIME);
		List<AlarmStatiticsEntity> alarmOfAll = alarmService.getLogStatistics(Constants.ALL_TIME);
		List<AlarmStatiticsEntity> logOfAll = systemLogService.getLogStatistics(Constants.ALL_TIME);
		model.addAttribute("logOfMonth", JSONArray.fromObject(logOfMonth));
		model.addAttribute("alarmOfMonth", JSONArray.fromObject(alarmOfMonth));
		model.addAttribute("logOfAll", JSONArray.fromObject(logOfAll));
		model.addAttribute("alarmOfAll", JSONArray.fromObject(alarmOfAll));
		return "systemlog/alarm_statistics";
	}

}
