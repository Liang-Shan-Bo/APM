<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<html>
<head>
	<title>监控系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/bootstrap/css/bootstrap.css" />
	<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=path%>/style/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$(document).ready(function(){
				test2();
				setInterval("test2();",5000); 
			});
		})
		
		function test2(){
			$.ajax({
				url : "<%=basePath%>/test2",
				method : 'post',
				async: false,
				dataType: "json",
				data: {},
				success : function(data){
					$("#str").val(data.str);
				},
				error : function(data){
				},
			});
		}
	</script>
</head>
<body>
	进程:<br/>
	<textarea rows="35" cols="100" id ="str" name="str" style="overflow-y:hidden"></textarea> 
</body>
</html>
