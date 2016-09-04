package com.mj.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import  com.mj.user.dao. BillUserDao;
import  com.mj.user.service. BillUserService;

@Service
public class BillUserServiceImpl implements  BillUserService{
	
	@Autowired
	private BillUserDao billUserDao;
	

}
