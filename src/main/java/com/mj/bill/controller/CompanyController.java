package com.mj.bill.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.Company;
import com.mj.bill.service.ICarInfoService;
import com.mj.bill.service.ICompanyService;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	private final static Logger logger = LoggerFactory.getLogger(CompanyController.class);
	
	@Resource
	private ICompanyService companyService;
	
	/**
	 * 公司页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String toIndex(HttpServletRequest request,Model model,Company company){
		model.addAttribute("company", company);
		return "company/company_index";
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public void search(HttpServletRequest request,HttpServletResponse response,Company company,Integer limit ,Integer offset){
		
		//页面大小
        Integer pageSize = 20 ;
        if(limit != 0){
            pageSize = limit ;
        }

        //开始记录数
        Integer beginRow = 0;
           if(offset != 0){
            beginRow = offset ;
         }
         company.setBeginRow(beginRow);
         company.setPageSize(pageSize);
		 List<Company> companyList = this.companyService.queryCompanyByConditionNew(company);
		 Integer total = this.companyService.queryCompanyByConditionTotal(company);
		 JSONObject json = new JSONObject();
		 json.put("rows",companyList);
		 json.put("total",total);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(HttpServletRequest request,HttpServletResponse response,String ids){
		JSONObject json = new JSONObject();
		try {
			if(ids != null){
				if(ids.contains(",")){
					String[] id =  ids.split(",") ;
					for(int i = 0 ; i < id.length ;i++){
						this.companyService.updateCompanyById(id[i]);
					}
				}else{
					this.companyService.updateCompanyById(ids);
				}
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("删除公司信息===="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 保存公司信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(HttpServletRequest request,HttpServletResponse response,Company company){
		JSONObject json = new JSONObject();
		try {
			
			if(company != null){
				company.setStatus(0);
				this.companyService.saveCompany(company);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("保存公司信息===="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	/**
	 * 修改公司信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(HttpServletRequest request,HttpServletResponse response,Company company){
		JSONObject json = new JSONObject();
		try {
			
			if(company != null){
				this.companyService.updateCompany(company);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("修改公司信息===="+e); 
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	/**
	 * 左边菜单
	 * @param request
	 * @param response
	 */
	@RequestMapping("/queryFactory")
	@ResponseBody
	public void queryFactory(HttpServletRequest request,HttpServletResponse response){
		JSONObject json = new JSONObject();
		try {
			Company company = new Company();
			company.setFlag(0);
			company.setStatus(0);
			List<Company> factoryList = this.companyService.queryCompanyByCondition(company);
			
			json.put("status",0);
			json.put("factoryList",factoryList);
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
}
