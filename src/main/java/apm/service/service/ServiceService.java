package apm.service.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.service.ServiceDao;
import apm.entity.service.ServiceEntity;
import apm.util.Page;

@Service
public class ServiceService {

	@Resource
	private ServiceDao serviceDao;

	/**
	 * 根据ID查询服务
	 * 
	 * @return ServiceEntity
	 */
	public ServiceEntity getServiceById(int id) {
		return serviceDao.getServiceById(id);
	}

	/**
	 * 条件查询服务列表
	 * 
	 * @return Page
	 */
	public Page<ServiceEntity> getServiceList(Page<ServiceEntity> page) {
		page.init();
		page.setPage(serviceDao.getServiceList(page), serviceDao.getServiceCount());
		return page;
	}

	/**
	 * 添加服务
	 * 
	 */
	public void createService(ServiceEntity serviceEntity) {
		serviceDao.createService(serviceEntity);
	}
	
	/**
	 * 修改服务
	 * 
	 */
	public void updateService(ServiceEntity serviceEntity) {
		serviceDao.updateService(serviceEntity);
	}
	
	/**
	 * 删除服务
	 * 
	 */
	public void deleteService(int id) {
		serviceDao.deleteService(id);
	}

	/**
	 * 校验IP和端口是否存在
	 * 
	 * @return boolean
	 */
	public boolean checkPort(ServiceEntity serviceEntity) {
		if (serviceEntity.getId() != null) {
			if (serviceDao.getServiceById(serviceEntity.getId()).getServicePort()
					.equals(serviceEntity.getServicePort())) {
				return true;
			}
		}
		int count = serviceDao.checkPort(serviceEntity);
		if (count > 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 校验IP和监控端口是否存在
	 * 
	 * @return boolean
	 */
	public boolean checkJmxPort(ServiceEntity serviceEntity) {
		if (serviceEntity.getId() != null) {
			if (serviceDao.getServiceById(serviceEntity.getId()).getMonitorPort()
					.equals(serviceEntity.getMonitorPort())) {
				return true;
			}
		}
		int count = serviceDao.checkJmxPort(serviceEntity);
		if (count > 0) {
			return false;
		} else {
			return true;
		}
	}

}
