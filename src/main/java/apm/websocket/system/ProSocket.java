package apm.websocket.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.hyperic.sigar.ProcState;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;
import org.hyperic.sigar.cmd.Ps;

import apm.entity.system.ProEntity;
import apm.util.PropertiesUtil;

@ServerEndpoint(value = "/proSocket", encoders = {ProEncoder.class})
public class ProSocket {

	// 推送消息时间间隔(ms)
	private static int interval = Integer.parseInt(PropertiesUtil.getValue("ws", "monitor.interval"));
	// concurrent包的线程安全Set，用来存放每个客户端对应的WebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	private static CopyOnWriteArraySet<ProSocket> webSocketSet = new CopyOnWriteArraySet<ProSocket>();
	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;
	// 定时任务
	private Timer timer = null;

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
		timer.schedule(task, 0, interval);
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

	}

	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		error.printStackTrace();
	}

	/**
	 * 向客户端推送信息
	 * 
	 * @param Session
	 * @throws IOException
	 * @throws EncodeException
	 * @throws SigarException
	 */
	public void sendMessage(Session session) throws IOException, EncodeException, SigarException {
		if (session.isOpen()) {
			List<ProEntity> list = getProInfo();
			if (list != null) {
				session.getBasicRemote().sendObject(list);
			}
		}
	}

	private List<ProEntity> getProInfo() throws SigarException {
		Sigar sigar = new Sigar();
		List<ProEntity> list = new ArrayList<ProEntity>();
		long[] pids = sigar.getProcList();
		Arrays.sort(pids);
		for (long pid : pids) {
			List<?> ps = Ps.getInfo(sigar, pid);
			ProcState prs = sigar.getProcState(pid);
			ProEntity pro = new ProEntity(pid, prs.getPpid(), prs.getName(), prs.getState(), ps.get(4).toString(),
					prs.getThreads());
			list.add(pro);
		}
		sigar.close();
		return list;
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
			} catch (SigarException e) {
				e.printStackTrace();
			}
		}
	};
}
