<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" type="text/css" href="style/assets/css/bootstrap-datepicker.min.css" />
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/assets/js/bootbox.min.js"></script>
<script src="style/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="style/assets/js/date-time/bootstrap-datepicker.zh-CN.min.js"></script>
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
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>
						<li class="active">用户管理</li>
					</ul>
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							用户管理<small> <i class="icon-double-angle-right"></i> 查看</small>
						</h1>
					</div>
					
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/userList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
					</form>
					
					<a href="<%=path%>/createService" class="btn btn-sm btn-success" style="margin-bottom:15px;float:right;">添加用户</a>
					
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>用户名</th>
											<th>创建人</th>
											<th>创建时间</th>
											<th>更新人</th>
											<th>更新时间</th>
											<th>用户角色</th>
											<th>用户状态</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.resultList}" var="user">
											<tr>
												<td>${user.loginName}</td>
												<td>${user.createUser}</td>
												<td>${user.createTime}</td>
												<td>${user.updateUser}</td>
												<td>${user.updateTime}</td>
												<td>
													<c:choose>
													    <c:when test="${user.role == 1}"><span class="label label-sm label-warning">超级管理员</span></c:when>
													    <c:when test="${user.role == 2}"><span class="label label-sm label-warning">监控管理员</span></c:when>
													    <c:otherwise> <span class="label label-sm label-info">普通用户</span></c:otherwise>
													</c:choose>
												</td>
												<td>
													<c:choose>
													    <c:when test="${user.enabled == 0}"><span class="label label-sm label-danger">不可用</span></c:when>
													    <c:when test="${user.enabled == 1}"><span class="label label-sm label-success">可用</span></c:when>
													</c:choose>
												</td>
												<td>
													<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
														<a class="blue" href="#" onclick="resetPassword('${user.id}');" title="重置密码"> <i class="icon-refresh bigger-130"></i></a> 
														<c:if test="${user.role != 1}">
													    	<c:choose>
															    <c:when test="${user.role == 2}">
															    	<a href="#" onclick="revoke('${user.id}');" title="撤销管理员"> <i class="blue icon-user bigger-130"></i></a>
															    </c:when>
															    <c:otherwise>
															    	<a href="#" onclick="appoint('${user.id}');" title="任命管理员"> <i class="orange icon-user bigger-130"></i></a>
															    </c:otherwise>
															</c:choose>
													    	<c:choose>
															    <c:when test="${user.enabled == 0}">
															    	<a href="#" onclick="unfreeze('${user.id}');" title="启用用户"> <i class="green icon-circle-blank bigger-130"></i></a>
															    </c:when>
															    <c:otherwise>
															    	<a href="#" onclick="freeze('${user.id}');" title="注销用户"> <i class="red icon-ban-circle bigger-130"></i></a>
															    </c:otherwise>
															</c:choose>
														</c:if>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${page.totalPage > 1}">
									<%@ include file="../page.jsp"%>
								</c:if>
							</div>
						</div>
					</div><!-- 用户管理列表 -->
				</div>
			</div>
		</div>
	</div>
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<script type="text/javascript">
		$("#menu7").addClass("active");
		// 重置密码
		function resetPassword(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认重置该用户密码为\"123456\"？", function(re) {
				if (re) {
					$.ajax({
						url : "<%=path%>/resetPassword",
						method : 'post',
						async: false,
						dataType: "json",
						data: { id : id },
						success : function(data){
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '重置密码成功',  
					        });
						},
						error : function(data){
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '发送请求失败',  
					        });
						}
					});
				}
			});
		}
		
		// 撤销管理员
		function revoke(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认撤销该用户管理员？", function(re) {
				if (re) {
					location.href = "revoke?id=" + id;
				}
			});
		}
		
		// 任命管理员
		function appoint(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认任命该用户为管理员？", function(re) {
				if (re) {
					location.href = "appoint?id=" + id;
				}
			});
		}
		
		// 启用用户
		function unfreeze(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认启用该用户？", function(re) {
				if (re) {
					location.href = "unfreeze?id=" + id;
				}
			});
		}
		
		// 注销用户
		function freeze(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认注销该用户？", function(re) {
				if (re) {
					location.href = "freeze?id=" + id;
				}
			});
		}
	</script>
</body>
</html>

