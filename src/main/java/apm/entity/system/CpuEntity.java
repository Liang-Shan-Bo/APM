package apm.entity.system;

/**
 * @author CPU实体类
 *
 */
public class CpuEntity {

	public CpuEntity() {
	}

	public CpuEntity(Double userPercent, Double systemPercent, Double waitPercent, Double idlePercent) {
		this.userPercent = userPercent;
		this.systemPercent = systemPercent;
		this.waitPercent = waitPercent;
		this.idlePercent = idlePercent;
	}

	// 用户使用率
	private Double userPercent;
	// 系统使用率
	private Double systemPercent;
	// 当前等待率
	private Double waitPercent;
	// 当前空闲率
	private Double idlePercent;

	public Double getUserPercent() {
		return userPercent;
	}
	public void setUserPercent(Double userPercent) {
		this.userPercent = userPercent;
	}
	public Double getSystemPercent() {
		return systemPercent;
	}
	public void setSystemPercent(Double systemPercent) {
		this.systemPercent = systemPercent;
	}
	public Double getWaitPercent() {
		return waitPercent;
	}
	public void setWaitPercent(Double waitPercent) {
		this.waitPercent = waitPercent;
	}
	public Double getIdlePercent() {
		return idlePercent;
	}
	public void setIdlePercent(Double idlePercent) {
		this.idlePercent = idlePercent;
	}

}
