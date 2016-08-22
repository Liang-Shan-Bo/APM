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
						<li class="active">服务策略</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							服务策略<small> <i class="icon-double-angle-right"></i> 编辑
							</small>
						</h1>
					</div>
					<!-- 编辑策略 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="updateForm" class="form-horizontal" role="form" action="<%=path%>/updateAlarmPolicy" method="post">
								<input type="hidden" id="id" name="id" value="${alarmPolicyEntity.id}"/>
								<input type="hidden" id="alarmPolicyType" name="alarmPolicyType" value="${alarmPolicyEntity.alarmPolicyType}"/>
								<input type="hidden" id="messageStartTime" name="messageStartTime" value="${alarmPolicyEntity.messageStartTime}"/>
								<input type="hidden" id="messageEndTime" name="messageEndTime" value="${alarmPolicyEntity.messageEndTime}"/>
								<input type="hidden" id="emailStartTime" name="emailStartTime" value="${alarmPolicyEntity.emailStartTime}"/>
								<input type="hidden" id="emailEndTime" name="emailEndTime" value="${alarmPolicyEntity.emailEndTime}"/>
								<input type="hidden" id="phoneStartTime" name="phoneStartTime" value="${alarmPolicyEntity.phoneStartTime}"/>
								<input type="hidden" id="phoneEndTime" name="phoneEndTime" value="${alarmPolicyEntity.phoneEndTime}"/>
								<input type="hidden" id="sendMessage" name="sendMessage"/>
								<input type="hidden" id="sendEmail" name="sendEmail"/>
								<input type="hidden" id="sendPhone" name="sendPhone"/>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="alarmPolicyName"> 策略名称 </label>
									<div class="col-sm-9">
										<input type="text" id="alarmPolicyName" class="col-xs-10 col-sm-4" name="alarmPolicyName" value="${alarmPolicyEntity.alarmPolicyName}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="sendFlag"> 是否报警 </label>
									<div class="col-sm-9">
										<select id="sendFlag" name="sendFlag">
											<option value="0" <c:if test="${alarmPolicyEntity.sendFlag == 0}">selected="selected"</c:if>>只记录不报警</option>
											<option value="1" <c:if test="${alarmPolicyEntity.sendFlag == 1}">selected="selected"</c:if>>记录并且报警</option>
										</select> 
									</div>
								</div>
								
								<div id="send" hidden="hidden">
									<div class="space-4"></div>
								
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="message">是否发送站内信 </label>
										<div class="col-sm-9">
											<label>
												<input class="ace ace-checkbox-2" <c:if test="${alarmPolicyEntity.sendMessage == 1}">checked="checked"</c:if> type="checkbox" id="message">
												<span class="lbl"> </span>
											</label>
										</div>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group" id="messageTime" hidden="hidden">
										<label class="col-sm-3 control-label no-padding-right"> 发送站内信时间范围</label>
										<div class="col-sm-9">
											<input type="text" class="input-mini" id="msgBeginHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="msgBeginMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="msgBeginSecU"/>
											<label class="time-font">-</label>
											<input type="text" class="input-mini" id="msgEndHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="msgEndMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="msgEndSecU"/>
										</div>
									</div>
			
									<div class="space-4"></div>
									
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="email"> 是否发送邮件</label>
										<div class="col-sm-9">
											<label>
												<input class="ace ace-checkbox-2" <c:if test="${alarmPolicyEntity.sendEmail == 1}">checked="checked"</c:if> type="checkbox" id="email">
												<span class="lbl"> </span>
											</label>
										</div>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group" id="emailTime" hidden="hidden">
										<label class="col-sm-3 control-label no-padding-right"> 发送邮件时间范围</label>
										<div class="col-sm-9">
											<input type="text" class="input-mini" id="emlBeginHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="emlBeginMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="emlBeginSecU"/>
											<label class="time-font">-</label>
											<input type="text" class="input-mini" id="emlEndHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="emlEndMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="emlEndSecU"/>
										</div>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="phone"> 是否发送短信</label>
										<div class="col-sm-9">
											<label>
												<input class="ace ace-checkbox-2" <c:if test="${alarmPolicyEntity.sendPhone == 1}">checked="checked"</c:if> type="checkbox" id="phone">
												<span class="lbl"> </span>
											</label>
										</div>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group" id="phoneTime" hidden="hidden">
										<label class="col-sm-3 control-label no-padding-right"> 发送短信时间范围</label>
										<div class="col-sm-9">
											<input type="text" class="input-mini" id="phnBeginHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="phnBeginMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="phnBeginSecU"/>
											<label class="time-font">-</label>
											<input type="text" class="input-mini" id="phnEndHourU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="phnEndMinU"/>
											<label class="time-font">:</label>
											<input type="text" class="input-mini" id="phnEndSecU"/>
										</div>
									</div>
									
									<div class="space-4"></div>
									
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="alarmPolicyLevel"> 达到报警级别</label>
										<div class="col-sm-9">
											<select id="alarmPolicyLevel" name="alarmPolicyLevel">
												<option value="1" <c:if test="${alarmPolicyEntity.alarmPolicyLevel == 1}">selected="selected"</c:if>>一般</option>
												<option value="2" <c:if test="${alarmPolicyEntity.alarmPolicyLevel == 2}">selected="selected"</c:if>>警告</option>
												<option value="3" <c:if test="${alarmPolicyEntity.alarmPolicyLevel == 3}">selected="selected"</c:if>>过高</option>
											</select> 
										</div>
									</div>
								</div>
		
								<div class="space-4"></div>
		
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<a onclick="history.back()"  class="btn"><i class="icon-reply bigger-110"></i>返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
										&nbsp; &nbsp; &nbsp;
										<a id="submitBtn" class="btn btn-info"><i class="icon-ok bigger-110"></i>提&nbsp;&nbsp;&nbsp;&nbsp;交</a>
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- 编辑策略 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- 引用设置时间段JS -->
	<script src="js/apm.time.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			sendFlagChange();
			sendChange("message");
			sendChange("email");
			sendChange("phone");
		});
	
		$("#sendFlag").change(function() {
			sendFlagChange();
		});
		
		$("#message").click(function() {
			sendChange("message");
		});
		
		$("#email").click(function() {
			sendChange("email");
		});
		
		$("#phone").click(function() {
			sendChange("phone");
		});
	
		// 是否报警
		function sendFlagChange() {
			if ($("#sendFlag").val() == 0) {
				$("#send").hide();
			} else {
				$("#send").show();
			}
		}
		
		// 是否发送
		function sendChange(id) {
			if (!$("#" + id).prop('checked')) {
				$("#" + id + "Time").hide();
			} else {
				$("#" + id + "Time").show();
			}
		}
	
		// 点击提交
		$("#submitBtn").click(function() {
			if ($("#sendFlag").val() == 1) {
				if (!$("#message").prop('checked') && !$("#email").prop('checked') && !$("#phone").prop('checked')) {
					bootbox.setDefaults("locale", "zh_CN");
					bootbox.alert("请至少选择一种发送方式", function() {
					});
					return;
				} else {
					setSendValueUpdate();
				}
			}
			$("#updateForm").submit();
		});
	
		// 校验表单
		$("#updateForm").validate({
			errorElement : 'div',
			errorClass : 'help-block',
			focusInvalid : false,
			rules : {
				alarmPolicyName : {
					required : true,
					remote : {
						type : "get",
						url : "<%=path%>/checkPolicyName",
						data : { id : function() {return $("#id").val();},
								 alarmPolicyName : function() {return $("#alarmPolicyName").val();}
						}
					}
				}
			},
			messages : {
				alarmPolicyName : {
					required : "请输入策略名称",
					remote : "该策略名称已存在"
				}
			},
	
			invalidHandler : function(event, validator) { //display error alert on form submit   
				$('.alert-danger', $('.login-form')).show();
			},
	
			highlight : function(e) {
				$(e).closest('.form-group').removeClass('has-info')
						.addClass('has-error');
			},
	
			success : function(e) {
				$(e).closest('.form-group').removeClass('has-error')
						.addClass('has-info');
				$(e).remove();
			}
		});
		
	</script>
</body>
</html>

