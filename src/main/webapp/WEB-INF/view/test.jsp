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
				test();
				setInterval("test();",2000); 
			});
		})
		
		function test(){
			$.ajax({
				url : "<%=basePath%>/test",
				method : 'post',
				async: false,
				dataType: "json",
				data: {},
				success : function(data){
					$("#user1").val(data.user1);
					$("#sys1").val(data.sys1);
					$("#wait1").val(data.wait1);
					$("#id1").val(data.id1);
					$("#com1").val(data.com1);
					$("#user2").val(data.user2);
					$("#sys2").val(data.sys2);
					$("#wait2").val(data.wait2);
					$("#id2").val(data.id2);
					$("#com2").val(data.com2);
					$("#tmen").val(data.tmen);
					$("#umen").val(data.umen);
					$("#fmen").val(data.fmen);
				},
				error : function(data){
				},
			});
		}
	</script>
</head>
<body>
	CPU1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPU2:<br/>
	用户使用率 :<input type="text" id ="user1" name="user1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户使用率 :<input type="text" id ="user2" name="user2" /><br/>
	系统使用率 :<input  type="text" id ="sys1" name="sys1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统使用率 :<input  type="text" id ="sys2" name="sys2" /><br/>
	当前等待率  :<input  type="text" id ="wait1" name="wait1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前等待率  :<input  type="text" id ="wait2" name="wait2" /><br/>
	当前空闲率 :<input  type="text" id ="id1" name="id1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前空闲率 :<input  type="text" id ="id2" name="id2" /><br/>
	总的使用率 :<input  type="text" id ="com1" name="com1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总的使用率 :<input  type="text" id ="com2" name="com2" /> <br/>
	<br/><br/><br/>
	内存:<br/>
	总内存 :<input type="text" id ="tmen" name="tmen" /> <br/>
	使用中 :<input  type="text" id ="umen" name="umen" /> <br/>
	空闲  :<input  type="text" id ="fmen" name="fmen" /> <br/>
</body>
</html>
