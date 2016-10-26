package apm.service.norm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.norm.NormDao;
import apm.entity.norm.NormEntity;
import apm.util.Page;

/**
 * @author 指标设置事务管理
 *
 */
@Service
public class NormService {

	@Resource
	private NormDao normDao;

	/**
	 * 根据ID查询指标
	 * 
	 * @return ServiceEntity
	 */
	public NormEntity getNormById(long id) {
		return normDao.getNormById(id);
	}
	
	/**
	 * 查询所有服务指标列表
	 * 
	 * @return Page
	 */
	public List<NormEntity> getServiceNormListAll() {
		return normDao.getServiceNormListAll();
	}

	/**
	 * 分页查询服务指标列表
	 * 
	 * @return Page
	 */
	public Page<NormEntity> getServiceNormList(Page<NormEntity> page) {
		page.init();
		page.setPage(normDao.getServiceNormList(page), normDao.getNormCount());
		return page;
	}
	
	/**
	 * 查询系统指标列表
	 * 
	 * @return Page
	 */
	public List<NormEntity> getSystemNormList() {
		return normDao.getSystemNormList();
	}

	/**
	 * 添加指标
	 * 
	 */
	public void createNorm(NormEntity normEntity) {
		normDao.createNorm(normEntity);
	}
	
	/**
	 * 修改指标
	 * 
	 */
	public void updateNorm(NormEntity normEntity) {
		normDao.updateNorm(normEntity);
	}
	
	/**
	 * 删除指标
	 * 
	 */
	public void deleteNorm(int id) {
		normDao.deleteNorm(id);
	}


	/**
	 * 校验指标名称是否存在
	 * 
	 * @return boolean
	 */
	public boolean checkName(NormEntity normEntity) {
		if (normEntity.getId() != null) {
			if (normDao.getNormById(normEntity.getId()).getNormName()
					.equals(normEntity.getNormName())) {
				return true;
			}
		}
		int count = normDao.checkName(normEntity.getNormName());
		if (count > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 查询该指标是被使用
	 * 
	 * @return boolean
	 */
	public boolean isNormUsed(long id) {
		if (normDao.getServiceCount(id) != 0) {
			return true;
		}else {
			return false;
		}
	}
	
	/**
	 * 根据策略获取系统报警指标
	 * 
	 * @return int
	 */
	public Integer getNormByNormType(int type) {
		return normDao.getNormByNormType(type);
	}

}
