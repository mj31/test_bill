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

	    	
	    	 //1.初始化Table
	    	 var oTable = new TableInit();
	    	 oTable.Init();
	    	 
	    	 //2.初始化Button的点击事件
	    	 var oButtonInit = new ButtonInit();
	    	 oButtonInit.Init();
	    	 
	    	 //查询 
	    	 $("#btn_query").click(function(){
	    		 $("#formSearch").submit();
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
    	   queryParams: oTableInit.queryParams,//传递参数（*）
    	   sidePagination: "client",   //分页方式：client客户端分页，server服务端分页（*）
    	   pageNumber:1,      //初始化加载第一页，默认第一页
    	   pageSize: 5,      //每页的记录行数（*）
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
                return index+1+'<input type="hidden" class="ids" customerId='+row.customerId+' carId = '+row.carId+' companyId = '+row.companyId+' factoryId = '+row.factoryId+' isOrNotTax ='+row.isOrNotTax+' value='+value+'>';
              
            }
    	   },{
    	    field: 'operateNum',
    	    title: '运单编号', 
    	    align: "center",//水平
            valign: "middle"//垂直
    	   },{
    	    field: 'customerShortName',
    	    title: '下游客户',
    	    align: "center",//水平
            valign: "middle"//垂直
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
          	    field: 'strLoadDate',
           	    title: '装车时间', 
           	    align: "center",//水平
                valign: "middle"//垂直
           	},{
       	    field: 'carNum',
       	    title: '承运车号', 
       	    align: "center",//水平
            valign: "middle"//垂直
       	   },
       	   {
       	    field: 'factoryShortName',
       	    title: '上游工厂',  
       	    align: "center",//水平
            valign: "middle"//垂直
       	   },
       	   {
       	    field: 'factoryPrice',
       	    title: '出厂价',
       	    align: "center",//水平
            valign: "middle",//垂直
           	formatter:function(value,row,index){
              		if(value != null && value != ''){
              			return (value/100).toFixed(2) ;
              		}else{
              			return '-' ;
              		}
                 }
       	    },
           	{
              	    field: 'customerAddress',
              	    title: '卸车地',   
              	    align: "center",//水平
                   valign: "middle"//垂直
              },{
               	    field: 'strUploadDate',
               	    title: '卸车时间',    
               	    align: "center",//水平
                    valign: "middle"//垂直
              },
           	  {
              	    field: 'customerPrice',
              	    title: '运到价',  
              	    align: "center",//水平
                    valign: "middle",//垂直
                  	formatter:function(value,row,index){
                     		if(value != null && value != ''){
                     			return (value/100).toFixed(2) ;
                     		}else{
                      			return '-' ;
                      		}
                        }
              	 },
             	 {
               	    field: 'compangShortName',
               	    title: '承运单位',   
               	    align: "center",//水平
                    valign: "middle"//垂直
               	},
           		{
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
              	 },
            	 {
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
               	 },
            	 {
                	    field: 'uploadEmpty',
                	    title: '气差',   
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		if(row.uploadEmpty != null && row.uploadEmpty != ''){
                    			return  (row.gasDiff).toFixed(2);
                    		}else{
	                    		return '-' ;
                    		}
                    	}
                	 },{
                	    field: 'factWeight',
                	    title: '实际结算量',     
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		if(row.uploadEmpty != null && row.uploadEmpty != ''){
                    			return  value.toFixed(2);
                    		}else{
	                    		return '-' ;
                    		}
                          }
                	 },{
                   	    field: 'carFee',
                  	    title: '运费',   
                  	    align: "center",//水平
                        valign: "middle",//垂直
                      	formatter:function(value,row,index){
                         		if(value != null && value != ''){
                         			return Number(value/100).toFixed(2) ;
                         		}else{
                          			return '-' ;
                          		}
                            }
                  	 },{
                    	    field: 'isOrNotTax',
                    	    title: '是否含税',    
                    	    align: "center",//水平
                            valign: "middle",//垂直
                            formatter:function(value,row,index){
                         		if(value != null && value == 0){
                         			return '是' ; 
                         		}else{
                         			return '否' ;
                         		}
                            }
                       },{
                 	    field: 'uploadEmpty',
                 	    title: '气损',    
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
   	               	    field: 'factWeight',
   	               	    title: '车辆运费',  
   	               	    align: "center",//水平
   	                    valign: "middle",//垂直
   	                   	formatter:function(value,row,index){
	   	                   	if(row.uploadEmpty != null && row.uploadEmpty != ''){
	                			return  Number(row.settlePrice).toFixed(2);
	                		}else{
	                    		return '-' ;
	                		}
  	                     }
                  	 }
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
    <div class="container-fluid all">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default">
   <div class="panel-heading">运费结算</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/settle/index.do">
		     <div class="form-group" style="margin-top:15px">
		     	  <label class="control-label col-sm-1" for="txt_search_departmentname">运单编号</label>
			      <div class="col-sm-3" style="width:12%">
			       	  <input type="text" class="form-control" id="operateNum" name="operateNum" value="${operateEvent.operateNum}">
			      </div>
		     		
			      <label class="control-label col-sm-1" for="txt_search_departmentname">下游客户</label>
			      <div class="col-sm-3" style="width:12%">
			      		 	<select class="selectpicker bla bla bli querySelect"   data-live-search="true"  id="customerId" name="customerId">
			      		 				   <option value=''>----请选择----</option>
	                               	<c:forEach items="${companyList}" var="customer">
	                               		<c:if test="${customer.flag eq 1}">
							     			<option value="${customer.id}" <c:if test="${operateEvent.customerId eq customer.id}">selected</c:if>>${customer.shortName}</option> 
	                               		</c:if>
	                               	</c:forEach> 
						 	 </select>
			      </div>
			      <label class="control-label col-sm-1" for="txt_search_statu">上游工厂</label>
			      <div class="col-sm-3" style="width:12%">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true" id="factoryId" name="factoryId"> 
			       								 <option value=''>----请选择----</option>
								      <c:forEach items="${companyList}" var="factory">
	                                  		  <c:if test="${factory.flag eq 0}">
										         <option value="${factory.id}"  <c:if test="${operateEvent.factoryId eq factory.id}">selected</c:if>>${factory.shortName}</option> 
	                                  		  </c:if>
	                                  </c:forEach>
						    </select>
			      </div>
			      <!-- <label class="control-label col-sm-1" for="txt_search_statu"></label> -->
		      </div>
		      <div class="form-group" style="margin-top:30px">
			      <label class="control-label col-sm-1" for="txt_search_statu">承运单位</label>
			      <div class="col-sm-3" style="width:12%">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true" id="companyId" name="companyId"> 
			       								 <option value=''>----请选择----</option>
								      <c:forEach items="${companyList}" var="company">
	                                  		  <c:if test="${company.flag eq 2}">
										         <option value="${company.id}"  <c:if test="${operateEvent.companyId eq company.id}">selected</c:if>>${company.shortName}</option> 
	                                  		  </c:if>
	                                  </c:forEach>
						    </select>
			      </div>
			      
			      <label class="control-label col-sm-1" for="txt_search_statu">承运车号</label>
			      <div class="col-sm-3" style="width:4%">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true"  id="carId" name="carId"> 
			       								  <option value=''>----请选择----</option>
	                                    	<c:forEach items="${carInfoList}" var="carInfo">
												   <option value="${carInfo.id}"  <c:if test="${operateEvent.carId eq carInfo.id}">selected</c:if>>${carInfo.headerNumber}</option> 
	                                    	</c:forEach>
						 	</select>
			      </div>
			      <label class="control-label col-sm-1" for="txt_search_statu"></label>
			      <div class="col-sm-2" style="text-align:left;">
		       		 <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		          </div>
		      </div>
    </form>
   </div>
  </div>  
        <table id="table"></table>
    </div>
  <%@ include file="/common/footer.jsp"%>
</body>
</html>