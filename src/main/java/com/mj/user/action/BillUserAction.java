package com.mj.user.action;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mj.user.service. BillUserService;
@Controller
@RequestMapping(value = "/billUser")
public class BillUserAction{
	
	  	@Autowired
	    private BillUserService billUserService;
	  
	  	
		
}
