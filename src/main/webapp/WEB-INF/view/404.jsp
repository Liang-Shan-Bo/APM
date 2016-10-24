<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
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
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
</head>

<body style="background-color: #fff;">
	<div class="navbar navbar-default" id="navbar">
		<script type="text/javascript">
			try {
				ace.settings.check('navbar', 'fixed')
			} catch (e) {
			}
		</script>
		<div class="navbar-container" id="navbar-container">
			<div class="navbar-header pull-left">
				<a href="#" class="navbar-brand"> <small><i class="icon-desktop"></i> 监控系统</small>
				</a>
			</div>
			<div class="navbar-header pull-right" role="navigation">
				<ul class="nav ace-nav">
					<li class="purple"><a id="alarm" data-toggle="dropdown" class="dropdown-toggle" href="#"
						style="display: none;"> <i class="icon-bell-alt icon-animated-bell"></i> <span id="count"
							class="badge badge-important"></span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<div class="error-container">
					<div style="height: 467px; width: 50%; float: left;">
						<img src=style/assets/images/404.gif height="467" width="626" />
					</div>
					<div style="height: 467px; width: 50%; float: left;">
						<h1 class="grey lighter smaller">
							<span class="blue bigger-125"> <i class="icon-eye-close"></i> 404
							</span> 页面未找到
						</h1>
						<hr />
						<h3 class="lighter smaller">很抱歉，您访问的页面不存在！</h3>
						<hr />
						<h4 class="smaller">错误原因:</h4>

						<ul class="list-unstyled spaced inline bigger-110 margin-15">
							<li><i class="icon-hand-right blue"></i> 您输入的地址有误</li>

							<li><i class="icon-hand-right blue"></i> 您所查看的页面不存在或者暂时无法使用</li>

							<li><i class="icon-hand-right blue"></i> 您所查看的页面权限不足</li>
						</ul>
						<hr />
						<h4 class="smaller">请点击以下链接继续访问:</h4>
						<ul class="list-unstyled spaced inline bigger-110 margin-15">
							<li><i class="icon-hand-right blue"></i> <a href="#" onclick="history.back()"> 返回上一步 </a></li>

							<li><i class="icon-hand-right blue"></i> <a href="<%=path%>/index"> 返回首页 </a></li>
						</ul>
					</div>
				</div>
				<hr />
				<div class="space"></div>
			</div>
		</div>
	</div>
</body>
</html>

