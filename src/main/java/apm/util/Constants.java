package apm.util;

import java.util.HashMap;
import java.util.Map;

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

	// CPU指标类型
	public static final int SYSTEM_NORM_CPU = 1;
	// 内存指标类型
	public static final int SYSTEM_NORM_MEM = 2;
	// 磁盘指标类型
	public static final int SYSTEM_NORM_DIS = 3;
	// 网络指标类型
	public static final int SYSTEM_NORM_NET = 4;

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

	// 当日
	public static final int DAY_TIME = 1;
	// 当月
	public static final int MONTH_TIME = 2;
	// 当年
	public static final int YEAR_TIME = 3;
	// 全部
	public static final int ALL_TIME = 4;

	// 超级管理员
	public static final int ROLE_SUPER = 1;
	// 管理员
	public static final int ROLE_ADMIN = 2;
	// 普通用户
	public static final int ROLE_USER = 2;

	// 默认密码
	public static final String DEFAULT_PASSWORD = "123456";

	// 缓存
	public final static Map<String, Long> map = new HashMap<String, Long>() {

		private static final long serialVersionUID = 1L;

		{
			put("jmx.remote.x.client.connection.check.period", 0L);
		}
	};
}
