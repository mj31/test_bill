<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<%@ include file="/common/header.jsp"%>
    <title>永润系统</title>
    <script type="text/javascript">
    $(function () {
    	
    	
	    	 $('.querySelect').selectpicker({
		            'selectedText': 'cat'
		      });
	    	 
	    	 //修改弹出层 
	    	 $("#btn_edit").click(function(){
	    		 $("#lblAddTitle").text("修改运费结算");   
	    		 $("#saveUser").text("修改") ; 
	    		 /* formNull(); */
	    		 //校验选了一条数据 
	    		 if($(".updataOrDeleteClasss").length != 1){ 
	    			 bootbox.alert({  
	    		            buttons: {  
	    		               ok: {  
	    		                    label: '确定',  
	    		                    className: 'btn-myStyle'  
	    		                }  
	    		            },  
	    		            message: '请选择一条数据进行操作',  
	    		            
	    		        }); 
	    			 return ;
	    		 }else{
	    			 var id = $(".updataOrDeleteClasss .ids").val() ;
	    			 $.ajax({
		      		        url : "${ctx}/operate/updateSearch.do",
		      		        type: "post",
		      		        data:{"id":id},
		      		        dataType : "json",
		      		        success: function(result){
	  		                     if(result.status == 0){
	  		                    	  var operateEvent = result.operateEvent ;
		  		               		  //运单编号 
		  		               		  var operateNum = operateEvent.operateNum ;
		  		               		  $("#addForm #operateNum").val(operateNum);
		  		               		  //实际结算量
		  		               		  var tranFactWeight = operateEvent.tranFactWeight ;
		  		               		  if(tranFactWeight != null && tranFactWeight != ""){
		  		           	   			  $("#addForm #tranFactWeight").val(tranFactWeight/100);
			           	   		      }else{
			           	   				  $("#addForm #tranFactWeight").val("");
			           	   		       }
		  		               		  
		  		               		  //押车费用
		  		               		  var stockFee = operateEvent.stockFee ;
		  		               		  if(stockFee != null && stockFee != ""){
		  		           	   			  $("#addForm #stockFee").val(stockFee/100);
			           	   		      }else{
			           	   				$("#addForm #stockFee").val("");
			           	   		       }
		  		               		  //管理费用
		  		               		  var manageFee = operateEvent.manageFee ;
			  		               	  if(manageFee != null && manageFee != ""){
			  		           	   			$("#addForm #manageFee").val(manageFee/100);
				           	   		  }else{
				           	   				$("#addForm #manageFee").val("");
				           	   		  }
		  		               		  //结算情况
		  		               		  var settleRemark = operateEvent.settleRemark ;
		  		               	 	  $("#addForm #settleRemark").val(settleRemark); 
		  		               	 	  
		  		               	 	  //承运车号 
		  		               	 	  var carNum = operateEvent.carNum ;
		  		               	      $("#addForm #carNum").val(carNum); 
		  		               	      
		  		           	   		  
		  		           	   		  $('#add').modal();
	  		                     }else{
	  		                    	 bootbox.alert("获取失败"); 
	  		                     }
	   		               },
	   		            error:function(){
		  		            	 bootbox.alert("获取失败 ");
	   		        	   }
			          	});
	    		 }
	    	 });
	    	 
	    	 
	    	//============保存开始====================================
	    	 $("#saveUser").click(function(){

		 	   		 var saveUserValue = $("#saveUser").text() ;
		 	   		 
		 	   		  var reg = /^[0-9]+(.[0-9]{1,2})?$/;
               		  
               		  //实际结算量
               		  var tranFactWeight = $("#addForm #tranFactWeight").val();
               		  if(tranFactWeight != null  && tranFactWeight != ''){
					        if(!reg.test(tranFactWeight)){
					        	bootbox.alert("实际吨位必须是数字且保留2位小数");   
					        	return  ; 
					        }else{
					        	tranFactWeight = Number(tranFactWeight*100) ;
					        }
				 	  }
                 	  //押车费用
               		  var stockFee = $("#addForm #stockFee").val() ;  
               		  if(stockFee != null  && stockFee != ''){
				         if(!reg.test(stockFee)){
				        	 bootbox.alert("押车费用必须是数字且保留2位小数");   
				        	 return  ;
				         }else{
				        	 stockFee = Number(stockFee*100) ;
				         }
				 	 }
               		  //管理费用
               		  var manageFee = $("#addForm #manageFee").val() ;
               		  if(manageFee != null  && manageFee != ''){
				         if(!reg.test(manageFee)){
				        	 bootbox.alert("管理费用是数字且保留2位小数");   
				        	 return  ;
				         }else{
				        	 manageFee = Number(manageFee*100) ;
				        }
				 	 }
               		  //结算情况
               	 	  var settleRemark=  $("#addForm #settleRemark").val();
		 	 		
	 	   		if(saveUserValue == '修改'){
	 	   			var id = $(".updataOrDeleteClasss .ids").val() ;
		 	   		$.ajax({
		      		        url : "${ctx}/operate/updateBySettle.do",
		      		        type: "post",
		      		        data:{"id":id,"stockFee":stockFee,"manageFee":manageFee,"tranFactWeight":tranFactWeight
	      		        		, "settleRemark":settleRemark},
		      		        dataType : "json",
		      		        success: function(result){
		 		                     if(result.status == 0){
		 		                    	$("#table").bootstrapTable('refresh', TableInit);
		 		                    	$("#add").modal("hide");
		 		                     }else{
		 		                    	 bootbox.alert("保存失败 "); 
		 		                     }
		  		               }
	      		           ,error:function(){
		  		            	 bootbox.alert("保存失败 ");
	      		        	   }
		  		          });
	 	   		}
	    	 });
	    	 //============保存结束====================================

	    	
	    	 //1.初始化Table
	    	 var oTable = new TableInit();
	    	 oTable.Init();
	    	 
	    	 //2.初始化Button的点击事件
	    	 var oButtonInit = new ButtonInit();
	    	 oButtonInit.Init();
	    	 
	    	 //查询 
	    	 $("#btn_query").click(function(){
	    		 $("#table").bootstrapTable('refresh', TableInit);
	    	 });
    	});
    	 
    	 
    	var TableInit = function () {
    	 var oTableInit = new Object();
    	 //初始化Table
    	 oTableInit.Init = function () {
    	  $('#table').bootstrapTable({
    	   url: '${ctx}/settle/search.do',   //请求后台的URL（*） 
    	   method: 'get',      //请求方式（*）
    	   toolbar: '#toolbar',    //工具按钮用哪个容器
    	   striped: true,      //是否显示行间隔色
    	   cache: false,      //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    	   pagination: true,     //是否显示分页（*）
    	   sortable: false,      //是否启用排序
    	   sortOrder: "asc",     //排序方式
    	   queryParams : function(params) {
    		   var formSearchCustomerId = $("#formSearch #customerId").find("option:selected").val() ;
    	    	 var formSearchFactoryId = $("#formSearch #factoryId").find("option:selected").val() ;
    	    	 var formSearchCarId = $("#formSearch #carId").find("option:selected").val() ;
    	    	 var formSearchCompanyId = $("#formSearch #companyId").find("option:selected").val() ;
    	    	 var operateNum = $("#formSearch #operateNum").val() ;
                 return {
            	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   customerId: formSearchCustomerId ,
		    	   factoryId: formSearchFactoryId ,
		    	   carId: formSearchCarId ,
		    	   operateNum: operateNum ,
		    	   companyId: formSearchCompanyId
               };
       	},
    	   sidePagination: "server",   //分页方式：client客户端分页，server服务端分页（*）
    	   pageNumber:1,      //初始化加载第一页，默认第一页
    	   pageSize: 20,      //每页的记录行数（*）
    	   pageList: [10, 25, 50, 100],  //可供选择的每页的行数（*）
    	   search: true,      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
    	   strictSearch: true,
    	   showColumns: true,     //是否显示所有的列
    	   showRefresh: true,     //是否显示刷新按钮
    	   minimumCountColumns: 2,    //最少允许的列数
    	   clickToSelect: true,    //是否启用点击选中行
    	   height: 500,      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
    	   uniqueId: "ID",      //每一行的唯一标识，一般为主键列
    	   showToggle:true,     //是否显示详细视图和列表视图的切换按钮
    	   cardView: false,     //是否显示详细视图
    	   detailView: false,     //是否显示父子表
    	   columns: [{
    	    checkbox: true
    	   }, {
    	    field: 'id',
    	    title: '序号', 
    	    align: "center",//水平
            valign: "middle",//垂直;
            width:5,
            formatter:function(value,row,index){
                //通过formatter可以自定义列显示的内容
                //value：当前field的值，即id
                //row：当前行的数据
                var page = $('#table').bootstrapTable("getPage");  
                return page.pageSize * (page.pageNumber - 1) + index + 1+'<input type="hidden" class="ids" customerId='+row.customerId+' carId = '+row.carId+' companyId = '+row.companyId+' factoryId = '+row.factoryId+' isOrNotTax ='+row.isOrNotTax+' value='+value+'>';
              
            }
    	   },{
	    	    field: 'operateNum',
	    	    title: '运单编号', 
	    	    align: "center",//水平
	            valign: "middle"//垂直
    	   },{
          	    field: 'compangShortName',
           	    title: '承运单位',   
           	    align: "center",//水平
                valign: "middle"//垂直
           	},{
           	    field: 'carNum',
           	    title: '承运车号', 
           	    align: "center",//水平
                valign: "middle"//垂直
            },{
           	    field: 'factoryShortName',
           	    title: '供应商',    
           	    align: "center",//水平
                valign: "middle"//垂直
           	},{
          	    field: 'loadEmpty',
          	    title: '装车净重',   
          	    align: "center",//水平
                valign: "middle",//垂直
              	formatter:function(value,row,index){
                 		if(value != null && value != ''){
                 			return (value/100).toFixed(2) ;
                 		}else{
                  			return '-' ;
                  		}
                    }
          	 },{
            	    field: 'factoryPrice',
               	    title: '供货单价', 
               	    align: "center",//水平
                    valign: "middle",//垂直
                   	formatter:function(value,row,index){
                      		if(value != null && value != ''){
                      			return (value/100).toFixed(2) ;
                      		}else{
                      			return '-' ;
                      		}
                         }
            },{
	    	    field: 'customerShortName',
	    	    title: '采购商', 
	    	    align: "center",//水平
	            valign: "middle"//垂直
    	   },{
         	    field: 'uploadAddress', 
          	    title: '卸车地点',   
          	    align: "center",//水平
               valign: "middle"//垂直
          },{
           	    field: 'uploadEmpty',
           	    title: '卸车净重',   
           	    align: "center",//水平
                 valign: "middle",//垂直
               	formatter:function(value,row,index){
                  		if(value != null && value != ''){
                  			return (value/100).toFixed(2) ;
                  		}else{
                   			return '-' ;
                   		}
                     }
           	 },{
			    	    field: 'poundsDiff',
			    	    title: '磅差', 
			    	    align: "center",//水平
			            valign: "middle",//垂直
			           	formatter:function(value,row,index){
		            		if(value != null && value != ''){
		            			return (value/100).toFixed(2) ;
		            		}else{
		             			return '-' ;
		             		}
		               }
    	   	},{
                	    field: 'uploadEmpty',
                	    title: '装卸亏损',   
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		if(row.uploadEmpty != null && row.uploadEmpty != ''){
                    			return  (row.gasDiff/1000).toFixed(2);
                    		}else{
	                    		return '-' ;
                    		}
                    	}
                	 },{
                	    field: 'tranFactWeight',
                	    title: '实际吨位',      
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		if(value != null && value != ''){
                    			return  Number(value/100).toFixed(2);
                    		}else{
	                    		return '-' ;
                    		}
                          }
                	 },{
                   	    field: 'carFee',
                  	    title: '运费单价(税)',    
                  	    align: "center",//水平
                        valign: "middle",//垂直
                      	formatter:function(value,row,index){
                         		if(value != null && value != ''){
                         			var carIsOrNotTax = row.carIsOrNotTax ;
                         				if(carIsOrNotTax == 0){
		                         			return Number(value/100).toFixed(2)+"(是)" ;
                         				}else{
                         					return Number(value/100).toFixed(2) ;
                         				}
                         		}else{
                          			return '-' ;
                          		}
                            }
                  	 },{
                 	    field: 'uploadEmpty',
                 	    title: '气损金额',     
                 	    align: "center",//水平
                        valign: "middle",//垂直
                     	formatter:function(value,row,index){
                     		if(row.uploadEmpty != null && row.uploadEmpty != ''){
                    			return  Number(row.gasMiss).toFixed(2);
                    		}else{
                    			return '-' ;
                    		}
                           }
                 	 },
           	         {
    	               	    field: 'stockFee',
       	               	    title: '押车费用',   
       	               	    align: "center",//水平
       	                    valign: "middle",//垂直
       	                   	formatter:function(value,row,index){
    	   	                   	if(value != null && value != ''){
    	                			return  Number(value/100).toFixed(2);
    	                		}else{
    	                    		return '-' ;
    	                		}
      	                     }
                      	 },{
        	               	    field: 'manageFee',
           	               	    title: '管理费用',   
           	               	    align: "center",//水平
           	                    valign: "middle",//垂直
           	                   	formatter:function(value,row,index){
        	   	                   	if(value != null && value != ''){
        	                			return  Number(value/100).toFixed(2);
        	                		}else{
        	                    		return '-' ;
        	                		}
          	                     }
                          	 },{
            	               	    field: 'tranFactWeight',
               	               	    title: '车辆运费',  
               	               	    align: "center",//水平
               	                    valign: "middle",//垂直
               	                   	formatter:function(value,row,index){
               	                   		var yunfei = 0 ;
            	   	                   	if(value != null && value != ''){
            	   	                   		yunfei=  Number(value/100).toFixed(2);
            	                		}
            	   	                   	
            	   	                   	var carFee = 0 ;
            	   	                   	if(row.carFee != null && row.carFee != ''){
            	   	                   		carFee = Number(row.carFee/100).toFixed(2);
            	   	                   	}
            	   	                   	
            	   	                   	var uploadEmpty = 0 ;
            		   	                if(row.uploadEmpty != null && row.uploadEmpty != ''){
            		   	                	uploadEmpty =  Number(row.gasMiss).toFixed(2);
            	                 		}
            		   	                
            		   	                var stockFee = 0 ;
            		   	                if(row.stockFee != null && row.stockFee != ''){
            		   	                	stockFee = row.stockFee ;
            		   	                }
            		   	                
            		   	                var manageFee = 0;
            		   	               if(row.manageFee != null && row.manageFee != ''){
            		   	            		manageFee = row.manageFee ;
            		   	                }
            		   	                
            		   	                return Number(yunfei*carFee+Number(uploadEmpty)+Number(stockFee/100)+Number(manageFee/100)).toFixed(2);
            	   	                   	
            	   	                   	
              	                     }
                              	 },
    	   ]
    	  });
    	 };
    	 var formSearchCustomerId = $("#formSearch #customerId").find("option:selected").val() ;
    	 var formSearchFactoryId = $("#formSearch #factoryId").find("option:selected").val() ;
    	 var formSearchCarId = $("#formSearch #carId").find("option:selected").val() ;
    	 var formSearchCompanyId = $("#formSearch #companyId").find("option:selected").val() ;
    	 var operateNum = $("#formSearch #operateNum").val() ;
    	  //得到查询的参数  Number(capacity*100) 
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   customerId: formSearchCustomerId ,
		    	   factoryId: formSearchFactoryId ,
		    	   carId: formSearchCarId ,
		    	   operateNum: operateNum ,
		    	   companyId: formSearchCompanyId
	    	     };
    	  	  return temp;
    	 }; 
    	 return oTableInit;
    	};
    	 
    	 
    	 var ButtonInit = function () {
    	 var oInit = new Object();
    	 var postdata = {};
    	 
    	 oInit.Init = function () {
    	  //初始化页面上面的按钮事件
    	 };
    	 
    	 return oInit;
    	};  
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all" style="margin-right:20px;">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default"  style="margin-left:20px;">
   <div class="panel-heading">运费结算</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/settle/index.do">
		     <div class="form-group  form-group-sm" style="margin-top:15px">
		     	  <label class="control-label col-sm-1" for="txt_search_departmentname">运单编号</label>
			      <div class="col-sm-2">
			       	  <input type="text" class="form-control" id="operateNum" name="operateNum" value="${operateEvent.operateNum}">
			      </div>
			      
			       <label class="control-label col-sm-1" for="txt_search_statu">承运车号</label>
			      <div class="col-sm-2">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true"  id="carId" name="carId"> 
			       								  <option value=''>----请选择----</option>
	                                    	<c:forEach items="${carInfoList}" var="carInfo">
												   <option value="${carInfo.id}"  <c:if test="${operateEvent.carId eq carInfo.id}">selected</c:if>>${carInfo.headerNumber}</option> 
	                                    	</c:forEach>
						 	</select>
			      </div>
			      <!-- <label class="control-label col-sm-1" for="txt_search_statu"></label> -->
			      <div class="col-sm-2" style="text-align:left;">
		       		 <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		          </div>
		     </div>
		     <div class="form-group  form-group-sm" style="margin-top:25px">		
			      <label class="control-label col-sm-1" for="txt_search_departmentname">采购商</label>
			      <div class="col-sm-2">
			      		 	<select class="selectpicker bla bla bli querySelect"   data-live-search="true"  id="customerId" name="customerId">
			      		 				   <option value=''>----请选择----</option>
	                               	<c:forEach items="${companyList}" var="customer">
	                               		<c:if test="${customer.flag eq 1}">
							     			<option value="${customer.id}" <c:if test="${operateEvent.customerId eq customer.id}">selected</c:if>>${customer.shortName}</option> 
	                               		</c:if>
	                               	</c:forEach> 
						 	 </select>
			      </div>
			      <label class="control-label col-sm-1" for="txt_search_statu">供应商</label>
			      <div class="col-sm-2">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true" id="factoryId" name="factoryId"> 
			       								 <option value=''>----请选择----</option>
								      <c:forEach items="${companyList}" var="factory">
	                                  		  <c:if test="${factory.flag eq 0}">
										         <option value="${factory.id}"  <c:if test="${operateEvent.factoryId eq factory.id}">selected</c:if>>${factory.shortName}</option> 
	                                  		  </c:if>
	                                  </c:forEach>
						    </select>
			      </div>
			      <label class="control-label col-sm-1" for="txt_search_statu">承运方</label>
			      <div class="col-sm-2">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true" id="companyId" name="companyId"> 
			       								 <option value=''>----请选择----</option>
								      <c:forEach items="${companyList}" var="company">
	                                  		  <c:if test="${company.flag eq 2}">
										         <option value="${company.id}"  <c:if test="${operateEvent.companyId eq company.id}">selected</c:if>>${company.shortName}</option> 
	                                  		  </c:if>
	                                  </c:forEach>
						    </select>
			      </div>
			      <!-- <label class="control-label col-sm-1" for="txt_search_statu"></label> -->
		      </div>
    </form>
   </div>
  </div> 
  <div id="toolbar" class="btn-group">
	   <button id="btn_edit" type="button" class="btn btn-default">
	    	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
	   </button>
	   <button type="button" onclick="$('#table').tableExport({ type: 'excel', separator: ';', escape: 'false' });"  class="btn btn-default">
			<i class="glyphicon glyphicon-search">导出Excel</i>
	   </button>
  </div> 
        <table id="table"></table>
    </div>
    <!--------------------------添加/修改信息的弹出层---------------------------->
	<div id="add" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">
                    <i class="icon-pencil"></i>
                    <span id="lblAddTitle" style="font-weight:bold">修改运费结算</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                    
                    	
                    	<div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运单编号</label> 
                                <div class="col-md-10" style="width:50%"> 
                                     <input id="operateNum"  name="operateNum" type="text" class="form-control" readonly placeholder="运单编号" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">承运车号</label> 
                                <div class="col-md-10" style="width:50%"> 
                                     <input id="carNum"  name="carNum" type="text" class="form-control" readonly placeholder="承运车号" />
                                </div>
                            </div>
                        </div>
                    
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">实际吨位</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="tranFactWeight" name="tranFactWeight" type="text" class="form-control" placeholder="实际吨位" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">押车费用</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="stockFee" name="stockFee" type="text" class="form-control" placeholder="押车费用" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">管理费用</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="manageFee" name="manageFee" type="text" class="form-control" placeholder="管理费用" />
                                </div>
                            </div>
                        </div>
                        
                        
                        
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">结算情况</label>
                                <div class="col-md-10" style="width:50%">
                                    <textarea id="settleRemark" name="settleRemark"  class="form-control"/></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-info">
                    <button type="button" class="btn blue" id="saveUser">保存</button>
                    <button type="button" class="btn green" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
  <%@ include file="/common/footer.jsp"%>
</body>
</html>