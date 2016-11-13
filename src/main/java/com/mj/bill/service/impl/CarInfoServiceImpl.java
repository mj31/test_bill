package com.mj.bill.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.dao.ICarInfoDao;
import com.mj.bill.dao.IUserDao;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.User;
import com.mj.bill.service.ICarInfoService;

@Service("carInfoService")
public class CarInfoServiceImpl implements ICarInfoService {
	
	@Resource
	private ICarInfoDao carInfoDao;
	
	
	@Override
	public CarInfo getCarInfoById(int userId) {
		return this.carInfoDao.selectByPrimaryKey(userId);
	}

	@Override
	public CarInfo queryCarInfoByLoginName(String loginName) {
		return carInfoDao.queryCarInfoByLoginName(loginName);
	}

	@Override
	public List<CarInfo> queryCarInfoByCondition(CarInfo carInfo) {
		return carInfoDao.queryCarInfoByCondition(carInfo);
	}
	
	@Override
	public List<CarInfo> queryCarInfoByConditionNew(CarInfo carInfo) {
		return carInfoDao.queryCarInfoByConditionNew(carInfo);
	}
	

	@Override
	public Integer queryCarInfoByConditionTotal(CarInfo carInfo) {
		return carInfoDao.queryCarInfoByConditionTotal(carInfo);
	}

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
	public List<CarInfo> findPage(CarInfo carInfo) {
		List<CarInfo> list = carInfoDao.findPage(carInfo);
		return list;
	}

	@Override
	public void updateCarInfo(CarInfo carInfo) {
		carInfoDao.update(carInfo);
	}

} 
