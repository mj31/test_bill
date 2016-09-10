package com.mj.bill.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mj.bill.pojo.User;

@Controller
@RequestMapping("/operating")
public class OperatingController {
	
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model){
		//int userId = Integer.parseInt(request.getParameter("id"));
		return "operating/index";
	}

}
