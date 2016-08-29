package apm.dao.alrampolicy;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.util.Constants;
import apm.util.Page;

/**
 * 报警策略DAO
 *
 */
@Repository
public class AlarmPolicyDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询服务策略总数
	 * 
	 * @return int
	 */
	public int getAlarmPolicyCount() {
		String sql = "select count(*) from apm_alarm_policy where alarm_policy_type = 1";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	/**
	 * 根据ID查询策略信息
	 * 
	 * @return AlarmPolicyEntity
	 */
	public AlarmPolicyEntity getAlarmPolicyById(int id) {
		String sql = "select * from apm_alarm_policy where id=?";
		AlarmPolicyEntity AlarmPolicyEntity = (AlarmPolicyEntity) jdbcTemplate.queryForObject(sql, new Object[]{id},
				new BeanPropertyRowMapper<AlarmPolicyEntity>(AlarmPolicyEntity.class));
		return AlarmPolicyEntity;
	}
	
	/**
	 * 根据策略名获取ID
	 * 
	 * @return AlarmPolicyEntity
	 */
	public Integer getAlarmPolicyByName(String name) {
		String sql = "select id from apm_alarm_policy where alarm_policy_name=?";
		Integer id = (Integer) jdbcTemplate.queryForObject(sql, new Object[]{name}, Integer.class);
		return id;
	}
	
	/**
	 * 查询所有服务策略列表
	 * 
	 * @return List<AlarmPolicyEntity>
	 */
	public List<AlarmPolicyEntity> getServiceAlarmPolicyListAll() {
		String sql = "select * from apm_alarm_policy where alarm_policy_type = 1 order by id";
		List<AlarmPolicyEntity> list = (List<AlarmPolicyEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<AlarmPolicyEntity>(
				AlarmPolicyEntity.class));
		return list;
	}
	
	/**
	 * 分页查询服务策略列表
	 * 
	 * @return List<AlarmPolicyEntity>
	 */
	public List<AlarmPolicyEntity> getServiceAlarmPolicyList(Page<AlarmPolicyEntity> page) {
		String sql = "SELECT * FROM (" + 
						 "SELECT A.*, ROWNUM RN FROM ( " + 
							 "select * from apm_alarm_policy t " + 
							 "where t.alarm_policy_type = 1 " + 
							 "order by t.id ) A " + 
						 "WHERE ROWNUM <= ? ) page " + 
					 "WHERE RN >= ?";
		List<AlarmPolicyEntity> list = (List<AlarmPolicyEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<AlarmPolicyEntity>(
						AlarmPolicyEntity.class));
		return list;
	}
	
	/**
	 * 查询系统策略列表
	 * 
	 * @return List<AlarmPolicyEntity>
	 */
	public List<AlarmPolicyEntity> getSystemAlarmPolicyList() {
		String sql = "select * from apm_alarm_policy t where t.alarm_policy_type = 2 order by id";
		List<AlarmPolicyEntity> list = (List<AlarmPolicyEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<AlarmPolicyEntity>(
				AlarmPolicyEntity.class));
		return list;
	}
	
	/**
	 * 添加策略
	 * 
	 */
	public void createAlarmPolicy(AlarmPolicyEntity alarmPolicyEntity) {
		String sql = "insert into apm_alarm_policy(" +
						"id," +
						"alarm_policy_name," +
						"send_flag," +
						"send_message," +
						"send_email," +
						"send_phone," +
						"alarm_policy_level," +
						"alarm_policy_type," +
						"delete_flag" +
					    ") values(APM_ALARM_POLICY_SEQ.Nextval,?,?,?,?,?,?,?,1)";
		jdbcTemplate.update(sql, new Object[]{alarmPolicyEntity.getAlarmPolicyName(), alarmPolicyEntity.getSendFlag(),
				alarmPolicyEntity.getSendMessage(), alarmPolicyEntity.getSendEmail(), alarmPolicyEntity.getSendPhone(),
				alarmPolicyEntity.getAlarmPolicyLevel(), Constants.SERVICE_POLICY_TYPE});
	}
	
	/**
	 * 修改策略
	 * 
	 */
	public void updateAlarmPolicy(AlarmPolicyEntity alarmPolicyEntity) {
		String sql = "update apm_alarm_policy set " +
						"alarm_policy_name=?," +
						"send_flag=?," +
						"send_message=?," +
						"send_email=?," +
						"send_phone=?," +
						"alarm_policy_level=?" +
					  	"where id=?";
		jdbcTemplate.update(sql, new Object[]{alarmPolicyEntity.getAlarmPolicyName(), alarmPolicyEntity.getSendFlag(),
				alarmPolicyEntity.getSendMessage(), alarmPolicyEntity.getSendEmail(), alarmPolicyEntity.getSendPhone(),
				alarmPolicyEntity.getAlarmPolicyLevel(), alarmPolicyEntity.getId()});
	}
	
	/**
	 * 删除策略
	 * 
	 */
	public void deleteAlarmPolicy(int id) {
		String sql = "delete from apm_alarm_policy where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 删除策略角色列表
	 * 
	 */
	public void deleteAlarmPolicyUser(int id) {
		String sql = "delete from apm_policy_user where alarm_policy_id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 校验策略名称是否存在
	 * 
	 * @return int
	 */
	public int checkName(String alarmPolicyName) {
		String sql = "select count(*) from apm_alarm_policy where alarm_policy_name = ?";
		return jdbcTemplate.queryForObject(sql,
				new Object[]{alarmPolicyName}, Integer.class);
	}
	
	/**
	 * 校验策略是否被使用
	 * 
	 * @return int
	 */
	public int getPolicyCount(int id) {
		String sql = "select count(*) from apm_service_info where alarm_policy_id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[]{id}, Integer.class);
	}
	
	/**
	 * 添加策略角色
	 * 
	 */
	public void createAlarmPolicyUser(int policyId, int[] users) {
		if (users == null) {
			return;
		}
		String sql = "insert into apm_policy_user(alarm_policy_id,user_id) values (?,?)";
		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setInt(1, policyId);
				ps.setInt(2, users[i]);
			}

			@Override
			public int getBatchSize() {
				return users.length;
			}
		});
	}
	
}
