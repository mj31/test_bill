package com.mj.bill.dao;

import java.util.List;

import com.mj.bill.pojo.Company;

public interface ICompanyDao {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Company company);

    int insertSelective(Company company);

    Company selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Company company);

    int updateByPrimaryKey(Company company);

    Company queryCompanyByLoginName(String loginName);

	List<Company> queryCompanyByCondition(Company company);

	Integer queryCompanyByConditionTotal(Company company);

	void updateCompanyByIds(List<String> ids);
	
	void updateCompanyById(String id);

	List<Company> findPage(Company company);

	void update(Company company);
}
