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
				test1();
				setInterval("test1();",2000); 
			});
		})
		
		function test1(){
			$.ajax({
				url : "<%=basePath%>/test1",
				method : 'post',
				async: false,
				dataType: "json",
				data: {},
				success : function(data){
					$("#name").val(data.name);
					$("#Address").val(data.Address);
					$("#RxPackets").val(data.RxPackets);
					$("#TxPackets").val(data.TxPackets);
					$("#RxBytes").val(data.RxBytes);
					$("#TxBytes").val(data.TxBytes);
					$("#RxErrors").val(data.RxErrors);
					$("#TxErrors").val(data.TxErrors);
					$("#RxDropped").val(data.RxDropped);
					$("#TxDropped").val(data.TxDropped);
				},
				error : function(data){
				},
			});
		}
	</script>
</head>
<body>
	网络参数:<br/>
	网络设备名  :<input type="text" id ="name" name="name" /> <br/>
	IP地址 :<input  type="text" id ="Address" name="Address" /> <br/>
	接收的总包裹数  :<input  type="text" id ="RxPackets" name="RxPackets" /> <br/>
	发送的总包裹数   :<input  type="text" id ="TxPackets" name="TxPackets" /> <br/>
	接收到的总字节数   :<input  type="text" id ="RxBytes" name="RxBytes" /> <br/>
	发送的总字节数  :<input  type="text" id ="TxBytes" name="TxBytes" /> <br/>
	接收到的错误包数  :<input  type="text" id ="RxErrors" name="RxErrors" /> <br/>
	发送数据包时的错误数  :<input  type="text" id ="TxErrors" name="TxErrors" /> <br/>
	接收时丢弃的包数   :<input  type="text" id ="RxDropped" name="RxDropped" /> <br/>
	发送时丢弃的包数  :<input  type="text" id ="TxDropped" name="TxDropped" /> <br/>
</body>
</html>
