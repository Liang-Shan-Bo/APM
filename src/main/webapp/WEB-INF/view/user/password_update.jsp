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
						<li class="active">个人中心</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							修改密码<small> <i class="icon-double-angle-right"></i> 编辑
							</small>
						</h1>
					</div>
					<!-- 修改密码 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="updateForm" class="form-horizontal" role="form" action="<%=path%>/changePassword" method="post">
								<input type="password" style="display: none;">
								<input type="hidden" id="id" name="id" value="${userId}"/>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="oldPassword"> 当前密码 </label>
									<div class="col-sm-9">
										<input type="password" id="oldPassword" name="oldPassword" class="col-xs-10 col-sm-4"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="password"> 新密码 </label>
									<div class="col-sm-9">
										<input type="password" id="password" name="password" class="col-xs-10 col-sm-4"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="confirmPassword"> 确认密码 </label>
									<div class="col-sm-9">
										<input type="password" id="confirmPassword" name="confirmPassword" class="col-xs-10 col-sm-4"/>
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
					<!-- 修改密码 -->
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
				$("#updateForm").submit();
			}
		});
		
		// 确认密码验证
		jQuery.validator.addMethod("isSame", function(value, element) {
			if (value == $("#password").val()) {
				return true;
			}else {
				return false;
			}
		}, "确认密码与新密码不同");
		
		// 校验表单
		$("#updateForm").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			rules: {
				oldPassword: {
					required: true,
					remote:{
			               type:"post",
			               url:"<%=path%>/checkPassword",           
			               data:{ id: function() { return $("#id").val(); }, 
			            	   	  password: function() { return $("#oldPassword").val(); }
			               } 
					}
				},
				password: {
					required: true,
					minlength: 6,
				},
				confirmPassword: {
					required: true,
					isSame: true
				},
			},
	
			messages: {
				oldPassword: {
					required: "请输入当前密码",
					remote: "当前密码错误"
				},
				password: {
					required: "请输入新密码",
					minlength: "密码不能少于6个字符",
				},
				confirmPassword: {
					required: "请输入确认密码",
					isSame: "确认密码与新密码不同"
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

