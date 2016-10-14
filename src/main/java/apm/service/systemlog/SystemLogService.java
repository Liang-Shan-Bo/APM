package apm.service.systemlog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.systemlog.SystemLogDao;
import apm.entity.systemlog.AlarmStatiticsEntity;
import apm.entity.systemlog.SystemLogPage;

/**
 * @author 报警策略事务管理
 *
 */
@Service
public class SystemLogService {

	@Resource
	private SystemLogDao systemLogDao;

	/**
	 * 分页查询服务策略列表
	 * 
	 * @return Page
	 */
	public SystemLogPage getSystemLogList(SystemLogPage page) {
		page.init();
		page.setPage(systemLogDao.getSystemLogList(page), systemLogDao.getSystemLogCount(page));
		return page;
	}
	
	/**
	 * 按时间段获取监控日志统计信息(1:本日；2：本月;3:本年；4：全部)
	 * 
	 * @return Map
	 */
	public List<AlarmStatiticsEntity> getLogStatistics(int dateFlag) {
		return systemLogDao.getLogStatistics(dateFlag);
	}

}
