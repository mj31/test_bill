package com.mj.bill.dao;

import java.util.List;

import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.User;

public interface ICarInfoDao {
    int deleteByPrimaryKey(Integer id);

    int insert(CarInfo record);

    int insertSelective(CarInfo record);

    CarInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CarInfo record);

    int updateByPrimaryKey(User record);

    CarInfo queryCarInfoByLoginName(String loginName);

	List<CarInfo> queryCarInfoByCondition(CarInfo carInfo);

	Integer queryCarInfoByConditionTotal(CarInfo carInfo);

	void updateCarInfoByIds(List<String> ids);
	
	void updateCarInfoById(String id);

	List<CarInfo> findPage(CarInfo carInfo);

	void update(CarInfo carInfo);
	
	
	
	
}