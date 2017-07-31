package apm.entity.chart;

/**
 * 图表统计实体类
 *
 */
public class ChartEntity {

	// ID
	private Long id;
	// 服务ID
	private String serviceId;
	// 服务名称
	private String serviceName;
	// 服务IP地址
	private String serviceAddress;
	// 服务监控端口号
	private String monitorPort;
	// CPU使用率
	private String cpuPercentage;
	// 已使用内存
	private Long memoryUsed;
	// 创建时间
	private String createTime;

	public String getServiceAddress() {
		return serviceAddress;
	}

	public void setServiceAddress(String serviceAddress) {
		this.serviceAddress = serviceAddress;
	}

	public String getMonitorPort() {
		return monitorPort;
	}

	public void setMonitorPort(String monitorPort) {
		this.monitorPort = monitorPort;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getCpuPercentage() {
		return cpuPercentage;
	}

	public void setCpuPercentage(String cpuPercentage) {
		this.cpuPercentage = cpuPercentage;
	}

	public Long getMemoryUsed() {
		return memoryUsed;
	}

	public void setMemoryUsed(Long memoryUsed) {
		this.memoryUsed = memoryUsed;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
