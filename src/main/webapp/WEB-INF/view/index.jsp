<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = PropertiesUtil.getValue("ws", "websocket.url"); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>监控系统</title>
<!-- basic styles -->
<link rel="stylesheet" type="text/css" href="style/assets/css/bootstrap.min.css"  />
<link rel="stylesheet" type="text/css" href="style/assets/css/font-awesome.min.css"  />
<!-- ace styles -->
<link rel="stylesheet" type="text/css" href="style/assets/css/ace.min.css"  />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-rtl.min.css"  />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-skins.min.css"  />
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/echarts/echarts.js"></script>
</head>

<body>
	<%@ include file="head.jsp"%>

	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<div class="main-container-inner">
			<%@ include file="menu.jsp"%>
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
						<li class="active">实时监控</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							实时监控<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
				</div>
				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="cpu" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="mem" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="net" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="disk" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
			</div>
		</div>

		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		var websocket = null;
		var url = "<%=url%>";
		var cpuCount = 0;
		var diskCount = 0;
		var cpuLegend = [];
		var diskLegend = [];
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
		}

		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var json = JSON.parse(event.data);
			// 初始化图表
			if (cpuCount == 0 || diskCount == 0) {
				cpuCount = json[0].users.length;
				diskCount = json[0].disks.length;
				for (var i = 1; i <= cpuCount; i++) {
					cpuLegend.push("CPU" + i);
				}
				for (var i = 0; i < diskCount; i++) {
					diskLegend.push(json[0].disks[i].devName);
				}
				cpuChart.setOption({
					legend : {
						data : cpuLegend
					}
				});
				diskChart.setOption({
					legend : {
						data : diskLegend
					}
				});
				memChart.setOption({
					yAxis : {max : json[i].totalMem}
				});
				
			}
			//清空原有数据
			for (var j = 0; j < cpuCount; j++) {
				cpuData[j] = [];
			}
			for (var j = 0; j < diskCount; j++) {
				diskData[j] = [];
			}
			memData = [];
			netData = [];
			// 写入新数据
			for (var i = 0; i < json.length; i++) {
				var now = new Date(json[i].time);
				var time = now.getHours() + ":" + now.getMinutes() + ":"
						+ now.getSeconds();
				cpuList = [];
				//写入新cpu列表数据
				for (var j = 0; j < cpuCount; j++) {
					cpuData[j].push({
						name : time,
						value : [ now, json[i].users[j].toFixed(1)]
					});
				}
				//写入新内存数据
				memData.push({
					name : time,
					value : [ now, json[i].useMem ]
				});
				//写入新网络流量数据
				netData.push({
					name : time,
					value : [ now, (json[i].totalBytes/1024).toFixed(1) ]
				});
				//写入新磁盘列表数据
				for (var j = 0; j < diskCount; j++) {
					diskData[j].push({
						name : time,
						value : [ now, json[i].disks[j].usePercent.toFixed(1)]
					});
				}
			}
			// 更新图表
			fresh();
		}

		//连接关闭的回调方法
		websocket.onclose = function() {
			clearInterval(sysInterval);
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
		// CPU图表
		var cpuChart = echarts.init(document.getElementById('cpu'));
		var cpuData = [];
		cpuOption = {
			title : {
				text : 'CPU使用率'
			},
			legend : {
				data : []
			},
			tooltip : {
				trigger : 'axis',
				formatter : function(params) {
					var relVal = params[0].name + "<br/>";
					for (var i = 0; i < cpuCount; i++) {
						relVal += params[i].seriesName + " : " + params[i].value[1]
						+ "%<br/>";
					}
					return relVal;
				},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				name : '时间',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				type : 'value',
				name : 'CPU',
				min : 0,
				max : 100,
				splitLine : {
					show : false
				},
				axisLabel : {
					formatter : '{value}%'
				},
			},
			series : []
		};
		
		//刷新图表
		function fresh() {
			var cpuSeries = [];
			var diskSeries = [];
			for (var i = 0; i < cpuCount; i++) {
				cpuSeries.push({
					name : 'CPU'+ (i + 1),
					type : 'line',
					showSymbol : false,
					hoverAnimation : false,
					smooth : true,
					data : cpuData[i]
				});
			}
			for (var i = 0; i < diskCount; i++) {
				diskSeries.push({
					name : diskLegend[i],
					type : 'line',
					showSymbol : false,
					hoverAnimation : false,
					smooth : true,
					data : diskData[i]
				});
			}
			cpuChart.setOption({
				series : cpuSeries
			});
			memChart.setOption({
				series : {data : memData}
			});
			netChart.setOption({
				series : {data : netData}
			});
			diskChart.setOption({
				series : diskSeries
			});
		}

		// 使用刚指定的配置项和数据显示图表。
		cpuChart.setOption(cpuOption);
	</script>
	<script type="text/javascript">
		// 内存图表
		var memChart = echarts.init(document.getElementById('mem'));
		var memData = [];
		memOption = {
			title : {
				text : '内存使用量'
			},
			legend : {
				data : ['内存']
			},
			tooltip : {
				trigger : 'axis',
				formatter : function(params) {
					return params[0].name + " : " + params[0].value[1] + "M";
				},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				name : '时间',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				type : 'value',
				name : '内存',
				min : 0,
				nameGap : 20,
				splitLine : {
					show : false
				},
				axisLabel : {
					formatter : '{value}M'
				},
			},
			series : [{
				name : '内存',
				type : 'line',
				showSymbol : false,
				hoverAnimation : false,
				smooth : true
			}]
		};

		// 使用刚指定的配置项和数据显示图表。
		memChart.setOption(memOption);
	</script>
	<script type="text/javascript">
		// 网络图表
		var netChart = echarts.init(document.getElementById('net'));
		var netData = [];
		netOption = {
			title : {
				text : '网络流量统计'
			},
			legend : {
				data : ['网络']
			},
			tooltip : {
				trigger : 'axis',
				formatter : function(params) {
					var relVal = params[0].name + " : ";
					var netBytes = params[0].value[1];
					if (netBytes < 1024) {
						relVal += netBytes + "K";
					}else {
						relVal += (netBytes / 1024).toFixed(1) + "M"
					}
					return relVal;
				},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				name : '时间',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				type : 'value',
				name : '网络',
				min : 0,
				nameGap : 20,
				splitLine : {
					show : false
				},
				axisLabel : {
					formatter : '{value}K'
				},
			},
			series : [{
				name : '网络',
				type : 'line',
				showSymbol : false,
				hoverAnimation : false,
				smooth : true
			}]
		};

		// 使用刚指定的配置项和数据显示图表。
		netChart.setOption(netOption);
	</script>
	<script type="text/javascript">
		// 磁盘图表
		var diskChart = echarts.init(document.getElementById('disk'));
		var diskData = [];
		diskOption = {
			title : {
				text : '磁盘使用率'
			},
			legend : {
				data : []
			},
			tooltip : {
				trigger : 'axis',
				formatter : function(params) {
					var relVal = params[0].name + "<br/>";
					for (var i = 0; i < diskCount; i++) {
						relVal += params[i].seriesName + " : " + params[i].value[1]
						+ "%<br/>";
					}
					return relVal;
				},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				name : '时间',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				type : 'value',
				name : '磁盘',
				min : 0,
				max : 100,
				splitLine : {
					show : false
				},
				axisLabel : {
					formatter : '{value}%'
				},
			},
			series : []
		};

		// 使用刚指定的配置项和数据显示图表。
		diskChart.setOption(diskOption);
	</script>
</body>
</html>

