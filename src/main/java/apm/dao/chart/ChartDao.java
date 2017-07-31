package apm.dao.chart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.chart.ChartEntity;

/**
 * 图表统计DAO
 *
 */
@Repository
public class ChartDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 获取统计列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getAllChartList() {
		String sql = "select distinct a.service_id, " +
						"b.service_name " +
						"from apm_chart a " +
						"left join apm_service_info b on b.id = a.service_id " +
						"order by a.service_id"; 
		List<ChartEntity> list = (List<ChartEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<ChartEntity>(
				ChartEntity.class));
		return list;
	}
	
	/**
	 * 根据ID取当天统计列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getChartListByDay(String serviceId, String createTime) {
		String sql = "select to_char(a.create_time,'HH24:MI:SS') createTime, " +
						"a.cpu as cpuPercentage, " +
						"a.mem as memoryUsed " +
						"from apm_chart a " +
						"where to_char(a.create_time,'yyyy-mm-dd') = ? " +
						"and a.service_id = ? " +
						"order by a.create_time"; 
		List<ChartEntity> list = (List<ChartEntity>) jdbcTemplate.query(sql, new Object[] { createTime, serviceId },
				new BeanPropertyRowMapper<ChartEntity>(ChartEntity.class));
		return list;
	}
	
	/**
	 * 根据ID取当周统计列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getChartListByWeek(String serviceId, String createTime) {
		String sql = "select to_char(a.create_time,'yyyy-mm-dd') as createTime, " +
						"avg(a.cpu) as cpuPercentage, " +
						"avg(a.mem) as memoryUsed " +
						"from apm_chart a " +
						"where to_char(a.create_time,'iw') = to_char(to_date(?,'yyyy-mm-dd'),'iw') " +
						"and a.service_id = ? " +
						"group by to_char(a.create_time, 'yyyy-mm-dd') " +
						"order by createTime"; 
		List<ChartEntity> list = (List<ChartEntity>) jdbcTemplate.query(sql, new Object[] { createTime, serviceId },
				new BeanPropertyRowMapper<ChartEntity>(ChartEntity.class));
		return list;
	}
	
	/**
	 * 根据ID取当月统计列表
	 * 
	 * @return List<AlarmEntity>
	 */
	public List<ChartEntity> getChartListByMonth(String serviceId, String createTime) {
		String sql = "select to_char(a.create_time,'yyyy-mm-dd') as createTime, " +
						"avg(a.cpu) as cpuPercentage, " +
						"avg(a.mem) as memoryUsed " +
						"from apm_chart a " +
						"where to_char(a.create_time,'yyyy-mm') = substr(? ,0, 7) " +
						"and a.service_id = ? " +
						"group by to_char(a.create_time, 'yyyy-mm-dd') " +
						"order by createTime"; 
		List<ChartEntity> list = (List<ChartEntity>) jdbcTemplate.query(sql, new Object[] { createTime, serviceId },
				new BeanPropertyRowMapper<ChartEntity>(ChartEntity.class));
		return list;
	}
	
}
