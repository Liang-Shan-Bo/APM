package apm.websocket.service;

import java.io.IOException;
import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.ThreadMXBean;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.TimeUnit;

import javax.management.MBeanServerConnection;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import apm.entity.service.ServiceEntity;
import apm.util.DateUtil;

@ServerEndpoint(value = "/serviceSocket", encoders = {ServiceEncoder.class})
public class ServiceSocket {

	// 推送消息时间间隔(ms)
	private final static int SERVICE_INTERVAL = 5000;
	// JMX地址
	private static String service_url = null;
	// concurrent包的线程安全Set，用来存放每个客户端对应的WebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	private static CopyOnWriteArraySet<ServiceSocket> webSocketSet = new CopyOnWriteArraySet<ServiceSocket>();
	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;
	// 定时任务
	private Timer timer = null;
	// 获取CPU时间间隔
	private static int interval = 100;

	/**
	 * 连接建立成功调用的方法
	 * 
	 * @param session
	 *            可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		webSocketSet.add(this);
		// 启动定时任务
		timer = new Timer(true);
		timer.schedule(task, 0, SERVICE_INTERVAL);
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose() {
		webSocketSet.remove(this);
		// 关闭定时任务
		if (timer != null) {
			timer.cancel();
		}
	}

	/**
	 * 收到客户端消息后调用的方法
	 * 
	 * @param message
	 *            客户端发送过来的消息
	 */
	@OnMessage
	public void onMessage(String message) {
		service_url = message;
		interval = 100;
	}

	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("发生错误");
		error.printStackTrace();
	}

	/**
	 * 向客户端推送信息
	 * 
	 * @param Session
	 * @throws IOException
	 * @throws EncodeException
	 */
	public void sendMessage(Session session) throws IOException, EncodeException {
		if (session.isOpen() && service_url != null) {
			ServiceEntity info = getServiceInfo();
			if (session.isOpen()) {
				session.getBasicRemote().sendObject(info);
				interval = 5000;
			}
		}
	}

	/**
	 * 获取服务信息
	 * 
	 * @throws IOException
	 * @throws EncodeException
	 */
	public ServiceEntity getServiceInfo() throws IOException, EncodeException {
		JMXConnector jmxConnector = null;
		ServiceEntity serviceEntity = new ServiceEntity();

		try {
			// 连接监控服务
			JMXServiceURL ServiceURL = new JMXServiceURL(service_url);
			jmxConnector = JMXConnectorFactory.connect(ServiceURL);
			MBeanServerConnection mBeanServerConnection = jmxConnector.getMBeanServerConnection();

			// 计算单位时间内的CPU使用率
			OperatingSystemMXBean operatingSystemMXBean = ManagementFactory.newPlatformMXBeanProxy(
					mBeanServerConnection, ManagementFactory.OPERATING_SYSTEM_MXBEAN_NAME, OperatingSystemMXBean.class);
			double ratio = 0.0;
			long start = System.currentTimeMillis();
			long startC = (long) mBeanServerConnection.getAttribute(operatingSystemMXBean.getObjectName(),
					"ProcessCpuTime");
			// 设置单位时间间隔
			TimeUnit.MILLISECONDS.sleep(interval);
			long end = System.currentTimeMillis();
			long endC = (long) mBeanServerConnection.getAttribute(operatingSystemMXBean.getObjectName(),
					"ProcessCpuTime");
			int availableProcessors = operatingSystemMXBean.getAvailableProcessors();
			ratio = (endC - startC) / 1000000.0 / (end - start) / availableProcessors;
			// CPU使用率
			serviceEntity.setCpuPercentage(ratio);
			// 获取JVM信息
			ObjectName runtimeObjName = new ObjectName("java.lang:type=Runtime");
			// JVM启动时间
			Date startTime = new Date((Long) mBeanServerConnection.getAttribute(runtimeObjName, "StartTime"));
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			serviceEntity.setStartTime(df.format(startTime));
			// JVM连续工作时间
			Long spanTime = (Long) mBeanServerConnection.getAttribute(runtimeObjName, "Uptime");
			serviceEntity.setSpanTime(DateUtil.formatTimeSpan(spanTime));

			// 获取内存信息
			MemoryMXBean memoryMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
					ManagementFactory.MEMORY_MXBEAN_NAME, MemoryMXBean.class);
			// 堆内存信息
			MemoryUsage heapMemoryUsage = memoryMXBean.getHeapMemoryUsage();
			// 非堆内存信息
			MemoryUsage nonHeapMemoryUsage = memoryMXBean.getNonHeapMemoryUsage();
			serviceEntity.setMemoryUsed(heapMemoryUsage.getUsed() + nonHeapMemoryUsage.getUsed());
			serviceEntity.setMemoryCommitted(heapMemoryUsage.getCommitted() + nonHeapMemoryUsage.getCommitted());
			// 获取线程信息
			ThreadMXBean threadMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
					ManagementFactory.THREAD_MXBEAN_NAME, ThreadMXBean.class);
			serviceEntity.setThreadCount(threadMXBean.getThreadCount());
			serviceEntity.setDaemonThreadCount(threadMXBean.getDaemonThreadCount());
			serviceEntity.setPeakThreadCount(threadMXBean.getPeakThreadCount());
			// 获取加载类信息
			ClassLoadingMXBean classLoadingMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
					ManagementFactory.CLASS_LOADING_MXBEAN_NAME, ClassLoadingMXBean.class);
			// 当前加载到Java虚拟机中类的数量
			serviceEntity.setLoadedClassCount(classLoadingMXBean.getLoadedClassCount());
			serviceEntity.setTotalLoadedClassCount(classLoadingMXBean.getTotalLoadedClassCount());
			serviceEntity.setUnloadedClassCount(classLoadingMXBean.getUnloadedClassCount());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (jmxConnector != null) {
				jmxConnector.close();
			}
		}
		return serviceEntity;
	}

	/**
	 * 心跳任务
	 */
	TimerTask task = new TimerTask() {
		public void run() {
			try {
				sendMessage(session);
			} catch (IOException e) {
				e.printStackTrace();
			} catch (EncodeException e) {
				e.printStackTrace();
			}
		}
	};
}
