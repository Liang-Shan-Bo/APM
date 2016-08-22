package apm.entity.alrampolicy;

/**
 * 报警策略实体类
 *
 */
public class AlarmPolicyEntity {

	// ID
	private Integer id;
	// 策略名称
	private String alarmPolicyName;
	// 是否报警标识(0:否;1:是)
	private Integer sendFlag;
	// 是否发送站内信标识(0:否;1:是)
	private Integer sendMessage;
	// 是否发送邮件标识(0:否;1:是)
	private Integer sendEmail;
	// 是否发送短信标识(0:否;1:是)
	private Integer sendPhone;
	// 发送站内信起始区间
	private String messageStartTime;
	// 发送站内信结束区间
	private String messageEndTime;
	// 发送邮件起始区间
	private String emailStartTime;
	// 发送邮件结束区间
	private String emailEndTime;
	// 发送短信起始区间
	private String phoneStartTime;
	// 发送短信结束区间
	private String phoneEndTime;
	// 报警级别(1：一般;2：警告;3：过高)
	private Integer alarmPolicyLevel;
	// 报警策略类型(1:服务策略;2:系统策略)
	private Integer alarmPolicyType;
	// 是否使用
	private boolean used;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAlarmPolicyName() {
		return alarmPolicyName;
	}
	public void setAlarmPolicyName(String alarmPolicyName) {
		this.alarmPolicyName = alarmPolicyName;
	}
	public Integer getSendFlag() {
		return sendFlag;
	}
	public void setSendFlag(Integer sendFlag) {
		this.sendFlag = sendFlag;
	}
	public Integer getSendMessage() {
		return sendMessage;
	}
	public void setSendMessage(Integer sendMessage) {
		this.sendMessage = sendMessage;
	}
	public Integer getSendEmail() {
		return sendEmail;
	}
	public void setSendEmail(Integer sendEmail) {
		this.sendEmail = sendEmail;
	}
	public Integer getSendPhone() {
		return sendPhone;
	}
	public void setSendPhone(Integer sendPhone) {
		this.sendPhone = sendPhone;
	}
	public String getMessageStartTime() {
		return messageStartTime;
	}
	public void setMessageStartTime(String messageStartTime) {
		this.messageStartTime = messageStartTime;
	}
	public String getMessageEndTime() {
		return messageEndTime;
	}
	public void setMessageEndTime(String messageEndTime) {
		this.messageEndTime = messageEndTime;
	}
	public String getEmailStartTime() {
		return emailStartTime;
	}
	public void setEmailStartTime(String emailStartTime) {
		this.emailStartTime = emailStartTime;
	}
	public String getEmailEndTime() {
		return emailEndTime;
	}
	public void setEmailEndTime(String emailEndTime) {
		this.emailEndTime = emailEndTime;
	}
	public String getPhoneStartTime() {
		return phoneStartTime;
	}
	public void setPhoneStartTime(String phoneStartTime) {
		this.phoneStartTime = phoneStartTime;
	}
	public String getPhoneEndTime() {
		return phoneEndTime;
	}
	public void setPhoneEndTime(String phoneEndTime) {
		this.phoneEndTime = phoneEndTime;
	}
	public Integer getAlarmPolicyLevel() {
		return alarmPolicyLevel;
	}
	public void setAlarmPolicyLevel(Integer alarmPolicyLevel) {
		this.alarmPolicyLevel = alarmPolicyLevel;
	}
	public boolean isUsed() {
		return used;
	}
	public void setUsed(boolean used) {
		this.used = used;
	}
	public Integer getAlarmPolicyType() {
		return alarmPolicyType;
	}
	public void setAlarmPolicyType(Integer alarmPolicyType) {
		this.alarmPolicyType = alarmPolicyType;
	}
}