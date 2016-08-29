package apm.service.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.user.UserDao;
import apm.entity.user.User;

/**
 * @author 用户事务管理
 *
 */
@Service
public class UserService {

	@Resource
	private UserDao userDao;
	
	/**
	 * 获取所有用户
	 * 
	 * @return List<User>
	 */
	public List<User> getAll() {
		return userDao.getAll();
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
	 * 根据ID查询服务
	 * 
	 * @return ServiceEntity
	 */
	public User getUserByName(String loginName) {
		return userDao.getUserByName(loginName);
	}
}
