package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.Bank;
import com.mj.bill.pojo.BankVo;

public interface IBankService {
	
	/**
	 * 根据条件查询
	 * @param bank
	 * @return
	 */
	List<BankVo> queryBankByCondition(BankVo bank);
	
	/**
	 * 根据条件求和
	 * @param bank
	 * @return
	 */
	Integer queryBankByConditionTotal(BankVo bank);
	
	/**
	 * 保存
	 * @param bank
	 */
	void saveBank(BankVo bank);
	
	/**
	 * 更新
	 * @param bank
	 */
	void updateBank(BankVo bank);
	
	BankVo getByOperateId(Long operateId) ;
	
	/**
	 * 删除
	 * @param string
	 */
	void deleteById(String string);
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	BankVo getById(Integer id);

}
