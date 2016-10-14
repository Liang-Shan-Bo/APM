package apm.dao.systemlog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.systemlog.AlarmStatiticsEntity;
import apm.entity.systemlog.SystemLogEntity;
import apm.entity.systemlog.SystemLogPage;

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
		if (page.getAlarmType() != null && !page.getAlarmType().equals("")) {
			sql += " and alarm_type = " + page.getAlarmType();
		}
		if (page.getAlarmStartTime() != null && !page.getAlarmStartTime().equals("")) {
			sql += " and alarm_time >= to_date('"+ page.getAlarmStartTime() +"','yyyy-mm-dd')";
		}
		if (page.getAlarmEndTime() != null && !page.getAlarmEndTime().equals("")) {
			sql += " and alarm_time < to_date('"+ page.getAlarmEndTime() +"','yyyy-mm-dd') + 1";
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
		if (page.getAlarmType() != null && !page.getAlarmType().equals("")) {
			sql += " and alarm_type = " + page.getAlarmType();
		}
		if (page.getAlarmStartTime() != null && !page.getAlarmStartTime().equals("")) {
			sql += " and alarm_time >= to_date('"+ page.getAlarmStartTime() +"','yyyy-mm-dd')";
		}
		if (page.getAlarmEndTime() != null && !page.getAlarmEndTime().equals("")) {
			sql += " and alarm_time < to_date('"+ page.getAlarmEndTime() +"','yyyy-mm-dd') + 1";
		}
		sql +=  "order by alarm_time desc ) A " + 
				 "WHERE ROWNUM <= ? ) page " + 
			 "WHERE RN >= ?";
		List<SystemLogEntity> list = (List<SystemLogEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<SystemLogEntity>(
						SystemLogEntity.class));
		return list;
	}
	
	/**
	 * 按时间段获取监控日志统计信息(1:本日；2：本月;3:本年；4：全部)
	 * 
	 * @return List<AlarmStatiticsEntity>
	 */
	public List<AlarmStatiticsEntity> getLogStatistics(int dateFlag) {
		String sql = "select count(*) count,t.alarm_system_name " +
						"from apm_alarm_log t " +
						"where 1 = 1 ";
		switch (dateFlag) {
			case 1 :
				sql += "and to_char(alarm_time,'yyyyMMdd')=to_char(sysdate,'yyyyMMdd') ";
				break;
			case 2 :
				sql += "and to_char(alarm_time,'yyyyMM')=to_char(sysdate,'yyyyMM') ";
				break;
			case 3 :
				sql += "and to_char(alarm_time,'yyyy')=to_char(sysdate,'yyyy') ";
				break;
			case 4 :
				break;
		}
		sql += "group by t.alarm_system_name";
		List<AlarmStatiticsEntity> list = (List<AlarmStatiticsEntity>) jdbcTemplate.query(sql,
				new BeanPropertyRowMapper<AlarmStatiticsEntity>(AlarmStatiticsEntity.class));
		return list;
	}
}
