package apm.entity.systemlog;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import apm.util.Page;

public class SystemLogPage extends Page<SystemLogEntity> {

	// 报警类型
	private Integer alarmType;
	// 系统名称
	private String alarmSystemName;
	// 查询起始时间
	@DateTimeFormat( pattern = "yyyy-MM-dd HH:mm:ss" )
	private Date alarmStartTime;
	// 查询终止时间
	@DateTimeFormat( pattern = "yyyy-MM-dd HH:mm:ss" )
	private Date alarmEndTime;
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
	public Date getAlarmStartTime() {
		return alarmStartTime;
	}
	public void setAlarmStartTime(Date alarmStartTime) {
		this.alarmStartTime = alarmStartTime;
	}
	public Date getAlarmEndTime() {
		return alarmEndTime;
	}
	public void setAlarmEndTime(Date alarmEndTime) {
		this.alarmEndTime = alarmEndTime;
	}

}
