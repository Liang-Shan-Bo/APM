<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try {
			ace.settings.check('sidebar', 'fixed')
		} catch (e) {
		}
	</script>
	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
			<button class="btn btn-success">
				<i class="icon-signal"></i>
			</button>
			<button class="btn btn-info">
				<i class="icon-pencil"></i>
			</button>
			<button class="btn btn-warning">
				<i class="icon-group"></i>
			</button>
			<button class="btn btn-danger">
				<i class="icon-cogs"></i>
			</button>
		</div>
	</div>
	<!-- #sidebar-shortcuts -->
	<ul class="nav nav-list">
		<li class="active">
			<a href="<%=basePath%>/index"> <i class="icon-dashboard"></i> <span class="menu-text">实时监控 </span></a>
		</li>
		<li>
			<a href="<%=basePath%>/serviceList"> <i class="icon-off"></i> <span class="menu-text">服务监控 </span></a>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-desktop"></i><span class="menu-text">系统监控 </span><b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
			<!--style="display: block;"-->
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> CPU监控</a>
				</li>
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 内存监控</a>
				</li>
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 网络监控</a>
				</li>
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 进程监控</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-list"></i> <span class="menu-text"> 报警策略 </span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 服务策略</a>
				</li>
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 系统策略</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-edit"></i> <span class="menu-text"> 指标设置</span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="<%=basePath%>/serviceNormList"> <i class="icon-double-angle-right"></i> 服务指标</a>
				</li>
				<li>
					<a href="<%=basePath%>/systemNormList""> <i class="icon-double-angle-right"></i> 系统指标</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="#" class="dropdown-toggle"> 
				<i class="icon-list-alt"></i> <span class="menu-text">系统功能 </span> <b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> 系统信息</a>
				</li>
				<li>
					<a href="#"> <i class="icon-double-angle-right"></i> ping监控</a>
				</li>
			</ul>
		</li>
	</ul>
</div>
