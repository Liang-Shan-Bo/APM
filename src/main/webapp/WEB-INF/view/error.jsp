<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" import="java.io.*"%>
<%@ page contentType="text/html" isErrorPage="true"%>
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
					<div style="width: 100%;">
						<h1 class="grey lighter smaller">
							<span class="blue bigger-125"> <i class="icon-lock"></i> ERROR
							</span> 系统错误
						</h1>
						<hr />
						<h3 class="lighter smaller">很抱歉，页面发生错误！</h3>
						<hr />
						<h4 class="smaller">错误信息:</h4>
						<h5><%=exception.getMessage()%></h5>
						<hr />
						<h4 class="smaller">异常日志:</h4>
						<h5>
							<%
								StringWriter sw = new StringWriter();
								PrintWriter pw = new PrintWriter(sw);
								exception.printStackTrace(pw);
								out.println(sw);
							%>
						</h5>
					</div>
				</div>
				<hr />
				<div class="space"></div>
			</div>
		</div>
	</div>
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
</body>
</html>
