package apm.util;

import java.util.List;

/**
 * 
 * @author 分页类
 *
 * @param <T>
 */
public class Page<T> {

	public static final int NUMBERS_PER_PAGE = 10;
	// 一页显示的记录数
	private int numPerPage = NUMBERS_PER_PAGE;
	// 记录总数
	private int totalRow;
	// 总页数
	private int totalPage;
	// 当前页码
	private int currentPage;
	// 起始行数
	private int startRow;
	// 结束行数
	private int endRow;
	// 结果集存放List
	private List<T> resultList;

	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getTotalRow() {
		return totalRow;
	}
	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public List<T> getResultList() {
		return resultList;
	}
	public void setResultList(List<T> resultList) {
		this.resultList = resultList;
	}

	/**
	 * 初始化分页信息
	 */
	public void init() {
		if (this.currentPage == 0) {
			this.currentPage = 1;
		}
		this.startRow = numPerPage * (currentPage - 1) + 1;
		this.endRow = this.startRow + numPerPage - 1;
	}

	/**
	 * 分页处理
	 * 
	 * @param resultList
	 * @param count
	 */
	public void setPage(List<T> resultList, int count) {
		this.resultList = resultList;
		this.totalRow = count;
		this.totalPage = (totalRow + numPerPage - 1) / numPerPage;
	}

}
