package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.Company;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.service.ICarInfoService;
import com.mj.bill.service.ICompanyService;
import com.mj.bill.service.IOperateService;

@Controller
@RequestMapping("/operate")
public class OperateController {
	
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
		//获取company表数据 可用的数据=======================
		Company company = new Company();
		company.setStatus(0);
		List<Company> companyList = companyService.queryCompanyByCondition(company) ;
		model.addAttribute("companyList", companyList);
		//获取company表数据 可用的数据========================
		//获取car_info表数据 可用的数据=======================
		CarInfo carInfo = new CarInfo();
		carInfo.setStatus(0);
		List<CarInfo> carInfoList = carInfoService.queryCarInfoByCondition(carInfo);
		model.addAttribute("carInfoList", carInfoList);
		//获取car_info表数据 可用的数据=======================
		
		return "operate/operate_index";
	}
	
	@RequestMapping(value="/search")
	public void search(HttpServletRequest request,HttpServletResponse response,OperateEventVo operateEvent){
		 List<OperateEventVo> operateList = this.operateService.queryOperateByCondition(operateEvent);
		 Integer total = this.operateService.queryOperateByConditionTotal(operateEvent);
		 
		 if(!CollectionUtils.isEmpty(operateList)){
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			 Calendar c = Calendar.getInstance();
			 for(int i = 0 ; i < operateList.size() ; i++){
				//装车时间
				 if(operateList.get(i).getLoadDate() != null){
					 long loadDate = operateList.get(i).getLoadDate();
					 if(loadDate != 0){
						 c.setTimeInMillis(loadDate);
						 operateList.get(i).setStrLoadDate(format.format(c.getTime()));
					 }else{
						 operateList.get(i).setStrLoadDate("-");
					 }
				 }
				//卸车时间
				 if(operateList.get(i).getUploadDate() != null){
					 long upLoadDate = operateList.get(i).getUploadDate() ;
					 if(upLoadDate != 0){
						 c.setTimeInMillis(upLoadDate);
						 operateList.get(i).setStrUploadDate(format.format(c.getTime()));
					 }else{
						 operateList.get(i).setStrUploadDate("-");
					 }
					 
				 }
			 }
			 
		 }
		 
		 JSONObject json = new JSONObject();
		 json.put("data",operateList);
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
	public void save(HttpServletRequest request,HttpServletResponse response,OperateEventVo operateEvent){
		JSONObject json = new JSONObject();
		try {
			
			if(operateEvent != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strLoadDate = operateEvent.getStrLoadDate() ;
				if(StringUtils.isNotEmpty(strLoadDate)){
					Date newDate = format.parse(strLoadDate) ;
					operateEvent.setLoadDate(newDate.getTime());
				}else{
					operateEvent.setLoadDate(0L);
				}
				//获取运单编号
				Integer operateNum = operateService.queryOperateNum();
				operateEvent.setOperateNum(operateNum);
				this.operateService.saveOperateEvent(operateEvent);
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
	@RequestMapping("/update")
	@ResponseBody
	public void update(HttpServletRequest request,HttpServletResponse response,OperateEventVo operateEvent){
		JSONObject json = new JSONObject();
		try {
			
			if(operateEvent != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strLoadDate = operateEvent.getStrLoadDate() ;
				if(StringUtils.isNotEmpty(strLoadDate)){
					Date newDate = format.parse(strLoadDate) ;
					operateEvent.setLoadDate(newDate.getTime());
				}else{
					operateEvent.setLoadDate(0L);
				}
				this.operateService.updateOperateEvent(operateEvent);
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
	
	public static void main(String[] args) {
	  
	        Date date = new Date();  
	        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
	        String dateNowStr = sdf.format(date);  
	        System.out.println("格式化后的日期：" + dateNowStr); 
	}
	
	
	

}
