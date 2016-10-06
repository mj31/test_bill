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
	    	   url: '${ctx}/planSettle/search.do',   //请求后台的URL（*） 
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
                return index+1+'<input type="hidden" class="ids" customerId='+row.customerId+' carId = '+row.carId+' companyId = '+row.companyId+' factoryId = '+row.factoryId+' isOrNotTax ='+row.isOrNotTax+' value='+value+'>';
              
            }
    	   },{
    	    field: 'operateNum',
    	    title: '运单编号', 
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
         	    field: 'compangShortName',
         	    title: '承运方',   
         	    align: "center",//水平
              valign: "middle"//垂直
         	},{
          	    field: 'carNum',
           	    title: '承运车号', 
           	    align: "center",//水平
                valign: "middle"//垂直
           },{
         	    field: 'transportProperties',
          	    title: '运输性质',   
          	    align: "center",//水平
                valign: "middle",//垂直
              	formatter:function(value,row,index){
                 		if(value == 1){
                 			return '配送' ;
                 		}else if(value == 2){
                  			return '承运' ;
                  		}else if(value == 3){
                  			return '自提' ;
                  		}else{
                  			return "";
                  		}
                    }
          	 },{
          	    field: 'factoryShortName',
           	    title: '供货方',   
           	    align: "center",//水平
                valign: "middle"//垂直
           	},{
        	    field: 'loadAddress',
        	    title: '装车地点',    
        	    align: "center",//水平
                valign: "middle"//垂直
        	},{
             	    field: 'strLoadDate',
              	    title: '装车时间', 
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
		    	    field: 'customerShortName',
		    	    title: '接收方', 
		    	    align: "center",//水平
		            valign: "middle"//垂直
		     },{
		    	    field: 'uploadAddress',
		    	    title: '接收地点',   
		    	    align: "center",//水平
		            valign: "middle"//垂直
    	     },{
	          	    field: 'strUploadDate',
	          	    title: '卸车时间',    
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
               	    field: 'uploadEmpty',
               	    title: '装卸亏损',    
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
 	               	    field: 'eventRemark',
 	               	    title: '备注',    
 	               	    align: "center",//水平
 	                    valign: "middle"//垂直
             }]
    	  });
    	 };
    	 var formSearchCustomerId = $("#formSearch #customerId").find("option:selected").val() ;
    	 var formSearchFactoryId = $("#formSearch #factoryId").find("option:selected").val() ;
    	 var formSearchCarId = $("#formSearch #carId").find("option:selected").val() ;
    	 var formSearchCompanyId = $("#formSearch #companyId").find("option:selected").val() ;
    	 var loadAddress = $("#formSearch #loadAddress").val() ;
    	 var uploadAddress = $("#formSearch #uploadAddress").val() ;
    	 var operateNum = $("#formSearch #operateNum").val() ;
    	 var transportProperties = $("#formSearch #transportProperties").find("option:selected").val() ;
    	  //得到查询的参数  Number(capacity*100) 
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   customerId: formSearchCustomerId ,
		    	   factoryId: formSearchFactoryId ,
		    	   carId: formSearchCarId ,
		    	   operateNum: operateNum ,
		    	   companyId: formSearchCompanyId,
		    	   loadAddress: loadAddress ,
		    	   uploadAddress:uploadAddress ,
		    	   transportProperties:transportProperties
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
   <div class="panel-heading">销售计划</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/salePlan/index.do">
		     <div class="form-group" style="margin-top:10px">
			      <label class="control-label col-sm-1" for="txt_search_departmentname">接收方</label>
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
			      <label class="control-label col-sm-1" for="txt_search_statu">供货方</label>
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
			      <div class="col-sm-2" style="text-align:left;">
		       		 <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		          </div>
		      </div>
		      
		      <div class="form-group" style="margin-top:20px">
		      	  <label class="control-label col-sm-1" for="txt_search_departmentname">运单编号</label>
			      <div class="col-sm-2">
			       	  <input type="text" class="form-control" id="operateNum" name="operateNum" value="${operateEvent.operateNum}">
			      </div>
		     		
		     	  <label class="control-label col-sm-1" for="txt_search_departmentname">装车地点</label>
			      <div class="col-sm-2">
			       	  <input type="text" class="form-control" id="loadAddress" name="loadAddress" value="${operateEvent.loadAddress}">
			      </div>
			       <label class="control-label col-sm-1" for="txt_search_departmentname">接收地点</label>
			      <div class="col-sm-2">
			       	  <input type="text" class="form-control" id="uploadAddress" name="uploadAddress" value="${operateEvent.uploadAddress}">
			      </div>
		     		
		      </div>
		      <div class="form-group" style="margin-top:24px">
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
			      
			      <label class="control-label col-sm-1" for="txt_search_statu">承运车号</label>
			      <div class="col-sm-2">
			       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true"  id="carId" name="carId"> 
			       								  <option value=''>----请选择----</option>
	                                    	<c:forEach items="${carInfoList}" var="carInfo">
												   <option value="${carInfo.id}"  <c:if test="${operateEvent.carId eq carInfo.id}">selected</c:if>>${carInfo.headerNumber}</option> 
	                                    	</c:forEach>
						 	</select>
			      </div>
			      
			      <label class="control-label col-sm-1" for="txt_search_statu">运输性质</label>
			      <div class="col-sm-2">
			       			<select class="form-control" id="transportProperties" name="transportProperties">
                                          <option  value=''>--请选择--</option> 
									      <option  value="1"  <c:if test="${operateEvent.transportProperties eq 1}">selected</c:if>>配送</option> 
									      <option  value="2"  <c:if test="${operateEvent.transportProperties eq 2}">selected</c:if>>承运</option>
									      <option  value="3"  <c:if test="${operateEvent.transportProperties eq 3}">selected</c:if>>自提</option>
					      			</select>
			      </div>
			      
		      </div>
    </form>
   </div>
  </div>
  <div id="toolbar" class="btn-group">
	  <button type="button" onclick="$('#table').tableExport({ type: 'excel', separator: ';', escape: 'false' });"  class="btn btn-default">
	            <i class="glyphicon glyphicon-search">导出Excel</i>
	   </button>
   </div>
 
        <table id="table"></table>
    </div>
  <%@ include file="/common/footer.jsp"%>
</body>
</html>