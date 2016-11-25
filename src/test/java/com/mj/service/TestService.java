package com.mj.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.RedisClient;
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
	
	@Test
	public void test2() {
		List<User> userList = userService.queryUserByCondition(new User()) ;
		JSONObject json = new JSONObject();
		json.put("code", 102);
		json.put("data", userList);
		RedisClient.getInstance().set("rain",json.toJSONString(), 1000);
		String result = RedisClient.getInstance().get("rain");
		System.out.println("返回的结果="+result);
		JSONObject jsonObject = JSONObject.parseObject(result);
		List<User> resultUser = JSONArray.parseArray(jsonObject.get("data").toString(), User.class);
		System.out.println("数组长度==="+resultUser.size());
	}
	
	
	
	public static void main(String[] args) {
		/*Jedis jedis = new Jedis("121.199.20.251",6379);*/
		/*Jedis jedis = new Jedis("redis.t.ziroom.com",6379);
		System.out.println(jedis.info());*/
		//jedis.auth("root123");
		/*Jedis jedis1 = new Jedis("121.199.20.251",6379);
		
		System.out.println(jedis1.info());
		System.out.println(jedis1.get("xiao"));*/
		
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("code", 1001);
		jsonObject.put("message", "操作成功");
		jsonObject.put("data", null);
		
		/*RedisClient.getInstance().set("rain",jsonObject.toJSONString(), 1000);*/
		System.out.println("数量=="+Runtime.getRuntime().availableProcessors());
		System.out.println("结果数据===="+RedisClient.getInstance().get("rain"));
		
	}
}
