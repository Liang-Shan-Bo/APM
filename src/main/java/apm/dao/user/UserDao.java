package apm.dao.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.user.User;
import apm.util.Page;

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
	public List<User> getAllEnabledUser() {
		String sql = "select * from apm_user where enabled = 1";
		List<User> list = (List<User>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<User>(User.class));
		return list;
	}
	
	/**
	 * 查询用户总数
	 * 
	 * @return int
	 */
	public int getUserCount() {
		String sql = "select count(*) from apm_user";
		return jdbcTemplate.queryForObject(sql,Integer.class);
	}
	
	/**
	 * 分页查询用户列表
	 * 
	 * @return List<User>
	 */
	public List<User> getUserList(Page<User> page) {
		String sql = "SELECT * FROM (" + 
						 "SELECT A.*, ROWNUM RN FROM ( " + 
							 "select a.id," +
								"a.login_name," +
								"a.create_time," +
								"a.create_user," +
								"a.update_time," +
								"a.update_user," +
								"a.enabled," +
								"min(b.role_id) role " +
							  "from apm_user a " +
							  "left join apm_user_role b on a.id = b.user_id " +
							  "left join apm_role c on c.id = b.role_id " +
							  "group by a.id," +
								"a.login_name," +
								"a.create_time," +
								"a.create_user," +
								"a.update_time," +
								"a.update_user," +
								"a.enabled " +
				          	  "order by id desc) A " + 
						 "WHERE ROWNUM <= ? ) page " + 
					 "WHERE RN >= ?";
		List<User> list = (List<User>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<User>(
						User.class));
		return list;
	}
	
	/**
	 * 根据策略ID获取用户列表
	 * 
	 * @return List<User>
	 */
	public List<User> getUserByPolicyId(Integer id) {
		String sql = "select u.* " +
						"from apm_user u," +
						"apm_policy_user p," +
						"apm_alarm_policy a " +
						"where a.id=? " +
						"and p.user_id=u.id " +
						"and p.alarm_policy_id=a.id" +
						"and u.enabled = 1";
		List<User> list = (List<User>) jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper<User>(User.class));
		return list;
	}
	
	/**
	 * 根据ID获取未列入报警列表用户
	 * 
	 * @return List<User>
	 */
	public List<User> getOtherUser(Integer id) {
		String sql = "select * " + 
						"from apm_user " + 
						"where id not in " + 
							"(select u.id " +
							"from apm_user u," +
							"apm_policy_user p," +
							"apm_alarm_policy a " +
							"where p.alarm_policy_id=? " +
							"and p.user_id=u.id " +
							"and p.alarm_policy_id=a.id) " +
						"and enabled = 1";
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
		try {
			User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{loginName},
					new BeanPropertyRowMapper<User>(User.class));
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 根据ID查询用户
	 * 
	 * @return ServiceEntity
	 */
	public User getUserById(long id) {
		String sql = "select * from apm_user where id=?";
		User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper<User>(
				User.class));
		return user;
	}
	
	/**
	 * 新增用户
	 * 
	 */
	public void createUser(User user) {
		String sql = "insert into apm_user(" +
						"id," +
						"login_name," +
						"password," +
						"phone," +
						"email," +
						"create_time," +
						"create_user," +
						"enabled" +
					") values(APM_USER_SEQ.Nextval, ?, ?, ?, ?, SYSDATE, ?, 1)";
		jdbcTemplate.update(sql, new Object[]{user.getLoginName(), user.getPassword(), user.getPhone(),
				user.getEmail(), user.getLoginName()});
	}
	
	/**
	 * 修改密码
	 * 
	 */
	public void updatePassword(String password, long id) {
		String sql = "update apm_user set password=? where id=?";
		jdbcTemplate.update(sql, new Object[]{password, id});
	}
	
	/**
	 * 撤销管理员
	 * 
	 */
	public void revoke(long id, int roleType) {
		String sql = "delete from apm_user_role where user_id=? and role_id=?";
		jdbcTemplate.update(sql, new Object[]{id, roleType});
	}
	
	/**
	 * 任命管理员
	 * 
	 */
	public void appoint(long id, int roleType) {
		String sql = "insert into apm_user_role (user_id, role_id) values(?, ?)";
		jdbcTemplate.update(sql, new Object[]{id, roleType});
	}
	
	/**
	 * 启用用户
	 * 
	 */
	public void unfreeze(long id) {
		String sql = "update apm_user set enabled=1 where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 注销用户
	 * 
	 */
	public void freeze(long id) {
		String sql = "update apm_user set enabled=0 where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
}
