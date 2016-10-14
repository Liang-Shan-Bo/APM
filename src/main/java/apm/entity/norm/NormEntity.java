package apm.entity.norm;

/**
 * 指标实体类
 *
 */
public class NormEntity {

	// ID
	private Long id;
	// 指标名称
	private String normName;
	// 指标类型(1：CPU；2：内存；3：网络；4：磁盘)
	private Integer normType;
	// 一般指标
	private Integer normNormal;
	// 警告指标
	private Integer normWarning;
	// 过高指标
	private Integer normDanger;
	// 系统类型(1:服务指标;2:系统指标)
	private Integer serviceType;
	// 是否使用
	private boolean used;
	// 删除标识(0:不可删除;1:可删除)
	private Integer deleteFlag;

	public String getNormName() {
		return normName;
	}
	public void setNormName(String normName) {
		this.normName = normName;
	}
	public Integer getNormType() {
		return normType;
	}
	public void setNormType(Integer normType) {
		this.normType = normType;
	}
	public Integer getNormNormal() {
		return normNormal;
	}
	public void setNormNormal(Integer normNormal) {
		this.normNormal = normNormal;
	}
	public Integer getNormWarning() {
		return normWarning;
	}
	public void setNormWarning(Integer normWarning) {
		this.normWarning = normWarning;
	}
	public Integer getNormDanger() {
		return normDanger;
	}
	public void setNormDanger(Integer normDanger) {
		this.normDanger = normDanger;
	}
	public boolean isUsed() {
		return used;
	}
	public void setUsed(boolean used) {
		this.used = used;
	}
	public Integer getServiceType() {
		return serviceType;
	}
	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
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
