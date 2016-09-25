package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.Company;

public interface ICompanyService {
	
	Company getCompanyById(int companyId);
	
	/**
	 * 公司信息查询
	 * @param user
	 * @return
	 */
	List<Company> queryCompanyByCondition(Company company);

	/**
	 * 查询总行数
	 * @param user
	 * @return
	 */
	Integer queryCompanyByConditionTotal(Company company);

	/**
	 * 批量修改
	 * @param ids
	 */
	void updateCompanyByIds(List<String> ids);
	
	/**
	 * 删除
	 * @param id
	 */
	void updateCompanyById(String id);

	/**
	 * 保存公司信息
	 * @param user
	 */
	void saveCompany(Company company);

	/**
	 * 根据条件查询
	 * @param user
	 * @return
	 */
	List<Company> findPage(Company company);

	/**
	 * 修改
	 * @param user
	 */
	void updateCompany(Company company);

}
