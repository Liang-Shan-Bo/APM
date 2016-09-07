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
<script src="js/bootstrap-paginator.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/jquery.validate.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
</head>

<body class="login-layout">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="login-container">
						<div class="center">
							<h1>
								<i class="icon-desktop white"></i>
								<span class="white">监控系统</span>
							</h1>
						</div>

						<div class="space-6"></div>

						<div class="position-relative">
							<div id="login-box" class="login-box visible widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header blue lighter bigger">
											<i class="icon-coffee green"></i>
											请输入用户名和密码
										</h4>

										<div class="space-6"></div>

										<form action="<%=path%>/login" method="post">
											<fieldset>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control" placeholder="用户名" name="loginName"/>
														<i class="icon-user"></i>
													</span>
												</label>

												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="password" class="form-control" placeholder="密码" name="password"/>
														<i class="icon-lock"></i>
													</span>
												</label>

												<div class="space"></div>

												<div class="clearfix">
													<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
														<i class="icon-key"></i>
														登录
													</button>
												</div>

												<div class="space-4"></div>
											</fieldset>
										</form>
									</div><!-- /widget-main -->

									<div class="toolbar clearfix">
										<div>
											<a href="#" onclick="show_box('forgot-box'); return false;" class="forgot-password-link">
												<i class="icon-arrow-left"></i>
												忘记密码
											</a>
										</div>

										<div>
											<a href="#" onclick="show_box('signup-box'); return false;" class="user-signup-link">
												注册
												<i class="icon-arrow-right"></i>
											</a>
										</div>
									</div>
								</div><!-- /widget-body -->
							</div><!-- /login-box -->

							<div id="forgot-box" class="forgot-box widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header red lighter bigger">
											<i class="icon-key"></i>
											找回密码
										</h4>

										<div class="space-6"></div>
										<p>
											请输入您的绑定邮箱地址
										</p>

										<form>
											<fieldset>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="email" class="form-control" placeholder="Email" />
														<i class="icon-envelope"></i>
													</span>
												</label>

												<div class="clearfix">
													<button type="button" class="width-35 pull-right btn btn-sm btn-danger">
														<i class="icon-lightbulb"></i>
														发送
													</button>
												</div>
											</fieldset>
										</form>
									</div><!-- /widget-main -->

									<div class="toolbar center">
										<a href="#" onclick="show_box('login-box'); return false;" class="back-to-login-link">
											回到登录页面
											<i class="icon-arrow-right"></i>
										</a>
									</div>
								</div><!-- /widget-body -->
							</div><!-- /forgot-box -->

							<div id="signup-box" class="signup-box widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header green lighter bigger">
											<i class="icon-group blue"></i>
											注册新用户
										</h4>

										<div class="space-6"></div>
										<p> 请填写正确信息: </p>

										<form id="registerForm" action="<%=path%>/register" method="post">
											<input type="password" style="display: none;">
											<fieldset>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control" id="loginName" name="loginName" placeholder="用户名" />
														<i class="icon-user"></i>
													</span>
												</label>

												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="password" class="form-control" id="password" name="password" placeholder="密码" />
														<i class="icon-lock"></i>
													</span>
												</label>

												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="password" class="form-control" id="vPassword" placeholder="确认密码" />
														<i class="icon-retweet"></i>
													</span>
												</label>
												
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control" id="email" name="email" placeholder="邮件地址"/>
														<i class="icon-envelope"></i>
													</span>
												</label>
												
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control" id="phone" name="phone" placeholder="手机号码"/>
														<i class="icon-phone-sign"></i>
													</span>
												</label>

												<div class="space-24"></div>

												<div class="clearfix">
													<button type="reset" class="width-30 pull-left btn btn-sm">
														<i class="icon-refresh"></i>
														重置
													</button>

													<button type="submit" class="width-65 pull-right btn btn-sm btn-success">
														注册
														<i class="icon-arrow-right icon-on-right"></i>
													</button>
												</div>
											</fieldset>
										</form>
									</div>

									<div class="toolbar center">
										<a href="#" onclick="show_box('login-box'); return false;" class="back-to-login-link">
											<i class="icon-arrow-left"></i>
											回到登录页面
										</a>
									</div>
								</div><!-- /widget-body -->
							</div><!-- /signup-box -->
						</div><!-- /position-relative -->
					</div>
				</div><!-- /.col -->
			</div><!-- /.row -->
		</div>
	</div><!-- /.main-container -->
	
	<script type="text/javascript">
		function show_box(id) {
			jQuery('.widget-box.visible').removeClass('visible');
			jQuery('#' + id).addClass('visible');
		}
		
		// 校验表单
		$("#registerForm").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			rules: {
				loginName: {
					required: true,
					remote:{
			               type:"get",
			               url:"<%=path%>/checkPort",           
			               data:{ id: function() { return $("#loginName").val(); } }
			               } 
				},
				password: {
					required: true
				},
				vPassword: {
					required: true
				},
				email: {
					required: true
				},
				phone: {
					required: true
				}
			},
	
			messages: {
				loginName: {
					required: "请输入用户名",
					remote: "该用户名已存在"
				},
				password: {
					required: "请输入密码"
				},
				vPassword: {
					required: "请输入确认密码"
				},
				email: {
					required: "请输入邮件地址"
				},
				phone: {
					required: "请输入手机号"
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

