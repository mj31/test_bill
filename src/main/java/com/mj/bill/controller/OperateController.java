package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.mj.bill.pojo.OperateEvent;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.service.ICarInfoService;
import com.mj.bill.service.ICompanyService;
import com.mj.bill.service.IOperateService;

@Controller
@RequestMapping("/operate")
public class OperateController {
	private final static Logger logger = LoggerFactory.getLogger(OperateController.class); 
	
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
	 * @returns
	 */
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request,Model model,OperateEventVo operateEvent){
		model.addAttribute("operateEvent", operateEvent);
		
		Company company= new Company();
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
			logger.info("保存运作详情打印数据====="+e);
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
				this.operateService.updateOperateByEvent(operateEvent);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("更新打印数据====="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	/**
	 * 修改弹出
	 * @param request
	 * @param response
	 * @param operateEvent
	 */
	@RequestMapping("/updateSearch")
	@ResponseBody
	public void updateSearch(HttpServletRequest request,HttpServletResponse response,Integer id){
		JSONObject json = new JSONObject();
		try {
				OperateEventVo operateEvent =	this.operateService.getById(id);
			    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c = Calendar.getInstance();
		    	 //装车时间
				 if(operateEvent != null){
					 Long loadDate = operateEvent.getLoadDate();
					 if(loadDate != null && loadDate != 0){
						 c.setTimeInMillis(loadDate);
						 operateEvent.setStrLoadDate(format.format(c.getTime()));
					 }else{
						 operateEvent.setStrLoadDate("-");
					 }
				 }
			    json.put("operateEvent", operateEvent) ;
				json.put("status",0);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("弹出层查询===="+e);
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
