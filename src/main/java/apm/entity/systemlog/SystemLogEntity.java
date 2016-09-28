package apm.entity.systemlog;

import java.util.Date;

/**
 * 监控日志实体类
 *
 */
public class SystemLogEntity {

	// ID
	private Integer id;
	// 报警参数
	private Integer alarmValue;
	// 报警时间
	private Date alarmTime;
	// 报警类型
	private Integer alarmType;
	// 系统名称
	private String alarmSystemName;
	// 日志概述
	private String alarmDesc;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getAlarmValue() {
		return alarmValue;
	}
	public void setAlarmValue(Integer alarmValue) {
		this.alarmValue = alarmValue;
	}
	public Date getAlarmTime() {
		return alarmTime;
	}
	public void setAlarmTime(Date alarmTime) {
		this.alarmTime = alarmTime;
	}
	public Integer getAlarmType() {
		return alarmType;
	}
	public void setAlarmType(Integer alarmType) {
		this.alarmType = alarmType;
	}
	public String getAlarmSystemName() {
		return alarmSystemName;
	}
	public void setAlarmSystemName(String alarmSystemName) {
		this.alarmSystemName = alarmSystemName;
	}
	public String getAlarmDesc() {
		return alarmDesc;
	}
	public void setAlarmDesc(String alarmDesc) {
		this.alarmDesc = alarmDesc;
	}
}