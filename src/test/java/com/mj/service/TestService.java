package com.mj.service;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@RunWith(SpringJUnit4ClassRunner.class)		//表示继承了SpringJUnit4ClassRunner类
@WebAppConfiguration()
@ContextConfiguration(locations = {"classpath:spring/spring-mybatis.xml"})
public class TestService {
	@SuppressWarnings("unused")
	private static Logger LOGGER = Logger.getLogger(TestService.class);
	
	@Autowired
	private IUserService userService ;

	@Test
	public void test1() {
		User user = userService.queryUserByLoginName("mj") ;
		System.out.println(user.getLoginName());
	}
}
