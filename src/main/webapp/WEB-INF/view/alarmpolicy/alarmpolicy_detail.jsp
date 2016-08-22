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
<script src="js/bootstrap-paginator.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/jquery.validate.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/assets/js/fuelux/fuelux.spinner.min.js"></script>
<script src="style/assets/js/bootbox.min.js"></script>
<style>
.time-font {
	font-size: 25px;
	height: 20px;
	width: 10px;
	margin-left: 3px;
	margin-top: -36px;
}
</style>
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
								<input type="hidden" id="messageStartTime" value="${alarmPolicyEntity.messageStartTime}"/>
								<input type="hidden" id="messageEndTime" value="${alarmPolicyEntity.messageEndTime}"/>
								<input type="hidden" id="emailStartTime" value="${alarmPolicyEntity.emailStartTime}"/>
								<input type="hidden" id="emailEndTime" value="${alarmPolicyEntity.emailEndTime}"/>
								<input type="hidden" id="phoneStartTime" value="${alarmPolicyEntity.phoneStartTime}"/>
								<input type="hidden" id="phoneEndTime" value="${alarmPolicyEntity.phoneEndTime}"/>
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
											<label class="col-sm-3 control-label no-padding-right"> 发送站内信时间范围</label>
											<label id="messageTime" class="col-xs-2"></label>
										</div>
									</c:if>
									
									<c:if test="${alarmPolicyEntity.sendEmail == 1}">
										<div class="space-4"></div>
										
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"> 发送邮件时间范围</label>
											<label id="emailTime" class="col-xs-2"></label>
										</div>
									</c:if>
									
									<c:if test="${alarmPolicyEntity.sendPhone == 1}">
										<div class="space-4"></div>
										
										<div class="form-group" >
											<label class="col-sm-3 control-label no-padding-right"> 发送短信时间范围</label>
											<label id="phoneTime" class="col-xs-2"></label>
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
	<script type="text/javascript">
		$(document).ready(function() {
			var ms = $("#messageStartTime").val().split(":");
			var me = $("#messageEndTime").val().split(":");
			var es = $("#emailStartTime").val().split(":");
			var ee = $("#emailEndTime").val().split(":");
			var ps = $("#phoneStartTime").val().split(":");
			var pe = $("#phoneEndTime").val().split(":");
			var mst = ms[0] + "时" + ms[1] + "分" + ms[2] + "秒";
			var mse = me[0] + "时" + me[1] + "分" + me[2] + "秒";
			var est = es[0] + "时" + es[1] + "分" + es[2] + "秒";
			var ese = ee[0] + "时" + ee[1] + "分" + ee[2] + "秒";
			var pst = ps[0] + "时" + ps[1] + "分" + ps[2] + "秒";
			var pse = pe[0] + "时" + pe[1] + "分" + pe[2] + "秒";
			$("#messageTime").text(mst + " 至 " + mse);
			$("#emailTime").text(est + " 至 " + ese);
			$("#phoneTime").text(pst + " 至 " + pse);
		});
	</script>
</body>
</html>

