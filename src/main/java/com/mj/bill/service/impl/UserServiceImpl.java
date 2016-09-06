package com.mj.bill.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.dao.IUserDao;
import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {
	
	@Resource
	private IUserDao userDao;

	public User getUserById(int userId) {
		return this.userDao.selectByPrimaryKey(userId);
	}
	
	/*@Override
	public User getUserById(int userId) {
		return this.userDao.selectByPrimaryKey(userId);
	}*/

} 
