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
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>
						<li class="active">报警策略</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							报警策略<small> <i class="icon-double-angle-right"></i> 详细
							</small>
						</h1>
					</div>
					<!-- 策略详细信息 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="updateForm" class="form-horizontal" role="form" action="<%=path%>/updateAlarmPolicy" method="post">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"> 策略名称 </label>
									<label class="col-xs-2"> ${alarmPolicyEntity.alarmPolicyName}</label>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="sendFlag"> 是否报警 </label>
									<label class="col-xs-2">
										<c:if test="${alarmPolicyEntity.sendFlag == 0}">只记录不报警</c:if>
										<c:if test="${alarmPolicyEntity.sendFlag == 1}">记录并且报警</c:if>
									</label>
								</div>
								
								<c:if test="${alarmPolicyEntity.sendFlag == 1}">
									<c:if test="${alarmPolicyEntity.sendMessage == 1}">
										<div class="space-4"></div>
										
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"> 是否发送站内信</label>
											<label id="messageTime" class="col-xs-2">发送</label>
										</div>
									</c:if>
									
									<c:if test="${alarmPolicyEntity.sendEmail == 1}">
										<div class="space-4"></div>
										
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"> 是否发送邮件</label>
											<label id="emailTime" class="col-xs-2">发送</label>
										</div>
									</c:if>
									
									<c:if test="${alarmPolicyEntity.sendPhone == 1}">
										<div class="space-4"></div>
										
										<div class="form-group" >
											<label class="col-sm-3 control-label no-padding-right"> 是否发送短信</label>
											<label id="phoneTime" class="col-xs-2">发送</label>
										</div>
									</c:if>
									
									<div class="space-4"></div>
									
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="alarmPolicyLevel"> 达到报警级别</label>
										<label class="col-xs-2">
											<c:if test="${alarmPolicyEntity.alarmPolicyLevel == 1}">一般</c:if>
											<c:if test="${alarmPolicyEntity.alarmPolicyLevel == 2}">警告</c:if>
											<c:if test="${alarmPolicyEntity.alarmPolicyLevel == 3}">过高</c:if>
										</label>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="users">报警角色</label>
										<select class="class="col-xs-2" id="users" multiple="multiple" style="margin-left:12px;width:200px;height:155px;">
											<c:forEach items="${userList}" var="user">
												<option value="${user.id}">${user.loginName}</option>
											</c:forEach>
										</select>
									</div>
								</c:if>
								
								<div class="space-4"></div>
		
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<a onclick="history.back()"  class="btn"><i class="icon-reply bigger-110"></i>返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
										&nbsp; &nbsp; &nbsp;
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- 策略详细信息 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
</body>
</html>

