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
@RequestMapping("/settle")
public class FeeSettleController {
	private final static Logger logger = LoggerFactory.getLogger(FeeSettleController.class);
	
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
		/*//上游工厂
		Company upFactory = new Company();
		upFactory.setStatus(0);
		upFactory.setFlag(0);
		List<Company> upFactoryList = companyService.queryCompanyByCondition(upFactory) ;
		model.addAttribute("upFactoryList", upFactoryList);
		
		//承运单位
		Company company = new Company();
		company.setStatus(0);
		company.setFlag(2);
		List<Company> companyList = companyService.queryCompanyByCondition(company) ;
		model.addAttribute("companyList", companyList);*/
		
		/*//卸车地
		Company loadCustomer = new Company();
		loadCustomer.setStatus(0);
		loadCustomer.setFlag(1);
		List<Company> loadCustomerList = companyService.queryCompanyByCondition(loadCustomer) ;
		model.addAttribute("loadCustomerList", loadCustomerList);*/
		
		
		//获取company表数据 可用的数据========================
		//获取car_info表数据 可用的数据=======================
		CarInfo carInfo = new CarInfo();
		carInfo.setStatus(0);
		List<CarInfo> carInfoList = carInfoService.queryCarInfoByCondition(carInfo);
		model.addAttribute("carInfoList", carInfoList);
		//获取car_info表数据 可用的数据=======================
		
		return "settle/settle_index";
	}
	
	@RequestMapping(value="/search")
	public void search(HttpServletRequest request,HttpServletResponse response,OperateEventVo operateEvent){
		 List<OperateEventVo> operateList = this.operateService.queryOperateByCondition(operateEvent);
		 Integer total = this.operateService.queryOperateByConditionTotal(operateEvent);
		 
		 if(!CollectionUtils.isEmpty(operateList)){
			 SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
			 Calendar c = Calendar.getInstance();
			 OperateEventVo newOperateEvent = null ;
			 for(int i = 0 ; i < operateList.size() ; i++){
				 newOperateEvent = operateList.get(i);
				 //装车时间
				 if(newOperateEvent.getLoadDate() != null){
					 long loadDate = newOperateEvent.getLoadDate();
					 if(loadDate != 0){
						 c.setTimeInMillis(loadDate);
						 newOperateEvent.setStrLoadDate(format.format(c.getTime()));
					 }else{
						 newOperateEvent.setStrLoadDate("-");
					 }
				 }
				 //卸车时间
				 if(newOperateEvent.getUploadDate() != null){
					 long upLoadDate = newOperateEvent.getUploadDate() ;
					 if(upLoadDate != 0){
						 c.setTimeInMillis(upLoadDate);
						 newOperateEvent.setStrUploadDate(format.format(c.getTime()));
					 }else{
						 newOperateEvent.setStrUploadDate("-");
					 }
					 
				 }
				 
				 //==============气差的计算============
				 //磅差
				 Long  poundsDiff = newOperateEvent.getPoundsDiff();
				 //卸车净重
				 Float  uploadEmpty = newOperateEvent.getUploadEmpty() ;
				 //装车净重
				 Float  loadEmpty = newOperateEvent.getLoadEmpty() ;
				 
				 //装车净重与卸车净重都有值时
				 if(uploadEmpty != null && uploadEmpty != 0 && loadEmpty != null && loadEmpty != 0){
					 uploadEmpty = uploadEmpty/100 ;
					 loadEmpty = loadEmpty/100 ;
					 Float diffValue = (uploadEmpty - loadEmpty)*1000 ;
					 
					 //如果磅差不等于0
					 if(poundsDiff != null && poundsDiff != 0){
						 poundsDiff = poundsDiff/100 ;
						 if(poundsDiff == 200){
							 if(diffValue > 200 || diffValue < -200){
								 newOperateEvent.setGasDiff(diffValue);
								 newOperateEvent.setFactWeight(uploadEmpty);
							 }else{
								 newOperateEvent.setGasDiff(0f);
								 newOperateEvent.setFactWeight(loadEmpty);
							 }
						 }else if(poundsDiff == 100){
							 if(diffValue > 100 || diffValue < -100){
								 newOperateEvent.setGasDiff(diffValue+0.1f);
								 newOperateEvent.setFactWeight(uploadEmpty+0.1f);
							 }else{
								 newOperateEvent.setGasDiff(0f);
								 newOperateEvent.setFactWeight(loadEmpty);
							 }
						 }else{
							 //气差
							 newOperateEvent.setGasDiff(diffValue);
							 //结算量
							 newOperateEvent.setFactWeight(uploadEmpty);
						 }
					 }else{
						 //气差
						 newOperateEvent.setGasDiff(diffValue);
						 //结算量
						 newOperateEvent.setFactWeight(uploadEmpty);
					 }
					 
					 
					 
					 Long factoryPrice = newOperateEvent.getFactoryPrice() ;
							 
					 if(factoryPrice != null && factoryPrice != 0){
						 //气损
						 newOperateEvent.setGasMiss(newOperateEvent.getGasDiff()/1000*factoryPrice/100);
					 }
					 
					 Long carFee = newOperateEvent.getCarFee() ;
					 //运费 
					 if(carFee != null && carFee != 0){
						 //结算运费 = 结算量 * 运费+气损
						 newOperateEvent.setSettlePrice((carFee/100)*newOperateEvent.getFactoryPrice()+newOperateEvent.getGasMiss());
					 }
					 
				 }
				//==============气差的计算============
				 
			 }
			 
		 }
		 
		 JSONObject json = new JSONObject();
		 json.put("data",operateList);
		 json.put("total",total);
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	

}
