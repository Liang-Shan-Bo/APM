package apm.util;

import java.io.IOException;

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
}
