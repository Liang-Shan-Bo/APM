package apm.util;

import java.io.IOException;

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
			}
			// 连接的Session和Connection对象都需要关闭
			ssh.close();
			conn.close();
		} catch (IOException e) {
			return 1;
		}
		return 0;
	}
}
