package apm.entity.option;

/**
 * 系统信息实体类
 *
 */
public class SystemEntity {

	public SystemEntity() {
	}

	public SystemEntity(String hostName, String arch, String cpuEndian, String dataModel, String description,
			String name, String patchLevel, String vendor, String vendorCodeName, String vendorName,
			String vendorVersion, String version) {
		this.hostName = hostName;
		this.arch = arch;
		this.cpuEndian = cpuEndian;
		this.dataModel = dataModel;
		this.description = description;
		this.name = name;
		this.patchLevel = patchLevel;
		this.vendor = vendor;
		this.vendorCodeName = vendorCodeName;
		this.vendorName = vendorName;
		this.vendorVersion = vendorVersion;
		this.version = version;
	}
	// 系统名称
	private String hostName;
	// 内核类型
	private String arch;
	// CPU字节序
	private String cpuEndian;
	// 操作系统位数
	private String dataModel;
	// 系统描述
	private String description;
	// 操作系统类型
	private String name;
	// 操作系统补丁级别
	private String patchLevel;
	// 操作系统供应商
	private String vendor;
	// 供应商编码名
	private String vendorCodeName;
	// 操作系统供应商名称
	private String vendorName;
	// 操作系统供应商版本
	private String vendorVersion;
	// 操作系统的版本号
	private String version;

	public String getArch() {
		return arch;
	}
	public void setArch(String arch) {
		this.arch = arch;
	}
	public String getCpuEndian() {
		return cpuEndian;
	}
	public void setCpuEndian(String cpuEndian) {
		this.cpuEndian = cpuEndian;
	}
	public String getDataModel() {
		return dataModel;
	}
	public void setDataModel(String dataModel) {
		this.dataModel = dataModel;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPatchLevel() {
		return patchLevel;
	}
	public void setPatchLevel(String patchLevel) {
		this.patchLevel = patchLevel;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getVendorCodeName() {
		return vendorCodeName;
	}
	public void setVendorCodeName(String vendorCodeName) {
		this.vendorCodeName = vendorCodeName;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public String getVendorVersion() {
		return vendorVersion;
	}
	public void setVendorVersion(String vendorVersion) {
		this.vendorVersion = vendorVersion;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

}
