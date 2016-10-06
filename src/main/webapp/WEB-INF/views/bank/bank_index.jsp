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
    	
    	 var exchangeDate = {
    		    elem:'#exchangeDate',
    		    format:'YYYY-MM-DD',
    		    istime:false,
    		    isclear:true,
    		    istoday:true,
    		    issure:true,
    		    festival:false,
    		    fixed:false,
    		    zIndex:99999999
    		}

    		laydate(exchangeDate); 
    	 
    	 
    	 //1.初始化Table
    	 var oTable = new TableInit();
    	 oTable.Init();
    	 
    	 //2.初始化Button的点击事件
    	 var oButtonInit = new ButtonInit();
    	 oButtonInit.Init();
    	 
    	 // 添加弹出层 
    	 $("#btn_add").click(function(){
    		 $("#lblAddTitle").text("添加交易流水信息");
    		 formNull();
    		 $("#saveUser").text("保存") ; 
    		 $('.selectpicker').selectpicker({
	             'selectedText': 'cat'
	         });
    	     $('#add').modal();
    	 });
    	 
    	 //修改弹出层 
    	 $("#btn_edit").click(function(){
    		 $("#lblAddTitle").text("修改交易流水信息");  
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
	      		        url : "${ctx}/bank/updateSearch.do",
	      		        type: "post",
	      		        data:{"id":id},
	      		        dataType : "json",
	      		        success: function(result){
  		                     if(result.status == 0){
  		                    	  var bank = result.bank ;
  		                    	  
  		                    	  
  		                       //交易流水号
  		                       var serialNumber = bank.serialNumber;
  		                     
  		                       var strExchangeDate = bank.strExchangeDate;
  		                       //交易金额 
  		                       var exchangeMoney = bank.exchangeMoney;
  		                       //对方账号
  		                       var hisAccount = bank.hisAccount;
  		                       //对方账号名称
  		                       var hisAccountName = bank.hisAccountName;
  		                       //对方账号id
  		                       var hisAccountId = bank.hisAccountId;
  		                       //交易状态0代表收入 1代表支出  
  		                       var exchangeFlag = bank.exchangeFlag;
  		                       //业务类型
  		                       var serviceType = bank.serviceType;
 		                       //备注     
  		                       var remark = bank.remark;
  		                         
  		                     //获取数据
  		            		 $("#addForm #serialNumber").val(serialNumber);
  		                     
  		            		 if(exchangeMoney != '' && exchangeMoney != null ){
  		            			  $("#addForm #exchangeMoney").val(Number(exchangeMoney/100));
		               		 }else{
		               			  $("#addForm #exchangeMoney").val('');
		               		 }
  		        	   		 
  		        	   		
  		        	   		 $("#addForm #serviceType").val(serviceType); 
  		        	   		 $("#addForm #remark").val(remark); 
  		        	   	 	 $("#addForm #hisAccount").val(hisAccount); 
  		        	   	 	 
  		        	   		 $("#addForm #exchangeDate").val(strExchangeDate);
  		        	   	 	 
  		        	   		 $("#addForm #exchangeFlag").find("option[value="+exchangeFlag+"]").attr("selected",true);
  		        	   		 
  		        	   	     $("#addForm #hisAccountId").find("option[value="+hisAccountId+"]").attr("selected",true);
  		           	   		  $('.selectpicker').selectpicker({
  		           	             'selectedText': 'cat'
  		           	          });
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
    	 
    	 
    	 //===============删除开始=========================
    	 $("#btn_delete").click(function(){
    		 if($(".updataOrDeleteClasss").length == 0){ 
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
    		 
    		 var $ids = $(".updataOrDeleteClasss .ids") ;
    		 var arrayIds = new Array();
    		 for(var i = 0 ; i< $ids.length ;i++){
    			 arrayIds[i] = $ids[i].value ;
    		 }
    		bootbox.confirm("您确认删除选定的记录吗？", function (result) {
             if (result) {
                 //然后发送异步请求的信息到后台删除数据
                 $.get("${ctx}/bank/delete.do?ids="+arrayIds, function (json) {
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
	 	   		
	 	   		
	 	   		var serialNumber =  $("#addForm #serialNumber").val();
	 	   	    var exchangeMoney = $("#addForm #exchangeMoney").val();
	 	   		var exchangeDate= $("#addForm #exchangeDate").val();
	 	   		var hisAccount= $("#addForm #hisAccount").val();
	 	 		var serviceType= $("#addForm #serviceType").val();
	 	 		var remark=  $("#addForm #remark").val();
			 	var hisAccountId =  $("#addForm #hisAccountId").find("option:selected").val();
			 	var hisAccountName = $("#addForm #hisAccountId").find("option:selected").text();
			 	//交易类型 
			 	var exchangeFlag = $("#addForm #exchangeFlag").find("option:selected").val();
			 	//交易金额 
			 	var reg = /^[0-9]+(.[0-9]{1,2})?$/;
			 	if(exchangeMoney != null  && exchangeMoney != ""){
			        if(!reg.test(exchangeMoney)){
			        	bootbox.alert("交易金额必须是数字且保留2位小数"); 
			        	return  ;
			        }else{
			        	exchangeMoney = Number(exchangeMoney*100) ;
			        }
			 	}
			 	
			 	
			 	if(exchangeDate == '-'){
			 		exchangeDate = '';
			 	}
			 	
	 	   		 if(saveUserValue == '保存'){
	                    $.ajax({
			      		        url : "${ctx}/bank/save.do",
			      		        type: "post",
			      		        data:{"serialNumber":serialNumber,"exchangeMoney":exchangeMoney,"strExchangeDate":exchangeDate
			      		        	,"hisAccount":hisAccount,"serviceType":serviceType,"remark":remark,"hisAccountId":hisAccountId,
			      		        	"hisAccountName":hisAccountName,"exchangeFlag":exchangeFlag},
			      		        dataType : "json",
			      		        success: function(result){
		     		                     if(result.status == 0){
		     		                    	 $("#formSearch").submit();
		     		                     }else{
		     		                    	 bootbox.alert("保存失败 "); 
		     		                     }
		      		               }
			      		         ,error:function(){
			      		        	 bootbox.alert("保存失败 "); 
			      		         }
	      		          	});
 	   		 }
 	   		 
 	   		if(saveUserValue == '修改'){
 	   			var id = $(".updataOrDeleteClasss .ids").val() ;
	 	   		$.ajax({
	      		        url : "${ctx}/bank/update.do",
	      		        type: "post",
	      		        data:{"id":id,"serialNumber":serialNumber,"exchangeMoney":exchangeMoney,"strExchangeDate":exchangeDate
	      		        		,"hisAccount":hisAccount,"serviceType":serviceType,"remark":remark,"hisAccountId":hisAccountId,
	      		        		"hisAccountName":hisAccountName,"exchangeFlag":exchangeFlag},
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
     		        	,error:function(){
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
    	   url: '${ctx}/bank/search.do',   //请求后台的URL（*） 
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
                return index+1+'<input type="hidden" class="ids"  value='+value+'>';
              
            }
    	   },{
    	    field: 'serialNumber',
    	    title: '交易流水号', 
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'strExchangeDate',
    	    title: '转账时间', 
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'exchangeMoney',
    	    title: '交易金额',  
    	    align: "center",//水平
            valign: "middle",//垂直
           	formatter:function(value,row,index){
           		var exchangeFlag = row.exchangeFlag ;
	           		if(value != null && value != "" ){
	           		   if(exchangeFlag == 0){
	           			   
	           			   return Number(value/100).toFixed(2) ;
	           		   }
	           		   
	           		   if(exchangeFlag == 1){
	           			   return '-'+Number(value/100).toFixed(2) ;
	           		   }
	           		}
               }
    	   }, {
    	    field: 'hisAccount',
    	    title: '对方账户',
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'hisAccountName',
    	    title: '对方账号名称',
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'serviceType',
    	    title: '业务类型',  
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'remark',
    	    title: '备注', 
    	    align: "center",//水平
            valign: "middle"//垂直
    	   }, {
    	    field: 'status',
    	    title: '状态', 
    	    align: "center",//水平
            valign: "middle",//垂直
            formatter:function(value,row,index){
           		   if(value == 0){
           			   return '正常' ; 
           		   }else{
           			   return '删除' ; 
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
		    	   hisAccountName: $("#formSearch #hisAccountName").val(), 
		    	   exchangeFlag: $("#formSearch #exchangeFlag").val()
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
    		 $("#addForm #serialNumber").val("");
 	   	     $("#addForm #exchangeMoney").val("");
 	   		 $("#addForm #exchangeDate").val("");
 	   		 $("#addForm #hisAccount").val("");
 	 		 $("#addForm #serviceType").val("");
 	 		 $("#addForm #remark").val("");
    	} 
    	
    	
    	function checkMoneyFormat(val){
            var reg = /^(([1-9]+)|([0-9]+\.[0-9]{1,2}))$/;
            var isMoneyFormatRight = reg.test(val);
            return isMoneyFormatRight;
        }
    	
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default">
   <div class="panel-heading">付款信息</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/bank/index.do" method="post">
	     <div class="form-group" style="margin-top:15px">
		      <label class="control-label col-sm-1" for="txt_search_departmentname">对方账户名称</label>
		      <div class="col-sm-2">
		       		<input type="text" class="form-control" id="hisAccountName" name="hisAccountName" value="${bank.hisAccountName}">
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu">状态</label>
		      <div class="col-sm-2" >
		       		<div class="form-group">
					    <select class="form-control" id="exchangeFlag" name="exchangeFlag"> 
						      <option value="">全部</option> 
						      <option value="0"  <c:if test="${bank.exchangeFlag eq 0 }"> selected </c:if>>收入</option> 
						      <option value="1"  <c:if test="${bank.exchangeFlag eq 1 }"> selected </c:if>>支出</option> <!-- <c:if test="${user.status eq 1 }"> selected </c:if> -->
					      </select>
					  </div>
		      </div>
		      <div class="col-sm-2" style="text-align:left;">
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
    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>禁用
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
                    <span id="lblAddTitle" style="font-weight:bold">添加银行流水</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                    	 <div class="col-md-12">
                          		<div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">交易类型</label>
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="exchangeFlag" name="exchangeFlag"> 
									      <option value="0" >收入</option> 
									      <option  value="1">支出</option>
					      			</select>
                                </div>
                            </div>
                      	</div>
                    
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">交易流水号</label>
                                <div class="col-md-10" style="width:50%">
                                    <!-- <select id="PID" name="PID" type="text" class="form-control select2" placeholder="父ID..." ></select> -->
                                    <input id="serialNumber" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" name="serialNumber" type="text" class="form-control" placeholder="交易流水号" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">交易金额</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="exchangeMoney" name="exchangeMoney" type="text" class="form-control" placeholder="交易金额" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">转账时间</label>
                                <div class="col-md-10" style="width:50%"> 
                                    <input id="exchangeDate" name="exchangeDate" type="text" class="form-control" placeholder="转账时间" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">对方账户</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="hisAccount" name="hisAccount" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" type="text" class="form-control" placeholder="对方账户" />
                                </div>
                            </div>
                        </div>
                        
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">对方账户名称</label>
                                <div class="col-md-10" style="width:50%">
                                    <select class="selectpicker bla bla bli"  data-live-search="true" id="hisAccountId" name="hisAccountId"> 
									      <c:forEach items="${companyList}" var="factory">
                                    		  <c:if test="${factory.flag eq 0 or factory.flag eq 1}">
											      <option value="${factory.id}" >${factory.companyName}</option> 
                                    		  </c:if>
                                    	  </c:forEach>
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">业务类型</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="serviceType" name="serviceType" type="text" class="form-control" placeholder="业务类型" />
                                </div>
                            </div>
                        </div>
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">备注</label>
                                <div class="col-md-10" style="width:50%">
                                    <textarea id="remark" name="remark"  class="form-control" placeholder="" ></textarea>
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