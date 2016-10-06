<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<%@ include file="/common/header.jsp"%>
    <title>永润系统</title>
   <%--  <link href="${ctx}/js/jsDate/css/jcDate.css" rel="stylesheet">
	 <script src="${ctx}/js/jsDate/js/jquery.min.1.7.js"></script>
	<script src="${ctx}/js/jsDate/js/jQuery-jcDate.js"  type="text/javascript"></script> --%>
    <script type="text/javascript">
    $(function () {
    	
    	 //1.初始化Table
    	 var oTable = new TableInit();
    	 oTable.Init();
    	 
    	 //2.初始化Button的点击事件
    	 var oButtonInit = new ButtonInit();
    	 oButtonInit.Init();
    	 
    	 // 添加弹出层 
    	 $("#btn_add").click(function(){
    		 $("#lblAddTitle").text("添加公司信息");
    		 $("#addForm #loginName").attr("readonly",false);
    		 formNull();
    		 $("#saveUser").text("保存") ; 
    	     $('#add').modal();
    	 });
    	 
    	 //修改弹出层 
    	 $("#btn_edit").click(function(){
    		 $("#lblAddTitle").text("修改公司信息");  
    		 $("#saveUser").text("修改") ; 
    		 formNull();
    		 //校验选了一条数据 
    		 if($(".selected").length != 1){ 
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
    		 }
    		 
    		 //获取数据
    		 $("#addForm #companyAddress").val($(".selected").find("td:eq(2)").text());
	   		 $("#addForm #companyName").val($(".selected").find("td:eq(3)").text());
	   		$("#addForm #shortName").val($(".selected").find("td:eq(4)").text());
	   		var flag =  $(".selected .flag").val();
	   		$("#addForm #flag").val(flag);
	   		$('#add').modal();
	   		 
    	 });
    	 
    	 
    	 //===============删除开始=========================
    	 $("#btn_delete").click(function(){
    		 if($(".selected").length == 0){ 
    			 bootbox.alert({  
    		            buttons: {  
    		               ok: {  
    		                    label: '确定',  
    		                    className: 'btn-myStyle'  
    		                }  
    		            },  
    		            message: '请至少选择一条数据进行操作',  
    		            
    		        }); 
    			 return ;
    		 }
    		 
    		 var $ids = $(".selected .ids") ;
    		 var arrayIds = new Array();
    		 for(var i = 0 ; i< $ids.length ;i++){
    			 arrayIds[i] = $ids[i].value ;
    		 }
    		bootbox.confirm("您确认删除选定的记录吗？", function (result) {
             if (result) {
                 //然后发送异步请求的信息到后台删除数据
                 $.get("${ctx}/company/delete.do?ids="+arrayIds, function (json) {
                     if (json.status == 0) {
                    	 $("#formSearch").submit();//刷新页面数据
                     }else {
                    	 bootbox.alert({  
          		            buttons: {  
          		               ok: {  
          		                    label: '确定',  
          		                    className: 'btn-myStyle'  
          		                }  
          		            },  
          		            message: '操作失败',    
          		        }); 
                     }
                 });
             }
          }); 
    	 })
    	 
    	 //===============删除结束=========================
    	 
    	 
    	 
    	 //查询 
    	 $("#btn_query").click(function(){
    		 $("#formSearch").submit();
    	 });
    	 
    	 //============保存开始====================================
    	 $("#saveUser").click(function(){

	 	   		var saveUserValue = $("#saveUser").text() ;
	 	   		var companyAddress =  $("#addForm #companyAddress").val();
	 	   	    var companyName = $("#addForm #companyName").val();
	 	   		var shortName = $("#addForm #shortName").val();
			 	//车头类型  0代表气头 1代表油头
			 	var flag = $("#addForm #flag").find("option:selected").val();
			 	
	 	   		 if(saveUserValue == '保存'){
	                    $.ajax({
			      		        url : "${ctx}/company/save.do",
			      		        type: "post",
			      		        data:{"companyAddress":companyAddress,"companyName":companyName,"flag":flag,"shortName":shortName},
			      		        dataType : "json",
			      		        success: function(result){
		     		                     if(result.status == 0){
		     		                    	 $("#formSearch").submit();
		     		                     }else{
		     		                    	 bootbox.alert("保存失败 "); 
		     		                     }
		      		               }
	      		          	});
 	   		 }
 	   		 
 	   		if(saveUserValue == '修改'){
 	   			var id = $(".selected .ids").val() ;
	 	   		$.ajax({
	      		        url : "${ctx}/company/update.do",
	      		        type: "post",
	      		        data:{"id":id,"companyAddress":companyAddress,"companyName":companyName,"flag":flag,"shortName":shortName},
	      		        dataType : "json",
	      		        success: function(result){
	 		                     if(result.status == 0){
	 		                    	/*  bootbox.alert("保存成功 ");
	 		                    	 setInterval(5000); */
	 		                    	 $("#formSearch").submit();
	 		                     }else{
	 		                    	 bootbox.alert("保存失败 "); 
	 		                     }
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
    	   url: '${ctx}/company/search.do',   //请求后台的URL（*） 
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
                return index+1+'<input type="hidden" class="ids"  value='+value+'><input type="hidden" class="flag"  value='+row.flag+'>';
              
            }
    	   },{
    	    field: 'companyAddress',
    	    title: '公司地址',
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'companyName',
    	    title: '公司名称',
    	    align: "center",//水平
            valign: "middle"//垂直
    	   },{
    	    field: 'shortName', 
    	    title: '公司简称',
    	    align: "center",//水平
            valign: "middle"//垂直
    	   },{
    	    field: 'flag', 
    	    title: '公司类别',
    	    align: "center",//水平
            valign: "middle",//垂直
            formatter:function(value,row,index){
                if(value == 0){
                	return '发货方';
                }else if(value == 1){
                	return '收货方'; 
                }else if(value == 2){
                	return '承运方'; 
                }
            } 
    	   },{
    	    field: 'status',
    	    title: '状态'  ,
    	    align: "center",//水平
            valign: "middle",//垂直 
            width:20,
            formatter:function(value,row,index){
                if(value == 0){
                	return '正常';
                }else{
                	return '禁用'; 
                }
            } 
            
    	   }]
    	  });
    	 };
    	 
    	  //得到查询的参数
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   companyAddress: $("#formSearch #companyAddress").val(), 
		    	   /* companyName: $("#formSearch #companyName").val(),  */
		    	   shortName: $("#formSearch #shortName").val(), 
		    	   status: $("#formSearch #status").val(),
		    	   flag: $("#formSearch #flag").val()
		    	   
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
	   		 $("#addForm #companyAddress").val("");
	   		 $("#addForm #companyName").val("");
	   		$("#addForm #shortName").val("");
	   		 
    	} 
    	
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default">
   <div class="panel-heading">公司信息管理</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/company/list.do" method="post">
	     <div class="form-group" style="margin-top:15px">
		      <label class="control-label col-sm-1" for="txt_search_departmentname">地址</label>
		      <div class="col-sm-2">
		       		<input type="text" class="form-control" id="companyAddress" name="companyAddress" value="${company.companyAddress}">
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_departmentname">简称</label>
		      <div class="col-sm-2">
		       		<input type="text" class="form-control" id="shortName" name="shortName" value="${company.shortName}">
		      </div>
		      <div class="col-sm-2" style="text-align:left;">
		       		<button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		      </div>
		  </div>
		  <div class="form-group" style="margin-top:25px">
		      <label class="control-label col-sm-1" for="txt_search_departmentname">公司类别</label>
		      <div class="col-sm-2">
		       		<div class="form-group">
					    <select class="form-control" id="flag" name="flag"> 
						      <option value="">全部</option> 
						      <option value="0"  <c:if test="${company.flag eq 0 }"> selected </c:if>>发货方</option> 
						      <option value="1"  <c:if test="${company.flag eq 1 }"> selected </c:if>>收货方</option>
						      <option value="2"  <c:if test="${company.flag eq 2 }"> selected </c:if>>承运方</option> <!-- <c:if test="${user.status eq 1 }"> selected </c:if> -->
					      </select>
					  </div>
		      </div>
		      
		      <label class="control-label col-sm-1" for="txt_search_departmentname">状态</label>
		      <div class="col-sm-2">
		       		<div class="form-group">
					    <select class="form-control" id="status" name="status"> 
						      <option value="">全部</option> 
						      <option value="0"  <c:if test="${company.status eq 0 }"> selected </c:if>>正常</option> 
						      <option value="1"  <c:if test="${company.status eq 1 }"> selected </c:if>>禁用</option> <!-- <c:if test="${user.status eq 1 }"> selected </c:if> -->
					      </select>
					  </div>
		      </div>
		      
	     </div>
    </form>
   </div>
  </div>  
 
  <div id="toolbar" class="btn-group">
    <button id="btn_add" type="button" class="btn btn-default">
    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
   </button>
   <button id="btn_edit" type="button" class="btn btn-default">
    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
   </button>
   <button id="btn_delete" type="button" class="btn btn-default">
    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>禁用
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
                    <span id="lblAddTitle" style="font-weight:bold">添加公司信息</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                      <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">公司类型</label>
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="flag" name="flag"> 
									      <option value="0" >发货方</option> 
									      <option  value="1">收货方</option>
									      <option  value="2">承运方</option>
					      			</select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">公司地址</label>
                                <div class="col-md-10" style="width:50%">
                                    <!-- <select id="PID" name="PID" type="text" class="form-control select2" placeholder="父ID..." ></select> -->
                                    <input id="companyAddress"  name="companyAddress" type="text" class="form-control" placeholder="公司地址" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">公司名称</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="companyName" name="companyName" type="text" class="form-control" placeholder="公司名称" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">公司简称</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="shortName" name="shortName" type="text" class="form-control" placeholder="公司简称" />
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