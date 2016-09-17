package com.mj.bill.dao;

import java.util.List;

import com.mj.bill.pojo.Bank;
import com.mj.bill.pojo.BankVo;

public interface IBankDao {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Bank bank);

    int insertSelective(Bank bank);

    Bank selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Bank bank);

    int updateByPrimaryKey(Bank bank);


	List<BankVo> queryBankByCondition(BankVo bank);

	Integer queryBankByConditionTotal(BankVo bank);

	void updateBankByIds(List<String> ids);
	
	void updateBankById(String id);

	List<Bank> findPage(Bank bank);

	void update(Bank bank);
	
	BankVo getByOperateId(Long operateId) ;
}
