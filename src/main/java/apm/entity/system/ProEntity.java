package apm.entity.system;

/**
 * @author 进程参数实体类
 *
 */
public class ProEntity {

	public ProEntity() {
	}

	public ProEntity(Long pid, Long pPid, String name, char state, String memUsed, Long threads) {
		this.pid = pid;
		this.pPid = pPid;
		this.name = name;
		this.state = state;
		this.memUsed = memUsed;
		this.threads = threads;
	}

	// PID
	private Long pid;
	// PPID
	private Long pPid;
	// 进程名
	private String name;
	// 进程状态
	private char state;
	// 占用内存
	private String memUsed;
	// 线程数
	private Long threads;

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Long getpPid() {
		return pPid;
	}

	public void setpPid(Long pPid) {
		this.pPid = pPid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public char getState() {
		return state;
	}

	public void setState(char state) {
		this.state = state;
	}

	public String getMemUsed() {
		return memUsed;
	}

	public void setMemUsed(String memUsed) {
		this.memUsed = memUsed;
	}

	public Long getThreads() {
		return threads;
	}

	public void setThreads(Long threads) {
		this.threads = threads;
	}

}
