<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String url = PropertiesUtil.getValue("ws", "websocket.url"); 
	String interval = PropertiesUtil.getValue("ws", "websocket.interval"); 
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
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/echarts/echarts.js"></script>
</head>

<body>
	<div class="navbar navbar-default" id="navbar">
		<script type="text/javascript">
			try {
				ace.settings.check('navbar', 'fixed')
			} catch (e) {
			}
		</script>
		<div class="navbar-container" id="navbar-container">
			<div class="navbar-header pull-left">
				<a href="#" class="navbar-brand"> 
					<small><i class="icon-desktop"></i> 监控系统</small>
				</a>
			</div>
			<div class="navbar-header pull-right" role="navigation">
				<ul class="nav ace-nav">
					<li class="purple">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#"> 
							<i class="icon-bell-alt icon-animated-bell"></i> 
							<span class="badge badge-important">8</span>
						</a>
						<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
							<li class="dropdown-header">
								<i class="icon-warning-sign"></i> 8条报警
							</li>
							<li>
								<a href="#">
									<div class="clearfix">
										<span class="pull-left"> 
											<i class="btn btn-xs no-hover btn-pink icon-comment"></i> 系统警告
										</span> 
										<span class="pull-right badge badge-info">+8</span>
									</div>
								</a>
							</li>
							<li>
								<a href="#"> 查看所有 <i class="icon-arrow-right"></i> </a>
							</li>
						</ul>
					</li>
					<li class="light-blue">
						<a data-toggle="dropdown" href="#" class="dropdown-toggle"> 
							<img class="nav-user-photo" src="style/assets/avatars/user.jpg" alt="Jason's Photo" /> 
							<span class="user-info"> <small>欢迎光临,</small> Admin </span> 
							<i class="icon-caret-down"></i>
						</a>
						<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
							<li>
								<a href="#"> <i class="icon-cog"></i> 设置 </a>
							</li>
							<li>
								<a href="#"> <i class="icon-user"></i> 个人资料 </a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="#"> <i class="icon-off"></i> 退出 </a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<div class="main-container-inner">
			<a class="menu-toggler" id="menu-toggler" href="#"> 
				<span class="menu-text"></span>
			</a>

			<div class="sidebar" id="sidebar">
				<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'fixed')
					} catch (e) {
					}
				</script>
				<!-- #sidebar-shortcuts -->

				<ul class="nav nav-list">
					<li class="active">
						<a href="#"> 
							<i class="icon-dashboard"></i> 
							<span class="menu-text">实时监控 </span>
						</a>
					</li>
					<li>
						<a href="#"> 
							<i class="icon-off"></i> 
							<span class="menu-text">服务监控 </span>
						</a>
					</li>

					<li>
					<a href="#" class="dropdown-toggle"> 
						<i class="icon-desktop"></i> 
						<span class="menu-text">性能监控 </span> 
						<b class="arrow icon-angle-down"></b>
					</a>
						<ul class="submenu">
							<li><a href="#"> <i class="icon-double-angle-right"></i> CPU监控
							</a></li>
							<li><a href="#"> <i class="icon-double-angle-right"></i> 内存监控
							</a></li>
							<li><a href="#"> <i class="icon-double-angle-right"></i> 网络监控
							</a></li>
							<li><a href="#"> <i class="icon-double-angle-right"></i> 进程监控
							</a></li>
						</ul></li>

					<li><a href="#" class="dropdown-toggle"> <i class="icon-list"></i> <span class="menu-text"> 报警策略 </span> <b
							class="arrow icon-angle-down"></b>
					</a>

						<ul class="submenu">
							<li><a href="#"> <i class="icon-double-angle-right"></i> 服务策略
							</a></li>

							<li><a href="#"> <i class="icon-double-angle-right"></i> 性能策略
							</a></li>
						</ul></li>

					<li><a href="#" class="dropdown-toggle"> <i class="icon-edit"></i> <span class="menu-text"> 指标设置</span> <b
							class="arrow icon-angle-down"></b>
					</a>

						<ul class="submenu">
							<li><a href="#"> <i class="icon-double-angle-right"></i> 服务指标
							</a></li>

							<li><a href="#"> <i class="icon-double-angle-right"></i> 性能指标
							</a></li>

						</ul></li>

					<li>
						<a href="#"  class="dropdown-toggle"> 
							<i class="icon-list-alt"></i> <span class="menu-text">系统功能 </span>
							<b class="arrow icon-angle-down"></b>
						</a>
						<ul class="submenu">
							<li><a href="#"> <i class="icon-double-angle-right"></i> 系统信息
							</a></li>
							<li><a href="#"> <i class="icon-double-angle-right"></i> ping监控
							</a></li>
						</ul>
					</li>
			</div>
			<div class="main-content">
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try {
							ace.settings.check('breadcrumbs', 'fixed')
						} catch (e) {
						}
					</script>

					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="#">查看</a></li>
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
				<div id="main" style="width: 500px;height:300px;padding: 8px 20px 24px;float:left;margin-left:20px;"></div>
			</div>

			<div class="ace-settings-container" id="ace-settings-container">
				<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
					<i class="icon-cog bigger-150"></i>
				</div>

				<div class="ace-settings-box" id="ace-settings-box">
					<div>
						<div class="pull-left">
							<select id="skin-colorpicker" class="hide">
								<option data-skin="default" value="#438EB9">#438EB9</option>
								<option data-skin="skin-1" value="#222A2D">#222A2D</option>
								<option data-skin="skin-2" value="#C6487E">#C6487E</option>
								<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
							</select>
						</div>
						<span>&nbsp; 选择皮肤</span>
					</div>

					<div>
						<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" /> <label class="lbl"
							for="ace-settings-navbar"> 固定导航条</label>
					</div>

					<div>
						<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" /> <label class="lbl"
							for="ace-settings-sidebar"> 固定滑动条</label>
					</div>

					<div>
						<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" /> <label class="lbl"
							for="ace-settings-breadcrumbs">固定面包屑</label>
					</div>

					<div>
						<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" /> <label class="lbl"
							for="ace-settings-rtl">切换到左边</label>
					</div>

					<div>
						<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" /> <label class="lbl"
							for="ace-settings-add-container"> 切换窄屏 <b></b>
						</label>
					</div>
				</div>
			</div>
		</div>

		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		var websocket = null;
		var url = "<%=url%>";
		var jsonData = 0;
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
			var dataObject = null;
			var json = JSON.parse(event.data);
			data = [];
			for (var i = 0; i < json.length; i++) {
				var now = new Date(json[i].date.time);
				dataObject = {
					name : now.getHours() + ":" + now.getMinutes() + ":"
							+ now.getSeconds(),
					value : [ now, json[i].user.replace("%","") ]
				}
				data.push(dataObject);
			}
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
		// 基于准备好的dom，初始化echarts实例
		var cpuChart = echarts.init(document.getElementById('main'));
		var data = [];
		option = {
			title : {
				text : 'CPU使用率'
			},
			tooltip : {
				trigger : 'axis',
				formatter : function(params) {
					params = params[0];
					return params.name + ' : ' + params.value[1] + '%';
				},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				name: '时间',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				type : 'value',
				name: 'CPU',
				min : 0,
				max : 100,
				splitLine : {
					show : false
				},
				axisLabel : {
	                formatter: '{value}%'
	            },
			},
			series : [ {
				name : 'cpu',
				type : 'line',
				showSymbol : false,
				hoverAnimation : false,
				smooth:true,
				data : data
			} ]
		};

		var sysInterval = setInterval(function() {
			cpuChart.setOption({
				series : [ {
					data : data
				} ]
			});
		}, <%=interval%>);

		// 使用刚指定的配置项和数据显示图表。
		cpuChart.setOption(option);
	</script>
</body>
</html>

