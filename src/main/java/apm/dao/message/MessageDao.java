package apm.dao.message;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.message.MessageEntity;
import apm.entity.message.MessagePage;

/**
 * 系统消息DAO
 *
 */
@Repository
public class MessageDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询系统消息总数
	 * 
	 * @return int
	 */
	public Integer getMessageCount() {
		String sql = "select count(*) from apm_alarm_send";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	/**
	 * 根据ID查询系统消息总数
	 * 
	 * @return int
	 */
	public Integer getMessageCountById(MessagePage page) {
		String sql = "select count(*) from apm_alarm_send where user_id = ? ";
		if (page.getReadFlag() != null && !page.getReadFlag().equals("")) {
			sql += " and read_flag =" + page.getReadFlag();
		}
		return jdbcTemplate.queryForObject(sql, new Object[]{page.getId()}, Integer.class);
	}

	/**
	 * 根据ID分页查询系统消息
	 * 
	 * @return NormEntity
	 */
	public List<MessageEntity> getMessageListById(MessagePage page) {
		String sql = "SELECT * FROM (" + 
						 "SELECT A.*, ROWNUM RN FROM ( " + 
						 	"select c.id," +
								"c.read_flag," +
								"c.title," +
								"c.message," +
								"b.alarm_value," +
								"b.alarm_time," +
								"b.alarm_type," +
								"b.alarm_system_name " +
								"from apm_alarm_send c " + 
								"join apm_alarm_log b on b.id = c.alram_log_id " +
								"where c.user_id = ? ";  
		if (page.getReadFlag() != null && !page.getReadFlag().equals("")) {
			sql += "and c.read_flag = " + page.getReadFlag();
		}
		sql += " order by c.send_time desc ) A " + 
				"WHERE ROWNUM <= ? ) page " + 
			 "WHERE RN >= ?";
		List<MessageEntity> list = (List<MessageEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getId(), page.getEndRow(), page.getStartRow()},
				new BeanPropertyRowMapper<MessageEntity>(MessageEntity.class));
		return list;
	}
	
	/**
	 * 根据用户ID获取系统消息
	 * 
	 * @return Page
	 */
	public MessageEntity getMessageById(long id) {
		String sql = "select c.id," +
						"c.read_flag," +
						"c.title," +
						"c.message," +
						"b.alarm_value," +
						"b.alarm_time," +
						"b.alarm_type," +
						"b.alarm_system_name " +
						"from apm_alarm_send c " + 
						"join apm_alarm_log b on b.id = c.alram_log_id " +
						"where c.id = ? ";  
		MessageEntity messageEntity = (MessageEntity) jdbcTemplate.queryForObject(sql, new Object[]{id},
				new BeanPropertyRowMapper<MessageEntity>(MessageEntity.class));
		return messageEntity;
	}
	
	/**
	 * 根据用户ID获取未读消息条数
	 * 
	 * @return int
	 */
	public Integer getUnReadCount(long id) {
		String sql = "select count(*) from apm_alarm_send where user_id = ? and read_flag = 0";
		return jdbcTemplate.queryForObject(sql, new Object[]{id}, Integer.class);
	}
	
	/**
	 * 根据信息ID设为已读状态
	 * 
	 */
	public void setRead(long id) {
		String sql = "update apm_alarm_send set " +
						"read_flag=1 " +
					  	"where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 设为已读状态
	 * 
	 */
	public void setReadByUserId(long id) {
		String sql = "update apm_alarm_send set " +
						"read_flag=1 " +
					  	"where user_id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 清空所有已读消息
	 * 
	 */
	public void deleteReadById(long id) {
		String sql = "delete from apm_alarm_send " +
						"where user_id = ? " +
						"and read_flag = 1";
		jdbcTemplate.update(sql, new Object[]{id});
	}
}
