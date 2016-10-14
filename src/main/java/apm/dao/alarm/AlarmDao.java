package apm.dao.alarm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.message.MessageEntity;
import apm.entity.systemlog.AlarmStatiticsEntity;

/**
 * 报警信息DAO
 *
 */
@Repository
public class AlarmDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 根据用户ID查询报警列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<MessageEntity> getAlarmList(Long id) {
		String sql = "select a.id," +
						"a.read_flag," +
						"a.title," +
						"a.message," +
						"b.alarm_value," +
						"b.alarm_time," +
						"b.alarm_type," +
						"b.alarm_system_name " +
						"from apm_alarm_send a " +
						"join apm_alarm_log b on b.id = a.alram_log_id " +
						"where a.read_flag = 0 " +
						"and a.user_id = ? " +
						"order by a.id desc"; 
		List<MessageEntity> list = (List<MessageEntity>) jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper<MessageEntity>(
				MessageEntity.class));
		return list;
	}
	
	/**
	 * 按时间段获取报警统计信息(1:本日；2：本月;3:本年；4：全部)
	 * 
	 * @return List<AlarmStatiticsEntity>
	 */
	public List<AlarmStatiticsEntity> getLogStatistics(int dateFlag) {
		String sql = "select count(*) count,a.alarm_system_name " +
				"from apm_alarm_send t " +
				"join apm_alarm_log a on t.alram_log_id = a.id " +
				"where 1 = 1 ";
		switch (dateFlag) {
			case 1 :
				sql += "and to_char(t.send_time,'yyyyMMdd')=to_char(sysdate,'yyyyMMdd') ";
				break;
			case 2 :
				sql += "and to_char(t.send_time,'yyyyMM')=to_char(sysdate,'yyyyMM') ";
				break;
			case 3 :
				sql += "and to_char(t.send_time,'yyyy')=to_char(sysdate,'yyyy') ";
				break;
			case 4 :
				break;
		}
		sql += "group by a.alarm_system_name";
		List<AlarmStatiticsEntity> list = (List<AlarmStatiticsEntity>) jdbcTemplate.query(sql,
				new BeanPropertyRowMapper<AlarmStatiticsEntity>(AlarmStatiticsEntity.class));
		return list;
	}
	
}
