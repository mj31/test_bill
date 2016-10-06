<%@ page language="java"  pageEncoding="utf-8"%>
     <script type="text/javascript">
     	$(function(){
     		$("#updateUserPassword").click(function(){
     			var id =$("#userId").val();
     			var firstPassword = $("#firstPassword").val();
     			var secondPassword = $("#secondPassword").val();
     			if(firstPassword != secondPassword){
     				bootbox.alert({  
    		            buttons: {  
    		               ok: {  
    		                    label: '确定',  
    		                    className: 'btn-myStyle'  
    		                }  
    		            },  
    		            message: '两次密码输入必须一致',     
    		            
    		        }); 
    			 return ;
     			}
     			
     			bootbox.confirm("一定要记住密码,点击确定即可!", function (result) { 
     	             if (result) {
     	                 //然后发送异步请求的信息到后台删除数据
     	                 $.get("${ctx}/user/update.do?id="+id+"&password="+firstPassword, function (json) {
     	                     if (json.status == 0) {
     	                    	 window.location.href="${ctx}/login.do"
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
     	});
     
		function updateSecret(){
	   	     $('#addTop').modal();
		}
</script>
<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle show pull-left" data-target="sidebar">
                    <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                        aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button>
               <!--  <a class="navbar-brand" href="index.html">Bootstrap</a> -->
            </div>
            <div id="navbar" class="collapse navbar-collapse">

                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-expanded="false"><i class="fa fa-user fa-fw"></i>&nbsp;${user.userName}&nbsp;<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a onclick="updateSecret()">修改密码</a></li>
                            <li class="divider"></li>
                            <li><a href="${ctx}/loginOut.do">退出</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div id="addTop" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">
                    <i class="icon-pencil"></i>
                    <span id="lblAddTitle" style="font-weight:bold">修改密码</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe"  id="addForm" data-toggle="validator" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">新密码</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="firstPassword" name="firstPassword" type="password" class="form-control"/>
                                    <input type="hidden" id = "userId" name="userId" value="${user.id}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2" style="margin-left:40px">确认密码</label>
                                <div class="col-md-10" style="width:50%">
                                    <input id="secondPassword" name="secondPassword" type="password" class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-info">
                    <button type="button" class="btn blue" id="updateUserPassword">修改</button>
                    <button type="button" class="btn green" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
