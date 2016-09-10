<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>  
     <head> 
     <!--加载js插件  -->
<link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/css/signin.css" rel="stylesheet">

<script src="${ctx}/js/jquery.min.js"></script>

	<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="favicon.ico" />
    <!--jquery库-->
    <script src="${ctx}/js/jquery.min.js"></script>
    <!--bootstrap库-->
    <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" />
    <script src="${ctx}/js/bootstrap/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
      <script src="js/bootstrap/html5shiv.min.js"></script>
      <script src="js/bootstrap/respond.min.js"></script>
    <![endif]-->
    <!--font-awesome字体库-->
    <link href="${ctx}/css/font-awesome.min.css" rel="stylesheet" />
    <!--页面加载进度条-->
    <link href="${ctx}/css/pace/dataurl.css" rel="stylesheet" />
    <script src="${ctx}/js/pace/pace.min.js"></script>
    <!--jquery.hammer手势插件-->
    <script src="${ctx}/js/jquery.hammer/hammer.min.js"></script>
    <script src="${ctx}/js/jquery.hammer/jquery.hammer.js"></script>
    <!--平滑滚动到顶部库-->
    <script src="${ctx}/js/jquery.scrolltopcontrol/scrolltopcontrol.js" type="text/javascript"></script>
    <!--主要写的jquery拓展方法-->
    <script src="${ctx}/js/jquery.extend.js" type="text/javascript"></script>
    <!--主要写的css代码-->
    <link href="${ctx}/css/default.css" rel="stylesheet" type="text/css" />
    <!--主要写的js代码-->
    <script src="${ctx}/js/default.js" type="text/javascript"></script> 
       <title><decorator:title default="装饰器页面..." /></title>  
       <decorator:head />  
     </head>  
     <body>  
       <jsp:include page="${ctx}/common/top.jsp"></jsp:include>  
        <div class="container-fluid all"> 
      		<jsp:include page="${ctx}/common/left.jsp"></jsp:include> 
       		<decorator:body />  
       </div>
       <jsp:include page="${ctx}/common/footer.jsp"></jsp:include>  
     </body>  
</html>