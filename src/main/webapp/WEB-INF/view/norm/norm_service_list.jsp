<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>监控系统</title>
<!-- basic styles -->
<link rel="stylesheet" type="text/css" href="style/assets/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/font-awesome.min.css" />
<!-- ace styles -->
<link rel="stylesheet" type="text/css" href="style/assets/css/ace.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-skins.min.css" />
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/assets/js/bootbox.min.js"></script>
</head>

<body>
	<%@ include file="../head.jsp"%>

	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<div class="main-container-inner">
			<%@ include file="../menu.jsp"%>
			<!-- 主页面 -->
			<div class="main-content">
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try {
							ace.settings.check('breadcrumbs', 'fixed')
						} catch (e) {
						}
					</script>

					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="<%=path%>/index">主页</a></li>
						<li class="active">服务指标</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							服务指标<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
					<!-- 服务指标列表 -->
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/serviceNormList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
					</form>
					<shiro:hasRole name="admin"> 
						<a href="<%=path%>/createNorm" class="btn btn-sm btn-success" style="margin-bottom:15px;float:right;">添加服务指标</a>
					</shiro:hasRole>
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>指标名称</th>
											<th>正常负载</th>
											<th>警告负载</th>
											<th>过高负载</th>
											<th>使用情况</th>
											<shiro:hasRole name="admin"> 
												<th>操作</th>
											</shiro:hasRole>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.resultList}" var="norm">
											<tr>
												<td>${norm.normName}</td>
												<td>${norm.normNormal}M</td>
												<td>${norm.normWarning}M</td>
												<td>${norm.normDanger}M</td>
												<td>
													<c:if test="${norm.used == true}"><span class="label label-sm label-success">已使用</span></c:if>
													<c:if test="${norm.used == false}"><span class="label label-sm label-danger">未使用</span></c:if>
												</td>
												<shiro:hasRole name="admin"> 
													<td>
														<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
															<a class="green" href="updateServiceNorm?id=${norm.id}" title="编辑"> <i class="icon-pencil bigger-130"></i></a>
															<c:if test="${norm.deleteFlag == 1}">
																<c:if test="${norm.used == false}">
																	<a class="red" href="#" onclick="deleteService('${norm.id}');" title="删除"> <i class="icon-trash bigger-130"></i></a>
																</c:if> 
															</c:if>
														</div>
													</td>
												</shiro:hasRole>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${page.totalPage > 1}">
									<%@ include file="../page.jsp"%>
								</c:if>
							</div>
						</div>
					</div>
					<!-- 服务指标列表 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		$("#menu5").addClass("open");
		$("#menu5").find(".submenu").css("display","block");
		$("#serviceNormList").addClass("active");
		// 删除指标
		function deleteService(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认删除？", function(re) {
				if (re) {
					location.href = "deleteNorm?id=" + id;
				}
			});
		}
	</script>
</body>
</html>

