<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'fixed')
		} catch (e) {
		}
	</script>
	<div class="sidebar-shortcuts" id="sidebar-shortcuts" style="height:50px;">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
<!-- 			<button class="btn btn-success"> -->
<!-- 				<i class="icon-signal"></i> -->
<!-- 			</button> -->
<!-- 			<button class="btn btn-info"> -->
<!-- 				<i class="icon-pencil"></i> -->
<!-- 			</button> -->
<!-- 			<button class="btn btn-warning"> -->
<!-- 				<i class="icon-group"></i> -->
<!-- 			</button> -->
<!-- 			<button class="btn btn-danger"> -->
<!-- 				<i class="icon-cogs"></i> -->
<!-- 			</button> -->
		</div>
	</div>
	<!-- #sidebar-shortcuts -->
	<ul class="nav nav-list">
		<li id="menu1">
			<a href="<%=basePath%>/index"> <i class="icon-dashboard"></i> <span class="menu-text">实时监控 </span></a>
		</li>
		<li id="menu2">
			<a href="<%=basePath%>/serviceList"> <i class="icon-off"></i> <span class="menu-text">服务监控 </span></a>
		</li>
		<li id="menu3">
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-desktop"></i><span class="menu-text">系统监控 </span><b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li id="cpuMonitor">
					<a href="<%=basePath%>/cpuMonitor"> <i class="icon-double-angle-right"></i> CPU监控</a>
				</li>
<!-- 				<li id="memMonitor"> -->
<%-- 					<a href="<%=basePath%>/memMonitor"> <i class="icon-double-angle-right"></i> 内存监控</a> --%>
<!-- 				</li> -->
				<li id="netMonitor">
					<a href="<%=basePath%>/netMonitor"> <i class="icon-double-angle-right"></i> 网络监控</a>
				</li>
				<li id="proMonitor">
					<a href="<%=basePath%>/proMonitor"> <i class="icon-double-angle-right"></i> 进程监控</a>
				</li>
			</ul>
		</li>
		<li id="menu4">
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-list"></i> <span class="menu-text"> 报警策略 </span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li id="serviceAlarmPolicyList">
					<a href="<%=basePath%>/serviceAlarmPolicyList"> <i class="icon-double-angle-right"></i> 服务策略</a>
				</li>
				<li id="systemAlarmPolicyList">
					<a href="<%=basePath%>/systemAlarmPolicyList"> <i class="icon-double-angle-right"></i> 系统策略</a>
				</li>
			</ul>
		</li>
		<li id="menu5">
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-edit"></i> <span class="menu-text"> 指标设置</span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li id="serviceNormList">
					<a href="<%=basePath%>/serviceNormList"> <i class="icon-double-angle-right"></i> 服务指标</a>
				</li>
				<li id="systemNormList">
					<a href="<%=basePath%>/systemNormList"> <i class="icon-double-angle-right"></i> 系统指标</a>
				</li>
			</ul>
		</li>
		<shiro:hasRole name="admin">
			<li id="menu6">
				<a href="#" class="dropdown-toggle"> 
					<i class="icon-calendar"></i> <span class="menu-text">报警日志 </span> <b class="arrow icon-angle-down"></b>
				</a>
				<ul class="submenu">
					<li id="systemLogList">
						<a href="<%=basePath%>/systemLogList"> <i class="icon-double-angle-right"></i> 监控日志</a>
					</li>
					<li id="alarmList">
						<a href="<%=basePath%>/alarmList"> <i class="icon-double-angle-right"></i> 报警统计</a>
					</li>
				</ul>
			</li>
		</shiro:hasRole>
		<shiro:hasRole name="super">
			<li id="menu7">
				<a href="<%=basePath%>/userList"> <i class="icon-user"></i> <span class="menu-text">用户管理 </span></a>
			</li>
		</shiro:hasRole>
		<li id="menu8">
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-list-alt"></i> <span class="menu-text">系统功能 </span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li id="systemDetail">
					<a href="<%=basePath%>/systemDetail"> <i class="icon-double-angle-right"></i> 操作系统信息</a>
				</li>
<!-- 				<li id="ping"> -->
<%-- 					<a href="<%=basePath%>/ping"> <i class="icon-double-angle-right"></i> ping监控</a> --%>
<!-- 				</li> -->
			</ul>
		</li>
	</ul>
</div>
