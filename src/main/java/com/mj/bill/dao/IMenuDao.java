package com.mj.bill.dao;

import java.util.List;

import com.mj.bill.pojo.Menu;

public interface IMenuDao {
	
	List<Menu> findPage(Menu menu);
}
