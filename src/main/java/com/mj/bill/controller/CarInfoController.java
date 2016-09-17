package com.mj.bill.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.service.ICarInfoService;

@Controller
@RequestMapping("/car")
public class CarInfoController {
	
	Logger logger = Logger.getLogger(CarInfoController.class);
	
	@Resource
	private ICarInfoService carInfoService;
	
	/**
	 * 车辆信息页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String toIndex(HttpServletRequest request,Model model,CarInfo carInfo){
		model.addAttribute("carInfo", carInfo);
		return "car/car_index";
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public void search(HttpServletRequest request,HttpServletResponse response,CarInfo carInfo){
		 List<CarInfo> carInfoList = this.carInfoService.queryCarInfoByCondition(carInfo);
		 Integer total = this.carInfoService.queryCarInfoByConditionTotal(carInfo);
		 
		 if(!CollectionUtils.isEmpty(carInfoList)){
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			 Calendar c = Calendar.getInstance();
			 for(int i = 0 ; i < carInfoList.size() ; i++){
				 long expiredDate = carInfoList.get(i).getExpiredDate();
				 if(expiredDate != 0){
					 c.setTimeInMillis(expiredDate);
					 carInfoList.get(i).setStrExpiredDate(format.format(c.getTime()));
				 }else{
					 carInfoList.get(i).setStrExpiredDate("-");
				 }
			 }
			 
		 }
		 
		 logger.info("======查询======");
		 JSONObject json = new JSONObject();
		 json.put("data",carInfoList);
		 json.put("total",total);
		 json.put("page",1);
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
						this.carInfoService.updateCarInfoById(id[i]);
					}
				}else{
					this.carInfoService.updateCarInfoById(ids);
				}
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
	 * 保存车辆信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(value ="/save" , method = RequestMethod.POST)
	@ResponseBody
	public void save(HttpServletRequest request,HttpServletResponse response,CarInfo carInfo){
		JSONObject json = new JSONObject();
		try {
			
			if(carInfo != null){
				carInfo.setStatus(0);
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strExpiredDate = carInfo.getStrExpiredDate() ;
				if(StringUtils.isNotEmpty(strExpiredDate)){
					Date newDate = format.parse(strExpiredDate) ;
					carInfo.setExpiredDate(newDate.getTime());
				}else{
					carInfo.setExpiredDate(0l);
				}
				this.carInfoService.saveCarInfo(carInfo);
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
	 * 修改车辆信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(HttpServletRequest request,HttpServletResponse response,CarInfo carInfo){
		JSONObject json = new JSONObject();
		try {
			
			if(carInfo != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String strExpiredDate = carInfo.getStrExpiredDate() ;
				if(StringUtils.isNotEmpty(strExpiredDate)){
					Date newDate = format.parse(strExpiredDate) ;
					carInfo.setExpiredDate(newDate.getTime());
				}else{
					carInfo.setExpiredDate(0l);
				}
				this.carInfoService.updateCarInfo(carInfo);
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
		long dateLong = 1474560000000l ;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(dateLong);
		System.out.println(format.format(c.getTime()));
		
	}
	
}
