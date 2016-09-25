<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- <script type="text/javascript">
     	$(function(){
     		$("#loadFactoryData").click(function(){
	     		$.ajax({
	  		        url : "${ctx}/company/queryFactory.do",
	  		        success: function(result){
			                     if(result.status == 0){
			                    	 var newHtml = "";
			                    	for(var i = 0 ; i < result.factoryList.length;i++){
			                    		var factory = result.factoryList[i];
			                    		var id=factory.id;
			                    		var shortName = factory.shortName;
			                    		newHtml += '<li><a href="${ctx}/factory/index.do?id='+id+'"><i class="fa fa-circle-o fa-fw"></i>&nbsp;'+shortName+'</a></li>'
			                    	}
			                    	$("#factoryId").html(newHtml);
			                    	
			                     }else{
			                    	 bootbox.alert("工厂数据加载失败 ");  
			                     }
			               }
			           ,error:function(){
			            	 bootbox.alert("工厂数据加载失败 "); 
			        	   }
			          });
     		    });
     		
     	});
</script> -->
<div class="sidebar">
	<ul class="nav">
		<%-- <li><a href="${ctx}/login.do">主页面</a></li> --%>
		<li><a href="${ctx}/operate/index.do">运作详情</a></li>
		<li><a href="${ctx}/bank/index.do">交易流水信息</a></li>
		<li><a href="${ctx}/factory/index.do">工厂对账单信息</a></li>
		<%-- <li class="has-sub" id="loadFactoryData"><a href="javascript:void(0);"><span>工厂对账单信息</span><i
				class="fa fa-caret-right fa-fw pull-right"></i></a>
			<ul class="sub-menu" id="factoryId">
				<li><a href="${ctx}/user/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;用户管理</a></li>
			</ul>
		</li> --%>
		<li><a href="${ctx}/customer/index.do">客户对账单</a></li>
		<li class="has-sub"><a href="javascript:void(0);"><span>系统管理</span><i
				class="fa fa-caret-right fa-fw pull-right"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/user/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;用户管理</a></li>
				<li><a href="${ctx}/car/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;车辆信息管理</a></li>
				<li><a href="${ctx}/company/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;公司信息管理</a></li>
			</ul>
		</li>
	</ul>
</div>