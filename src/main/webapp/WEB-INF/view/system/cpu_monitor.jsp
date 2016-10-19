<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = PropertiesUtil.getValue("ws", "cpu.url"); 
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
						<li class="active">系统监控</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							CPU监控<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
				</div>
				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="cpuTotal" style="width: 560px;height:500px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="cpuDetail" style="width: 560px;height:500px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		$("#menu3").addClass("open");
		$("#menu3").find(".submenu").css("display","block");
		$("#cpuMonitor").addClass("active");
		
		var websocket = null;
		var url = "<%=url%>";
		var cpuCount = 0;
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
			var json = JSON.parse(event.data);
			if (cpuCount == 0) {
				cpuCount = json.length;
			}
			// 初始化
			use = 0.00;
			sys = 0.00;
			wait = 0.00;
			idle = 0.00;
			detailLegendData = [];
			detailData = [];
			totalData = [];
			// 获取新数据
			for (var i = 1; i <= cpuCount; i++) {
				detailLegendData.push({
					value : 100,
					name : "CPU" + i
				});
				detailData.push({
					value : (json[i - 1].userPercent * 100).toFixed(2),
					name : "用户使用率"
				});
				detailData.push({
					value : (json[i - 1].systemPercent * 100).toFixed(2),
					name : "系统使用率"
				});
				detailData.push({
					value : (json[i - 1].waitPercent * 100).toFixed(2),
					name : "当前等待率"
				});
				detailData.push({
					value : (json[i - 1].idlePercent * 100).toFixed(2),
					name : "当前空闲率"
				});
				use +=  json[i - 1].userPercent * 100;
				sys +=  json[i - 1].systemPercent * 100;
				wait +=  json[i - 1].waitPercent * 100;
				idle +=  json[i - 1].idlePercent * 100;
			}
			totalData.push({
				value : use / 2,
				name : "用户使用率"
			});
			totalData.push({
				value : sys / 2,
				name : "系统使用率"
			});
			totalData.push({
				value : wait / 2,
				name : "当前等待率"
			});
			totalData.push({
				value : idle / 2,
				name : "当前空闲率"
			});
			// 刷新图表
			totalChart.setOption({
				series : {
					data : totalData
				}
			});
			detailChart.setOption({
				series : [ {
					data : detailLegendData
				}, {
					data : detailData
				} ]
			});
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
		var use = 0.00;
		var sys = 0.00;
		var wait = 0.00;
		var idle = 0.00;
		var detailLegendData = [];
		var totalData = [];
		var detailData = [];
		var totalChart = echarts.init(document.getElementById('cpuTotal'));
		var detailChart = echarts.init(document.getElementById('cpuDetail'));
		
		detailOption = {
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b}: {c}%"
			},
			legend : {
				orient : 'vertical',
				x : 'left'
			},
			series : [ {
				name : '详细信息',
				type : 'pie',
				selectedMode : 'single',
				radius : [ 0, '30%' ],
				label : {
					normal : {
						position : 'inner'
					}
				},
				labelLine : {
					normal : {
						show : false
					}
				},
				data : detailLegendData
			}, {
				name : '详细信息',
				type : 'pie',
				radius : [ '40%', '60%' ],
				data : detailData
			} ]
		};
		
		totalOption = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        x: 'left',
			        data:['用户使用率','系统使用率','当前等待率','当前空闲率']
			    },
			    series: [
			        {
			            name:'综合信息',
			            type:'pie',
			            radius: ['40%', '60%'],
			            data:totalData
			        }
			    ],
			    color:['#61a0a8', '#d48265', '#91c7ae', '#749f83']
			};

		// 显示图表。
		totalChart.setOption(totalOption);
		detailChart.setOption(detailOption);
	</script>
</body>
</html>

