package apm.dao.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.user.User;

/**
 * 用户DAO
 *
 */
@Repository
public class UserDao {

	@Resource
	private JdbcTemplate jdbcTemplate;

	/**
	 * 获取所有用户
	 * 
	 * @return List<User>
	 */
	public List<User> getAll() {
		String sql = "select * from apm_user";
		List<User> list = (List<User>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<User>(User.class));
		return list;
	}
	
	/**
	 * 根据策略ID获取用户列表
	 * 
	 * @return List<User>
	 */
	public List<User> getUserByPolicyId(Integer id) {
		String sql = "select u.* from apm_user u,apm_policy_user p,apm_alarm_policy a where a.id=? and p.user_id=u.id and p.alarm_policy_id=a.id";
		List<User> list = (List<User>) jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper<User>(User.class));
		return list;
	}
	
	/**
	 * 根据ID获取未列入报警列表用户
	 * 
	 * @return List<User>
	 */
	public List<User> getOtherUser(Integer id) {
		String sql = "select * from apm_user where id not in(select u.id from apm_user u,apm_policy_user p,apm_alarm_policy a where p.alarm_policy_id=? and p.user_id=u.id and p.alarm_policy_id=a.id)";
		List<User> list = (List<User>) jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper<User>(User.class));
		return list;
	}

	/**
	 * 根据用户名查询用户
	 * 
	 * @return ServiceEntity
	 */
	public User getUserByName(String loginName) {
		String sql = "select * from apm_user where login_name=?";
		User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{loginName}, new BeanPropertyRowMapper<User>(
				User.class));
		return user;
	}
}
