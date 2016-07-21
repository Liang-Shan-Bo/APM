package apm.util;

import java.io.IOException;

import org.springframework.core.io.support.PropertiesLoaderUtils;

public class PropertiesUtil {
	
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
