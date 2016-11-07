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
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
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

<body class="login-layout" style="background-image: url(style/assets/images/background.jpg); background-size: cover; background-repeat: no-repeat;background-size:100% 100%;">
	<div class="row" style="padding-top: 16%; width: 100%;">
		<div class="col-lg-3 col-lg-offset-7 col-md-3 col-md-offset-7 col-sm-3 col-sm-offset-7">
			<div id="login-box" class="login-box visible widget-box no-border" style="background-color: #4866b5;">
				<div class="col-lg-10 col-lg-offset-1">
				
					<div class="space"></div>
					
					<h4 class="header white lighter bigger">登录系统</h4>

					<form id="loginForm" action="<%=path%>/login" method="post">
						<div class="space"></div>
						<div class="form-group" style="height:43px;">
							<label class="block clearfix"> 
								<span class="block input-icon input-icon-right"> 
									<input type="text" id="loginName" class="form-control" placeholder="用户名" name="loginName" /> 
									<i class="icon-user"></i>
								</span>
							</label>
						</div>

						<div class="space"></div>
						
						<div class="form-group" style="height:43px;">
							<label class="block clearfix"> 
								<span class="block input-icon input-icon-right"> 
									<input type="password" id="password" class="form-control" placeholder="密码" name="password" /> 
									<span id="message" class="help-block" style="color: #d16e6c">${message}</span>
									<i class="icon-lock"></i>
								</span>
							</label>
						</div>

						<div class="space"></div>

						<div class="clearfix">
							<button type="submit" class="btn btn-login btn-block">
								<span style="font-size: 16px;"> 登 录</span>
							</button>
						</div>

						<div class="space"></div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function show_box(id) {
			jQuery('.widget-box.visible').removeClass('visible');
			jQuery('#' + id).addClass('visible');
		}

		// 校验表单
		$("#loginForm").validate(
				{
					errorElement : 'div',
					errorClass : 'help-block',
					focusInvalid : false,
					rules : {
						loginName : {
							required : true
						},
						password : {
							required : true
						}
					},

					messages : {
						loginName : {
							required : "请输入用户名"
						},
						password : {
							required : "请输入密码"
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

