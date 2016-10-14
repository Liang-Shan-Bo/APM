package apm.entity.systemlog;

import apm.util.Page;

public class SystemLogPage extends Page<SystemLogEntity> {

	// 报警类型
	private Integer alarmType;
	// 系统名称
	private String alarmSystemName;
	// 查询起始时间
	private String alarmStartTime;
	// 查询终止时间
	private String alarmEndTime;
	
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
	public String getAlarmStartTime() {
		return alarmStartTime;
	}
	public void setAlarmStartTime(String alarmStartTime) {
		this.alarmStartTime = alarmStartTime;
	}
	public String getAlarmEndTime() {
		return alarmEndTime;
	}
	public void setAlarmEndTime(String alarmEndTime) {
		this.alarmEndTime = alarmEndTime;
	}

}
