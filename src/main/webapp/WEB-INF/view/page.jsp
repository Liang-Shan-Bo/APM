<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 页码 -->
<div class="message-footer clearfix">
	<div class="pull-left">共${page.totalRow}条</div>

	<div class="pull-right">
		<div class="inline middle">页数 : ${page.currentPage} / ${page.totalPage}</div>

		&nbsp; &nbsp;
		<ul class="pagination middle">
			<c:choose>
				<c:when test="${page.currentPage == 1}">
					<li class="disabled"><span> <i class="icon-step-backward middle"></i>
					</span></li>
					<li class="disabled"><span> <i class="icon-caret-left bigger-140 middle"></i>
					</span></li>
				</c:when>
				<c:otherwise>
					<li><a href="#" onclick="paginate(1);"> <i class="icon-step-backward middle"></i>
					</a></li>
					<li><a href="#" onclick="paginate('${page.currentPage - 1}');"> <i
							class="icon-caret-left bigger-140 middle"></i>
					</a></li>
				</c:otherwise>
			</c:choose>
			<li><span> <input id="pageNo" value="${page.currentPage}" type="text" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
			</span></li>
			<c:choose>
				<c:when test="${page.currentPage == page.totalPage}">
					<li class="disabled"><span> <i class="icon-caret-right bigger-140 middle"></i>
					</span></li>
					<li class="disabled"><span> <i class="icon-step-forward middle"></i>
					</span></li>
				</c:when>
				<c:otherwise>
					<li><a href="#" onclick="paginate(${page.currentPage + 1});"> <i
							class="icon-caret-right bigger-140 middle"></i>
					</a></li>
					<li><a href="#" onclick="paginate(${page.totalPage});"> <i class="icon-step-forward middle"></i>
					</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
<script src="style/assets/js/bootbox.min.js"></script>
<script type="text/javascript">
	// 跳转页码
	function paginate(page) {
		$("#currentPage").val(page);
		$("#queryForm").submit();
	}
	// 回车触发事件
	var totalPage = ${page.totalPage};
	$(function(){
		$("#pageNo").bind('keypress',function(event){
            if(event.keyCode == "13")    
            {	
            	if ($("#pageNo").val() == "" || $("#pageNo").val() < 1 || $("#pageNo").val() > totalPage){
            		bootbox.alert({  
			            buttons: { ok: { label: '确认' } },  
			            message: '请输入正确的页码',  
			        });
				}else {
					paginate($("#pageNo").val());
				}
            }
        });
    });
</script>
<!-- 页码 -->