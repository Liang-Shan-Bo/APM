package apm.dao.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.service.ServiceEntity;
import apm.util.Page;

/**
 * 服务管理DAO
 *
 */
@Repository
public class ServiceDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询服务总数
	 * 
	 * @return ServiceEntity
	 */
	public int getServiceCount() {
		String sql = "select count(*) from apm_service_info";
		return jdbcTemplate.queryForObject(sql,Integer.class);
	}

	/**
	 * 根据ID查询服务信息
	 * 
	 * @return ServiceEntity
	 */
	public ServiceEntity getServiceById(int id) {
		String sql = "select * from apm_service_info where id=?";
		ServiceEntity serviceEntity = (ServiceEntity) jdbcTemplate.queryForObject(sql, new Object[]{id},
				new BeanPropertyRowMapper<ServiceEntity>(ServiceEntity.class));
		return serviceEntity;
	}

	/**
	 * 根据ID查询服务信息
	 * 
	 * @return Page
	 */
	public List<ServiceEntity> getServiceList(Page<ServiceEntity> page) {
		String sql = "SELECT * FROM (" + 
					 "SELECT A.*, ROWNUM RN FROM ( " + 
					 "select * from apm_service_info t " + 
					 "order by t.id ) A " + 
					 "WHERE ROWNUM <= ? ) page " + 
					 "WHERE RN >= ?";
		List<ServiceEntity> list = (List<ServiceEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<ServiceEntity>(
						ServiceEntity.class));
		return list;
	}
	
	/**
	 * 添加服务
	 * 
	 */
	public void createService(ServiceEntity serviceEntity) {
		String sql = "insert into apm_service_info(" +
						"id," +
						"service_name," +
						"service_address," +
						"service_port," +
						"monitor_port," +
						"cpu_available_count," +
						"system_name," +
						"system_arch," +
						"system_version," +
						"jvm_vendor," +
						"jvm_name," +
						"jvm_version" +
					") values(?,?,?,?,?,?,?,?,?,?,?,?)";
		jdbcTemplate.update(
				sql,
				new Object[]{getId(), serviceEntity.getServiceName(), serviceEntity.getServiceAddress(),
						serviceEntity.getServicePort(), serviceEntity.getMonitorPort(),
						serviceEntity.getCpuAvailableCount(), serviceEntity.getSystemName(),
						serviceEntity.getSystemArch(), serviceEntity.getSystemVersion(), serviceEntity.getJvmVendor(),
						serviceEntity.getJvmName(), serviceEntity.getJvmVersion()});
	}
	
	/**
	 * 修改服务
	 * 
	 */
	public void updateService(ServiceEntity serviceEntity) {
		String sql = "update apm_service_info set " +
						"service_name=?," +
						"service_address=?," +
						"service_port=?," +
					 	"monitor_port=?" +
					  	"where id=?";
		jdbcTemplate.update(sql, new Object[]{serviceEntity.getServiceName(), serviceEntity.getServiceAddress(),
				serviceEntity.getServicePort(), serviceEntity.getMonitorPort(), serviceEntity.getId()});
	}
	
	/**
	 * 删除服务
	 * 
	 */
	public void deleteService(int id) {
		String sql = "delete from apm_service_info where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 获取ID
	 * 
	 * @return Page
	 */
	public int getId() {
		String sql = "select max(id) from apm_service_info";
		int id = jdbcTemplate.queryForObject(sql,Integer.class);
		return ++id;
	}
	
	/**
	 * 校验IP和端口是否存在
	 * 
	 * @return boolean
	 */
	public int checkPort(ServiceEntity serviceEntity) {
		String sql = "select count(*) from apm_service_info where service_address = ? and service_port = ?";
		return jdbcTemplate.queryForObject(sql,
				new Object[]{serviceEntity.getServiceAddress(), serviceEntity.getServicePort()}, Integer.class);
	}
	
	/**
	 * 校验IP和监控端口是否存在
	 * 
	 * @return boolean
	 */
	public int checkJmxPort(ServiceEntity serviceEntity) {
		String sql = "select count(*) from apm_service_info where service_address = ? and monitor_port = ?";
		return jdbcTemplate.queryForObject(sql,
				new Object[]{serviceEntity.getServiceAddress(), serviceEntity.getMonitorPort()}, Integer.class);
	}
}
