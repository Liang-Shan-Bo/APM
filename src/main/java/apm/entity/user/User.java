package apm.entity.user;

import java.util.Set;

/**
 * 用户实体类
 *
 */
public class User {

	// ID
	private Integer id;
	// 用户名
	private String loginName;
	// 密码
	private String password;
	// 姓名
	private String userName;
	// 角色列表
	private Set<String> roleList;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Set<String> getRoleList() {
		return roleList;
	}
	public void setRoleList(Set<String> roleList) {
		this.roleList = roleList;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

}