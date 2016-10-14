package apm.entity.systemlog;

/**
 * 监控统计实体类
 *
 */
public class AlarmStatiticsEntity {

	// 统计数
	private Integer count;
	// 系统名称
	private String alarmSystemName;
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getAlarmSystemName() {
		return alarmSystemName;
	}
	public void setAlarmSystemName(String alarmSystemName) {
		this.alarmSystemName = alarmSystemName;
	}

}