package apm.entity;

import java.util.List;

public class SystemInfo {

	private List<String> users;

	private Long time;

	private Long totalMem;

	private Long useMem;
	
	private Long totalBytes;

	public List<String> getUsers() {
		return users;
	}

	public void setUsers(List<String> users) {
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

}
