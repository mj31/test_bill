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
    	

        $('.selectpicker').selectpicker({
            'selectedText': 'cat'
        });
        
    	var uploadDate = {
    		    elem:'#uploadDate',
    		    format:'YYYY-MM-DD',
    		    istime:false,
    		    isclear:true,
    		    istoday:true,
    		    issure:true,
    		    festival:false,
    		    fixed:false,
    		    zIndex:99999999
    		}

    		laydate(uploadDate); 
    	
    	 //1.初始化Table
    	 var oTable = new TableInit();
    	 oTable.Init();
    	 
    	 //2.初始化Button的点击事件
    	 var oButtonInit = new ButtonInit();
    	 oButtonInit.Init();
    	 
    	 
    	 //修改弹出层 
    	 $("#btn_edit").click(function(){
    		 $("#lblAddTitle").text("修改客户对账单");    
    		 $("#saveUser").text("修改") ; 
    		 formNull();
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
	      		        url : "${ctx}/customer/updateSearch.do",
	      		        type: "post",
	      		        data:{"id":id},
	      		        dataType : "json",
	      		        success: function(result){
  		                     if(result.status == 0){
  		                    	 var operateEvent = result.operateEvent ;
	  		                     $("#addForm #operateNum").val(operateEvent.operateNum);
	  		         	   		 $("#addForm #uploadDate").val(operateEvent.strUploadDate);
	  		         	   		 
	  		         	   		 if(operateEvent.loadEmpty != null && operateEvent.loadEmpty != ""){
	  		         	   			  $("#addForm #loadEmpty").val((operateEvent.loadEmpty)/100);
	  		         	   		 }else{
	  		         	   			  $("#addForm #loadEmpty").val("");
	  		         	   		 }
	  		         	   		 
		  		         	   	 if(operateEvent.uploadEmpty != null && operateEvent.uploadEmpty != ""){
		  		         	   		  $("#addForm #uploadEmpty").val((operateEvent.uploadEmpty)/100); 
	 		         	   		 }else{
	 		         	   			  $("#addForm #uploadEmpty").val(""); 
	 		         	   		 }
	  		         	   		 
		  		         	   	 if(operateEvent.factWeight != null && operateEvent.factWeight != ""){
		  		         	   	 	  $("#addForm #factWeight").val((operateEvent.factWeight)/100);
	 		         	   		 }else{
	 		         	   		      $("#addForm #factWeight").val("");
	 		         	   		 }
	  		         	   		
	  		         	   		 $("#addForm #customerRemark").val(operateEvent.customerRemark); 
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
    	 
    	 //查询 
    	 $("#btn_query").click(function(){
    		 $("#formSearch").submit();
    	 });
    	 
    	 //============保存开始====================================
    	 $("#saveUser").click(function(){

	 	   		var saveUserValue = $("#saveUser").text() ;
	 	   		
			 	var uploadDate = $("#addForm #uploadDate").val();
			 	var loadEmpty= $("#addForm #loadEmpty").val();
			 	var uploadEmpty = $("#addForm #uploadEmpty").val(); 
			 	var factWeight= $("#addForm #factWeight").val();
			 	var customerRemark= $("#addForm #customerRemark").val();
	 	 		
			 	
			 	var reg = /^[0-9]+(.[0-9]{1,2})?$/;
			 	
			 	if(loadEmpty != null  && loadEmpty != ''){
			        if(!reg.test(loadEmpty)){
			        	bootbox.alert("装车净重必须是数字且保留2位小数");   
			        	return  ;
			        }else{
			        	loadEmpty = Number(loadEmpty*100) ;
			        }
			 	}
			 	
			 	if(uploadEmpty != null  && uploadEmpty != ''){
			        if(!reg.test(uploadEmpty)){
			        	bootbox.alert("卸车净重必须是数字且保留2位小数");     
			        	return  ;
			        }else{
			        	uploadEmpty = Number(uploadEmpty*100) ;
			        }
			 	}
			 	
				if(factWeight != null  && factWeight != ''){
			        if(!reg.test(factWeight)){
			        	bootbox.alert("实际结算量必须是数字且保留2位小数");      
			        	return  ;
			        }else{
			        	factWeight = Number(factWeight*100) ;
			        }
			 	}
				
				if(uploadDate == '-'){
					uploadDate = '';
				}
			 	
 	   		 
 	   		if(saveUserValue == '修改'){
 	   			var id = $(".updataOrDeleteClasss .ids").val() ;
	 	   		$.ajax({
	      		        url : "${ctx}/customer/update.do",
	      		        type: "post",
	      		        data:{"id":id,"loadEmpty":loadEmpty,"strUploadDate":uploadDate
	      		        	 , "uploadEmpty":uploadEmpty, "customerRemark":customerRemark
      		        		 , "factWeight":factWeight},
	      		        dataType : "json",
	      		        success: function(result){
	 		                     if(result.status == 0){
	 		                    	 $("#formSearch").submit();
	 		                     }else{
	 		                    	 bootbox.alert("保存失败 "); 
	 		                     }
	  		               },error:function(){
	  		            	 bootbox.alert("保存失败 ");
      		        	   }
	  		          });
 	   		}
    	 });
    	 //============保存结束====================================
    	    
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
                return index+1+'<input type="hidden" class="ids"  value='+value+'>';
              
            }
    	   },{
		    	    field: 'operateNum',
		    	    title: '运单编号', 
		    	    align: "center",//水平
		            valign: "middle"//垂直
    	   }, {
		    	    field: 'customerShortName',
		    	    title: '下游客户', 
		    	    align: "center",//水平
		            valign: "middle"//垂直
    	   },
    	   {
		       	    field: 'strLoadDate',
		       	    title: '装车时间', 
		       	    align: "center",//水平
		            valign: "middle"//垂直
       	   },
       	   {
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
              	    field: 'customerAddress',
              	    title: '卸车地',   
              	    align: "center",//水平
                    valign: "middle"//垂直
              	},
             	 {
               	    field: 'strUploadDate',
               	    title: '卸车时间',    
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
                      			return '' ;
                      		}
                        }
              	 },{
              	    field: 'uploadEmpty',
              	    title: '卸车净重',    
              	    align: "center",//水平
                    valign: "middle",//垂直
                  	formatter:function(value,row,index){
                     		if(value != null && value != ''){
                     			return (value/100).toFixed(2) ;
                     		}else{
                      			return '' ;
                      		}
                        }
              	 },{
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
                	 },
            	     {
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
                	 },
                	 {
                 	    field: 'factWeight',
                 	    title: '结算金额',    
                 	    align: "center",//水平
                         valign: "middle",//垂直
                     	formatter:function(value,row,index){
                     		var factWeightNew = 0 ;
                       		if(value != null && value != ''){
                       			factWeightNew  =  value  ;
                       		}
                       		
                       		var customerPriceNew = 0 ;
                       		var customerPrice = row.customerPrice ;
                       		if(customerPrice != null && customerPrice != ''){
                       			customerPriceNew =  customerPrice  ;
                       		}
                       		return (Number(factWeightNew/100)*Number(customerPriceNew/100)).toFixed(2) ;
                           }
                 	 },
                 	{
                 	    field: 'factWeight',
                 	    title: '预付款',    
                 	    align: "center",//水平
                         valign: "middle",//垂直
                     	formatter:function(value,row,index){
                     		return '没处理';
                           }
                 	 },
                 	{
                 	    field: 'factWeight',
                 	    title: '余额',     
                 	    align: "center",//水平
                         valign: "middle",//垂直
                     	formatter:function(value,row,index){
                     		return '没处理';
                           }
                 	 },
          	         {
  	               	    field: 'customerRemark',
  	               	    title: '备注',    
  	               	    align: "center",//水平
  	                    valign: "middle"//垂直
                 	 }
    	   ]
    	  });
    	 };
    	 var formSearchCustomerId = $("#formSearch #customerId").find("option:selected").val() ;
    	 var formSearchFactoryId = $("#formSearch #factoryId").find("option:selected").val() ;
    	 var formSearchCarId = $("#formSearch #carId").find("option:selected").val() ;
    	 var operateNum = $("#formSearch #operateNum").val() ;
    	  //得到查询的参数  Number(capacity*100) 
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   customerId: formSearchCustomerId ,
		    	   factoryId: formSearchFactoryId ,
		    	   carId: formSearchCarId ,
		    	   operateNum:operateNum
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
    	
    	//表单滞空 
    	function formNull(){
 	 		 $("#addForm #operateNum").val("");
	   		 $("#addForm #uploadDate").val("");
	   		 
	   		 $("#addForm #loadSkin").val("");
	   		 $("#addForm #loadEmpty").val("");
	   		 
	   		 $("#addForm #uploadHair").val("");
	   		 $("#addForm #updateSkin").val("");
	   		 $("#addForm #uploadEmpty").val(""); 
	   		
	   		 $("#addForm #factWeight").val("");
	   		 $("#addForm #customerRemark").val("");
    	} 
    	
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default">
   <div class="panel-heading">客户对账单</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/customer/index.do">
	     <div class="form-group" style="margin-top:15px">
	     
	     	  <label class="control-label col-sm-1" for="txt_search_departmentname">运单编号</label>
		      <div class="col-sm-3" style="width:12%">
		       	  <input type="text" class="form-control" id="operateNum" name="operateNum" value="${operateEvent.operateNum}">
		      </div>
	     		
		      <label class="control-label col-sm-1" for="txt_search_departmentname">下游客户</label>
		      <div class="col-sm-1" style="width:12%">
		      		 	<select class="selectpicker bla bla bli"   data-live-search="true"  id="customerId" name="customerId">
		      		 				   <option value=''>----请选择----</option>
                               	<c:forEach items="${companyList}" var="customer">
                               		<c:if test="${customer.flag eq 1}">
						     			<option value="${customer.id}" <c:if test="${operateEvent.customerId eq customer.id}">selected</c:if>>${customer.shortName}</option> 
                               		</c:if>
                               	</c:forEach> 
					 	 </select>
		       		<%-- <input type="text" class="form-control" id="headerNumber" name="headerNumber" value="${carInfo.headerNumber}"> --%>
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu">上游工厂</label>
		      <div class="col-sm-3" style="width:12%">
		       			<select class="selectpicker bla bla bli"  data-live-search="true" id="factoryId" name="factoryId"> 
		       								 <option value=''>----请选择----</option>
							      <c:forEach items="${companyList}" var="factory">
                                  		  <c:if test="${factory.flag eq 0}">
									         <option value="${factory.id}"  <c:if test="${operateEvent.factoryId eq factory.id}">selected</c:if>>${factory.shortName}</option> 
                                  		  </c:if>
                                  </c:forEach>
					    </select>
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu">承运车号</label>
		      <div class="col-sm-3" style="width:12%">
		       			<select class="selectpicker bla bla bli"  data-live-search="true"  id="carId" name="carId"> 
		       								  <option value=''>----请选择----</option>
                                    	<c:forEach items="${carInfoList}" var="carInfo">
											   <option value="${carInfo.id}"  <c:if test="${operateEvent.carId eq carInfo.id}">selected</c:if>>${carInfo.headerNumber}</option> 
                                    	</c:forEach>
					 	</select>
		      </div>
		      
		      <div class="col-sm-2" style="text-align:left;">
		       		<button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		      </div>
	     </div>
    </form>
   </div>
  </div>  
 
  <div id="toolbar" class="btn-group">
   <button id="btn_edit" type="button" class="btn btn-default">
    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
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
                    <span id="lblAddTitle" style="font-weight:bold">修改客户对账单</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                    
                    	 <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运单编号</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="operateNum"  name="operateNum" type="text" readonly class="form-control" placeholder="运单编号" />
                                </div>
                            </div>
                         </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">卸车时间</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="uploadDate" name="uploadDate" type="text" class="form-control" placeholder="卸车时间" />
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">装车净重</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="loadEmpty"  name="loadEmpty" type="text" class="form-control" placeholder="装车净重" />
                                </div>
                            </div>
                        </div>
                        
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">卸车净重</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="uploadEmpty"  name="uploadEmpty" type="text" class="form-control" placeholder="卸车净重" />
                                </div>
                            </div>
                        </div>
                        
                          <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">实际结算量</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="factWeight"  name="factWeight" type="text" class="form-control" placeholder="实际结算量" />
                                </div>
                            </div>
                         </div>
                        
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">备注</label>
                                <div class="col-md-10" style="width:50%">
                                    <textarea id="customerRemark" name="customerRemark"  class="form-control"/></textarea>
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