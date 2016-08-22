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
<script src="style/assets/js/jquery.validate.min.js"></script>
<script src="style/assets/js/ace-elements.min.js"></script>
<script src="style/assets/js/ace.min.js"></script>
<script src="style/assets/js/ace-extra.min.js"></script>
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
						<li class="active">服务指标</li>
					</ul>
					<!-- .breadcrumb -->
				</div>

				<div class="page-content">
					<div class="page-header">
						<h1>
							服务指标<small> <i class="icon-double-angle-right"></i> 编辑
							</small>
						</h1>
					</div>
					<!-- 编辑指标 -->
					<div class="row">
						<div class="col-xs-12">
							<form id="updateForm" class="form-horizontal" role="form" action="<%=path%>/updateNorm" method="post">
								<input type="hidden" id="id" name="id" value="${normEntity.id}"/>
								<input type="hidden" id="serviceType" name="serviceType" value="${normEntity.serviceType}"/>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normName"> 指标名称 </label>
									<div class="col-sm-9">
										<input type="text" id="normName" class="col-xs-10 col-sm-4" name="normName" value="${normEntity.normName}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normNormal"> 正常负载(M)</label>
									<div class="col-sm-9">
										<input type="text" id="normNormal" class="col-xs-10 col-sm-4" name="normNormal" value="${normEntity.normNormal}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normWarning"> 警告负载 (M)</label>
									<div class="col-sm-9">
										<input type="text" id="normWarning" class="col-xs-10 col-sm-4" name="normWarning" value="${normEntity.normWarning}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="normDanger"> 过高负载 (M)</label>
									<div class="col-sm-9">
										<input type="text" id="normDanger" class="col-xs-10 col-sm-4" name="normDanger" value="${normEntity.normDanger}"/>
									</div>
								</div>
		
								<div class="space-4"></div>
		
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<a onclick="history.back()"  class="btn"><i class="icon-reply bigger-110"></i>返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
										&nbsp; &nbsp; &nbsp;
										<a id="submitBtn" class="btn btn-info"><i class="icon-ok bigger-110"></i>提&nbsp;&nbsp;&nbsp;&nbsp;交</a>
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- 编辑指标 -->
				</div>
			</div>
		</div>
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript">
		// 点击提交
		$("#submitBtn").click(function() {
			$("#updateForm").submit();
		});

		// 校验表单
		
		$("#updateForm").validate({
			errorElement : 'div',
			errorClass : 'help-block',
			focusInvalid : false,
			rules : {
				normName : {
					required : true,
					remote:{
			               type:"get",
			               url:"<%=path%>/checkName",           
			               data:{ id : function() { return $("#id").val(); },
            	   				  normName : function() { return $("#normName").val(); }
			               } 
					}
				},
				normNormal : {
					required : true,
					digits : true
				},
				normWarning : {
					required : true,
					digits : true
				},
				normDanger : {
					required : true,
					digits : true
				}
			},
			messages : {
				normName : {
					required : "请输入指标名称",
					remote: "该指标名称已存在"
				},
				normNormal : {
					required : "请输入正常指标 ",
					digits : "请输入整数"
				},
				normWarning : {
					required : "请输入警告指标 ",
					digits : "请输入整数"
				},
				normDanger : {
					required : "请输入过高指标 ",
					digits : "请输入整数"
				}
			},

			invalidHandler : function(event, validator) { //display error alert on form submit   
				$('.alert-danger', $('.login-form')).show();
			},

			highlight : function(e) {
				$(e).closest('.form-group').removeClass('has-info')
						.addClass('has-error');
			},

			success : function(e) {
				$(e).closest('.form-group').removeClass('has-error')
						.addClass('has-info');
				$(e).remove();
			}
		});
	</script>
</body>
</html>

