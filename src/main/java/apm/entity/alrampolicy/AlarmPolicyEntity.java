package apm.entity.alrampolicy;

/**
 * 报警策略实体类
 *
 */
public class AlarmPolicyEntity {

	// ID
	private Long id;
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
	// 报警级别(1：一般;2：警告;3：过高)
	private Integer alarmPolicyLevel;
	// 报警策略类型(1:服务策略;2:系统策略)
	private Integer alarmPolicyType;
	// 是否使用
	private boolean used;
	// 角色列表
	private int[] users;
	// 删除标识(0:不可删除;1:可删除)
	private Integer deleteFlag;

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
	public int[] getUsers() {
		return users;
	}
	public void setUsers(int[] users) {
		this.users = users;
	}
	public Integer getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
}