<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
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
<script src="style/assets/js/bootbox.min.js"></script>
</head>

<body class="login-layout">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="login-container">
						<div class="center">
							<h1>
								<i class="icon-desktop white"></i> <span class="white">初始化</span>
							</h1>
						</div>

						<div class="space-6"></div>

						<div class="position-relative">
							<div id="login-box" class="login-box visible widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header blue lighter bigger">
											<i class="icon-hdd green"></i> 请输入数据库信息
										</h4>

										<div class="space-6"></div>

										<form id="initForm" action="<%=path%>/init" method="post">
											<fieldset>
												<div class="form-group">
													<input type="text" id="driver" class="form-control" placeholder="数据库驱动" name="driver" value="${driver}" />
												</div>

												<div class="form-group">
													<input type="text" id="url" class="form-control" placeholder="数据库地址" name="url" value="${url}" />
												</div>

												<div class="form-group">
													<input type="text" id="username" class="form-control" placeholder="用户名" name="username" value="${username}" />
												</div>

												<div class="form-group">
													<input type="text" id="password" class="form-control" placeholder="口令" name="password" value="${password}" />
												</div>

												<div class="space"></div>

												<div class="clearfix">
													<a class="width-35 btn btn-sm btn-success" href="#" onclick="connect()" style="float: left;"> 测试连接 </a> <a
														class="width-35 pull-right btn btn-sm btn-primary" href="#" onclick="init()"> 初始化 </a>
												</div>

												<div class="space-4"></div>
											</fieldset>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.main-container -->

	<script type="text/javascript">
		var initFlag = 0;
		//测试数据库连接
		function connect() {
			if ($("#initForm").valid()) {
				$.ajax({
					url : "<%=path%>/initConnect",
					method : 'post',
					async : false,
					dataType : "json",
					data : {
						driver : $("#driver").val(),
						url : $('#url').val(),
						username : $("#username").val(),
						password : $("#password").val()
					},
					success : function(data) {
						if (data) {
							bootbox.alert({
								buttons : {
									ok : {
										label : '确认'
									}
								},
								message : '数据库连接成功',
							});
							initFlag = 1;
						}else{
							bootbox.alert({
								buttons : {
									ok : {
										label : '确认'
									}
								},
								message : '数据库连接失败',
							});
						}
					},
					error : function(data) {
						bootbox.alert({
							buttons : {
								ok : {
									label : '确认'
								}
							},
							message : '连接失败',
						});
					},
				});
			}
		}
		
		//系统初始化
		function init() {
			if (initFlag == 1) {
				$("#initForm").submit();
			}else{
				bootbox.alert({
					buttons : {
						ok : {
							label : '确认'
						}
					},
					message : '请测试连接成功后进行初始化',
				});
			}
		}
		
		// 清除测试状态
		$("#driver").change(function() {
			initFlag = 0;
		});
		// 清除测试状态
		$("#url").change(function() {
			initFlag = 0;
		});
		// 清除测试状态
		$("#username").change(function() {
			initFlag = 0;
		});
		// 清除测试状态
		$("#password").change(function() {
			initFlag = 0;
		});

		// 校验表单
		$("#initForm").validate({
			errorElement : 'div',
			errorClass : 'help-block',
			focusInvalid : false,
			rules : {
				driver : {
					required : true
				},
				url : {
					required : true
				},
				username : {
					required : true
				},
				password : {
					required : true
				}
			},

			messages : {
				driver : {
					required : "数据库驱动"
				},
				url : {
					required : "数据库地址"
				},
				username : {
					required : "请输入用户名"
				},
				password : {
					required : "请输入口令"
				}
			},

			invalidHandler : function(event, validator) { //display error alert on form submit   
				$('.alert-danger', $('.login-form')).show();
			},

			highlight : function(e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},

			success : function(e) {
				$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
				$(e).remove();
			}
		});
	</script>
</body>
</html>

