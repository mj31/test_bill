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
    	   url: '${ctx}/factory/search.do',   //请求后台的URL（*）  
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
    	   },{
		    	    field: 'strExchangeDate',
		    	    title: '转账时间',
		    	    align: "center",//水平
		            valign: "middle"//垂直
    	   },
    	   {
	    	    field: 'exchangeMoney',
	    	    title: '转账金额',
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
	    	    field: 'hisAccount',
	    	    title: '转账账户', 
	    	    align: "center",//水平
	            valign: "middle"//垂直
	      },{
	    	    field: 'hisAccountName',
	    	    title: '转账单位',  
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
         	    field: 'activityPrice',
         	    title: '优惠价/吨', 
         	    align: "center",//水平
                valign: "middle",//垂直
             	formatter:function(value,row,index){
                		if(value != null && value != ''){
                			return (value/100).toFixed(2) ;
                		}else{
                 			return '' ;
                 		}
                   }
          },
       	   {
          	    field: 'factoryPrice',
          	    title: '单价/吨',
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
                       			return '' ;
                       		}
                          }
                 },
               	 {
                	    field: 'loadEmpty',
                	    title: '结算金额',    
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		var loadEmpty = 0 ;
                    		if(value != null && value != ''){
                    			loadEmpty =  value/100 ;
                     		}
                    		
                    		var factoryPrice = 0 ;
                    		var factoryPrice = row.factoryPrice ;
                    		if(factoryPrice != null && factoryPrice != ''){
                    			factoryPrice = factoryPrice/100 ;
                       		}
                    		
                    		return Number(loadEmpty*factoryPrice).toFixed(2) ;
                       		
                    		
                          }
                	 },
                	{
                	    field: 'factWeight',
                	    title: '结余',     
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		return '没处理';
                          }
                	 }
    	   ]
    	  });
    	 };
    	 var factoryId = $("#formSearch #factoryId").find("option:selected").val() ;
    	  //得到查询的参数  Number(capacity*100) 
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	 /*   hisAccountName: $("#formSearch #hisAccountName").val(),  */
		    	   factoryId: factoryId
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
   <div class="panel-heading">工厂对账单信息</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/factory/index.do">
	     <div class="form-group" style="margin-top:15px">
		      <label class="control-label col-sm-1" for="txt_search_statu">上游工厂名称</label> 
		      <div class="col-sm-3" style="width:10%">
		       			<select class="selectpicker bla bla bli"  data-live-search="true"  id="factoryId" name="factoryId"> 
		       								  <option value=''>----请选择----</option>
                                    	<c:forEach items="${factoryList}" var="factory">
											   <option value="${factory.id}"  <c:if test="${factory.id eq operateEvent.factoryId}">selected</c:if>>${factory.shortName}</option> 
                                    	</c:forEach>
					 	</select>
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu"></label>
		      <%-- <label class="control-label col-sm-2" for="txt_search_statu">转账单位</label>
		      <div class="col-sm-3"  style="width:15%">
		       		<div class="form-group">
					   <input type="text" class="form-control" id="hisAccountName" name="hisAccountName" value="${operateEvent.hisAccountName}">
					  </div>
		      </div> --%>
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