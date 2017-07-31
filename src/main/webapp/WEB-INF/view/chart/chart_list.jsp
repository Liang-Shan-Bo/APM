<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css" href="style/assets/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/font-awesome.min.css" />
<!-- ace styles -->
<link rel="stylesheet" type="text/css" href="style/assets/css/ace.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/ace-skins.min.css" />
<link rel="stylesheet" type="text/css" href="style/assets/css/bootstrap-datepicker.min.css" />
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/echarts/echarts.js"></script>
<script src="style/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="style/assets/js/date-time/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="style/assets/js/moment.min.js"></script>
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
						<li class="active">监控统计</li>
					</ul>
				</div>
				<div class="page-content">
					<div class="page-header">
						<h1>
							监控统计<small> <i class="icon-double-angle-right"></i> 详细</small>
						</h1>
					</div>
					<!-- 监控统计 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="queryForm" class="form-inline checkForm">
								<label>系统名称： </label>
								<div style="display:inline-block;" class="form-group">
									<select id="serviceId" name="serviceId" style="width:130px;">
										<c:forEach items="${list}" var="chart">
											<option value="${chart.serviceId}" <c:if test="${chartEntity.serviceId == chart.serviceId}">selected="selected"</c:if>>${chart.serviceName}</option>
										</c:forEach>
									</select> 
								</div>
								<label style="margin-left:20px;">报警时间： </label>
								<div style="display:inline-block;" class="form-group">
									<div class="input-daterange input-group">
										<input type="text" class="input-sm form-control datepicker" id="createTime" name="createTime" value="${chartEntity.createTime}">
									</div>
								</div>
								
								<label style="margin-left:20px;">统计方式： </label>
								<div style="display:inline-block;" class="form-group">
									<select id="dateFlag" name="dateFlag" style="width:130px;">
										<option value="1" <c:if test="${dateFlag == 1}">selected="selected"</c:if>>天</option>
										<option value="2" <c:if test="${dateFlag == 2}">selected="selected"</c:if>>周</option>
										<option value="3" <c:if test="${dateFlag == 3}">selected="selected"</c:if>>月</option>
									</select> 
								</div>
								<label style="margin-left:20px;"></label>
								<a onclick="getCharts()" class="btn btn-purple btn-sm">查看统计<i class="icon-search icon-on-right bigger-110"></i></a>
							</form>
							<div id="view" class="col-xs-12" style="height:500px;margin-top:20px;"></div>
						</div>
					</div><!-- 监控统计 -->
				</div>
			</div>
		</div>
	</div>

	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<script type="text/javascript">
		$("#menu6").addClass("open");
		$("#menu6").find(".submenu").css("display","block");
		$("#chartList").addClass("active");
		$('#createTime').val(moment(new Date()).format("YYYY-MM-DD"));
		$(function () {
	        $(".datepicker").datepicker({
	            language: "zh-CN",
	            autoclose: true,//选中之后自动隐藏日期选择框
	            todayHighlight: true,
	            todayBtn: true,//今日按钮
	            clearBtn: true,//今日按钮
	            format: "yyyy-mm-dd"//日期格式，详见 http://bootstrap-datepicker.readthedocs.org/en/release/options.html#format
	        });
	    });
		
		function getCharts(){
			if ($('#createTime').val() == "") {
				bootbox.alert({
					buttons : {
						ok : {
							label : '确认'
						}
					},
					message : '报警时间不能为空',
				});
			} else {
				$.ajax({
					url : "<%=path%>/chartList",
					method : 'post',
					async : false,
					dataType : "json",
					data : {
						serviceId : $("#serviceId").val(),
						createTime : $('#createTime').val(), 
						dateFlag : $("#dateFlag").val()
					},
					success : function(data) {
						xAxisData = [];
						cpuData = [];
						memData = [];
						data.forEach(function(chart){
						    xAxisData.push(chart.createTime);
						    cpuData.push(new Number(chart.cpuPercentage).toFixed(2));
						    memData.push(chart.memoryUsed);
						})
						option = {
						    title: {
						        text: $("#serviceId").find("option:selected").text() + '数据统计' + $('#createTime').val()
						    },
						    legend: {
						        data: ['CPU', '内存'],
						        align: 'left'
						    },
						    toolbox: {
						        // y: 'bottom',
						        feature: {
						            magicType: {
						                type: ['stack', 'tiled']
						            },
						            dataView: {},
						            saveAsImage: {
						                pixelRatio: 2
						            }
						        }
						    },
						    tooltip: {},
						    xAxis: {
						        data: xAxisData,
						        silent: false,
						        splitLine: {
						            show: false
						        }
						    },
						    yAxis: {
						    },
						    series: [{
						        name: 'CPU',
						        type: 'bar',
						        data: cpuData,
						        animationDelay: function (idx) {
						            return idx * 10;
						        }
						    }, {
						        name: '内存',
						        type: 'bar',
						        data: memData,
						        animationDelay: function (idx) {
						            return idx * 10 + 100;
						        }
						    }],
						    animationEasing: 'elasticOut',
						    animationDelayUpdate: function (idx) {
						        return idx * 5;
						    }
						};
						viewChart.setOption(option, true);
					},
					error : function(data) {
						bootbox.alert({
							buttons : {
								ok : {
									label : '确认'
								}
							},
							message : '连接失败',
						});
					},
				});
			}
		}
	</script>
	<script type="text/javascript">
		var xAxisData = [];
		var cpuData = [];
		var memData = [];
		var viewChart = echarts.init(document.getElementById('view'));
	</script>
</body>
</html>

