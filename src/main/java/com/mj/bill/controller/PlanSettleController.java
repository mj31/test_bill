package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.Company;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.service.ICarInfoService;
import com.mj.bill.service.ICompanyService;
import com.mj.bill.service.IOperateService;

@Controller
@RequestMapping("/planSettle")
public class PlanSettleController {

	private final static Logger logger = LoggerFactory.getLogger(PlanSettleController.class);
	
	@Resource
	private IOperateService operateService;
	
	@Resource
	private ICompanyService companyService;
	
	@Resource
	private ICarInfoService carInfoService;
	
	/**
	 * 显示运作详情页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model,OperateEventVo operateEvent){
		model.addAttribute("operateEvent", operateEvent);
		//下游客户
		Company company= new Company();
		company.setStatus(0);
		List<Company> companyList = companyService.queryCompanyByCondition(company) ;
		model.addAttribute("companyList", companyList);
		
		CarInfo carInfo = new CarInfo();
		carInfo.setStatus(0);
		List<CarInfo> carInfoList = carInfoService.queryCarInfoByCondition(carInfo);
		model.addAttribute("carInfoList", carInfoList);
		
		return "plan/plan_index";
	}
	

}
