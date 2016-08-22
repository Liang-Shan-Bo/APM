package apm.util;

/**
 * @author 常量类
 *
 */
public class Constants {

	// 连接正常
	public static final int SERVICE_LINK_SUCCESS = 0;
	// IP连接失败
	public static final int HOST_LINK_REEOR = 1;
	// 端口连接失败
	public static final int PORT_LINK_REEOR = 2;
	// 监控端口连接失败
	public static final int PORT_JXM_LINK_REEOR = 3;

	// 服务关闭
	public static final int SERVICE_STATUS_CLOSE = 0;
	// 服务开启
	public static final int SERVICE_STATUS_OPEN = 1;

	// 服务未加载
	public static final int SERVICE_LOAD_NONE = 0;
	// 良好
	public static final int SERVICE_LOAD_FAVORABLE = 1;
	// 一般
	public static final int SERVICE_LOAD_NORMAL = 2;
	// 警告
	public static final int SERVICE_LOAD_WARNING = 3;
	// 危险
	public static final int SERVICE_LOAD_DANGER = 4;

	// 服务指标类型
	public static final int SERVICE_NORM_TYPE = 1;
	// 系统指标类型
	public static final int SYSTEM_NORM_TYPE = 2;

	// 服务策略类型
	public static final int SERVICE_POLICY_TYPE = 1;
	// 系统策略类型
	public static final int SYSTEM_POLICY_TYPE = 2;

	// CPU指标
	public static final int NORM_CPU = 1;
	// 内存指标
	public static final int NORM_MEM = 2;
	// 磁盘指标
	public static final int NORM_DISK = 3;
	// 网络指标
	public static final int NORM_NET = 4;

}
