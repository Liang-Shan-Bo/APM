package apm.service.alrampolicy;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.dao.alrampolicy.AlarmPolicyDao;
import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.util.Page;

/**
 * @author 报警策略事务管理
 *
 */
@Service
public class AlarmPolicyService {

	@Resource
	private AlarmPolicyDao alarmPolicyDao;

	/**
	 * 根据ID查询策略
	 * 
	 * @return ServiceEntity
	 */
	public AlarmPolicyEntity getAlarmPolicyById(int id) {
		return alarmPolicyDao.getAlarmPolicyById(id);
	}
	
	/**
	 * 查询所有服务策略列表
	 * 
	 * @return Page
	 */
	public List<AlarmPolicyEntity> getServiceAlarmPolicyListAll() {
		return alarmPolicyDao.getServiceAlarmPolicyListAll();
	}

	/**
	 * 分页查询服务策略列表
	 * 
	 * @return Page
	 */
	public Page<AlarmPolicyEntity> getServiceAlarmPolicyList(Page<AlarmPolicyEntity> page) {
		page.init();
		page.setPage(alarmPolicyDao.getServiceAlarmPolicyList(page), alarmPolicyDao.getAlarmPolicyCount());
		return page;
	}
	
	/**
	 * 查询系统策略列表
	 * 
	 * @return Page
	 */
	public List<AlarmPolicyEntity> getSystemAlarmPolicyList() {
		return alarmPolicyDao.getSystemAlarmPolicyList();
	}

	/**
	 * 添加策略
	 * 
	 */
	@Transactional
	public void createAlarmPolicy(AlarmPolicyEntity alarmPolicyEntity) {
		alarmPolicyDao.createAlarmPolicy(alarmPolicyEntity);
		int id = alarmPolicyDao.getAlarmPolicyByName(alarmPolicyEntity.getAlarmPolicyName());
		alarmPolicyDao.createAlarmPolicyUser(id, alarmPolicyEntity.getUsers());
	}
	
	/**
	 * 修改策略
	 * 
	 */
	public void updateAlarmPolicy(AlarmPolicyEntity alarmPolicyEntity) {
		alarmPolicyDao.updateAlarmPolicy(alarmPolicyEntity);
		long id = alarmPolicyEntity.getId();
		alarmPolicyDao.deleteAlarmPolicyUser(id);
		alarmPolicyDao.createAlarmPolicyUser(id, alarmPolicyEntity.getUsers());
	}
	
	/**
	 * 删除策略
	 * 
	 */
	@Transactional
	public void deleteAlarmPolicy(int id) {
		alarmPolicyDao.deleteAlarmPolicy(id);
		alarmPolicyDao.deleteAlarmPolicyUser(id);
	}


	/**
	 * 校验策略名称是否存在
	 * 
	 * @return boolean
	 */
	public boolean checkName(AlarmPolicyEntity alarmPolicyEntity) {
		if (alarmPolicyEntity.getId() != null) {
			if (alarmPolicyDao.getAlarmPolicyById(alarmPolicyEntity.getId()).getAlarmPolicyName()
					.equals(alarmPolicyEntity.getAlarmPolicyName())) {
				return true;
			}
		}
		int count = alarmPolicyDao.checkName(alarmPolicyEntity.getAlarmPolicyName());
		if (count > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 查询该策略是被使用
	 * 
	 * @return boolean
	 */
	public boolean isAlarmPolicyUsed(long id) {
		if (alarmPolicyDao.getPolicyCount(id) != 0) {
			return true;
		}else {
			return false;
		}
	}

}
