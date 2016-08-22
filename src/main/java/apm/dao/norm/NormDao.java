package apm.dao.norm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import apm.entity.norm.NormEntity;
import apm.util.Constants;
import apm.util.Page;

/**
 * 指标设置DAO
 *
 */
@Repository
public class NormDao {

	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询服务指标总数
	 * 
	 * @return int
	 */
	public int getNormCount() {
		String sql = "select count(*) from apm_norm where service_type = 1";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	/**
	 * 根据ID查询指标信息
	 * 
	 * @return NormEntity
	 */
	public NormEntity getNormById(int id) {
		String sql = "select * from apm_norm where id=?";
		NormEntity normEntity = (NormEntity) jdbcTemplate.queryForObject(sql, new Object[]{id},
				new BeanPropertyRowMapper<NormEntity>(NormEntity.class));
		return normEntity;
	}
	
	/**
	 * 查询所有服务指标列表
	 * 
	 * @return List<NormEntity>
	 */
	public List<NormEntity> getServiceNormListAll() {
		String sql = "select * from apm_norm where service_type = 1 order by id";
		List<NormEntity> list = (List<NormEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<NormEntity>(
				NormEntity.class));
		return list;
	}
	
	/**
	 * 分页查询服务指标列表
	 * 
	 * @return List<NormEntity>
	 */
	public List<NormEntity> getServiceNormList(Page<NormEntity> page) {
		String sql = "SELECT * FROM (" + 
						 "SELECT A.*, ROWNUM RN FROM ( " + 
							 "select * from apm_norm t " + 
							 "where t.service_type = 1 " + 
							 "order by t.id ) A " + 
						 "WHERE ROWNUM <= ? ) page " + 
					 "WHERE RN >= ?";
		List<NormEntity> list = (List<NormEntity>) jdbcTemplate.query(sql,
				new Object[]{page.getEndRow(), page.getStartRow()}, new BeanPropertyRowMapper<NormEntity>(
						NormEntity.class));
		return list;
	}
	
	/**
	 * 查询系统指标列表
	 * 
	 * @return List<NormEntity>
	 */
	public List<NormEntity> getSystemNormList() {
		String sql = "select * from apm_norm t where t.service_type = 2 order by id";
		List<NormEntity> list = (List<NormEntity>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<NormEntity>(
				NormEntity.class));
		return list;
	}
	
	/**
	 * 添加指标
	 * 
	 */
	public void createNorm(NormEntity normEntity) {
		String sql = "insert into apm_norm(" +
						"id," +
						"norm_name," +
						"norm_type," +
						"norm_normal," +
						"norm_warning," +
						"norm_danger," +
						"service_type" +
					") values(APM_NORM_SEQ.Nextval,?,?,?,?,?,?)";
		jdbcTemplate.update(sql,
				new Object[]{normEntity.getNormName(), normEntity.getNormType(), normEntity.getNormNormal(),
						normEntity.getNormWarning(), normEntity.getNormDanger(), Constants.SERVICE_NORM_TYPE});
	}
	
	/**
	 * 修改指标
	 * 
	 */
	public void updateNorm(NormEntity normEntity) {
		String sql = "update apm_norm set " +
						"norm_name=?," +
						"norm_normal=?," +
						"norm_warning=?," +
						"norm_danger=?" +
					  	"where id=?";
		jdbcTemplate.update(sql,
				new Object[]{normEntity.getNormName(), normEntity.getNormNormal(), normEntity.getNormWarning(),
						normEntity.getNormDanger(), normEntity.getId()});
	}
	
	/**
	 * 删除指标
	 * 
	 */
	public void deleteNorm(int id) {
		String sql = "delete from apm_norm where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
	}
	
	/**
	 * 校验指标名称是否存在
	 * 
	 * @return int
	 */
	public int checkName(String normName) {
		String sql = "select count(*) from apm_norm where norm_name = ?";
		return jdbcTemplate.queryForObject(sql,
				new Object[]{normName}, Integer.class);
	}
	
	/**
	 * 校验指标名称是否被使用
	 * 
	 * @return int
	 */
	public int getServiceCount(int id) {
		String sql = "select count(*) from apm_service_info where norm_id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[]{id}, Integer.class);
	}
	
}
