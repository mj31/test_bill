package com.mj.bill.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mj.bill.dao.ICompanyDao;
import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.Company;
import com.mj.bill.service.ICompanyService;

@Service("companyService")
public class CompanyServiceImpl implements ICompanyService {
	
	@Resource
	private ICompanyDao companyDao;
	
	
	@Override
	public void updateCompanyByIds(List<String> ids) {
		companyDao.updateCompanyByIds(ids);
		
	}

	@Override
	public void updateCompanyById(String id) {
		companyDao.updateCompanyById(id);
	}

	@Override
	public void saveCompany(Company company) {
		companyDao.insert(company);
	}

	@Override
	public List<Company> findPage(Company company) {
		List<Company> list = companyDao.findPage(company);
		return list;
	}

	@Override
	public void updateCompany(Company company) {
		companyDao.update(company);
	}

	@Override
	public Company getCompanyById(int companyId) {
		return companyDao.selectByPrimaryKey(companyId);
	}

	@Override
	public List<Company> queryCompanyByCondition(Company company) {
		return companyDao.queryCompanyByCondition(company);
	}

	@Override
	public Integer queryCompanyByConditionTotal(Company company) {
		return companyDao.queryCompanyByConditionTotal(company);
	}

} 
