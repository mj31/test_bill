package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.User;

public interface IUserService {
	
	User getUserById(int userId);
	
	
	/**
	 * 根据登录名 查询用户信息
	 * @param loginName
	 * @return
	 */
	User queryUserByLoginName(String loginName);

	/**
	 * 用户信息查询
	 * @param user
	 * @return
	 */
	List<User> queryUserByCondition(User user);

	/**
	 * 查询总行数
	 * @param user
	 * @return
	 */
	Integer queryUserByConditionTotal(User user);

	/**
	 * 批量修改
	 * @param ids
	 */
	void updateUserByIds(List<String> ids);
	
	/**
	 * 删除
	 * @param id
	 */
	void updateUserById(String id);

	/**
	 * 保存用户
	 * @param user
	 */
	void saveUser(User user);

	/**
	 * 根据条件查询
	 * @param user
	 * @return
	 */
	List<User> findPage(User user);

	/**
	 * 修改
	 * @param user
	 */
	void updateUser(User user);

}
