package apm.controller.init;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import apm.entity.service.ServiceEntity;
import apm.service.service.ServiceService;
import apm.util.PropertiesUtil;
import apm.util.SystemUtil;

/**
 * @author 初始化控制层
 *
 */
@Controller
public class InitController {

	private final static String[] tables = {"APM_ALARM_LOG", "APM_ALARM_POLICY", "APM_ALARM_SEND", "APM_NORM",
			"APM_POLICY_USER", "APM_ROLE", "APM_SERVICE_INFO", "APM_USER", "APM_USER_ROLE"};
	private final static String[] sequences = {"APM_ALARM_LOG_SEQ", "APM_ALARM_POLICY_SEQ", "APM_ALARM_SEND_SEQ",
			"APM_NORM_SEQ", "APM_SERVICE_INFO_SEQ", "APM_USER_SEQ"};
	
	@Resource
	private ServiceService serviceService;
	
	@Resource
	private JdbcTemplate jdbcTemplate;

	/**
	 * 测试数据库连接
	 * 
	 * @return String
	 */
	@RequestMapping(value = "/initConnect", method = RequestMethod.POST)
	@ResponseBody
	private boolean initConnect(@RequestParam(value = "driver") String driver, @RequestParam(value = "url") String url,
			@RequestParam(value = "username") String username, @RequestParam(value = "password") String password) {
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			return false;
		} catch (ClassNotFoundException e) {
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 服务策略列表页面
	 * 
	 * @return String
	 * @throws IOException
	 */
	@RequestMapping(value = "/init", method = RequestMethod.POST)
	public String init(@RequestParam(value = "driver") String driver, @RequestParam(value = "url") String url,
			@RequestParam(value = "username") String username, @RequestParam(value = "password") String password)
			throws IOException {
		initDatabase();
		initProperties(driver,url,username,password);
		return "redirect:/login";
	}

	/**
	 * 初始化数据库
	 * 
	 * @throws IOException
	 */
	private void initDatabase() throws IOException {
		for (String table : tables) {
			dropTable(table);
			createTable(table);
		}
		for (String sequence : sequences) {
			dropSequence(sequence);
			createSequence(sequence);
		}
		init();
	}

	/**
	 * 删除表
	 * 
	 * @param table
	 */
	private void dropTable(String table) {
		String sql = "drop table " + table;
		if (isExistTable(table)) {
			jdbcTemplate.execute(sql);
		}
	}

	/**
	 * 删除序列
	 * 
	 * @param sequence
	 */
	private void dropSequence(String sequence) {
		String sql = "drop sequence " + sequence;
		if (isExistSequence(sequence)) {
			jdbcTemplate.execute(sql);
		}
	}

	/**
	 * 创建表
	 * 
	 * @param table
	 * @throws IOException
	 */
	private void createTable(String table) throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		String buffer = IOUtils.toString(classLoader.getResourceAsStream("sql/" + table + ".sql"),"utf-8");
		String sqls[] = buffer.split(";");
		for (String sql : sqls) {
			jdbcTemplate.execute(sql);
		}
	}

	/**
	 * 创建序列
	 * 
	 * @param sequence
	 * @throws IOException
	 */
	private void createSequence(String sequence) throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		String buffer = IOUtils.toString(classLoader.getResourceAsStream("sql/" + sequence + ".sql"),"utf-8");
		String sqls[] = buffer.split(";");
		for (String sql : sqls) {
			jdbcTemplate.execute(sql);
		}
	}

	/**
	 * 判断表是否存在
	 * 
	 * @param table
	 * @return
	 */
	private boolean isExistTable(String table) {
		String sql = "select COUNT(*) from user_tables where table_name='" + table + "'";
		int count = jdbcTemplate.queryForObject(sql, Integer.class);
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 判断序列是否存在
	 * 
	 * @param sequence
	 * @return
	 */
	private boolean isExistSequence(String sequence) {
		String sql = "select count(*) from user_sequences where sequence_name='" + sequence + "'";
		int count = jdbcTemplate.queryForObject(sql, Integer.class);
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 写入初始数据
	 * 
	 * @throws IOException
	 */
	private void init() throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		String buffer = IOUtils.toString(classLoader.getResourceAsStream("sql/init.sql"),"utf-8");
		String sqls[] = buffer.split(";");
		for (String sql : sqls) {
			jdbcTemplate.execute(sql);
		}
		initService();
	}
	
	/**
	 * 添加默认系统监控
	 */
	private void initService(){
		ServiceEntity serviceEntity = new ServiceEntity();
		serviceEntity.setServiceName("监控系统");
		serviceEntity.setServiceAddress("127.0.0.1");
		serviceEntity.setServicePort("8877");
		serviceEntity.setMonitorPort("8999");
		serviceEntity.setAlarmPolicyId(1L);
		serviceEntity.setNormId(1L);
		serviceEntity.setDeleteFlag(0);
		serviceEntity = SystemUtil.setServieInfo(serviceEntity);
		serviceService.createService(serviceEntity);
	}
	
	/**
	 * 重置配置文件
	 * 
	 * @param driver
	 * @param url
	 * @param username
	 * @param password
	 */
	private void initProperties(String driver, String url,
			 String username,  String password){
		Properties properties = PropertiesUtil.getProperties("config.properties");
		properties.setProperty("system.init.flag", "1");
		properties.setProperty("database.oracle.driver", driver);
		properties.setProperty("database.oracle.url", url);
		properties.setProperty("database.oracle.username", username);
		properties.setProperty("database.oracle.password", password);
		String path = this.getClass().getResource("/").getPath().replaceAll("%20", "");
		String filePath = path.substring(0, path.indexOf("WEB-INF")) + "WEB-INF/config.properties";
		try {
			properties.store(new FileOutputStream(filePath),null);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
