package apm.util;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;

import javax.management.MBeanServerConnection;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;

import apm.entity.service.ServiceEntity;
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
	
	/**
	 * 获取JMX地址
	 * 
	 * @return String
	 */
	public static String getJmxUrl(String address, String port) {
		return "service:jmx:rmi:///jndi/rmi://" + address + ":" + port + "/jmxrmi";
	}
	
	/**
	 * 获取服务基本信息
	 * 
	 * @return ServiceEntity
	 */
	public static ServiceEntity setServieInfo(ServiceEntity serviceEntity) {
		String serviceUrl = SystemUtil.getJmxUrl(serviceEntity.getServiceAddress(), serviceEntity.getMonitorPort());
		JMXConnector jmxConnector = null;
		try {
			// 连接监控服务
			JMXServiceURL ServiceURL = new JMXServiceURL(serviceUrl);
			jmxConnector = JMXConnectorFactory.connect(ServiceURL, Constants.map);
			MBeanServerConnection mBeanServerConnection = jmxConnector.getMBeanServerConnection();
			// 获取系统信息
			OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.newPlatformMXBeanProxy(
					mBeanServerConnection, ManagementFactory.OPERATING_SYSTEM_MXBEAN_NAME, OperatingSystemMXBean.class);
			serviceEntity.setCpuAvailableCount(operatingSystemMXBean.getAvailableProcessors());
			serviceEntity.setSystemName(operatingSystemMXBean.getName());
			serviceEntity.setSystemArch(operatingSystemMXBean.getArch());
			serviceEntity.setSystemVersion(operatingSystemMXBean.getVersion());
			// 获取JVM信息
			ObjectName runtimeObjName = new ObjectName("java.lang:type=Runtime");
			serviceEntity.setJvmName((String) mBeanServerConnection.getAttribute(runtimeObjName, "VmName"));
			serviceEntity.setJvmVendor((String) mBeanServerConnection.getAttribute(runtimeObjName, "VmVendor"));
			serviceEntity.setJvmVersion((String) mBeanServerConnection.getAttribute(runtimeObjName, "VmVersion"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jmxConnector != null) {
				try {
					jmxConnector.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return serviceEntity;
	}
}
