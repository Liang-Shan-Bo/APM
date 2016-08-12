package apm.controller.norm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.norm.NormEntity;
import apm.service.norm.NormService;
import apm.util.Constants;
import apm.util.Page;

/**
 * @author 指标设置
 *
 */
@Controller
public class NormController {

	@Resource
	private NormService normService;

	/**
	 * 服务指标列表页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/serviceNormList", method = RequestMethod.GET)
	public String serviceNormList(Model model, Page<NormEntity> page) {
		page = normService.getServiceNormList(page);
		page.setResultList(setNormUsed(page.getResultList()));
		model.addAttribute("page", page);
		return "norm/norm_service_list";
	}
	
	/**
	 * 系统指标列表页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/systemNormList", method = RequestMethod.GET)
	public String systemNormList(Model model, Page<NormEntity> page) {
		List<NormEntity> normList = normService.getSystemNormList();
		model.addAttribute("normList", normList);
		return "norm/norm_system_list";
	}

	/**
	 * 跳转到添加指标页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createNorm", method = RequestMethod.GET)
	public String createPage() {
		return "norm/norm_create";
	}

	/**
	 * 添加指标
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createNorm", method = RequestMethod.POST)
	public String createNorm(Model model, NormEntity normEntity) {
		normEntity.setNormType(Constants.NORM_MEM);
		normService.createNorm(normEntity);
		return "redirect:/serviceNormList";
	}

	/**
	 * 跳转到修改服务指标页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateServiceNorm", method = RequestMethod.GET)
	public String updateServicePage(Model model, @RequestParam int id) {
		NormEntity normEntity = normService.getNormById(id);
		model.addAttribute("normEntity", normEntity);
		return "norm/norm_service_update";
	}
	
	/**
	 * 跳转到修改系统指标页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateSystemNorm", method = RequestMethod.GET)
	public String updateSystemPage(Model model, @RequestParam int id) {
		NormEntity normEntity = normService.getNormById(id);
		model.addAttribute("normEntity", normEntity);
		return "norm/norm_system_update";
	}

	/**
	 * 修改指标
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateNorm", method = RequestMethod.POST)
	public String updateNorm(Model model, NormEntity normEntity) {
		normService.updateNorm(normEntity);
		if (normEntity.getServiceType() == 1) {
			return "redirect:/serviceNormList";
		}else {
			return "redirect:/systemNormList";
		}
		
	}

	/**
	 * 删除指标
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/deleteNorm", method = RequestMethod.GET)
	public String deleteNorm(Model model, @RequestParam int id) {
		normService.deleteNorm(id);
		return "redirect:/serviceNormList";
	}

	/**
	 * 校验指标名称是否存在
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkName", method = RequestMethod.GET)
	@ResponseBody
	private boolean checkName(String normName) {
		return normService.checkName(normName);
	}
	
	/**
	 * 设置指标列表使用状态
	 * 
	 * @return boolean
	 */
	private List<NormEntity> setNormUsed(List<NormEntity> list) {
		for (NormEntity normEntity : list) {
			if (normService.isNormUsed(normEntity.getId())) {
				normEntity.setUsed(true);
			}else {
				normEntity.setUsed(false);
			}
			
		}
		return list;
	}

}
