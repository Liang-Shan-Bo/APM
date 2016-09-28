package apm.service.systemlog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.dao.alrampolicy.AlarmPolicyDao;
import apm.dao.systemlog.SystemLogDao;
import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.systemlog.SystemLogEntity;
import apm.entity.systemlog.SystemLogPage;
import apm.util.Page;

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

}
