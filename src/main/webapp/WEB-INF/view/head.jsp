<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
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
				<!-- 报警信息 -->
					<li class="purple" >
						<a id="alarm" data-toggle="dropdown" class="dropdown-toggle" href="#" style="display:none;"> 
							<i class="icon-bell-alt icon-animated-bell"></i> 
							<span id="count" class="badge badge-important"></span>
						</a>
						<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
							<li class="dropdown-header">
								<i class="icon-warning-sign"></i> <span id="subCount"></span>条报警
							</li>
							<div id="alarmForm" class="dropdown-navbar dropdown-menu2 navbar-pink" style="height:230px;overflow:auto;margin-top: -1px;">
							</div>
							<li>
								<a href="<%=path%>/messageList"> 查看所有 <i class="icon-arrow-right"></i> </a>
							</li>
						</ul>
					</li><!-- 报警信息 -->
				
				<li class="light-blue">
					<a data-toggle="dropdown" href="#" class="dropdown-toggle"> 
						<span class="user-info"> 
							<small>
								&nbsp;&nbsp;欢迎登录<br/>
								&nbsp;&nbsp;<shiro:user>
									<shiro:principal/>
									<input id="loginName" type="hidden" value="<shiro:principal/>"/>
								</shiro:user>
							</small>
						</span> 
						<i class="icon-caret-down"></i>
					</a>
					<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						<li>
							<a href="<%=path%>/passwordPage"> <i class="icon-cog orange"></i> 修改密码 </a>
						</li>
<!-- 						<li> -->
<%-- 							<a href="<%=path%>/userDetail"> <i class="icon-user blue"></i> 个人信息 </a> --%>
<!-- 						</li> -->
						<li>
							<a href="<%=path%>/messageList"> <i class="icon-envelope green"></i> 系统消息 </a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="<%=path%>/logout"> <i class="icon-off red"></i> 退出 </a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>

<script src="style/assets/js/bootbox.min.js"></script>
<script type="text/javascript">
	$(document).ready(showAlarmMessage());
	var interval = setInterval("showAlarmMessage()",60000);
	
	//动态刷新报警信息
	function showAlarmMessage(){
		$.ajax({
			url : "<%=path%>/getAlarmMessage",
			method : 'post',
			async: false,
			dataType: "json",
			data: { loginName : $("#loginName").val() },
			success : function(data){
				if(data.count <= 0){
					$("#alarm").hide();
				}else{
					
					//清空列表
					$(".alarmList").remove();
					//更新报警信息
					for (var i = 0; i < data.count; i++) {
						var alarm = data.list[i];
						addAlarm(alarm, i);
						
					}
					$("#count").html(data.count);
					$("#subCount").html(data.count);
					$("#alarm").show();
				}
			},
			error : function(data){
				clearInterval(interval);
			}
		});
	}
	
	//写入报警信息到报警列表
	function addAlarm(alarm, index){
		var msg = "";
		switch (alarm.alarmType) {
		case 1:
			msg += "CPU负载超标,当前负载为" + alarm.alarmValue + "%";
			break;
		case 2:
			msg += "内存负载超标,当前负载为" + alarm.alarmValue + "M";
			break;
		case 3:
			msg += "磁盘负载超标,当前负载为" + alarm.alarmValue + "%";
			break;
		case 4:
			msg += "网络负载超标,当前负载为" + alarm.alarmValue + "KB";
			break;
		}
		var html = "<div class=\"alarmList\" stlye=\"height:100px;\">";
		html += "<a href=\"detailMessage?id=" + alarm.id + "\" style=\"margin-left: 20px;\">";
		html += "<span class=\"msg-body\">";
		html += "<span class=\"msg-title\" style=\"margin-top: 5px;\">";
		html += "<span class=\"blue\">" + alarm.alarmSystemName + ":</span>";
		html += msg;
		html += "</span>";
		html += "<span class=\"msg-time\">";
		html += "<i class=\"icon-time\"></i>  ";
		html += "<span>" + getLocalTime(alarm.alarmTime) + "</span>";
		html += "</span>";
		html += "</span>";
		html += "</a>";
		html += "<hr style=\"margin-top:0px;margin-bottom:0px;\"/>";
		html += "</div>";
		$("#alarmForm").append(html);
	}
	
	//时间戳格式化为日期格式
	function getLocalTime(nS) {
		return new Date(parseInt(nS)).toLocaleString()
	}
</script>

