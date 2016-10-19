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
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>
						<li class="active">服务监控</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							服务监控<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
					<!-- 服务管理列表 -->
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/serviceList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
					</form>
					<shiro:hasRole name="admin">
						<a href="<%=path%>/createService" class="btn btn-sm btn-success" style="margin-bottom:15px;float:right;">添加服务</a>
					</shiro:hasRole>
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>系统名称</th>
											<th>IP地址</th>
											<th>端口号</th>
											<th>开启状态</th>
											<th>负载</th>
											<th>使用指标</th>
											<th>使用策略</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.resultList}" var="service">
											<tr>
												<td>${service.serviceName}</td>
												<td>${service.serviceAddress}</td>
												<td>${service.servicePort}</td>
												<td id="status${service.id}">
													<c:if test="${service.status == 0}"><span class="label label-sm label-danger">关闭</span></c:if>
													<c:if test="${service.status != 0}"><span class="label label-sm label-success">开启</span></c:if>
												</td>
												<td id="load${service.id}">
													<c:if test="${service.load == 0}"><span class="label label-sm label-inverse">无</span></c:if>
													<c:if test="${service.load == 1}"><span class="label label-sm label-success">良好</span></c:if>
													<c:if test="${service.load == 2}"><span class="label label-sm label-success">正常</span></c:if>
													<c:if test="${service.load == 3}"><span class="label label-sm label-warning">警告</span></c:if>
													<c:if test="${service.load == 4}"><span class="label label-sm label-danger">过高</span></c:if>
												</td>
												<td>${service.normName}</td>
												<td>${service.alarmPolicyName}</td>
												<td>
													<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
														<c:if test="${service.status != 0}">
															<a id="detail${service.id}" class="blue" href="serviceDetail?id=${service.id}" title="查看"> <i class="icon-zoom-in bigger-130"></i></a> 
														</c:if>
													    <shiro:hasRole name="admin">  
													    	<a class="green" href="updateService?id=${service.id}" title="编辑"> <i class="icon-pencil bigger-130"></i></a>
															<c:if test="${service.deleteFlag == 1}">
														    	<a class="red" href="#" onclick="deleteService('${service.id}');" title="删除" > <i class="icon-trash bigger-130"></i></a>
																<c:if test="${service.status == 0}">
														    		<a id="switch${service.id}" class="green" href="#" onclick="startup('${service.id}');" title="开启"> <i class="icon-circle-blank bigger-130"></i></a>
														    	</c:if>
														    	<c:if test="${service.status != 0}">
														    		<a id="switch${service.id}" class="red" href="#" onclick="shutdown('${service.id}');" title="关闭"> <i class="icon-ban-circle bigger-130"></i></a>
														    	</c:if>
															</c:if>
													    </shiro:hasRole> 
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
					</div>
					<!-- 服务管理列表 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<div id="loading" hidden="hidden" style="position:absolute; top:6%; left:47%;z-index:9999;"><i class="icon-spinner icon-spin orange bigger-500"></i></div>
	<script type="text/javascript">
		$("#menu2").addClass("active");
		bootbox.setDefaults("locale","zh_CN");  
		// 删除服务
		function deleteService(id) {
			bootbox.confirm("是否确认删除？", function(re) {
				if (re) {
					location.href = "deleteService?id=" + id;
				}
			});
		}
		// 开启服务
		function startup(id) {
			bootbox.confirm("是否开启该服务？", function(re) {
				if (re) {
					$("#loading").show();
					$.ajax({
						url : "<%=path%>/startup",
						method : 'post',
						async: false,
						dataType: "json",
						data: { id : id },
						success : function(data){
							if (data.result != 0) {
								bootbox.alert({  
						            buttons: { ok: { label: '确认' } },  
						            message: '请确认服务参数是否正确',  
						        });
							}
						},
						error : function(data){
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '发送请求失败',  
					        });
						}
					});
					$("#loading").hide();
				}
			});
		}
		// 关闭服务
		function shutdown(id) {
			bootbox.confirm("是否关闭该服务？", function(re) {
				if (re) {
					$("#loading").show();
					$.ajax({
						url : "<%=path%>/shutdown",
						method : 'post',
						async: false,
						dataType: "json",
						data: { id : id },
						success : function(data){
							if (data.result != 0) {
								bootbox.alert({  
						            buttons: { ok: { label: '确认' } },  
						            message: '请确认服务参数是否正确',  
						        });
							}
						},
						error : function(data){
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '发送请求失败',  
					        });
						}
					});
					$("#loading").hide();
				}
			});
		}
		//定时刷新服务状态
		var serviceInterval = setInterval(function() {
			var cp = ${page.currentPage};
			$.ajax({
				url : "<%=path%>/getServiceStatus",
				method : 'post',
				async: false,
				dataType: "json",
				data: { currentPage : cp},
				success : function(data){
					var list = data.list;
					for (var i = 0; i < list.length; i++) {
						var status = $('#status' + list[i].id);
						var load = $('#load' + list[i].id);
						var switchFlag = $('#switch' + list[i].id);
						var detail = $('#detail' + list[i].id);
						if (list[i].load == 0) {
							status.html("<span class=\"label label-sm label-danger\">关闭</span>");
							load.html("<span class=\"label label-sm label-inverse\">无</span>");
							switchFlag.html("<i class=\"icon-circle-blank bigger-130\"></i>");
							switchFlag.attr("class", "green"); 
							switchFlag.attr("title", "开启");
							switchFlag.attr("onclick", "startup('" + list[i].id + "');");
							detail.hide();
						}else{
							status.html("<span class=\"label label-sm label-success\">开启</span>");
							switchFlag.html("<i class=\"icon-ban-circle bigger-130\"></i>");
							switchFlag.attr("class", "red"); 
							switchFlag.attr("title", "关闭");
							switchFlag.attr("onclick", "shutdown('" + list[i].id + "');");
							detail.show();
							switch (list[i].load) {
							case 1:
								load.html("<span class=\"label label-sm label-success\">良好</span>");
								break;
							case 2:
								load.html("<span class=\"label label-sm label-success\">正常</span>");
								break;
							case 3:
								load.html("<span class=\"label label-sm label-warning\">警告</span>");
								break;
							case 4:
								load.html("<span class=\"label label-sm label-danger\">过高</span>");
								break;
							default:
								break;
							}
						}
					}
				},
				error : function(data) {
					clearInterval(serviceInterval);
				}
			});
		}, 5000);
	</script>
</body>
</html>

