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
						<li class="active">个人中心</li>
					</ul>
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							系统消息<small> <i class="icon-double-angle-right"></i> 查看</small>
						</h1>
					</div>
					
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/systemLogList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
					</form>
					
					<div class="space-4"></div>
					<!-- 系统消息列表 -->
					<div class="row">
						<div class="col-xs-12">
							<div class="tabbable">
								<div class="tab-content no-border no-padding">
									<div class="tab-pane in active">
										<div class="message-container">
											<div id="id-message-list-navbar" class="message-navbar align-center clearfix">
												<a href="#" onclick="setAllRead();" class="messagebar-item-left btn btn-xs btn-message">全部设为已读</a>
												<!--  <a href="#" onclick="clearAllRead();" class="messagebar-item-left btn btn-xs btn-message" style="margin-left:100px;">清空所有已读消息</a> -->
												<div class="message-bar">
													<div class="message-infobar" id="id-message-infobar">
														<span class="blue bigger-150">系统消息</span>
														<span class="grey bigger-110">(${unReadCount} 条未读)</span>
													</div>
												</div>
											</div>

											<div class="message-list-container">
												<div class="message-list" id="message-list">
													<c:forEach items="${page.resultList}" var="msg">
														<div class="message-item <c:if test="${msg.readFlag == 0}">message-unread</c:if>">
															<span class="time">${fn:substring(msg.alarmTime, 0, 19)}</span>
															<span class="summary">
																<span class="text">
																	<a href="<%=path%>/detailMessage?id=${msg.id}">${msg.title}</a>
																</span>
															</span>
														</div>
													</c:forEach>
												</div>
											</div>
											<c:if test="${page.totalPage > 1}">
												<%@ include file="../page.jsp"%>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div><!-- 系统消息列表 -->
				</div>
			</div>
		</div>
	</div>
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<script type="text/javascript">
		// 全部设为已读
		function setAllRead() {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认将所有未读消息设为已读？", function(re) {
				if (re) {
					location.href = "setAllRead";
				}
			});
		}
		
		// 清空所有已读消息
		function clearAllRead() {
			bootbox.setDefaults("locale","zh_CN");  
			bootbox.confirm("确认清空所有已读消息？", function(re) {
				if (re) {
					location.href = "clearAllRead";
				}
			});
		}
	</script>
</body>
</html>

