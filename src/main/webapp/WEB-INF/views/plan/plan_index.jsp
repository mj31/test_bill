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

    	var loadDate = {
    		    elem:'#loadDate',
    		    format:'YYYY-MM-DD',
    		    istime:false,
    		    isclear:true,
    		    istoday:true,
    		    issure:true,
    		    festival:false,
    		    fixed:false,
    		    zIndex:99999999
    		}

    		laydate(loadDate); 
    	
    	 //1.初始化Table
    	 var oTable = new TableInit();
    	 oTable.Init();
    	 
    	 //2.初始化Button的点击事件
    	 var oButtonInit = new ButtonInit();
    	 oButtonInit.Init();
    	 
    	 // 添加弹出层 
    	 $("#btn_add").click(function(){
    		 $("#lblAddTitle").text("添加采购计划");
    		 $("#addForm #loginName").attr("readonly",false);
    		 formNull();
    		 $("#saveUser").text("保存") ; 
    		 $('.selectpicker').selectpicker({
    	            'selectedText': 'cat'
    	      });
    	     $('#add').modal();
    	 });
    	 
    	 //修改弹出层 
    	 $("#btn_edit").click(function(){
    		 $("#lblAddTitle").html("修改采购计划");    
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
	      		        url : "${ctx}/operate/updateSearch.do",
	      		        type: "post",
	      		        data:{"id":id},
	      		        dataType : "json",
	      		        success: function(result){
  		                     if(result.status == 0){
  		                    	  var operateEvent = result.operateEvent ;
  		                    	  var customerId = operateEvent.customerId ;
	  		               		  var carId = operateEvent.carId ;
	  		               		  var companyId = operateEvent.companyId ;
	  		               		  var factoryId = operateEvent.factoryId ;
	  		               		  var transportProperties = operateEvent.transportProperties ;
	  		               		 
	  		               		  //接收方
	  		               		  $("#addForm #customerId").find("option[value="+customerId+"]").attr("selected",true);
	  		               		  //承运车号
	  		               		  $("#addForm #carId").find("option[value="+carId+"]").attr("selected",true);
	  		               		  //发货方 
	  		               		  $("#addForm #factoryId").find("option[value="+factoryId+"]").attr("selected",true);
	  		               		  //承运方
	  		               		  $("#addForm #companyId").find("option[value="+companyId+"]").attr("selected",true);
	  		               		  //磅差
	  		               		  if(operateEvent.poundsDiff != '' && operateEvent.poundsDiff != null ){
		  		           	   		  $("#addForm #poundsDiff").val((operateEvent.poundsDiff)/100);
	  		               		  }else{
	  		               			  $("#addForm #poundsDiff").val('');
	  		               		  }
	  		               		  //装车时间
	  		           	   		  $("#addForm #loadDate").val(operateEvent.strLoadDate);
	  		           	   	      //备注
	  		           	   		  $("#addForm #eventRemark").val(operateEvent.eventRemark);
	  		           	   	      //装车地点
	  		           	   		  $("#addForm #loadAddress").val(operateEvent.loadAddress);
	  		           	   	      //卸车地点
	  		           	          $("#addForm #uploadAddress").val(operateEvent.uploadAddress);
	  		           	          //运输性质 
	  		                      $("#addForm #transportProperties").find("option[value="+transportProperties+"]").attr("selected",true);
	  		           	          
	  		                      //供货单价
	  		               		  var factoryPrice = operateEvent.factoryPrice ;
		  		               	  if(factoryPrice != '' && factoryPrice != null){
		  		           	   		  $("#addForm #factoryPrice").val(factoryPrice/100);
	  		           	   		  }else{
	  		           	   			  $("#addForm #factoryPrice").val(""); 
	  		           	   		  }
	  		               		  //接收单价
	  		               		  var customerPrice = operateEvent.customerPrice ;
	  		               		  if(customerPrice != null && customerPrice != ""){
  		           	   			      $("#addForm #customerPrice").val(customerPrice/100);
  		           	   		  	  }else{
  		           	   		 		  $("#addForm #customerPrice").val("");
  		           	   		      }
	  		               		  //接收单价是否含税 
	  		               		  var isOrNotTax = operateEvent.isOrNotTax ;
	  		               		  $("#addForm #isOrNotTax").find("option[value="+isOrNotTax+"]").attr("selected",true);
	  		               		  
	  		               		  // 运费单价 
	  		               		  var carFee = operateEvent.carFee ;
		  		               	  if(carFee != null && carFee != ""){
		  		           	   			$("#addForm #carFee").val(carFee/100);
			           	   		  }else{
			           	   				$("#addForm #carFee").val("");
			           	   		  }
	  		               		  //运费单价是否含税
	  		               		  var carIsOrNotTax = operateEvent.carIsOrNotTax ;
	  		               		  $("#addForm #carIsOrNotTax").find("option[value="+carIsOrNotTax+"]").attr("selected",true);
	  		           	   		
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
    		 }
    		 
    		 var $ids = $(".updataOrDeleteClasss .ids") ;
    		 var arrayIds = new Array();
    		 for(var i = 0 ; i< $ids.length ;i++){
    			 arrayIds[i] = $ids[i].value ;
    		 }
    		bootbox.confirm("您确认删除选定的记录吗？", function (result) {
             if (result) {
                 //然后发送异步请求的信息到后台删除数据
                 $.get("${ctx}/operate/delete.do?id="+arrayIds, function (json) {
                     if (json.status == 0) {
                    	 $("#table").bootstrapTable('refresh', TableInit);
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
    		 $("#table").bootstrapTable('refresh', TableInit);
    	 });
    	 
    	 //============保存开始====================================
    	 $("#saveUser").click(function(){

	 	   		var saveUserValue = $("#saveUser").text() ;
	 	   		
	 	   		//接收方 
			 	var customerId = $("#addForm #customerId").find("option:selected").val();
	 	   		//磅差
			 	var poundsDiff= $("#addForm #poundsDiff").val();
	 	   		//装车时间
			 	var loadDate= $("#addForm #loadDate").val();  
	 	   		//承运车号 
			 	var carId = $("#addForm #carId").find("option:selected").val();
	 	   		//承运方 
			 	var companyId = $("#addForm #companyId").find("option:selected").val();
	 	   		//发货方 
			 	var factoryId = $("#addForm #factoryId").find("option:selected").val();
			 	
	 	 		var eventRemark=  $("#addForm #eventRemark").val();
	 	   		
	 	 		//装车地点 
			 	var loadAddress = $("#addForm #loadAddress").val();
	 	   		
	 	 		//卸车地点 
	 	   		var uploadAddress = $("#addForm #uploadAddress").val();
	 	 		
	 	 		//运输性质 
	 	   	    var transportProperties = $("#addForm #transportProperties").find("option:selected").val();
	 	 		
	 	 		
			 	
			 	//行车证荷载量进行校验
			 	var reg = /^[0-9]+(.[0-9]{1,2})?$/;
			 	
			 	 //供货单价
				  var factoryPrice= $("#addForm #factoryPrice").val(); 
				  if(factoryPrice != null  && factoryPrice != ''){
				        if(!reg.test(factoryPrice)){
				        	bootbox.alert("供货单价必须是数字且保留2位小数");   
				        	return  ;
				        }else{
				        	factoryPrice = Number(factoryPrice*100) ;
				        }
				 	}
         		  
         		  //接收单价
				  var customerPrice= $("#addForm #customerPrice").val(); 
				  if(customerPrice != null  && customerPrice != ''){
				        if(!reg.test(customerPrice)){
				        	bootbox.alert("接收单价必须是数字且保留2位小数");   
				        	return  ;
				        }else{
				        	customerPrice = Number(customerPrice*100) ;
				        }
				 	}
         		  
         		  //接收单价是否含税 
			 	  var isOrNotTax = $("#addForm #isOrNotTax").find("option:selected").val();
         		  
			 	// 运费单价 
           		  var carFee= $("#addForm #carFee").val();
           		  if(carFee != null  && carFee != ''){
			         if(!reg.test(carFee)){
			        	 bootbox.alert("运费单价必须是数字且保留2位小数");   
			        	 return  ;
			         }else{
			        	 carFee = Number(carFee*100) ;
			         }
			 	 }
           		  //运费单价是否含税
           		  var carIsOrNotTax = $("#addForm #carIsOrNotTax").find("option:selected").val() ;
			 	
			 	if(poundsDiff != null && poundsDiff != ""){
			 		if(poundsDiff != 100 && poundsDiff != 200){
			 			bootbox.alert("磅差必须是100或者是200 或者无");    
			        	return  ;
			 		}else{
			 			poundsDiff = Number(poundsDiff*100) ;
			 		}
			 	}
			 	
			 	
			 	if(loadDate == '-'){
			 		loadDate = '' ;
			 	}
			 	
	 	   		 if(saveUserValue == '保存'){
	                    $.ajax({
			      		        url : "${ctx}/operate/save.do",
			      		        type: "post",
			      		        data:{"customerId":customerId,"poundsDiff":poundsDiff,"strLoadDate":loadDate
			      		        		,"carId":carId,"companyId":companyId,"factoryId":factoryId
			      		        		, "eventRemark":eventRemark,"loadAddress":loadAddress,"uploadAddress":uploadAddress
			      		        		,"transportProperties":transportProperties,"factoryPrice":factoryPrice
			      		        		,"customerPrice":customerPrice,"isOrNotTax":isOrNotTax,"carIsOrNotTax":carIsOrNotTax,"carFee":carFee},
			      		        dataType : "json",
			      		        success: function(result){
		     		                     if(result.status == 0){
		     		                    	$("#table").bootstrapTable('refresh', TableInit);
			 		                    	$("#add").modal("hide");
		     		                     }else{
		     		                    	 bootbox.alert("保存失败 "); 
		     		                     }
		      		               },
		      		            error:function(){
		  	  		            	 bootbox.alert("保存失败 ");
		      		        	   }
	      		          	});
 	   		 }
 	   		 
 	   		if(saveUserValue == '修改'){
 	   			var id = $(".updataOrDeleteClasss .ids").val() ;
	 	   		$.ajax({
	      		        url : "${ctx}/operate/update.do",
	      		        type: "post",
	      		        data:{"id":id,"customerId":customerId,"poundsDiff":poundsDiff,"strLoadDate":loadDate
      		        				,"carId":carId,"companyId":companyId,"factoryId":factoryId
      		        				, "eventRemark":eventRemark,"loadAddress":loadAddress,"uploadAddress":uploadAddress
      		        				,"transportProperties":transportProperties,"factoryPrice":factoryPrice
		      		        		,"customerPrice":customerPrice,"isOrNotTax":isOrNotTax,"carIsOrNotTax":carIsOrNotTax,"carFee":carFee},
	      		        dataType : "json",
	      		        success: function(result){
	 		                     if(result.status == 0){
	 		                    	/*  bootbox.alert("保存成功 ");
	 		                    	 setInterval(5000); */
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
	    	    	 var loadAddress = $("#formSearch #loadAddress").val() ;
	    	    	 var uploadAddress = $("#formSearch #uploadAddress").val() ;
	    	    	 var operateNum = $("#formSearch #operateNum").val() ;
	    	    	 var transportProperties = $("#formSearch #transportProperties").find("option:selected").val() ;
	                 return {
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
	    	    checkbox: true,
	    	    align: "center",//水平
	            valign: "middle"//垂直;
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
                //return index + 1;  
                var page = $('#table').bootstrapTable("getPage");  
                return page.pageSize * (page.pageNumber - 1) + index + 1+'<input type="hidden" class="ids" customerId='+row.customerId+' carId = '+row.carId+' companyId = '+row.companyId+' factoryId = '+row.factoryId+' isOrNotTax ='+row.isOrNotTax+' value='+value+'>';
                /* return index+1+'<input type="hidden" class="ids" customerId='+row.customerId+' carId = '+row.carId+' companyId = '+row.companyId+' factoryId = '+row.factoryId+' isOrNotTax ='+row.isOrNotTax+' value='+value+'>'; */
              
            }
    	   },{
	    	    field: 'operateNum',
	    	    title: '运单编号', 
	    	    align: "center",//水平
	            valign: "middle"//垂直
    	   },{
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
	           	    title: '供应商',    
	           	    align: "center",//水平
	                valign: "middle"//垂直
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
	    	    title: '采购商',  
	    	    align: "center",//水平
	            valign: "middle"//垂直
    	     },{
           	    field: 'customerPrice',
         	    title: '接收单价(税)',   
         	    align: "center",//水平
               valign: "middle",//垂直
             	formatter:function(value,row,index){
             		var isOrNotTax = row.isOrNotTax ;	
             		 if(isOrNotTax == 0 || isOrNotTax == null){
             			if(value != null && value != ''){
               				return (value/100).toFixed(2);
               			}else{
                			return "";
                		}
            		}else{
            			isOrNotTax = '否' ;
            			if(value != null && value != ''){
               				return (value/100).toFixed(2)+"("+isOrNotTax+")" ;
               			}else{
                			return "("+isOrNotTax+")";
                		}
            		}
             		 
               		
                   }
         	 }, {
	    	    field: 'uploadAddress',
	    	    title: '卸车地点',   
	    	    align: "center",//水平
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
                	    field: 'factWeight',
                	    title: '实际吨位',    
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
  	               	    field: 'eventRemark',
  	               	    title: '备注',    
  	               	    align: "center",//水平
  	                    valign: "middle"//垂直
                 	 }
    	   ]
    	  });
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
		 	$("#addForm #poundsDiff").val("");
		 	$("#addForm #loadDate").val(""); 
		 	$("#addForm #factoryPrice").val(""); 
		 	$("#addForm #activityPrice").val(""); 
		 	$("#addForm #customerPrice").val(""); 
		 	$("#addForm #carFee").val("");
 	 		$("#addForm #eventRemark").val("");
 	 	    //装车地点
 	 	    $("#addForm #loadAddress").val("");
   	   	    //卸车地点
   	        $("#addForm #uploadAddress").val("");
    	} 
    	
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all" style="margin-right:20px;">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default" style="margin-left:20px;">
   <div class="panel-heading">采购计划</div> 
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/planSettle/index.do">
		     <div class="form-group  form-group-sm" style="margin-top:10px">
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
			      <div class="col-sm-1" style="text-align:left;">
		       		 <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
		          </div>
		      </div>
		      <div id="extentDivId">
			      <div class="form-group  form-group-sm" style="margin-top:20px">
			      	  <label class="control-label col-sm-1" for="txt_search_departmentname">运单编号</label>
				      <div class="col-sm-2">
				       	  <input type="text" class="form-control" id="operateNum" name="operateNum" value="${operateEvent.operateNum}">
				      </div>
			     		
			     	  <label class="control-label col-sm-1" for="txt_search_departmentname">装车地点</label>
				      <div class="col-sm-2">
				       	  <input type="text" class="form-control" id="loadAddress" name="loadAddress" value="${operateEvent.loadAddress}">
				      </div>
				       <label class="control-label col-sm-1" for="txt_search_departmentname">卸车地点</label>
				      <div class="col-sm-2">
				       	  <input type="text" class="form-control" id="uploadAddress" name="uploadAddress" value="${operateEvent.uploadAddress}">
				      </div>
			     		
			      </div>
			      <div class="form-group  form-group-sm" style="margin-top:24px">
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
                    <span id="lblAddTitle" style="font-weight:bold">添加采购计划</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                    
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">承运方</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="companyId" name="companyId">
                                    			<option  value=''>--请选择--</option> 
									     <c:forEach items="${companyList}" var="company">
                                    		<c:if test="${company.flag eq 2}">
											     <option value="${company.id}" >${company.shortName}</option> 
                                    		</c:if>
                                    	</c:forEach> 
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">承运车号</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"  data-live-search="true"  id="carId" name="carId"> 
                                    		   <option  value=''>--请选择--</option>
                                    	<c:forEach items="${carInfoList}" var="carInfo">
											   <option value="${carInfo.id}" >${carInfo.headerNumber}</option> 
                                    	</c:forEach> 
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">供应商</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"  data-live-search="true" id="factoryId" name="factoryId">
                                    			  <option  value=''>--请选择--</option> 
									      <c:forEach items="${companyList}" var="factory">
                                    		  <c:if test="${factory.flag eq 0}">
											      <option value="${factory.id}" >${factory.shortName}</option> 
                                    		  </c:if>
                                    	  </c:forEach>
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">供货单价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="factoryPrice" name="factoryPrice"  type="text" class="form-control" placeholder="供货单价" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">装车地点</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="loadAddress"  name="loadAddress" type="text" class="form-control" placeholder="装车地点" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">装车时间</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="loadDate" name="loadDate" type="text" class="form-control" placeholder="装车时间" />
                                </div>
                            </div>
                        </div>
                        
                    	<div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">采购商</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"   data-live-search="true"  id="customerId" name="customerId">
                                    			<option  value=''>--请选择--</option>
                                    	<c:forEach items="${companyList}" var="customer">
                                    		<c:if test="${customer.flag eq 1}">
											     <option value="${customer.id}" >${customer.shortName}</option> 
                                    		</c:if>
                                    	</c:forEach> 
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">接收单价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="customerPrice" name="customerPrice" type="text" class="form-control" placeholder="接收单价" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">是否含税</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="isOrNotTax" name="isOrNotTax"> 
									      <option value="0" >是</option> 
									      <option  value="1">否</option>
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运费单价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="carFee" name="carFee" type="text" class="form-control" placeholder="运费单价" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">是否含税</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="carIsOrNotTax" name="carIsOrNotTax"> 
									      <option value="0" >是</option> 
									      <option  value="1">否</option>
					      			</select>
                                </div>
                            </div>
                        </div>
                    	
                    	<div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">卸车地点</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="uploadAddress"  name="uploadAddress" type="text" class="form-control" placeholder="接收地点" />
                                </div>
                            </div>
                        </div>
                    	
                    
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">磅差</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="poundsDiff"  name="poundsDiff" type="text" class="form-control" placeholder="磅差" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运输性质</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="transportProperties" name="transportProperties">
                                          <option  value=''>--请选择--</option> 
									      <option value="1" >配送</option> 
									      <option  value="2">承运</option>
									      <option  value="3">自提</option>
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">备注</label>
                                <div class="col-md-10" style="width:50%">
                                    <textarea id="eventRemark" name="eventRemark"  class="form-control"/></textarea>
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