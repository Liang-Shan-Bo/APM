package apm.entity.norm;

/**
 * 指标实体类
 *
 */
public class NormEntity {

	// ID
	private Integer id;
	// 指标名称
	private String normName;
	// 指标类型
	private Integer normType;
	// 服务端口号
	private Integer normNormal;
	// 服务监控端口号
	private Integer normWarning;
	// CPU可使用数
	private Integer normDanger;
	// 指标类型(1:服务指标;2:系统指标)
	private Integer serviceType;
	// 是否使用
	private boolean used;
	// 删除标识(0:不可删除;1:可删除)
	private Integer deleteFlag;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
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
}
