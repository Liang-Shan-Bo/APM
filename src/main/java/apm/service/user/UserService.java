package apm.service.user;

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
	 * 根据ID查询服务
	 * 
	 * @return ServiceEntity
	 */
	public User getUserByName(String loginName) {
		return userDao.getUserByName(loginName);
	}
}
