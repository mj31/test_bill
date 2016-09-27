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
    		 $("#lblAddTitle").text("添加运作事件");
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
    		 $("#lblAddTitle").text("修改运作事件");   
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
    		 }
    		 
    		 //获取数据
    	/* 	 $("#addForm #customerId").val($(".selected").attr("customerId"));
    		 $("#addForm #carId").val($(".selected").attr("carId"));
    		 $("#addForm #companyId").val($(".selected").attr("companyId"));
    		 $("#addForm #factoryId").val($(".selected").attr("factoryId"));
    		 $("#addForm #isOrNotTax").val($(".selected").attr("isOrNotTax")); */
    		 
    		 var customerId = $(".selected .ids").attr("customerId") ;
    		 var carId = $(".selected .ids").attr("carId") ;
    		 var companyId = $(".selected .ids").attr("companyId") ;
    		 var factoryId = $(".selected .ids").attr("factoryId") ;
    		 var isOrNotTax = $(".selected .ids").attr("isOrNotTax") ;
    		 
    		  
    		 $("#addForm #customerId").find("option[value="+customerId+"]").attr("selected",true);
    		 $("#addForm #carId").find("option[value="+carId+"]").attr("selected",true);
    		 $("#addForm #factoryId").find("option[value="+factoryId+"]").attr("selected",true);
    		  
    		 
    		 $("#addForm #companyId").find("option[value="+companyId+"]").attr("selected",true);
    		 $("#addForm #isOrNotTax").find("option[value="+isOrNotTax+"]").attr("selected",true);
    		 
	   		 $("#addForm #poundsDiff").val($(".selected").find("td:eq(3)").text());
	   		 $("#addForm #loadDate").val($(".selected").find("td:eq(5)").text());
	   		 
	   		 $("#addForm #factoryPrice").val($(".selected").find("td:eq(8)").text());
	   		 $("#addForm #activityPrice").val($(".selected").find("td:eq(9)").text());
	   		 
	   		 $("#addForm #customerPrice").val($(".selected").find("td:eq(11)").text());
	   		 $("#addForm #carFee").val($(".selected").find("td:eq(13)").text());
	   		 $("#addForm #eventRemark").val($(".selected").find("td:eq(27)").text()); 
	   		
	   		 $('.selectpicker').selectpicker({
	            'selectedText': 'cat'
	         });
	   		 
	   		 $('#add').modal();
	   		 
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
                 $.get("${ctx}/operate/delete.do?ids="+arrayIds, function (json) {
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
	 	   		
			 	var customerId = $("#addForm #customerId").find("option:selected").val();
			 	var poundsDiff= $("#addForm #poundsDiff").val();
			 	var loadDate= $("#addForm #loadDate").val(); 
			 	var carId = $("#addForm #carId").find("option:selected").val();
			 	var companyId = $("#addForm #companyId").find("option:selected").val();
			 	var factoryId = $("#addForm #factoryId").find("option:selected").val();
			 	var factoryPrice= $("#addForm #factoryPrice").val(); 
			 	var activityPrice= $("#addForm #activityPrice").val(); 
			 	var customerPrice= $("#addForm #customerPrice").val(); 
			 	var carFee= $("#addForm #carFee").val();
			 	var isOrNotTax = $("#addForm #isOrNotTax").find("option:selected").val();
	 	 		var eventRemark=  $("#addForm #eventRemark").val();
			 	
			 	//行车证荷载量进行校验
			 	var reg = /^(([1-9]+)|([0-9]+\.[0-9]{0,2}))$/;
			 	if(poundsDiff != null  && poundsDiff != ""){
			        if(!reg.test(poundsDiff)){
			        	bootbox.alert("磅差必须是数字且保留2位小数");  
			        	return  ;
			        }else{
			        	poundsDiff = Number(poundsDiff*100) ;
			        }
			 	}
			 	
			 	if(factoryPrice != null  && factoryPrice != ''){
			        if(!reg.test(factoryPrice)){
			        	bootbox.alert("出厂价必须是数字且保留2位小数");  
			        	return  ;
			        }else{
			        	factoryPrice = Number(factoryPrice*100) ;
			        }
			 	}
			 	
			 	if(activityPrice != null  && activityPrice != ''){
			        if(!reg.test(activityPrice)){
			        	bootbox.alert("优惠价必须是数字且保留2位小数");   
			        	return  ;
			        }else{
			        	activityPrice = Number(activityPrice*100) ;
			        }
			 	}
			 	
			 	if(customerPrice != null  && customerPrice != ''){
			        if(!reg.test(customerPrice)){
			        	bootbox.alert("运到价必须是数字且保留2位小数");   
			        	return  ;
			        }else{
			        	customerPrice = Number(customerPrice*100) ;
			        }
			 	}
			 	
			 	if(carFee != null  && carFee != ''){
			        if(!reg.test(carFee)){
			        	bootbox.alert("运费必须是数字且保留2位小数");    
			        	return  ;
			        }else{
			        	carFee = Number(carFee*100) ;
			        }
			 	}
			 	
			 	if(loadDate == '-'){
			 		loadDate = '' ;
			 	}
			 	
	 	   		 if(saveUserValue == '保存'){
	                    $.ajax({
			      		        url : "${ctx}/operate/save.do",
			      		        type: "post",
			      		        data:{"customerId":customerId,"poundsDiff":poundsDiff,"strLoadDate":loadDate,
			      		        		"carId":carId,"companyId":companyId,"factoryId":factoryId,"factoryPrice":factoryPrice,"activityPrice":activityPrice
			      		        		,"customerPrice":customerPrice,"carFee":carFee,"isOrNotTax":isOrNotTax, "eventRemark":eventRemark},
			      		        dataType : "json",
			      		        success: function(result){
		     		                     if(result.status == 0){
		     		                    	 $("#formSearch").submit();
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
	      		        data:{"id":id,"customerId":customerId,"poundsDiff":poundsDiff,"strLoadDate":loadDate,
      		        		"carId":carId,"companyId":companyId,"factoryId":factoryId,"factoryPrice":factoryPrice,"activityPrice":activityPrice
      		        		,"customerPrice":customerPrice,"carFee":carFee,"isOrNotTax":isOrNotTax, "eventRemark":eventRemark},
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
    	   url: '${ctx}/operate/search.do',   //请求后台的URL（*） 
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
    	   }, {
    	    field: 'poundsDiff',
    	    title: '磅差', 
    	    align: "center",//水平
            valign: "middle",//垂直
           	formatter:function(value,row,index){
            		if(value != null && value != ''){
            			return (value/100).toFixed(2) ;
            		}else{
             			return '' ;
             		}
               }
    	   }, {
    	    field: 'customerShortName',
    	    title: '客户',
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
       	    title: '出厂地', 
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
              			return '' ;
              		}
                 }
       	    },{
          	    field: 'activityPrice',
          	    title: '优惠价', 
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
              	    field: 'customerAddress',
              	    title: '目的地',  
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
                      			return '' ;
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
              	    field: 'carFee',
              	    title: '运费',   
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
               	    field: 'strUploadDate',
               	    title: '卸车时间',    
               	    align: "center",//水平
                    valign: "middle"//垂直
                },
            	 {
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
                },
            	 {
            	    field: 'isOrNotTax',
            	    title: '税差',     
            	    align: "center",//水平
                    valign: "middle",//垂直
                    formatter:function(value,row,index){
                 		if(value != null && value == 0){
                 			var carFee = row.carFee ;
                 			if(carFee != null && carFee != 0){
                 				return (carFee*0.02/100).toFixed(2) ;
                 			}else{
                 				return  "" ;
                 			}
                 		}else{
                 			return "" ;
                 		}
                    }
                },
            	 {
            	    field: 'isOrNotTax',
            	    title: '利润',      
            	    align: "center",//水平
                    valign: "middle",//垂直
                    formatter:function(value,row,index){
                    	var tax = 0 ;
                    	
                    	var carFeeNew = 0 ;
                    	//税差 
                 		if(value != null && value == 0){
                 			var carFee = row.carFee ;
                 			if(carFee != null && carFee != 0){
                 				tax = carFee*0.02 ;
                 				carFeeNew = carFee ;
                 			}
                 		}
                    	
                    	//运到价
                    	var customerPriceNew = 0 ;
                    	var customerPrice = row.customerPrice ;
                    	if(customerPrice != null && customerPrice != 0){
                    		customerPriceNew = customerPrice ;
                    	}
                    	
                    	//出厂价
                    	var factoryPriceNew = 0 ;
                    	var factoryPrice = row.factoryPrice ;
                    	if(factoryPrice != null && factoryPrice != 0){
                    		factoryPriceNew = factoryPrice ;
                    	}
                    	return  (Number(customerPriceNew/100) - Number(factoryPriceNew/100)-Number(carFeeNew/100)-Number(tax/100)).toFixed(2);
                    }
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
                      			return '' ;
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
                       			return '' ;
                       		}
                         }
               	 },
            	 {
                	    field: 'uploadEmpty',
                	    title: '气差',   
                	    align: "center",//水平
                        valign: "middle",//垂直
                    	formatter:function(value,row,index){
                    		var uploadEmptyNew = 0 ;
                       		if(value != null && value != ''){
                       			uploadEmptyNew =  value  ;
                       		}
                       		var loadEmptyNew = 0 ;
                       		var loadEmpty = row.loadEmpty ;
                       		if(loadEmpty != null && loadEmpty != ''){
                       			loadEmptyNew =  loadEmpty  ;
                       		}
                       		return (Number(uploadEmptyNew/100) - Number(loadEmptyNew/100)).toFixed(2) ;
                          }
                	 },
           	         {
	               	    field: 'loadEmpty',
	               	    title: '工厂结算金额',   
	               	    align: "center",//水平
	                    valign: "middle",//垂直
	                   	formatter:function(value,row,index){
                   		    var loadEmptyNew = 0 ;
                      		if(value != null && value != ''){
                      			loadEmptyNew  =  value  ;
                      		}
                      		var factoryPriceNew = 0 ;
                      		var factoryPrice = row.factoryPrice ;
                      		if(factoryPrice != null && factoryPrice != ''){
                      			factoryPriceNew =  factoryPrice  ;
                      		}
                      		return (Number(loadEmptyNew/100)*Number(factoryPriceNew/100)).toFixed(2) ;
                         }
               	 },
            	 {
                	    field: 'factWeight',
                	    title: '实际结算量',    
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
 	               	    field: 'factWeight',
 	               	    title: '客户结算金额',   
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
  	               	    title: '每车毛利润',   
  	               	    align: "center",//水平
  	                    valign: "middle",//垂直
  	                   	formatter:function(value,row,index){
								var tax = 0 ;
		                    	
		                    	var carFeeNew = 0 ;
		                    	//税差 
		                 		if(row.isOrNotTax != null && row.isOrNotTax == 0){
		                 			var carFee = row.carFee ;
		                 			if(carFee != null && carFee != 0){
		                 				tax = carFee*0.02 ;
		                 				carFeeNew = carFee ;
		                 			}
		                 		}
		                    	
		                    	//运到价
		                    	var customerPriceNew = 0 ;
		                    	var customerPrice = row.customerPrice ;
		                    	if(customerPrice != null && customerPrice != 0){
		                    		customerPriceNew = customerPrice ;
		                    	}
		                    	
		                    	//出厂价
		                    	var factoryPriceNew = 0 ;
		                    	var factoryPrice = row.factoryPrice ;
		                    	if(factoryPrice != null && factoryPrice != 0){
		                    		factoryPriceNew = factoryPrice ;
		                    	}
		                    	return  ((Number(customerPriceNew/100) - Number(factoryPriceNew/100)-Number(carFeeNew/100)-Number(tax/100))*Number(row.factWeight/100)).toFixed(2);
 	                          }
                 	 },
                	 {
                 	    field: 'uploadEmpty',
                 	    title: '气差金额',    
                 	    align: "center",//水平
                        valign: "middle",//垂直
                     	formatter:function(value,row,index){
                     		  // ======气差开始======
                     		   var qicha = 0 ;
                     		   var uploadEmptyNew = 0 ;
                        	   if(value != null && value != ''){
                        			uploadEmptyNew =  value  ;
                        		}
                        		var loadEmptyNew = 0 ;
                        		var loadEmpty = row.loadEmpty ;
                        		if(loadEmpty != null && loadEmpty != ''){
                        			loadEmptyNew =  loadEmpty  ;
                        		}
                        		qicha =  Number(uploadEmptyNew/100) - Number(loadEmptyNew/100) ;
                        		// ======气差开始======
                        			
                        		//出厂价
                            	var factoryPriceNew = 0 ;
                            	var factoryPrice = row.factoryPrice ;
                            	if(factoryPrice != null && factoryPrice != 0){
                            		factoryPriceNew = Number(factoryPrice/100) ;
                            	}
                            	return Number(qicha*factoryPriceNew).toFixed(2);
                           }
                 	 },
           	         {
   	               	    field: 'factWeight',
   	               	    title: '车辆运费',    
   	               	    align: "center",//水平
   	                    valign: "middle",//垂直
   	                   	formatter:function(value,row,index){
  	                       		return Number((value/100)*(row.carFee/100)).toFixed(2);  
  	                          }
                  	 },
          	         {
  	               	    field: 'eventRemark',
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
    	  //得到查询的参数  Number(capacity*100) 
    	 oTableInit.queryParams = function (params) {
	    	  var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
		    	   limit: params.limit, //页面大小
		    	   offset: params.offset, //页码
		    	   customerId: formSearchCustomerId ,
		    	   factoryId: formSearchFactoryId ,
		    	   carId: formSearchCarId
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
		 	$("#addForm #poundsDiff").val("");
		 	$("#addForm #loadDate").val(""); 
		 	$("#addForm #factoryPrice").val(""); 
		 	$("#addForm #activityPrice").val(""); 
		 	$("#addForm #customerPrice").val(""); 
		 	$("#addForm #carFee").val("");
 	 		$("#addForm #eventRemark").val("");
    	} 
    	
    </script>
</head>
<body>
<%@ include file="/common/top.jsp"%>
    <div class="container-fluid all">
        <%@ include file="/common/left.jsp"%>
        <div class="panel panel-default">
   <div class="panel-heading">运作详情</div>
   <div class="panel-body">
    <form id="formSearch" class="form-horizontal" action="${ctx}/operate/index.do">
	     <div class="form-group" style="margin-top:15px">
		      <label class="control-label col-sm-1" for="txt_search_departmentname">客户</label>
		      <div class="col-sm-3" style="width:10%">
		      		 	<select class="selectpicker bla bla bli querySelect"   data-live-search="true"  id="customerId" name="customerId">
		      		 				   <option value=''>----请选择----</option>
                               	<c:forEach items="${companyList}" var="customer">
                               		<c:if test="${customer.flag eq 1}">
						     			<option value="${customer.id}" <c:if test="${operateEvent.customerId eq customer.id}">selected</c:if>>${customer.shortName}</option> 
                               		</c:if>
                               	</c:forEach> 
					 	 </select>
		       		<%-- <input type="text" class="form-control" id="headerNumber" name="headerNumber" value="${carInfo.headerNumber}"> --%>
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu">出厂地</label>
		      <div class="col-sm-3" style="width:10%">
		       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true" id="factoryId" name="factoryId"> 
		       								 <option value=''>----请选择----</option>
							      <c:forEach items="${companyList}" var="factory">
                                  		  <c:if test="${factory.flag eq 0}">
									         <option value="${factory.id}"  <c:if test="${operateEvent.factoryId eq factory.id}">selected</c:if>>${factory.shortName}</option> 
                                  		  </c:if>
                                  </c:forEach>
					    </select>
		      </div>
		      <label class="control-label col-sm-1" for="txt_search_statu">承运车号</label>
		      <div class="col-sm-3" style="width:10%">
		       			<select class="selectpicker bla bla bli querySelect"  data-live-search="true"  id="carId" name="carId"> 
		       								  <option value=''>----请选择----</option>
                                    	<c:forEach items="${carInfoList}" var="carInfo">
											   <option value="${carInfo.id}"  <c:if test="${operateEvent.carId eq carInfo.id}">selected</c:if>>${carInfo.headerNumber}</option> 
                                    	</c:forEach>
					 	</select>
		      </div>
		      
		      <label class="control-label col-sm-1" for="txt_search_statu"></label>
		    <%--
		     <label class="control-label col-sm-1" for="txt_search_statu">状态</label>   
		      <div class="col-sm-3"  style="width:6%">
		       		<div class="form-group">
					    <select class="form-control" id="status" name="status"> 
						      <option value="">全部</option> 
						      <option value="0"  <c:if test="${company.status eq 0 }"> selected </c:if>>正常</option> 
						      <option value="1"  <c:if test="${company.status eq 1 }"> selected </c:if>>禁用</option> <!-- <c:if test="${user.status eq 1 }"> selected </c:if> -->
					      </select>
					  </div>
		      </div> --%>
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
 <!--   <button id="btn_delete" type="button" class="btn btn-default">
    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>禁用
   </button> -->
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
                    <span id="lblAddTitle" style="font-weight:bold">添加运作事件</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                    
                    	<div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">客户</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"   data-live-search="true"  id="customerId" name="customerId">
                                    	<c:forEach items="${companyList}" var="customer">
                                    		<c:if test="${customer.flag eq 1}">
											     <option value="${customer.id}" >${customer.shortName}</option> 
                                    		</c:if>
                                    	</c:forEach> 
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">目的地</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="customerAddress" name="customerAddress" readonly type="text" class="form-control" placeholder="目的地" />
                                </div>
                            </div>
                        </div> -->
                    
                    
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
                                <label class="control-label col-md-2" style="margin-left:40px">装车时间</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="loadDate" name="loadDate" type="text" class="form-control" placeholder="装车时间" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">承运车号</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"  data-live-search="true"  id="carId" name="carId"> 
                                    	<c:forEach items="${carInfoList}" var="carInfo">
											   <option value="${carInfo.id}" >${carInfo.headerNumber}</option> 
                                    	</c:forEach> 
					      			</select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- <label for="bs3Select" class="col-lg-2 control-label">Test bootstrap 3 form</label>
		                <div class="col-lg-10">
		                    <select id="bs3Select" class="selectpicker show-tick form-control" multiple data-live-search="true">
		                        <option>cow</option>
		                        <option>bull</option>
		                    </select>
		                </div> -->
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">承运单位</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="form-control" id="companyId" name="companyId"> 
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
                                <label class="control-label col-md-2" style="margin-left:40px">出厂地</label> 
                                <div class="col-md-10" style="width:50%"> 
                                    <select class="selectpicker bla bla bli"  data-live-search="true" id="factoryId" name="factoryId"> 
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
                                <label class="control-label col-md-2" style="margin-left:40px">出厂价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="factoryPrice" name="factoryPrice"  type="text" class="form-control" placeholder="出厂价" />
                                </div>
                            </div>
                        </div>
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">优惠价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="activityPrice" name="activityPrice" type="text" class="form-control" placeholder="优惠价" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运到价</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="customerPrice" name="customerPrice" type="text" class="form-control" placeholder="运到价" />
                                </div>
                            </div>
                        </div>
                         <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">运费</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="carFee" name="carFee" type="text" class="form-control" placeholder="运费" />
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