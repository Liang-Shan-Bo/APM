<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
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
<!-- ace settings handler -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap-paginator.js"></script>
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/assets/js/bootbox.min.js"></script>
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
					<form id="queryForm" class="form-inline checkForm" action="<%=path%>/systemLogList" method="get">
						<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
						查询时间：<input type="text" id="alarmStartTime" name="alarmStartTime" value="${page.alarmStartTime}">
						至 <input type="text" id="alarmEndTime" name="alarmEndTime" value="${page.alarmEndTime}">
						&nbsp;&nbsp;&nbsp;&nbsp;报警类型：<input type="text" id="alarmType" name="alarmType" value="${page.alarmType}">
						&nbsp;&nbsp;&nbsp;&nbsp;系统名称：<input type="text" id="alarmSystemName" name="alarmSystemName" value="${page.alarmSystemName}">
						&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-purple btn-sm">查询 <i class="icon-search icon-on-right bigger-110"></i></button>
					</form>
					<div class="space-4"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>系统名称</th>
											<th>报警时间</th>
											<th>报警类型</th>
											<th>报警信息</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.resultList}" var="alarm">
											<tr>
												<td>${alarm.alarmSystemName}</td>
												<td>${alarm.alarmTime}</td>
												<td>
													<c:choose>
													    <c:when test="${alarm.alarmType == 1}">CPU</c:when>
													    <c:when test="${alarm.alarmType == 2}">内存</c:when>
													    <c:when test="${alarm.alarmType == 3}">网络</c:when>
													    <c:when test="${alarm.alarmType == 4}">磁盘</c:when>
													</c:choose>
												</td>
												<td>${alarm.alarmDesc}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<ul class="pagination no-margin" id="paginator" style="float:right;">
								</ul>
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
		var element = $('#paginator');
		var options = {
			bootstrapMajorVersion : 3,
			size : 'small',
			itemTexts : function(type, page, current) {
				switch (type) {
				case "first":
					return "首页";
				case "prev":
					return "上一页";
				case "next":
					return "下一页 ";
				case "last":
					return "末页";
				case "page":
					return page;
				}
			},
			tooltipTitles : function(type, page, current) {
				switch (type) {
				case "first":
					return "首页";
				case "prev":
					return "上一页";
				case "next":
					return "下一页";
				case "last":
					return "末页";
				case "page":
					return "第" + page + "页";
				}
			},
			currentPage : "${page.currentPage}",
			numberOfPages : 3,
			totalPages : "${page.totalPage}"
		}

		element.bootstrapPaginator(options);

		var cp = options.currentPage;
		var tp = options.totalPages;
		$("#paginator a").click(function() {
			var page = $(this).text().trim();
			if (page == "下一页") {
				cp++;
			} else if (page == "上一页") {
				cp--;
			} else if (page == "首页") {
				cp = 1;
			} else if (page == "末页") {
				cp = tp;
			} else {
				cp = page;
			}
			$("#currentPage").val(cp);
			$("#queryForm").submit();
		});
	</script>
</body>
</html>

