package com.mj.bill.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@Controller
@RequestMapping("/operating")
public class OperatingController {
	
	@Resource
	private IUserService userService;
	
	/**
	 * 显示运作详情页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model){
		User queryUser = this.userService.queryUserByLoginName("mj");
		return "operating/index";
	}
	
	@RequestMapping("/search")
	public void search(HttpServletRequest request,HttpServletResponse response){
		User user =new User();
		user.setLoginName("mj");
		System.out.println("======"+request.getParameter("limit"));
		System.out.println("========="+request.getParameter("offset"));
		System.out.println("========="+request.getParameter("search"));
		List<User> userList = this.userService.queryUserByCondition(user);
		 JSONObject json = new JSONObject();
		 json.put("data",userList);
		 /*json.put("loginName",queryUser.getLoginName());
		 json.put("userName",queryUser.getUserName());*/
		 json.put("total",userList.size());
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
	
	
	

}
