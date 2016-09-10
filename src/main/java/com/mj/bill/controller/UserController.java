package com.mj.bill.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mj.bill.common.MD5Util;
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
	
	
	@RequestMapping("/index")
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
			}
		}else{
			response.sendRedirect("index.do?flag=1");
		}
		return file;
	}
	
	public static void main(String[] args) {
		String str = "123456";
		System.out.println(MD5Util.MD5Encode(str, "utf-8"));
		
	}
	
	
}
