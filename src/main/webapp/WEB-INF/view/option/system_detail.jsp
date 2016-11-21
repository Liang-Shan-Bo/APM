<%@ page language="java" import="java.util.*,apm.util.*" pageEncoding="UTF-8"%>
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
<script src="style/assets/js/bootstrap.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
<script src="style/echarts/echarts.js"></script>
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
						<li><i class="icon-home home-icon"></i> <a href="<%=path%>/index">主页</a></li>
						<li class="active">系统设置</li>
					</ul>
				</div>
				<div class="page-content">
					<div class="page-header">
						<h1>
							操作系统信息<small> <i class="icon-double-angle-right"></i> 详细</small>
						</h1>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<!-- 操作系统信息 -->
							<div id="accordionMem" class="accordion-style1 panel-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionMem" href="#collapseMem"> 
											<i class="icon-angle-down bigger-110" data-icon-hide="icon-angle-down" data-icon-show="icon-angle-right"></i>
												&nbsp;操作系统信息
											</a>
										</h4>
									</div>
									<div class="panel-collapse collapse in" id="collapseMem">
										<div class="profile-info-row">
											<div class="profile-info-name"> 系统名称</div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.hostName}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 内核类型 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.arch}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> CPU字节序 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.cpuEndian}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统位数 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.dataModel}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 系统描述 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.description}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统类型 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.name}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统补丁级别</div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.patchLevel}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统供应商 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.vendor}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 供应商编码名 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.vendorCodeName}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统供应商名称</div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.vendorName}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统供应商版本 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.vendorVersion}</span>
											</div>
										</div>
										<div class="profile-info-row">
											<div class="profile-info-name"> 操作系统的版本号 </div>
											<div class="profile-info-value">
												<span class="editable">${systemEntity.version}</span>
											</div>
										</div>
									</div>
								</div>
							</div><!-- 操作系统信息 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<script type="text/javascript">
		$("#menu8").addClass("open");
		$("#menu8").find(".submenu").css("display","block");
		$("#systemDetail").addClass("active");
	</script>
</body>
</html>

