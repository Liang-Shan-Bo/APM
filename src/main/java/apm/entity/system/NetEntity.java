package apm.entity.system;

/**
 * @author 网络参数实体类
 *
 */
public class NetEntity {

	public NetEntity() {
	}

	public NetEntity(Long rxPackets, Long rxBytes, Long rxErrors, Long rxDropped, Long txPackets, Long txBytes,
			Long txErrors, Long txDropped) {
		this.rxPackets = rxPackets;
		this.rxBytes = rxBytes;
		this.rxErrors = rxErrors;
		this.rxDropped = rxDropped;
		this.txPackets = txPackets;
		this.txBytes = txBytes;
		this.txErrors = txErrors;
		this.txDropped = txDropped;
	}

	// 接收的总包数
	private Long rxPackets;
	// 接收到的总字节数
	private Long rxBytes;
	// 接收到的错误包数
	private Long rxErrors;
	// 接收时丢弃的包数
	private Long rxDropped;
	// 发送的总包数
	private Long txPackets;
	// 发送的总字节数
	private Long txBytes;
	// 发送的错误包数
	private Long txErrors;
	// 发送时丢弃的包数
	private Long txDropped;

	public Long getRxPackets() {
		return rxPackets;
	}

	public void setRxPackets(Long rxPackets) {
		this.rxPackets = rxPackets;
	}

	public Long getRxBytes() {
		return rxBytes;
	}

	public void setRxBytes(Long rxBytes) {
		this.rxBytes = rxBytes;
	}

	public Long getRxErrors() {
		return rxErrors;
	}

	public void setRxErrors(Long rxErrors) {
		this.rxErrors = rxErrors;
	}

	public Long getRxDropped() {
		return rxDropped;
	}

	public void setRxDropped(Long rxDropped) {
		this.rxDropped = rxDropped;
	}

	public Long getTxPackets() {
		return txPackets;
	}

	public void setTxPackets(Long txPackets) {
		this.txPackets = txPackets;
	}

	public Long getTxBytes() {
		return txBytes;
	}

	public void setTxBytes(Long txBytes) {
		this.txBytes = txBytes;
	}

	public Long getTxErrors() {
		return txErrors;
	}

	public void setTxErrors(Long txErrors) {
		this.txErrors = txErrors;
	}

	public Long getTxDropped() {
		return txDropped;
	}

	public void setTxDropped(Long txDropped) {
		this.txDropped = txDropped;
	}

}
