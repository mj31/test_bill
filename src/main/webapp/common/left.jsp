<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/common/taglibs.jsp"%>
<div class="sidebar">
	<ul class="nav">
		<c:if test="${menuList.size() gt 0}">
			<c:forEach items="${menuList}" var ="menu">
				<li><a href="${ctx}/${menu.menuUrl}">${menu.menuName}</a></li>
			</c:forEach>
		</c:if>
		<%-- <li><a href="${ctx}/operate/index.do">运作详情</a></li>
		<li><a href="${ctx}/planSettle/index.do">计划结算</a></li>
		<li><a href="${ctx}/salePlan/index.do">销售计划</a></li>
		<li><a href="${ctx}/bank/index.do">付款信息</a></li>
		<li><a href="${ctx}/factory/index.do">装车对账单</a></li>
		<li><a href="${ctx}/customer/index.do">卸车对账单</a></li>
		<li><a href="${ctx}/settle/index.do">运费结算</a></li> --%>
		<li class="has-sub"><a href="javascript:void(0);"><span>系统管理</span><i
				class="fa fa-caret-right fa-fw pull-right"></i></a>
			<ul class="sub-menu">
				<li><a href="${ctx}/user/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;用户管理</a></li>
				<li><a href="${ctx}/car/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;车辆信息管理</a></li>
				<li><a href="${ctx}/company/list.do"><i class="fa fa-circle-o fa-fw"></i>&nbsp;公司信息管理</a></li>
			</ul>
		</li>
	</ul>
</div>