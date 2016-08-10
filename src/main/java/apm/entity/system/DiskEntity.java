package apm.entity.system;

public class DiskEntity {

	public DiskEntity() {
	}

	public DiskEntity(Double usePercent, String devName) {
		this.usePercent = usePercent;
		this.devName = devName;
	}
	// 磁盘使用率
	private Double usePercent;
	// 磁盘盘符名
	private String devName;

	public String getDevName() {
		return devName;
	}
	public void setDevName(String devName) {
		this.devName = devName;
	}
	public Double getUsePercent() {
		return usePercent;
	}
	public void setUsePercent(Double usePercent) {
		this.usePercent = usePercent;
	}
}
