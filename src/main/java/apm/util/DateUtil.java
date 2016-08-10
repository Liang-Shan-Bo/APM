package apm.util;

import java.util.Formatter;

public class DateUtil {

	public static String formatTimeSpan(long span) {
		span = span / 1000;
		long seconds = span % 60;

		span = span / 60;
		long mins = span % 60;

		span = span / 60;
		long hours = span % 24;

		span = span / 24;
		long days = span;
		Formatter formatter = new Formatter();
		String TimeSpan = formatter.format("%1$d天 %2$02d小时%3$02d分%4$02d秒", days, hours, mins, seconds).toString();
		formatter.close();
		return TimeSpan;
	}

}
