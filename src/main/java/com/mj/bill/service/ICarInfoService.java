package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.User;

public interface ICarInfoService {
	
	CarInfo getCarInfoById(int carInfoId);
	
	
	/**
	 * 根据登录名 查询用户信息
	 * @param loginName
	 * @return
	 */
	CarInfo queryCarInfoByLoginName(String loginName);

	/**
	 * 车辆信息查询
	 * @param user
	 * @return
	 */
	List<CarInfo> queryCarInfoByCondition(CarInfo carInfo);
	
	List<CarInfo> queryCarInfoByConditionNew(CarInfo carInfo);
	

	/**
	 * 查询总行数
	 * @param user
	 * @return
	 */
	Integer queryCarInfoByConditionTotal(CarInfo carInfo);

	/**
	 * 批量修改
	 * @param ids
	 */
	void updateCarInfoByIds(List<String> ids);
	
	/**
	 * 删除
	 * @param id
	 */
	void updateCarInfoById(String id);

	/**
	 * 保存车辆信息
	 * @param user
	 */
	void saveCarInfo(CarInfo carInfo);

	/**
	 * 根据条件查询
	 * @param user
	 * @return
	 */
	List<CarInfo> findPage(CarInfo carInfo);

	/**
	 * 修改
	 * @param user
	 */
	void updateCarInfo(CarInfo carInfo);

}
