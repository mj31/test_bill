package com.mj.bill.service;

import com.mj.bill.pojo.User;

public interface IUserService {
	
	User getUserById(int userId);
	
	
	/**
	 * 根据登录名 查询用户信息
	 * @param loginName
	 * @return
	 */
	User queryUserByLoginName(String loginName);
}
