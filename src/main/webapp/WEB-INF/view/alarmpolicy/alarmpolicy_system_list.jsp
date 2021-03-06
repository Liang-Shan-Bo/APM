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
						<li class="active">系统策略</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							系统策略<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
					<!-- 系统策略列表 -->
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/systemAlarmPolicyList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
					</form>
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>策略名称</th>
											<th>是否报警</th>
											<th>站内信报警</th>
											<th>邮件报警</th>
											<th>短信报警</th>
											<th>报警策略</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${alarmPolicyEntity}" var="alarmPolicy">
											<tr>
												<td>${alarmPolicy.alarmPolicyName}</td>
												<td>
													<c:if test="${alarmPolicy.sendFlag == 0}">不报警</c:if>
													<c:if test="${alarmPolicy.sendFlag == 1}">报警</c:if>
												</td>
												<td>
													<c:if test="${alarmPolicy.sendMessage == 0}">不发送</c:if>
													<c:if test="${alarmPolicy.sendMessage == 1}">发送</c:if>
												</td>
												<td>
													<c:if test="${alarmPolicy.sendEmail == 0}">不发送</c:if>
													<c:if test="${alarmPolicy.sendEmail == 1}">发送</c:if>
												</td>
												<td>
													<c:if test="${alarmPolicy.sendPhone == 0}">不发送</c:if>
													<c:if test="${alarmPolicy.sendPhone == 1}">发送</c:if>
												</td>
												<td>
													<c:if test="${alarmPolicy.alarmPolicyLevel == 1}">正常</c:if>
													<c:if test="${alarmPolicy.alarmPolicyLevel == 2}">警告</c:if>
													<c:if test="${alarmPolicy.alarmPolicyLevel == 3}">过高</c:if>
												</td>
												<td>
													<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
														<a class="blue" href="detailAlarmPolicy?id=${alarmPolicy.id}" title="查看"> <i class="icon-zoom-in bigger-130"></i></a> 
														<shiro:hasRole name="admin">
															<a class="green" href="updateSystemAlarmPolicy?id=${alarmPolicy.id}" title="编辑"> <i class="icon-pencil bigger-130"></i></a>
													    </shiro:hasRole>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<ul class="pagination no-margin" id="paginator" style="float:right;">
								</ul>
							</div>
						</div>
					</div>
					<!-- 系统策略列表 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		$("#menu4").addClass("open");
		$("#menu4").find(".submenu").css("display","block");
		$("#systemAlarmPolicyList").addClass("active");
		// 删除策略
		function deletePolicy(id) {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认删除？", function(re) {
				if (re) {
					location.href = "deleteAlarmPolicy?id=" + id;
				}
			});
		}
	</script>
</body>
</html>

