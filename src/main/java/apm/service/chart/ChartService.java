package apm.service.chart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import apm.dao.chart.ChartDao;
import apm.entity.chart.ChartEntity;

/**
 * @author 图表统计事务管理
 *
 */
@Service
public class ChartService {

	@Resource
	private ChartDao chartDao;

	/**
	 * 获取所有服务列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getAllChartList() {
		return chartDao.getAllChartList();
	}

	/**
	 * 获取统计列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getChartListById(String serviceId, String createTime, int dateFlag) {
		switch (dateFlag) {
		case 1:
			return chartDao.getChartListByDay(serviceId, createTime);
		case 2:
			return chartDao.getChartListByWeek(serviceId, createTime);
		case 3:
			return chartDao.getChartListByMonth(serviceId, createTime);
		}
		return null;
	}
}
