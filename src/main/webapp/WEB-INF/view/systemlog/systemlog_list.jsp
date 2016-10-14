<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" isELIgnored="false"%>
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
<script src="style/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="style/assets/js/date-time/bootstrap-datepicker.zh-CN.min.js"></script>
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
						<li class="active">系统日志</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							监控日志<small> <i class="icon-double-angle-right"></i> 查看
							</small>
						</h1>
					</div>
					<!-- 监控日志列表 -->
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/systemLogList" method="post">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
						<label>报警时间： </label>
						<div style="display:inline-block;" class="form-group">
							<div class="input-daterange input-group" style="width:360px;">
								<input type="text" class="input-sm form-control datepicker" name="alarmStartTime" value="${page.alarmStartTime}">
								<span class="input-group-addon"><i class="icon-calendar"></i></span>
								<input type="text" class="input-sm form-control datepicker" name="alarmEndTime" value="${page.alarmEndTime}">
							</div>
						</div>
						<label style="margin-left:20px;">系统名称： </label>
						<div style="display:inline-block;" class="form-group">
							<input type="text" class="input-sm datepicker" name="alarmSystemName" value="${page.alarmSystemName}">
						</div>
						<label style="margin-left:20px;">指标类型： </label>
						<div style="display:inline-block;" class="form-group">
							<select name="alarmType" style="width:130px;">
								<option value="" <c:if test="${page.alarmType == null}">selected="selected"</c:if>>&nbsp;全部 </option>
								<option value="1" <c:if test="${page.alarmType == 1}">selected="selected"</c:if>>CPU</option>
								<option value="2" <c:if test="${page.alarmType == 2}">selected="selected"</c:if>>内存</option>
								<option value="3" <c:if test="${page.alarmType == 3}">selected="selected"</c:if>>磁盘</option>
								<option value="4" <c:if test="${page.alarmType == 4}">selected="selected"</c:if>>网络</option>
							</select> 
						</div>
						<label style="margin-left:20px;"></label><button type="submit" class="btn btn-purple btn-sm">查询 <i class="icon-search icon-on-right bigger-110"></i></button>
					</form>
					<div class="space-4"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>系统名称</th>
											<th>发生时间</th>
											<th>指标类型</th>
											<th>详细信息</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.resultList}" var="alarm">
											<tr>
												<td>${alarm.alarmSystemName}</td>
												<td>${fn:substring(alarm.alarmTime, 0, 19)}</td>
												<td>
													<c:choose>
													    <c:when test="${alarm.alarmType == 1}">CPU</c:when>
													    <c:when test="${alarm.alarmType == 2}">内存</c:when>
													    <c:when test="${alarm.alarmType == 3}">磁盘</c:when>
													    <c:when test="${alarm.alarmType == 4}">网络</c:when>
													</c:choose>
												</td>
												<td>${alarm.alarmDesc}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${page.totalPage > 1}">
									<%@ include file="../page.jsp"%>
								</c:if>
							</div>
						</div>
					</div>
					<!-- 监控日志列表 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
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
	</script>
</body>
</html>

