<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	String url = "ws://" + request.getServerName() + ":" + request.getServerPort() + path + "/proSocket";
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
						<li class="active">系统监控</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							进程监控<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
					<!-- 进程列表 -->
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>进程名</th>
											<th>进程ID</th>
											<th>父进程ID</th>
											<th>线程数</th>
											<th>占用内存</th>
											<th>进程状态</th>
										</tr>
									</thead>
									<tbody id="tbody">
									</tbody>
								</table>
								<c:if test="${page.totalPage > 1}">
									<%@ include file="../page.jsp"%>
								</c:if>
							</div>
						</div>
					</div>
					<!-- 进程列表 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		$("#menu3").addClass("open");
		$("#menu3").find(".submenu").css("display","block");
		$("#proMonitor").addClass("active");
		
		var websocket = null;
		var url = "<%=url%>";
		//判断当前浏览器是否支持WebSocket
		if ('WebSocket' in window) {
			websocket = new WebSocket(url);
		} else {
			alert('监控系统不支持此版本浏览器！');
		}

		//连接发生错误的回调方法
		websocket.onerror = function() {
		}

		//连接成功建立的回调方法
		websocket.onopen = function(event) {
		}

		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			$("#tbody").empty();
			var json = JSON.parse(event.data);
			// 刷新
			for (var i = 0; i < json.length; i++) {
				addPro(json[i]);
			}
		}

		//连接关闭的回调方法
		websocket.onclose = function() {
		}

		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		window.onbeforeunload = function() {
			websocket.close();
		}

		//关闭连接
		function closeWebSocket() {
			websocket.close();
		}

		//发送消息
		function send() {
			websocket.send("");
		}
	</script>
	<script type="text/javascript">
		function addPro(obj) {
			var state = "";
			switch (obj.state) {
			case "O":
				state = "运行状态";
				break;
			case "S":
				state = "休眠状态";
				break;
			case "R":
				state = "就绪状态";
				break;
			case "I":
				state = "空闲状态";
				break;
			case "Z":
				state = "僵尸状态";
				break;
			case "T":
				state = "跟踪状态";
				break;
			case "B":
				state = "正在等待";
				break;
			case "D":
				state = "深度睡眠";
				break;
			}
			var html = "<tr>";
			html += "<td>" + obj.name + "</td>";
			html += "<td>" + obj.pid + "</td>";
			html += "<td>" + obj.pPid + "</td>";
			html += "<td>" + obj.threads + "</td>";
			html += "<td>" + obj.memUsed + "</td>";
			html += "<td>" + state + "</td>";
			html += "</tr>";
			$("#tbody").append(html);
		}
	</script>
</body>
</html>

