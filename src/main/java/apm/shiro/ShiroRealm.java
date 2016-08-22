package apm.shiro;

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
			info.addRole("user");
//			info.setRoles(user.getRoleList());
			// 用户的角色对应的所有权限，如果只使用角色定义访问权限，下面的四行可以不要
			// List<Role> roleList = user.getRoleList();
			// for (Role role : roleList) {
			// info.addStringPermissions(role.getPermissionsName());
			// }
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

	private User getUserByName(String loginName) {
		String sql = "select * from apm_user where login_name=?";
		User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{loginName}, new BeanPropertyRowMapper<User>(
				User.class));
		return user;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
