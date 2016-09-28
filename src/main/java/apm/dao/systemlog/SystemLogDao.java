package apm.dao.systemlog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.systemlog.SystemLogEntity;
import apm.entity.systemlog.SystemLogPage;
import apm.util.Page;

/**
 * 报警策略DAO
 *
 */
@Repository
public class SystemLogDao {

	@Resource
	private JdbcTemplate jdbcTemplate;

	/**
	 * 查询监控日志总数
	 * 
	 * @return int
	 */
	public int getSystemLogCount(SystemLogPage page) {
		String sql = "select count(*) from apm_alarm_log where 1 = 1";
		if (page.getAlarmSystemName() != null && !page.getAlarmSystemName().equals("")) {
			sql += " and alarm_system_name like '%" + page.getAlarmSystemName() + "%'";
		}
		if (page.getAlarmType() != null) {
			sql += " and alarm_type = " + page.getAlarmType();
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	/**
	 * 分页查询监控日志列表
	 * 
	 * @return List<AlarmPolicyEntity>
	 */
	public List<SystemLogEntity> getSystemLogList(SystemLogPage page) {
		String sql = "SELECT * FROM (" + 
						 "SELECT A.*, ROWNUM RN FROM ( " + 
							 "select * from apm_alarm_log " + 
							 "where 1 = 1 ";  
							
		if (page.getAlarmSystemName() != null && !page.getAlarmSystemName().equals("")) {
			sql += " and alarm_system_name like '%" + page.getAlarmSystemName() + "%'";
		}
		if (page.getAlarmType() != null) {
			sql += " and alarm_type = " + page.getAlarmType();
		}
		sql +=  "order by alarm_time desc ) A " + 
				 "WHERE ROWNUM <= ? ) page " + 
			 "WHERE RN >= ?";
		List<SystemLogEntity> list = (List<SystemLogEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<SystemLogEntity>(
						SystemLogEntity.class));
		return list;
	}

}
