package com.mj.bill.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.controller.IBankService;
import com.mj.bill.dao.IBankDao;
import com.mj.bill.pojo.BankVo;

@Service("bankService")
public class BankServiceImpl implements IBankService {
	
	@Resource
	private IBankDao bankDao;
	
	
	@Override
	public List<BankVo> queryBankByCondition(BankVo bank) {
		return bankDao.queryBankByCondition(bank);
	}

	@Override
	public Integer queryBankByConditionTotal(BankVo bank) {
		return bankDao.queryBankByConditionTotal(bank);
	}
/*
	@Override
	public void updateCarInfoByIds(List<String> ids) {
		carInfoDao.updateCarInfoByIds(ids);
		
	}

	@Override
	public void updateCarInfoById(String id) {
		carInfoDao.updateCarInfoById(id);
	}

	@Override
	public void saveCarInfo(CarInfo carInfo) {
		carInfoDao.insert(carInfo);
	}

	@Override
	public void updateCarInfo(CarInfo carInfo) {
		carInfoDao.update(carInfo);
	}*/

	@Override
	public void saveBank(BankVo bank) {
		bankDao.insert(bank);
		
	}

	@Override
	public void updateBank(BankVo bank) {
		bankDao.update(bank);
		
	}

} 
