package apm.service.user;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import apm.dao.user.UserDao;
import apm.entity.user.User;
import apm.util.Constants;
import apm.util.EncUtil;
import apm.util.Page;

/**
 * @author 用户事务管理
 *
 */
@Service
public class UserService {

	@Resource
	private UserDao userDao;

	/**
	 * 获取所有可用用户
	 * 
	 * @return List<User>
	 */
	public List<User> getAllEnabledUser() {
		return userDao.getAllEnabledUser();
	}

	/**
	 * 分页查询用户列表
	 * 
	 * @return Page
	 */
	public Page<User> getUserList(Page<User> page) {
		page.init();
		page.setPage(userDao.getUserList(page), userDao.getUserCount());
		return page;
	}

	/**
	 * 根据策略ID获取用户列表
	 * 
	 * @return List<User>
	 */
	public List<User> getUserByPolicyId(Integer id) {
		return userDao.getUserByPolicyId(id);
	}

	/**
	 * 根据ID获取未列入报警列表用户
	 * 
	 * @return List<User>
	 */
	public List<User> getOtherUser(Integer id) {
		return userDao.getOtherUser(id);
	}

	/**
	 * 根据登录名查询用户
	 * 
	 * @return ServiceEntity
	 */
	public User getUserByName(String loginName) {
		return userDao.getUserByName(loginName);
	}

	/**
	 * 新增用户
	 * 
	 */
	public void createUser(User user) {
		String loginName = (String) SecurityUtils.getSubject().getPrincipal();
		user.setCreateUser(loginName);
		user.setPassword(EncUtil.MD5(user.getPassword()));
		userDao.createUser(user);
	}

	/**
	 * 修改密码
	 * 
	 */
	public void updatePassword(String password, long id) {
		userDao.updatePassword(EncUtil.MD5(password), id);
	}

	/**
	 * 校验旧密码是否正确
	 * 
	 * @return boolean
	 */
	public boolean checkPassword(String password, long id) {
		User user = userDao.getUserById(id);
		if (user.getPassword().equals(EncUtil.MD5(password))) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 撤销管理员
	 * 
	 */
	public void revoke(long id) {
		userDao.revoke(id, Constants.ROLE_ADMIN);
	}

	/**
	 * 任命管理员
	 * 
	 */
	public void appoint(long id) {
		userDao.appoint(id, Constants.ROLE_ADMIN);
	}

	/**
	 * 启用用户
	 * 
	 */
	public void unfreeze(long id) {
		userDao.unfreeze(id);
	}

	/**
	 * 注销用户
	 * 
	 */
	public void freeze(long id) {
		userDao.freeze(id);
	}

	/**
	 * 校验用户名是否存在
	 * 
	 * @return boolean
	 */
	public boolean checkLoginName(String loginName) {
		User user = userDao.getUserByName(loginName);
		if (user != null) {
			return false;
		} else {
			return true;
		}
	}
}
