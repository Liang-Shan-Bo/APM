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
							服务监控<small> <i class="icon-double-angle-right"></i> 编辑
							</small>
						</h1>
					</div>
					<!-- 编辑服务 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="updateForm" class="form-horizontal" role="form" action="<%=path%>/updateService" method="post">
								<input type="hidden" id="id" name="id" value="${serviceEntity.id}"/>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="serviceName"> 服务名称 </label>
									<div class="col-sm-9">
										<input type="text" id="serviceName" class="col-xs-10 col-sm-4" name="serviceName" value="${serviceEntity.serviceName}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="serviceAddress"> 服务IP地址 </label>
									<div class="col-sm-9">
										<input type="text" id="serviceAddress" class="col-xs-10 col-sm-4" name="serviceAddress" value="${serviceEntity.serviceAddress}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="servicePort"> 服务端口号 </label>
									<div class="col-sm-9">
										<input type="text" id="servicePort" class="col-xs-10 col-sm-4" name="servicePort" value="${serviceEntity.servicePort}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="monitorPort"> 监控端口号 </label>
									<div class="col-sm-9">
										<input type="text" id="monitorPort" class="col-xs-10 col-sm-4" name="monitorPort" value="${serviceEntity.monitorPort}"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="serviceUserName"> 登录系统用户名 </label>
									<div class="col-sm-9">
										<input type="text" id="serviceUserName" class="col-xs-10 col-sm-4" name="serviceUserName" value="${serviceEntity.serviceUserName}"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="servicePassword"> 登录系统口令 </label>
									<div class="col-sm-9">
										<input type="text" id="servicePassword" class="col-xs-10 col-sm-4" name="servicePassword" value="${serviceEntity.servicePassword}"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="startupPath"> 启动脚本路径 </label>
									<div class="col-sm-9">
										<input type="text" id="startupPath" class="col-xs-10 col-sm-4" name="startupPath" value="${serviceEntity.startupPath}"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="shutdownPath"> 关闭脚本路径 </label>
									<div class="col-sm-9">
										<input type="text" id="shutdownPath" class="col-xs-10 col-sm-4" name="shutdownPath" value="${serviceEntity.shutdownPath}"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normName"> 策略名称 </label>
									<div class="col-sm-9">
										<select name="alarmPolicyId">
											<c:forEach items="${alarmPolicyList}" var="alarmPolicy">
											<option value="${alarmPolicy.id}" <c:if test="${alarmPolicy.id == serviceEntity.alarmPolicyId}">selected="selected"</c:if>>${alarmPolicy.alarmPolicyName}</option>
											</c:forEach>
										</select> 
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normName"> 指标名称 </label>
									<div class="col-sm-9">
										<select name="normId">
											<c:forEach items="${normList}" var="norm">
											<option value="${norm.id}" <c:if test="${norm.id == serviceEntity.normId}">selected="selected"</c:if>>${norm.normName}</option>
											</c:forEach>
										</select> 
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
					<!-- 编辑服务 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		// 点击提交
		$("#submitBtn").click(function() {
			if ($("#updateForm").valid()) {
				$.ajax({
					url : "<%=path%>/testConnect",
					method : 'post',
					async: false,
					dataType: "json",
					data: { serviceAddress:$("#serviceAddress").val(), 
							servicePort:$('#servicePort').val(), 
							monitorPort:$("#monitorPort").val()},
					success : function(data){
						switch (data.connectResult) {
						case 0:
							$("#updateForm").submit();
							break;
						case 2:
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '服务端口无法连接',  
					        });
							break;
						case 3:
							bootbox.alert({  
					            buttons: { ok: { label: '确认' } },  
					            message: '监控端口无法连接',  
					        });
							break;
						default:
							break;
						}
					},
					error : function(data){
						bootbox.alert({  
				            buttons: { ok: { label: '确认' } },  
				            message: '连接失败',  
				        });
					},
				});
			}
		});
		
		// 修改IP地址时清空缓存
		$("#serviceAddress").change(function(){
			$("#servicePort").removeData("previousValue");
			$("#monitorPort").removeData("previousValue");
		}); 
		
		// IP地址验证
		jQuery.validator.addMethod("ip", function(value, element) {
		    var ip = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
		    return this.optional(element) || (ip.test(value) && (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 256));
		}, "Ip地址格式错误");
		
		// 校验表单
		$("#updateForm").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			rules: {
				serviceName: {
					required: true
				},
				serviceAddress: {
					required: true,
					ip: true
				},
				servicePort: {
					required: true,
					range: [1,65535],
					remote:{
			               type:"get",
			               url:"<%=path%>/checkPort",           
			               data:{ id: function() { return $("#id").val(); }, 
			            	   	  serviceAddress: function() { return $("#serviceAddress").val(); }, 
								  servicePort: function() { return $('#servicePort').val(); }
			               } 
					}
				},
				monitorPort: {
					required: true,
					range: [1,65535],
					remote:{
			               type:"get",
			               url:"<%=path%>/checkJmxPort",           
			               data:{ id: function() { return $("#id").val(); }, 
			            	      serviceAddress: function() { return $("#serviceAddress").val(); }, 
			            	   	  monitorPort: function() { return $('#monitorPort').val(); }
			               } 
					}
				}
			},
	
			messages: {
				serviceName: {
					required: "请输入服务名"
				},
				serviceAddress: {
					required: "请输入服务IP地址",
					ip: "请输入正确格式的IP地址"
				},
				servicePort: {
					required: "请输入服务端口号",
					range: "请输入1-65535之间的数字",
					remote: "该IP地址与端口已存在"
				},
				monitorPort: {
					required: "请输入监控端口号",
					range: "请输入1-65535之间的数字",
					remote: "该IP地址与端口已存在"
				}
			},
	
			invalidHandler: function (event, validator) { //display error alert on form submit   
				$('.alert-danger', $('.login-form')).show();
			},
	
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
	
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
				$(e).remove();
			}
		});
	</script>
</body>
</html>

