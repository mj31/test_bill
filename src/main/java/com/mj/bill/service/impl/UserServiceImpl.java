package com.mj.bill.service.impl;

import java.util.List;

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

	@Override
	public User queryUserByLoginName(String loginName) {
		return userDao.queryUserByLoginName(loginName);
	}

	@Override
	public List<User> queryUserByCondition(User user) {
		return userDao.queryUserByCondition(user);
	}

	@Override
	public Integer queryUserByConditionTotal(User user) {
		return userDao.queryUserByConditionTotal(user);
	}

	@Override
	public void updateUserByIds(List<String> ids) {
		userDao.updateUserByIds(ids);
		
	}

	@Override
	public void updateUserById(String id) {
		userDao.updateUserById(id);
	}


} 
