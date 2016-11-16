package apm.shiro;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import apm.entity.user.User;

/**
 * @author shiro
 *
 */
@Component
public class ShiroRealm extends AuthorizingRealm {

	private JdbcTemplate jdbcTemplate;

	/**
	 * 权限认证
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		// 获取登录时输入的用户名
		String loginName = (String) principalCollection.fromRealm(getName()).iterator().next();
		// 到数据库查是否有此对象
		User user = getUserByName(loginName);
		if (user != null) {
			// 权限信息对象info,用来存放查出的用户的所有的角色（role）及权限（permission）
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			// 用户的角色集合
			info.setRoles(getRoles(loginName));
			return info;
		}
		return null;
	}

	/**
	 * 登录认证;
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
			throws AuthenticationException {
		// UsernamePasswordToken对象用来存放提交的登录信息
		UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
		// 查出是否有此用户
		User user = getUserByName(token.getUsername());
		
		if (user != null) {
			// 若存在，将此用户存放到登录认证info中
			return new SimpleAuthenticationInfo(user.getLoginName(), user.getPassword(), getName());
		}
		
		return null;
	}

	/**
	 * 获取用户
	 * 
	 * @param loginName
	 * @return User
	 */
	private User getUserByName(String loginName) {
		String sql = "select * from apm_user where login_name=?";
		User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{loginName}, new BeanPropertyRowMapper<User>(
				User.class));
		return user;
	}

	/**
	 * 获取角色列表
	 * 
	 * @param loginName
	 * @return Set<String>
	 */
	private Set<String> getRoles(String loginName) {
		String sql = "select r.role_name from apm_user u,apm_role r,apm_user_role ur where u.login_name=? and ur.user_id =u.id and ur.role_id = r.id";
		List<String> roles = (List<String>) jdbcTemplate.queryForList(sql, new Object[]{loginName},
				java.lang.String.class);
		return new HashSet<String>(roles);
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
