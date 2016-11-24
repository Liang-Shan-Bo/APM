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
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/jquery.validate.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
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
						<li class="active">系统消息</li>
					</ul>
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							系统消息<small> <i class="icon-double-angle-right"></i> 详细
							</small>
						</h1>
					</div>
					<!-- 详细信息 -->
					<div class="message-header">
						<div>
							<span class="blue bigger-125"> ${messageEntity.title} </span>

							<div class="space-4"></div>

							<i class="icon-star orange2 mark-star"></i>

							&nbsp;
							<span class="sender"> ${messageEntity.alarmSystemName} </span>

							&nbsp;
							<i class="icon-time bigger-110 orange middle"></i>
							<span class="time">${fn:substring(messageEntity.alarmTime, 0, 19)}</span>
						</div>
					</div>

					<div class="hr hr-double"></div>

					<div class="message-body clearfix">
						<p>
							${messageEntity.message}
						</p>
					</div>

					<div class="hr hr-double"></div>
					
					<div class="form-actions clearfix">
						<div class="col-md-offset-5">
							<a onclick="history.back()" class="btn"><i class="icon-reply bigger-110"></i>返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
							&nbsp; &nbsp; &nbsp;
						</div>
					</div>
					<!-- 详细信息 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
</body>
</html>

