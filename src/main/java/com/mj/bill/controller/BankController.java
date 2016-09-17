package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.BankVo;
import com.mj.bill.pojo.Company;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.pojo.User;
import com.mj.bill.service.ICompanyService;

@Controller
@RequestMapping("/bank")
public class BankController {
	
	@Resource
	private IBankService bankService;
	
	@Resource
	private ICompanyService companyService;
	
	/**
	 * 车辆信息页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model,BankVo bank){
		model.addAttribute("bank", bank);
		//获取company表数据 可用的数据=======================
		Company company = new Company();
		company.setStatus(0);
		List<Company> companyList = companyService.queryCompanyByCondition(company) ;
		model.addAttribute("companyList", companyList);
		return "bank/bank_index";
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public void search(HttpServletRequest request,HttpServletResponse response,BankVo bank){
		 List<BankVo> bankList = this.bankService.queryBankByCondition(bank);
		 Integer total = this.bankService.queryBankByConditionTotal(bank);
		 
		 if(!CollectionUtils.isEmpty(bankList)){
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			 Calendar c = Calendar.getInstance();
			 for(int i = 0 ; i < bankList.size() ; i++){
				 long exchangeDate = bankList.get(i).getExchangeDate();
				 if(exchangeDate != 0){
					 c.setTimeInMillis(exchangeDate);
					 bankList.get(i).setStrExchangeDate(format.format(c.getTime()));
				 }else{
					 bankList.get(i).setStrExchangeDate("-");
				 }
			 }
			 
		 }
		 
		 JSONObject json = new JSONObject();
		 json.put("data",bankList);
		 json.put("total",total);
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 保存运作信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(value ="/save" , method = RequestMethod.POST)
	@ResponseBody
	public void save(HttpServletRequest request,HttpServletResponse response,BankVo bank){
		HttpSession session = request.getSession();
		JSONObject json = new JSONObject();
		try {
			
			if(bank != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strExchangeDate = bank.getStrExchangeDate() ;
				if(StringUtils.isNotEmpty(strExchangeDate)){
					Date newDate = format.parse(strExchangeDate) ;
					bank.setExchangeDate(newDate.getTime());
				}else{
					bank.setExchangeDate(0L);
				}
				
				User user = (User)session.getAttribute("user");
				bank.setCreateUserId(Long.parseLong(user.getId().toString()));
				bank.setCreateUserName(user.getUserName());
				bank.setCreateDate(new Date().getTime());
				
				this.bankService.saveBank(bank);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	/**
	 * 修改运作信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/update" , method = RequestMethod.POST)
	@ResponseBody
	public void update(HttpServletRequest request,HttpServletResponse response,BankVo bank){
		JSONObject json = new JSONObject();
		HttpSession session = request.getSession();
		try {
			
			if(bank != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strExchangeDate = bank.getStrExchangeDate() ;
				if(StringUtils.isNotEmpty(strExchangeDate)){
					Date newDate = format.parse(strExchangeDate) ;
					bank.setExchangeDate(newDate.getTime());
				}else{
					bank.setExchangeDate(0L);
				}
				
				User user = (User)session.getAttribute("user");
				bank.setUpdateUserId(Long.parseLong(user.getId().toString()));
				bank.setUpdateUserName(user.getUserName());
				bank.setUpdateDate(new Date().getTime());
				
				this.bankService.updateBank(bank);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}

}
