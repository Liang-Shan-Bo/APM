package apm.util;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;

public class SystemUtil {

	/**
	 * 远程调用shell脚本开启/关闭服务
	 * 
	 * @param userName
	 * @param password
	 * @param address
	 * @param path
	 * @return 0:成功；1：失败
	 */
	public static Integer shell(String userName, String password, String address, String path) {
		// 指明连接主机的IP地址
		Connection conn = new Connection(address);
		Session ssh = null;
		try {
			// 连接到主机
			conn.connect();
			// 使用用户名和密码校验
			boolean isconn = conn.authenticateWithPassword(userName, password);
			if (!isconn) {
				return 1;
			} else {
				ssh = conn.openSession();
				// 执行命令
				ssh.execCommand("source /etc/profile;sh " + path);
				Thread.sleep(5000);
			}
			// 连接的Session和Connection对象都需要关闭
			ssh.close();
			conn.close();
		} catch (Exception e) {
			return 1;
		}
		return 0;
	}

	public static String getJmxUrl(String address, String port) {
		return "service:jmx:rmi:///jndi/rmi://" + address + ":" + port + "/jmxrmi";
	}
}
