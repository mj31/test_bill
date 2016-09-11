<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en-us">
<head>
	<%@ include file="/common/header.jsp"%>
    <title>永润系统</title>
    <script type="text/javascript">
    
    $(function () {
    	 
    	 //1.初始化Table
    	 var oTable = new TableInit();
    	 oTable.Init();
    	 
    	 //2.初始化Button的点击事件
    	 var oButtonInit = new ButtonInit();
    	 oButtonInit.Init();
    	 
    	 
    	 $("#btn_add").click(function(){
    		 $("#add").css('display','block');
    	 });
    	 
    	 $("#btn_delete").click(function(){
    		bootbox.confirm("您确认删除选定的记录吗？", function (result) {
             if (result) {
                 //最后去掉最后的逗号,
                 ids = ids.substring(0, ids.length - 1);

                 //然后发送异步请求的信息到后台删除数据
                 var postData = { Ids: ids };
                 $.get("/Province/DeletebyIds", postData, function (json) {
                     var data = $.parseJSON(json);
                     if (data.Success) {
                         showTips("删除选定的记录成功");
                         Refresh();//刷新页面数据
                     }
                     else {
                         showTips(data.ErrorMessage);
                     }
                 });
             }
          }); 
    	 })
    	 
    	 
    	});
    	 
    	 
    	var TableInit = function () {
    	 var oTableInit = new Object();
    	 //初始化Table
    	 oTableInit.Init = function () {
    	  $('#table').bootstrapTable({
    	   url: '${ctx}/car/search.do',   //请求后台的URL（*）
    	   method: 'get',      //请求方式（*）
    	   toolbar: '#toolbar',    //工具按钮用哪个容器
    	   striped: true,      //是否显示行间隔色
    	   cache: false,      //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    	   pagination: true,     //是否显示分页（*）
    	   sortable: false,      //是否启用排序
    	   sortOrder: "asc",     //排序方式
    	   queryParams: oTableInit.queryParams,//传递参数（*）
    	  /*  sidePagination: "server", */   //分页方式：client客户端分页，server服务端分页（*）
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
    	    field: 'loginName',
    	    title: '登录名称'
    	   }, { 
    	    field: 'userName',
    	    title: '用户名'
    	   }, {
    	    field: 'loginName',
    	    title: '部门级别'
    	   }, {
    	    field: 'loginName',
    	    title: '描述'
    	   }]
    	  });
    	 };
    	 
    	 //得到查询的参数
    	 oTableInit.queryParams = function (params) {
    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
    	   limit: params.limit, //页面大小
    	   offset: params.offset, //页码
    	   departmentname: $("#txt_search_departmentname").val(),
    	   statu: $("#txt_search_statu").val()
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
   <div class="panel-heading">查询条件</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal">
     <div class="form-group" style="margin-top:15px">
      <label class="control-label col-sm-1" for="txt_search_departmentname">部门名称</label>
      <div class="col-sm-3">
       <input type="text" class="form-control" id="txt_search_departmentname">
      </div>
      <label class="control-label col-sm-1" for="txt_search_statu">状态</label>
      <div class="col-sm-3">
       <input type="text" class="form-control" id="txt_search_statu">
      </div>
      <div class="col-sm-4" style="text-align:left;">
       <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
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
    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
   </button>
  </div>
        <table id="table"></table>
    </div>
    
    
    <%@ include file="/common/footer.jsp"%>
    <!--------------------------添加/修改信息的弹出层---------------------------->
<div id="add" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">
                    <i class="icon-pencil"></i>
                    <span id="lblAddTitle" style="font-weight:bold">添加信息</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe" id="ffAdd" action="" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">父ID</label>
                                <div class="col-md-10">
                                    <select id="PID" name="PID" type="text" class="form-control select2" placeholder="父ID..." ></select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">名称</label>
                                <div class="col-md-10">
                                    <input id="Name" name="Name" type="text" class="form-control" placeholder="名称..." />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">备注</label>
                                <div class="col-md-10">
                                    <textarea id="Note" name="Note" class="form-control" placeholder="备注..."></textarea>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer bg-info">
                    <input type="hidden" id="ID" name="ID" />
                    <button type="submit" class="btn blue">确定</button>
                    <button type="button" class="btn green" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>