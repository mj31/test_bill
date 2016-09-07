package com.mj.bill.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@Controller
public class UserController {
	@Resource
	private IUserService userService;
	
	@RequestMapping("/login")
	public String toIndex(HttpServletRequest request,Model model){
		//int userId = Integer.parseInt(request.getParameter("id"));
		User user = this.userService.getUserById(1);
		model.addAttribute("user", user);
		return "login/login";
	}
}
