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
import com.mj.bill.service.ICarInfoService;

@Controller
@RequestMapping("/car")
public class CarInfoController {
	
	private final static Logger logger = LoggerFactory.getLogger(CarInfoController.class); 
	
	@Resource
	private ICarInfoService carInfoService;
	
	/**
	 * 车辆信息页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String toIndex(HttpServletRequest request,HttpServletResponse response,Model model,CarInfo carInfo){
		model.addAttribute("carInfo", carInfo);
		return "car/car_index";
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public void search(HttpServletRequest request,HttpServletResponse response,CarInfo carInfo,Integer limit ,Integer offset){
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
         carInfo.setBeginRow(beginRow);
         carInfo.setPageSize(pageSize);
		 List<CarInfo> carInfoList = this.carInfoService.queryCarInfoByConditionNew(carInfo);
		 
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
					 carInfoList.get(i).setStrExpiredDate("");
				 }
			 }
			 
		 }
		 
		 JSONObject json = new JSONObject();
		 json.put("rows",carInfoList);
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
			logger.info("===车辆信息修改==="+e);
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
			logger.info("=====保存车辆信息====="+e);
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
			logger.info("修改车辆信息===="+e);
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
