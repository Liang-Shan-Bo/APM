<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = PropertiesUtil.getValue("ws", "service.url"); 
	String interval = PropertiesUtil.getValue("ws", "service.interval"); 
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
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="js/ping.js"></script>
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
						<li class="active">系统功能</li>
					</ul>
				</div>
				<div class="page-content">
					<div class="page-header">
						<h1>
							ping监控<small> <i class="icon-double-angle-right"></i> 详细</small>
						</h1>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<!-- ping监控 -->
							<div id="accordionMem" class="accordion-style1 panel-group">
							<input id="ping123" type="text"/>
							<a href="#" onclick="ping123();">asdasd</a>
							<input id="text" type="text"/>
							</div><!-- ping监控 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<script type="text/javascript">
		$("#menu8").addClass("open");
		$("#menu8").find(".submenu").css("display","block");
		$("#ping").addClass("active");
		
		function ping123(){
			var a = $("#ping123").val();
			
			ping("123").then(function(delta) {
			    console.log('Ping time was ' + String(delta) + ' ms');
			}).catch(function(err) {
			    console.error('Could not ping remote URL', err);
			});
			
		}
	</script>
</body>
</html>

