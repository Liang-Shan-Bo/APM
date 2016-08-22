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
				<li class="purple">
					<a data-toggle="dropdown" class="dropdown-toggle" href="#"> 
						<i class="icon-bell-alt icon-animated-bell"></i> 
						<span class="badge badge-important">8</span>
					</a>
					<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
						<li class="dropdown-header">
							<i class="icon-warning-sign"></i> 8条报警
						</li>
						<li>
							<a href="#">
								<div class="clearfix">
									<span class="pull-left"> 
										<i class="btn btn-xs no-hover btn-pink icon-comment"></i> 系统警告
									</span> 
									<span class="pull-right badge badge-info">+8</span>
								</div>
							</a>
						</li>
						<li>
							<a href="#"> 查看所有 <i class="icon-arrow-right"></i> </a>
						</li>
					</ul>
				</li>
				<li class="light-blue">
					<a data-toggle="dropdown" href="#" class="dropdown-toggle"> 
						<img class="nav-user-photo" src="style/assets/avatars/user.jpg" alt="Jason's Photo" /> 
						<span class="user-info"> <small>欢迎 登录<br/><shiro:user><shiro:principal/></shiro:user></span> 
						<i class="icon-caret-down"></i>
					</a>
					<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						<li>
							<a href="#"> <i class="icon-cog"></i> 设置 </a>
						</li>
						<li>
							<a href="#"> <i class="icon-user"></i> 个人资料 </a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="#"> <i class="icon-off"></i> 退出 </a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>

