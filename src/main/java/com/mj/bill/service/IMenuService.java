package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.Menu;

public interface IMenuService {
	List<Menu> findPage(Menu menu);
}
