<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
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
				<div id="cpuTotal" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
				<div id="cpuDetail" style="width: 550px;height:280px;padding: 0px 20px 0px;float:left;margin-left:20px;"></div>
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
		// 当月报警
		var am = ${alarmOfMonth};
		// 当月日志
		var lm = ${logOfMonth};
		// 全部报警
		var aa = ${alarmOfAll};
		// 全部日志
		var la = ${logOfAll};
		var amLegned = [];
		var amData = [];
		var lmLegned = [];
		var lmData = [];
		var aaLegned = [];
		var aaData = [];
		var laLegned = [];
		var laData = [];
		for (var i = 0; i < am.length; i++) {
			amLegned.push(am[i].alarmSystemName);
			amData.push({value:am[i].count, name:am[i].alarmSystemName})
		}
		for (var i = 0; i < lm.length; i++) {
			lmLegned.push(lm[i].alarmSystemName);
			lmData.push({value:lm[i].count, name:lm[i].alarmSystemName})
		}
		for (var i = 0; i < aa.length; i++) {
			aaLegned.push(aa[i].alarmSystemName);
			aaData.push({value:aa[i].count, name:aa[i].alarmSystemName})
		}
		for (var i = 0; i < la.length; i++) {
			laLegned.push(la[i].alarmSystemName);
			laData.push({value:la[i].count, name:la[i].alarmSystemName})
		}
		var amChart = echarts.init(document.getElementById('alarmOfMonth'));
		var lmChart = echarts.init(document.getElementById('logOfMonth'));
		var aaChart = echarts.init(document.getElementById('alarmOfAll'));
		var laChart = echarts.init(document.getElementById('logOfAll'));
		
		amOption = {
			title : {
				text : '系统报警',
				subtext : '当月',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : amLegned
			},
			series : [ {
				name : '系统当月报警数',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : amData,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		lmOption = {
			title : {
				text : '系统监控日志',
				subtext : '当月',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : lmLegned
			},
			series : [ {
				name : '系统当月监控日志数',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : lmData,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		aaOption = {
			title : {
				text : '系统报警',
				subtext : '全部',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : aaLegned
			},
			series : [ {
				name : '系统全部报警数',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : aaData,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		laOption = {
			title : {
				text : '系统监控日志',
				subtext : '全部',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : laLegned
			},
			series : [ {
				name : '系统全部监控日志数',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : laData,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		// 显示图表。
		amChart.setOption(amOption);
		lmChart.setOption(lmOption);
		aaChart.setOption(aaOption);
		laChart.setOption(laOption);
	</script>
</body>
</html>

