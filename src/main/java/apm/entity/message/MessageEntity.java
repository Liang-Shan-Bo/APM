package apm.entity.message;

import apm.entity.systemlog.SystemLogEntity;

/**
 * 系统消息实体类
 *
 */
public class MessageEntity extends SystemLogEntity {

	// 已读标识(0：未读；1：已读)
	private Integer readFlag;
	// 消息标题
	private String title;
	// 消息内容
	private String message;

	public Integer getReadFlag() {
		return readFlag;
	}
	public void setReadFlag(Integer readFlag) {
		this.readFlag = readFlag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}