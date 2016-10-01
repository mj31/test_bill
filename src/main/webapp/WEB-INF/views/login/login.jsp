<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="SHORTCUT ICON" href="${ctx}/favicon.ico" />
  <link rel="BOOKMARK" href="${ctx}/favicon.ico" />
  <Link Rel="ICON NAME" href="${ctx}/favicon.ico" />
  <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx}/css/signin.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>永润系统</title>
</head>
<body>
	<div class="signin">
    <div class="signin-head"><img src="${ctx}/images/test/head_120.png" alt="" class="img-circle"></div>
    <form class="form-signin" action="${ctx}/loginin.do" role="form" method="post">
        <input type="text" class="form-control" placeholder="用户名" required autofocus  name="loginName" id="loginName"/>
        <input type="password" class="form-control" placeholder="密码" required name="password" id="password"/>
        <button class="btn btn-lg btn-warning btn-block" type="submit">登录</button>
       <!--  <label class="checkbox">
            <input type="checkbox" value="remember-me"> 记住我
        </label> -->
    </form>
</div>

<!-- <div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
    <p>适用浏览器：360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗. 不支持IE8及以下浏览器。</p>
    <p>来源：<a href="http://sc.chinaz.com/" target="_blank">站长素材</a></p>
</div> -->
</body>
</html>