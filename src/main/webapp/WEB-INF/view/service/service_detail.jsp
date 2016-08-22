<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = PropertiesUtil.getValue("ws", "service.url"); 
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
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>
						<li class="active">服务监控</li>
					</ul>
				</div>
				<div class="page-content">
					<div class="page-header">
						<h1>
							服务监控<small> <i class="icon-double-angle-right"></i> 详细</small>
						</h1>
					</div>
					<!-- 服务详细信息 -->
					<div class="row">
						<div class="col-xs-12">
							<!-- 操作系统信息 -->
							<input type="hidden" id="serviceUrl" value="${serviceUrl}">
							<div id="accordionCpu" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionCpu" href="#collapseCpu"> 
											<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;操作系统信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseCpu">
										<div class="profile-info-row">
											<div class="profile-info-name"> CPU占用百分比 </div>

											<div class="profile-info-value">
												<span class="editable" id="cpuPercentage">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 可用处理器数 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.cpuAvailableCount}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统名称 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.systemName}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统架构 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.systemArch}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统版本 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.systemVersion}</span>
											</div>
										</div>
									</div>
								</div>
							</div><!-- 操作系统信息 -->
							<!-- 内存信息 -->
							<div id="accordionMem" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionMem" href="#collapseMem"> 
											<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;内存信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseMem">
										<div class="profile-info-row">
											<div class="profile-info-name"> 已使用内存量 </div>
											<div class="profile-info-value">
												<span class="editable" id="memoryUsed">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 可使用内存量 </div>

											<div class="profile-info-value">
												<span class="editable" id="memoryCommitted">&nbsp;</span>
											</div>
										</div>
									</div>
								</div>
							</div><!-- 内存信息 -->
							<!-- 线程信息 -->
							<div id="accordionPro" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionPro" href="#collapsePro">
												<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;线程信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapsePro">
										<div class="profile-info-row">
											<div class="profile-info-name"> 当前活动线程数 </div>
											<div class="profile-info-value">
												<span class="editable" id="threadCount">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 当前守护线程数 </div>

											<div class="profile-info-value">
												<span class="editable" id="daemonThreadCount">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 总计启动线程数 </div>
											<div class="profile-info-value">
												<span class="editable" id="peakThreadCount">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 当前加载类数量 </div>
											<div class="profile-info-value">
												<span class="editable" id="loadedClassCount">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 已卸载类数量</div>
											<div class="profile-info-value">
												<span class="editable" id="unloadedClassCount">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 总加载类数量 </div>
											<div class="profile-info-value">
												<span class="editable" id="totalLoadedClassCount">&nbsp;</span>
											</div>
										</div>
									</div>
								</div>
							</div><!-- 线程信息 -->
							<!-- 虚拟机信息 -->
							<div id="accordionJvm" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionJvm" href="#collapseJvm">
												<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;虚拟机信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseJvm">
										<div class="profile-info-row">
											<div class="profile-info-name"> 供应商</div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.jvmVendor}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 名称 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.jvmName}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 版本 </div>
											<div class="profile-info-value">
												<span class="editable">${serviceEntity.jvmVersion}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 启动时间 </div>
											<div class="profile-info-value">
												<span class="editable" id="startTime">&nbsp;</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 连续工作时间 </div>
											<div class="profile-info-value">
												<span class="editable" id="spanTime">&nbsp;</span>
											</div>
										</div>
									</div>
								</div>
							</div><!-- 虚拟机信息 -->
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
		var websocket = null;
		var url = "<%=url%>";
		//判断当前浏览器是否支持WebSocket
		if ('WebSocket' in window) {
			websocket = new WebSocket(url);
		} else {
			alert('Not support websocket');
		}

		//连接发生错误的回调方法
		websocket.onerror = function() {
		}

		//连接成功建立的回调方法
		websocket.onopen = function(event) {
			send();
		}

		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var json = JSON.parse(event.data);
			var cpuPer = (json[0].cpuPercentage * 100).toFixed(2) + "%";
			var memUsed = (json[0].memoryUsed / 1024 / 1024).toFixed(1) + "MB";
			var memCommitted = (json[0].memoryCommitted / 1024 / 1024).toFixed(1) + "MB";
			$("#cpuPercentage").text(cpuPer);
			$("#memoryUsed").text(memUsed);
			$("#memoryCommitted").text(memCommitted);
			$("#threadCount").text(json[0].threadCount);
			$("#daemonThreadCount").text(json[0].daemonThreadCount);
			$("#peakThreadCount").text(json[0].peakThreadCount);
			$("#loadedClassCount").text(json[0].loadedClassCount);
			$("#totalLoadedClassCount").text(json[0].totalLoadedClassCount);
			$("#unloadedClassCount").text(json[0].unloadedClassCount);
			$("#startTime").text(json[0].startTime);
			$("#spanTime").text(json[0].spanTime);
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
			websocket.send($("#serviceUrl").val());
		}
	</script>
</body>
</html>
