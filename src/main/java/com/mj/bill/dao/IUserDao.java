package com.mj.bill.dao;

import java.util.List;
import java.util.Map;

import com.mj.bill.pojo.User;

public interface IUserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

	User queryUserByLoginName(String loginName);

	List<User> queryUserByCondition(User user);

	Integer queryUserByConditionTotal(User user);

	void updateUserByIds(List<String> ids);
	
	void updateUserById(String id);
	
	
	
	
}