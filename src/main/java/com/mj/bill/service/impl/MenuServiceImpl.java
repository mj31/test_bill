package com.mj.bill.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.dao.IMenuDao;
import com.mj.bill.pojo.Menu;
import com.mj.bill.service.IMenuService;

@Service("menuService")
public class MenuServiceImpl implements IMenuService {
	
	@Resource
	private IMenuDao menuDao;

	@Override
	public List<Menu> findPage(Menu menu) {
		return menuDao.findPage(menu);
	}

}
