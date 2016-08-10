package apm.util;

public class Constants {
	
	//连接正常
	public static final int SERVICE_LINK_SUCCESS = 0;
	//IP连接失败
	public static final int HOST_LINK_REEOR = 1;
	//端口连接失败
	public static final int PORT_LINK_REEOR = 2;
	//监控端口连接失败
	public static final int PORT_JXM_LINK_REEOR = 3;
	
	//服务关闭
	public static final int SERVICE_STATUS_CLOSE = 0;
	//服务开启
	public static final int SERVICE_STATUS_OPEN = 1;
	
	//服务未加载
	public static final int SERVICE_LOAD_NONE = 0;
	//负载正常
	public static final int SERVICE_LOAD_NORMAL = 1;
	//负载较高
	public static final int SERVICE_LOAD_WARNING = 2;
	//负载过高
	public static final int SERVICE_LOAD_DANGER = 3;
	

}
