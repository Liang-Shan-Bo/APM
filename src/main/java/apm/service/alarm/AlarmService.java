package apm.service.alarm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.alarm.AlarmDao;
import apm.entity.message.MessageEntity;
import apm.entity.systemlog.AlarmStatiticsEntity;

/**
 * @author 报警信息事务管理
 *
 */
@Service
public class AlarmService {

	@Resource
	private AlarmDao alarmDao;


	/**
	 * 根据用户ID查询报警列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<MessageEntity> getAlarmList(Long id) {
		return alarmDao.getAlarmList(id);
	}
	
	/**
	 * 按时间段获取报警统计信息(1:本日；2：本月;3:本年；4：全部)
	 * 
	 * @return Map
	 */
	public List<AlarmStatiticsEntity> getLogStatistics(int dateFlag) {
		return alarmDao.getLogStatistics(dateFlag);
	}

}
