package apm.entity.message;

import apm.util.Page;

public class MessagePage extends Page<MessageEntity> {

	// ID
	private Long id;
	// 已读标识(0：未读；1：已读)
	private Integer readFlag;

	public Integer getReadFlag() {
		return readFlag;
	}
	public void setReadFlag(Integer readFlag) {
		this.readFlag = readFlag;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

}
