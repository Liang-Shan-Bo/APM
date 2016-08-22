package apm.controller.service;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.OperatingSystemMXBean;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.management.MBeanServerConnection;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.alrampolicy.AlarmPolicyEntity;
import apm.entity.norm.NormEntity;
import apm.entity.service.ServiceEntity;
import apm.service.alrampolicy.AlarmPolicyService;
import apm.service.norm.NormService;
import apm.service.service.ServiceService;
import apm.util.Constants;
import apm.util.Page;

/**
 * @author 服务监控控制层
 *
 */
@Controller
public class ServiceController {

	@Resource
	private ServiceService serviceService;

	@Resource
	private NormService normService;
	
	@Resource
	private AlarmPolicyService alarmPolicyService;

	/**
	 * 服务列表页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public String serviceList(Model model, Page<ServiceEntity> page) {
		page = serviceService.getServiceList(page);
		page.setResultList(setServieStatus(page.getResultList()));;
		model.addAttribute("page", page);
		return "service/service_list";
	}

	/**
	 * 服务详细信息
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/serviceDetail", method = RequestMethod.GET)
	public String serviceDetail(Model model, @RequestParam int id) {
		ServiceEntity serviceEntity = serviceService.getServiceById(id);
		String serviceUrl = "service:jmx:rmi:///jndi/rmi://" + serviceEntity.getServiceAddress() + ":"
				+ serviceEntity.getMonitorPort() + "/jmxrmi";
		model.addAttribute("serviceEntity", serviceEntity);
		model.addAttribute("serviceUrl", serviceUrl);
		return "service/service_detail";
	}

	/**
	 * 跳转到添加服务页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createService", method = RequestMethod.GET)
	public String createPage(Model model) {
		//获取指标列表
		List<NormEntity> normList = normService.getServiceNormListAll();
		model.addAttribute("normList", normList);
		//获取策略列表
		List<AlarmPolicyEntity> alarmPolicyList = alarmPolicyService.getServiceAlarmPolicyListAll();
		model.addAttribute("alarmPolicyList", alarmPolicyList);
		return "service/service_create";
	}

	/**
	 * 添加服务
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/createService", method = RequestMethod.POST)
	public String createService(Model model, ServiceEntity serviceEntity) {
		serviceEntity = setServieInfo(serviceEntity);
		serviceService.createService(serviceEntity);
		return "redirect:/serviceList";
	}

	/**
	 * 跳转到修改服务页面
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateService", method = RequestMethod.GET)
	public String updatePage(Model model, @RequestParam int id) {
		ServiceEntity serviceEntity = serviceService.getServiceById(id);
		model.addAttribute("serviceEntity", serviceEntity);
		//获取指标列表
		List<NormEntity> normList = normService.getServiceNormListAll();
		model.addAttribute("normList", normList);
		//获取策略列表
		List<AlarmPolicyEntity> alarmPolicyList = alarmPolicyService.getServiceAlarmPolicyListAll();
		model.addAttribute("alarmPolicyList", alarmPolicyList);
		return "service/service_update";
	}

	/**
	 * 修改服务
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/updateService", method = RequestMethod.POST)
	public String updateService(Model model, ServiceEntity serviceEntity) {
		serviceService.updateService(serviceEntity);
		return "redirect:/serviceList";
	}

	/**
	 * 删除服务
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/deleteService", method = RequestMethod.GET)
	public String deleteService(Model model, @RequestParam int id) {
		serviceService.deleteService(id);
		return "redirect:/serviceList";
	}

	/**
	 * 测试连接
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/testConnect", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> testConnect(ServiceEntity serviceEntity) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		int port = Integer.parseInt(serviceEntity.getServicePort());
		int jmxport = Integer.parseInt(serviceEntity.getMonitorPort());
		int connectResult = ServieConnect(serviceEntity.getServiceAddress(), port, jmxport);
		map.put("connectResult", connectResult);
		return map;
	}

	/**
	 * 返回连接状态
	 * 
	 * @return int(0：连接正常;1:IP地址无法连接;2:服务端口无法连接;3:监控端口无法连接)
	 */
	private static int ServieConnect(String Address, int port, int jmxPort) {
		// 测试端口是否已启用
		Socket socket = new Socket();
		try {
			socket.connect(new InetSocketAddress(Address, port));
		} catch (IOException e) {
			return Constants.PORT_LINK_REEOR;
		} finally {
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 连接监控服务
		String serviceUrl = "service:jmx:rmi:///jndi/rmi://" + Address + ":" + jmxPort + "/jmxrmi";
		try {
			JMXServiceURL ServiceURL = new JMXServiceURL(serviceUrl);
			JMXConnectorFactory.connect(ServiceURL);
		} catch (Exception e) {
			return Constants.PORT_JXM_LINK_REEOR;
		}
		return Constants.SERVICE_LINK_SUCCESS;
	}

	/**
	 * 获取服务当前状态
	 * 
	 * @return String
	 */
	private List<ServiceEntity> setServieStatus(List<ServiceEntity> list) {
		for (ServiceEntity serviceEntity : list) {
			int port = Integer.parseInt(serviceEntity.getServicePort());
			int jmxport = Integer.parseInt(serviceEntity.getMonitorPort());
			int connectResult = ServieConnect(serviceEntity.getServiceAddress(), port, jmxport);
			if (connectResult != 0) {
				serviceEntity.setStatus(Constants.SERVICE_STATUS_CLOSE);
				serviceEntity.setLoad(Constants.SERVICE_LOAD_NONE);
			} else {
				serviceEntity.setStatus(Constants.SERVICE_STATUS_OPEN);
				String serviceUrl = "service:jmx:rmi:///jndi/rmi://" + serviceEntity.getServiceAddress() + ":"
						+ serviceEntity.getMonitorPort() + "/jmxrmi";
				JMXConnector jmxConnector = null;

				try {
					// 连接监控服务
					JMXServiceURL ServiceURL = new JMXServiceURL(serviceUrl);
					jmxConnector = JMXConnectorFactory.connect(ServiceURL);
					MBeanServerConnection mBeanServerConnection = jmxConnector.getMBeanServerConnection();
					// 获取内存信息
					MemoryMXBean memoryMXBean = ManagementFactory.newPlatformMXBeanProxy(mBeanServerConnection,
							ManagementFactory.MEMORY_MXBEAN_NAME, MemoryMXBean.class);
					// 获取指标
					NormEntity normEntity = normService.getNormById(serviceEntity.getNormId());
					int memTotal = (int) ((memoryMXBean.getHeapMemoryUsage().getUsed() + memoryMXBean
							.getNonHeapMemoryUsage().getUsed()) / 1024 / 1024);
					if (memTotal >= normEntity.getNormDanger()) {
						serviceEntity.setLoad(Constants.SERVICE_LOAD_DANGER);
					} else if (memTotal >= normEntity.getNormWarning() && memTotal < normEntity.getNormDanger()) {
						serviceEntity.setLoad(Constants.SERVICE_LOAD_WARNING);
					} else if (memTotal >= normEntity.getNormNormal() && memTotal < normEntity.getNormWarning()) {
						serviceEntity.setLoad(Constants.SERVICE_LOAD_NORMAL);
					}else {
						serviceEntity.setLoad(Constants.SERVICE_LOAD_FAVORABLE);
					}
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
			}
		}
		return list;
	}

	/**
	 * 获取服务基本信息
	 * 
	 * @return ServiceEntity
	 */
	private static ServiceEntity setServieInfo(ServiceEntity serviceEntity) {
		String serviceUrl = "service:jmx:rmi:///jndi/rmi://" + serviceEntity.getServiceAddress() + ":"
				+ serviceEntity.getMonitorPort() + "/jmxrmi";
		JMXConnector jmxConnector = null;
		try {
			// 连接监控服务
			JMXServiceURL ServiceURL = new JMXServiceURL(serviceUrl);
			jmxConnector = JMXConnectorFactory.connect(ServiceURL);
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

	/**
	 * 校验IP和端口是否已存在
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkPort", method = RequestMethod.GET)
	@ResponseBody
	private boolean checkPort(ServiceEntity serviceEntity) {
		return serviceService.checkPort(serviceEntity);
	}

	/**
	 * 校验IP和监控端口是否已存在
	 * 
	 * @return boolean
	 */
	@RequestMapping(value = "/checkJmxPort", method = RequestMethod.GET)
	@ResponseBody
	private boolean checkJmxPort(ServiceEntity serviceEntity) {
		return serviceService.checkJmxPort(serviceEntity);
	}

}
