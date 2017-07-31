<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'fixed')
		} catch (e) {
		}
	</script>
	<div class="sidebar-shortcuts" id="sidebar-shortcuts" style="height:50px;background: #2e363f;">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
		</div>
	</div>
	<!-- #sidebar-shortcuts -->
	<ul class="nav nav-list">
		<li id="menu1">
			<a href="<%=basePath%>/index"> 
				<img src="style/assets/images/h1.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;">实时监控 </span>
			</a>
		</li>
		<li id="menu2">
			<a href="<%=basePath%>/serviceList"> 
				<img src="style/assets/images/h2.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;">服务监控 </span>
			</a>
		</li>
		<li id="menu3">
			<a href="#" class="dropdown-toggle"> 
				<img src="style/assets/images/h3.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;">系统监控 </span>
				<b class="arrow icon-angle-down"></b>
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
				<img src="style/assets/images/h4.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;"> 报警策略 </span> 
				<b class="arrow icon-angle-down"></b>
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
				<img src="style/assets/images/h5.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;"> 指标设置</span> 
				<b class="arrow icon-angle-down"></b>
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
					<img src="style/assets/images/h6.png" style="padding-left:10px;"></img> 
					<span class="menu-text" style="padding-left:17px;">统计记录 </span> 
					<b class="arrow icon-angle-down"></b>
				</a>
				<ul class="submenu">
					<li id="systemLogList">
						<a href="<%=basePath%>/systemLogList"> <i class="icon-double-angle-right"></i> 监控日志</a>
					</li>
					<li id="alarmList">
						<a href="<%=basePath%>/alarmList"> <i class="icon-double-angle-right"></i> 报警统计</a>
					</li>
					<li id="chartList">
						<a href="<%=basePath%>/chartList"> <i class="icon-double-angle-right"></i> 监控统计</a>
					</li>
				</ul>
			</li>
		</shiro:hasRole>
		<shiro:hasRole name="super">
			<li id="menu7">
				<a href="<%=basePath%>/userList"> 
					<img src="style/assets/images/h7.png" style="padding-left:10px;"></img> 
					<span class="menu-text" style="padding-left:17px;">用户管理 </span>
				</a>
			</li>
		</shiro:hasRole>
		<li id="menu8">
			<a href="#" class="dropdown-toggle"> 
				<img src="style/assets/images/h8.png" style="padding-left:10px;"></img> 
				<span class="menu-text" style="padding-left:17px;">系统设置 </span> 
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li id="systemDetail">
					<a href="<%=basePath%>/systemDetail"> <i class="icon-double-angle-right"></i> 操作系统信息</a>
				</li>
<!-- 				<li id="ping"> -->
<%-- 					<a href="<%=basePath%>/ping"> <i class="icon-double-angle-right"></i> ping监控</a> --%>
<!-- 				</li> -->
<!-- 				<li id="initOption"> -->
<%-- 					<a href="<%=basePath%>/initOption"> <i class="icon-double-angle-right"></i> 恢复默认设置</a> --%>
<!-- 				</li> -->
<!-- 				<li id="propertyOption"> -->
<%-- 					<a href="<%=basePath%>/propertyOption"> <i class="icon-double-angle-right"></i> 参数配置</a> --%>
<!-- 				</li> -->
			</ul>
		</li>
	</ul>
</div>

<script type="text/javascript">
		
</script>

