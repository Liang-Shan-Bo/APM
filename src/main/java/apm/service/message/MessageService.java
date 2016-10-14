package apm.service.message;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.message.MessageDao;
import apm.entity.message.MessageEntity;
import apm.entity.message.MessagePage;

/**
 * @author 系统消息事务管理
 *
 */
@Service
public class MessageService {

	@Resource
	private MessageDao messageDao;
	
	/**
	 * 分页查询系统消息列表
	 * 
	 * @return Page
	 */
	public MessagePage getMessageList(MessagePage page) {
		page.init();
		page.setPage(messageDao.getMessageListById(page), messageDao.getMessageCountById(page));
		return page;
	}
	
	/**
	 * 根据用户ID获取系统消息
	 * 
	 * @return Page
	 */
	public MessageEntity getMessageById(long id) {
		return messageDao.getMessageById(id);
	}
	
	/**
	 * 根据用户ID获取未读消息条数
	 * 
	 * @return int
	 */
	public int getUnReadCount(long id) {
		return messageDao.getUnReadCount(id);
	}
	
	/**
	 * 根据信息ID设为已读状态
	 * 
	 */
	public void setRead(long id) {
		messageDao.setRead(id);
	}
	
	/**
	 * 将用户所有未读设为已读状态
	 * 
	 */
	public void setReadByUserId(long id) {
		messageDao.setReadByUserId(id);
	}
	
	/**
	 * 清空所有已读消息
	 * 
	 */
	public void deleteReadById(long id) {
		messageDao.deleteReadById(id);
	}
}
