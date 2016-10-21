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
						<li class="active">用户管理</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							添加用户<small> <i class="icon-double-angle-right"></i> 添加
							</small>
						</h1>
					</div>
					<!-- 添加用户 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="createForm" class="form-horizontal" role="form" action="<%=path%>/createUser" method="post">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="loginName"> 用户名 </label>
									<div class="col-sm-9">
										<input type="text" id="loginName" class="col-xs-10 col-sm-4" name="loginName"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="phone"> 手机号码 </label>
									<div class="col-sm-9">
										<input type="text" id="phone" class="col-xs-10 col-sm-4" name="phone"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="email"> 邮件地址 </label>
									<div class="col-sm-9">
										<input type="text" id="email" class="col-xs-10 col-sm-4" name="email"/>
									</div>
								</div>
								
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="role"> 用户角色 </label>
									<div class="col-sm-9">
										<select id="role" name="role">
											<option value="3">普通用户</option>
											<option value="2">管理员</option>
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
					<!-- 添加用户 -->
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
			if ($("#createForm").valid()) {
				$("#createForm").submit();
			}
		});
		
		jQuery.validator.addMethod("isMobile", function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
		}, "请正确填写您的手机号码");
		
		// 校验表单
		$("#createForm").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			rules: {
				loginName: {
					required: true,
					minlength: 5,
					remote:{
			               type:"get",
			               url:"<%=path%>/checkLoginName",           
			               data:{ loginName: function() { return $("#loginName").val(); }
			               } 
					}
				},
				phone: {
					required: true,
					isMobile: true
				},
				email: {
					required: true,
					email: true
				}
			},
	
			messages: {
				loginName: {
					required: "请输入用户名",
					minlength: "用户名不能少于5个字符",
					remote: "该用户名已存在"
				},
				phone: {
					required: "请输入手机号码",
					isMobile: "请输入正确格式的手机号码"
				},
				email: {
					required: "请输入邮件地址",
					email: "请输入正确格式的邮件地址"
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

