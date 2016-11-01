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
<script src="style/echarts/echarts.js"></script>
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
							<!-- 即时监控 -->
							<input type="hidden" id="serviceUrl" value="${serviceUrl}">
							<div id="accordionCpu" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionCpu" href="#collapseCpu"> 
											<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;即时监控
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseCpu">
<!-- 										<div class="profile-info-row"> -->
<!-- 											<div class="profile-info-name"> CPU占用百分比 </div> -->

<!-- 											<div class="profile-info-value"> -->
<!-- 												<span class="editable" id="cpuPercentage">0.00%</span> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										<div class="profile-info-row"> -->
<!-- 											<div class="profile-info-name"> 已使用内存量 </div> -->
<!-- 											<div class="profile-info-value"> -->
<!-- 												<span class="editable" id="memoryUsed">0.0MB</span> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										<div class="profile-info-row"> -->
<!-- 											<div class="profile-info-name"> 可使用内存量 </div> -->

<!-- 											<div class="profile-info-value"> -->
<!-- 												<span class="editable" id="memoryCommitted">0.0MB</span> -->
<!-- 											</div> -->
<!-- 										</div> -->
										
										<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
										<div id="cpu" style="width: 400px;height:300px;padding: 0px 20px 0px;float:left;margin-left:150px;"></div>
										<div id="mem" style="width: 400px;height:300px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
									</div>
								</div>
							</div><!-- 即时监控 -->
							<!-- 系统信息 -->
							<div id="accordionMem" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionMem" href="#collapseMem"> 
											<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;系统信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseMem">
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
							</div><!-- 系统信息 -->
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
		$("#menu2").addClass("active");
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
			send();
		}

		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var json = JSON.parse(event.data);
			cpuPer = (json[0].cpuPercentage * 100).toFixed(2);
			memUsed = (json[0].memoryUsed / 1024 / 1024).toFixed(1);
			memCommitted = (json[0].memoryCommitted / 1024 / 1024).toFixed(1);
			$("#cpuPercentage").text(cpuPer + "%");
			$("#memoryUsed").text(memUsed + "MB");
			$("#memoryCommitted").text(memCommitted + "MB");
			$("#threadCount").text(json[0].threadCount);
			$("#daemonThreadCount").text(json[0].daemonThreadCount);
			$("#peakThreadCount").text(json[0].peakThreadCount);
			$("#loadedClassCount").text(json[0].loadedClassCount);
			$("#totalLoadedClassCount").text(json[0].totalLoadedClassCount);
			$("#unloadedClassCount").text(json[0].unloadedClassCount);
			$("#startTime").text(json[0].startTime);
			$("#spanTime").text(json[0].spanTime);
			cpuGauge();
			memGauge();
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
	<script type="text/javascript">
		var cpuPer = 0;
		var memUsed = 0;
		var memCommitted = 0;
		// CPU仪表盘
		var cpuChart = echarts.init(document.getElementById('cpu'));
		cpuOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}%"
			},
			series : [ {
				name : 'CPU使用率',
				type : 'gauge',
				radius : 120,
				axisLine : {
					lineStyle : {
						width : 3,
						shadowColor : '#fff',
						shadowBlur : 10
					}
				},
				splitLine : {
					length : 15,
					lineStyle: {       
	                    width:3,
	                    color: 'auto',
	                    shadowColor : '#fff',
	                    shadowBlur: 10
	                }
				},
				detail : {
					formatter : '{value}%',
					textStyle : {
						fontSize : 15
					}
				},
				data : [ {
					value : 0,
					name : 'CPU'
				} ]
			} ]
		};
		
		cpuChart.setOption(cpuOption,true);
		
		// 刷新图表
		function cpuGauge(){
			cpuOption.series[0].data[0].value = cpuPer;
			// 使用刚指定的配置项和数据显示图表。
			cpuChart.setOption(cpuOption,true);
		}
		
	</script>
	<script type="text/javascript">
		// 内存仪表盘
		var memChart = echarts.init(document.getElementById('mem'));
		memOption = {
			tooltip : {
				formatter : "{a} <br/>{b} : {c}MB"
			},
			series : [ {
				name : '当前使用内存',
				type : 'gauge',
				radius : 120,
				max : 512,
				axisLine : {
					lineStyle : {
						width : 3,
						shadowColor : '#fff',
						shadowBlur : 10
					}
				},
				splitLine : {
					length : 15,
					lineStyle: {       
	                    width:3,
	                    color: 'auto',
	                    shadowColor : '#fff',
	                    shadowBlur: 10
	                }
				},
				axisLabel : {
					formatter : function(value) {
						return parseInt(value);
					}
				},
				detail : {
					formatter : '{value}MB',
					textStyle : {
						fontSize : 15
					}
				},
				data : [ {
					value : 0,
					name : '内存'
				} ]
			} ]
		};
		
		memChart.setOption(memOption);

		// 刷新图表
		function memGauge(){
			memOption.series[0].data[0].value = memUsed;
			memOption.series[0].max = memCommitted;
			// 使用刚指定的配置项和数据显示图表
			memChart.setOption(memOption,true);
		}
	</script>
</body>
</html>

