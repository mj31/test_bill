package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.service.IOperateService;

@Controller
@RequestMapping("/operate")
public class OperateController {
	
	@Resource
	private IOperateService operateService;
	
	/**
	 * 显示运作详情页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model,OperateEventVo operateEvent){
		model.addAttribute("operateEvent", operateEvent);
		return "operate/operate_index";
	}
	
	@RequestMapping("/search")
	public void search(HttpServletRequest request,HttpServletResponse response,OperateEventVo operateEvent){
		 List<OperateEventVo> operateList = this.operateService.queryOperateByCondition(operateEvent);
		 Integer total = this.operateService.queryOperateByConditionTotal(operateEvent);
		 
		 System.out.println("===========运单编号====="+operateService.queryOperateNum());
		 
		 JSONObject json = new JSONObject();
		 json.put("data",operateList);
		 json.put("total",total);
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	public static void main(String[] args) {
	  
	        Date date = new Date();  
	        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
	        String dateNowStr = sdf.format(date);  
	        System.out.println("格式化后的日期：" + dateNowStr); 
	}
	
	
	

}
