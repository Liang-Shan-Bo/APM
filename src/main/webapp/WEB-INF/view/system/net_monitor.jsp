<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = "ws://" + request.getServerName() + ":" + request.getServerPort() + path + "/netSocket";
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
						<li><i class="icon-home home-icon"></i> <a href="<%=path%>/index">主页</a></li>
						<li class="active">系统监控</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							网络监控<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
				</div>
				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="netPackets" style="width: 560px;height:500px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="netBytes" style="width: 560px;height:500px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		$("#menu3").addClass("open");
		$("#menu3").find(".submenu").css("display","block");
		$("#netMonitor").addClass("active");
		
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
			var json = JSON.parse(event.data);
			// 获取新数据
			rxPacketsData = [json[0].rxPackets,json[0].rxDropped,json[0].rxErrors];
			txPacketsData = [json[0].txPackets,json[0].txDropped,json[0].txErrors];
			rxBytesData = [json[0].rxBytes];
			txBytesData = [json[0].txBytes];
			// 刷新图表
			packetsChart.setOption({
				series : [ {
					data : rxPacketsData
				}, {
					data : txPacketsData
				} ]
			});
			bytesChart.setOption({
				series : [ {
					data : rxBytesData
				}, {
					data : txBytesData
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
		var rxPacketsData = [];
		var txPacketsData = [];
		var rxBytesData = [];
		var txBytesData = [];
		var packetsChart = echarts.init(document.getElementById('netPackets'));
		var bytesChart = echarts.init(document.getElementById('netBytes'));
		
		packetsOption = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            
			            type : 'shadow'       
			        }
			    },
			    legend: {
			        data:['发送','接收']
			    },
			    grid: {
			        containLabel: true
			    },
			    xAxis : [
			        {
			            type : 'category',
			            data : ['正常','丢包','错误']
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name:'发送',
			            type:'bar',
			            data:[]
			        },
			        {
			            name:'接收',
			            type:'bar',
			            data:[]
			        }
			    ]
			};
		
		bytesOption = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            
			            type : 'shadow'     
			        }
			    },
			    legend: {
			        data:['发送','接收']
			    },
			    grid: {
			        containLabel: true
			    },
			    xAxis : [
			        {
			            type : 'category',
			            data : ['字节数(BYTE)']
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name:'发送',
			            type:'bar',
			            data:[]
			        },
			        {
			            name:'接收',
			            type:'bar',
			            data:[]
			        }
			    ]
			};

		// 显示图表。
		packetsChart.setOption(packetsOption);
		bytesChart.setOption(bytesOption);
	</script>
</body>
</html>

