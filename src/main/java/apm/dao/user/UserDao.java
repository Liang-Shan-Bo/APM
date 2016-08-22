package apm.dao.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.service.ServiceEntity;
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
