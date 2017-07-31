package apm.controller.chart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.chart.ChartEntity;
import apm.service.chart.ChartService;

/**
 * @author 图表统计控制层
 *
 */
@Controller
public class ChartController {

	@Resource
	private ChartService chartService;

	/**
	 * 图表统计页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/chartList", method = RequestMethod.GET)
	public String chartPage(Model model) {
		model.addAttribute("list", chartService.getAllChartList());
		return "chart/chart_list";
	}

	/**
	 * 图表统计查询
	 * 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/chartList", method = RequestMethod.POST)
	public List<ChartEntity> chart(Model model, String serviceId, String createTime, int dateFlag) {
		return chartService.getChartListById(serviceId, createTime, dateFlag);
	}

}
