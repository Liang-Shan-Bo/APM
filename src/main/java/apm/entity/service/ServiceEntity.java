package apm.entity.service;

/**
 * 服务监控实体类
 *
 */
public class ServiceEntity {

	// ID
	private Long id;
	// 服务名称
	private String serviceName;
	// 服务IP地址
	private String serviceAddress;
	// 服务端口号
	private String servicePort;
	// 服务监控端口号
	private String monitorPort;
	// 登录系统用户名
	private String serviceUserName;
	// 登录系统用户口令
	private String servicePassword;
	// 启动脚本路径
	private String startupPath;
	// 关闭脚本路径
	private String shutdownPath;
	// CPU可使用数
	private Integer cpuAvailableCount;
	// 系统名称
	private String systemName;
	// 系统架构
	private String systemArch;
	// 系统版本
	private String systemVersion;
	// 虚拟机供应商
	private String jvmVendor;
	// 虚拟机名称
	private String jvmName;
	// 虚拟机版本
	private String jvmVersion;
	// cpu使用率
	private Double cpuPercentage;
	// 已使用内存
	private Long memoryUsed;
	// 可使用内存
	private Long memoryCommitted;
	// 当前活动线程数
	private Integer threadCount;
	// 当前守护线程数
	private Integer daemonThreadCount;
	// 总计启动线程数
	private Integer peakThreadCount;
	// 当前加载类数
	private Integer loadedClassCount;
	// 总加载类数
	private Long totalLoadedClassCount;
	// 已卸载类数
	private Long unloadedClassCount;
	// 启动时间
	private String startTime;
	// 连续工作时间
	private String spanTime;
	// 状态(0:关闭;1:开启)
	private Integer status;
	// 负载(0:无;1:良好;2：正常;3：警告;4:过高)
	private Integer load;
	// 指标ID
	private Long normId;
	// 指标名称
	private String normName;
	// 报警策略ID
	private Long alarmPolicyId;
	// 报警策略名称
	private String alarmPolicyName;
	// 删除标识(0:不可删除;1:可删除)
	private Integer deleteFlag;

	public String getServiceAddress() {
		return serviceAddress;
	}
	public void setServiceAddress(String serviceAddress) {
		this.serviceAddress = serviceAddress;
	}
	public String getServicePort() {
		return servicePort;
	}
	public void setServicePort(String servicePort) {
		this.servicePort = servicePort;
	}
	public String getMonitorPort() {
		return monitorPort;
	}
	public void setMonitorPort(String monitorPort) {
		this.monitorPort = monitorPort;
	}
	public Integer getCpuAvailableCount() {
		return cpuAvailableCount;
	}
	public void setCpuAvailableCount(Integer cpuAvailableCount) {
		this.cpuAvailableCount = cpuAvailableCount;
	}
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public String getSystemArch() {
		return systemArch;
	}
	public void setSystemArch(String systemArch) {
		this.systemArch = systemArch;
	}
	public String getSystemVersion() {
		return systemVersion;
	}
	public void setSystemVersion(String systemVersion) {
		this.systemVersion = systemVersion;
	}
	public String getJvmVendor() {
		return jvmVendor;
	}
	public void setJvmVendor(String jvmVendor) {
		this.jvmVendor = jvmVendor;
	}
	public String getJvmName() {
		return jvmName;
	}
	public void setJvmName(String jvmName) {
		this.jvmName = jvmName;
	}
	public String getJvmVersion() {
		return jvmVersion;
	}
	public void setJvmVersion(String jvmVersion) {
		this.jvmVersion = jvmVersion;
	}
	public Long getMemoryUsed() {
		return memoryUsed;
	}
	public void setMemoryUsed(Long memoryUsed) {
		this.memoryUsed = memoryUsed;
	}
	public Long getMemoryCommitted() {
		return memoryCommitted;
	}
	public void setMemoryCommitted(Long memoryCommitted) {
		this.memoryCommitted = memoryCommitted;
	}
	public Integer getThreadCount() {
		return threadCount;
	}
	public void setThreadCount(Integer threadCount) {
		this.threadCount = threadCount;
	}
	public Integer getDaemonThreadCount() {
		return daemonThreadCount;
	}
	public void setDaemonThreadCount(Integer daemonThreadCount) {
		this.daemonThreadCount = daemonThreadCount;
	}
	public Integer getPeakThreadCount() {
		return peakThreadCount;
	}
	public void setPeakThreadCount(Integer peakThreadCount) {
		this.peakThreadCount = peakThreadCount;
	}
	public Integer getLoadedClassCount() {
		return loadedClassCount;
	}
	public void setLoadedClassCount(Integer loadedClassCount) {
		this.loadedClassCount = loadedClassCount;
	}
	public Long getTotalLoadedClassCount() {
		return totalLoadedClassCount;
	}
	public void setTotalLoadedClassCount(Long totalLoadedClassCount) {
		this.totalLoadedClassCount = totalLoadedClassCount;
	}
	public Long getUnloadedClassCount() {
		return unloadedClassCount;
	}
	public void setUnloadedClassCount(Long unloadedClassCount) {
		this.unloadedClassCount = unloadedClassCount;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getSpanTime() {
		return spanTime;
	}
	public void setSpanTime(String spanTime) {
		this.spanTime = spanTime;
	}
	public void setCpuPercentage(Double cpuPercentage) {
		this.cpuPercentage = cpuPercentage;
	}
	public Double getCpuPercentage() {
		return cpuPercentage;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getLoad() {
		return load;
	}
	public void setLoad(Integer load) {
		this.load = load;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public Long getNormId() {
		return normId;
	}
	public void setNormId(Long normId) {
		this.normId = normId;
	}
	public String getNormName() {
		return normName;
	}
	public void setNormName(String normName) {
		this.normName = normName;
	}
	public Long getAlarmPolicyId() {
		return alarmPolicyId;
	}
	public void setAlarmPolicyId(Long alarmPolicyId) {
		this.alarmPolicyId = alarmPolicyId;
	}
	public String getAlarmPolicyName() {
		return alarmPolicyName;
	}
	public void setAlarmPolicyName(String alarmPolicyName) {
		this.alarmPolicyName = alarmPolicyName;
	}
	public String getStartupPath() {
		return startupPath;
	}
	public void setStartupPath(String startupPath) {
		this.startupPath = startupPath;
	}
	public String getShutdownPath() {
		return shutdownPath;
	}
	public void setShutdownPath(String shutdownPath) {
		this.shutdownPath = shutdownPath;
	}
	public String getServiceUserName() {
		return serviceUserName;
	}
	public void setServiceUserName(String serviceUserName) {
		this.serviceUserName = serviceUserName;
	}
	public String getServicePassword() {
		return servicePassword;
	}
	public void setServicePassword(String servicePassword) {
		this.servicePassword = servicePassword;
	}
	public Integer getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getId() {
		return id;
	}
}
