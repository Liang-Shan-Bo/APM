package apm.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.support.PropertiesLoaderUtils;

/**
 * @author 配置管理类
 *
 */
public class PropertiesUtil {
	
	/**
	 * 读取配置文件信息
	 * 
	 * @param fileName
	 * @param key
	 * @return String
	 */
	public static String getValue(String fileName, String key) {
		String result = "";
		try {
			result = PropertiesLoaderUtils.loadAllProperties(fileName + ".properties").getProperty(key);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 读取WEB-INF路径下配置文件
	 * 
	 * @param fileName
	 * @param key
	 * @return String
	 */
	public static Properties getProperties(String fileName) {
		String url = PropertiesUtil.class.getResource("/").getPath().replaceAll("%20", "");
		String path = url.substring(0, url.indexOf("WEB-INF")) + "WEB-INF/" + fileName;
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;
	}
}
