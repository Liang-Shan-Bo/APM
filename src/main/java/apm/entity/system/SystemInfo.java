package apm.entity.system;

import java.util.List;

/**
 * @author 系统参数实体类
 *
 */
public class SystemInfo {
	
	// CPU使用率列表
	private List<Double> users;
	// 磁盘使用率列表
	private List<DiskEntity> disks;
	// 时间轴
	private Long time;
	// 最大内存数
	private Long totalMem;
	// 已使用内存数
	private Long useMem;
	// 单位时间间隔内网络总流量
	private Long totalBytes;

	public List<Double> getUsers() {
		return users;
	}

	public void setUsers(List<Double> users) {
		this.users = users;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}

	public Long getTotalMem() {
		return totalMem;
	}

	public void setTotalMem(Long totalMem) {
		this.totalMem = totalMem;
	}

	public Long getUseMem() {
		return useMem;
	}

	public void setUseMem(Long useMem) {
		this.useMem = useMem;
	}

	public Long getTotalBytes() {
		return totalBytes;
	}

	public void setTotalBytes(Long totalBytes) {
		this.totalBytes = totalBytes;
	}

	public List<DiskEntity> getDisks() {
		return disks;
	}

	public void setDisks(List<DiskEntity> disks) {
		this.disks = disks;
	}

}
