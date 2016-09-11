package com.mj.bill.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.MD5Util;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@Controller
public class UserController {
	@Resource
	private IUserService userService;
	
	@RequestMapping("/login")
	public String index(HttpServletRequest request,Model model){
		return "login/login";
	}
	
	
	@RequestMapping("/loginin")
	public String login(HttpServletRequest request,HttpServletResponse response,Model model,User user)throws Exception{
		String  file = "login/index" ;
		HttpSession session = request.getSession();
		User queryUser = this.userService.queryUserByLoginName(user.getLoginName());
		if(queryUser != null){
			String password = queryUser.getPassword();
			//检验密码是否正确
			if(MD5Util.MD5Encode(user.getPassword(), "utf-8").equals(password)){
				session.setAttribute("user", queryUser);
				return file ;
			}else{
				response.sendRedirect(request.getContextPath()
						+ "/login.do?flag="+false);
				return null;
			}
		}else{
			response.sendRedirect(request.getContextPath()
					+ "/login.do?flag="+false);
			return null;
		}
		
	}
	
	/**
	 * 用户列表页
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/list")
	public String toIndex(HttpServletRequest request,Model model,User user){
		model.addAttribute("user", user);
		return "user/index";
	}
	
	/**
	 * 用户列表页查询
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/search")
	public void search(HttpServletRequest request,HttpServletResponse response,User user){
		 List<User> userList = this.userService.queryUserByCondition(user);
		 Integer total = this.userService.queryUserByConditionTotal(user);
		 JSONObject json = new JSONObject();
		 json.put("data",userList);
		 /*json.put("loginName",queryUser.getLoginName());
		 json.put("userName",queryUser.getUserName());*/
		 json.put("total",total);
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 用户列表页查询
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/delete")
	public void delete(HttpServletRequest request,HttpServletResponse response,String[] ids){
		System.out.println("===="+request.getParameter("ids"));
		JSONObject json = new JSONObject();
		try {
			this.userService.updateUserByIds(ids);
			json.put("status",0);
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
	
	public static void main(String[] args) {
		String str = "123456";
		System.out.println(MD5Util.MD5Encode(str, "utf-8"));
		
	}
	
	
}
