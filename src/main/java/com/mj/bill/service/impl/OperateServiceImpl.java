package com.mj.bill.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.dao.IOperateDao;
import com.mj.bill.pojo.OperateEventVo;
import com.mj.bill.service.IOperateService;

@Service("operateService")
public class OperateServiceImpl implements IOperateService {
	
	@Resource
	private IOperateDao operateDao;
	
	@Override
	public List<OperateEventVo> queryOperateByCondition(OperateEventVo operateEvent) {
		return operateDao.queryOperateByCondition(operateEvent);
	}

	@Override
	public Integer queryOperateByConditionTotal(OperateEventVo operateEvent) {
		return operateDao.queryOperateByConditionTotal(operateEvent);
	}

	@Override
	public Integer queryOperateNum() {
		Date date = new Date();  
        SimpleDateFormat format = new SimpleDateFormat("yyMMdd");  
        String operateNum = format.format(date);
		Integer num = operateDao.queryOperateNum(operateNum);
		if(num == null){
			return Integer.parseInt(operateNum+"001") ;
		}else{
			return num+1;
		}
	}

	@Override
	public void saveOperateEvent(OperateEventVo operateEvent) {
		operateDao.insert(operateEvent);
		
	}
	
	@Override
	public void updateOperateEvent(OperateEventVo operateEvent) {
		operateDao.update(operateEvent);
		
	}
	
	


} 
