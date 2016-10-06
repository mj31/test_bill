package com.mj.bill.service;

import java.util.List;

import com.mj.bill.pojo.OperateEvent;
import com.mj.bill.pojo.OperateEventVo;

public interface IOperateService {
	
	/**
	 * 根据条件查询记录
	 * @param operateEvent
	 * @return
	 */
	List<OperateEventVo> queryOperateByCondition(OperateEventVo operateEvent);
	
	/**
	 * 根据条件查询总记录数
	 * @param operateEvent
	 * @return
	 */
	Integer queryOperateByConditionTotal(OperateEventVo operateEvent);
	
	/**
	 * 运单编号的查询
	 */
	Integer queryOperateNum();
	
	/**
	 * 添加运作事件
	 * @param operateEvent
	 */
	void saveOperateEvent(OperateEventVo operateEvent);
	
	/**
	 * 更新运作事件
	 * @param operateEvent
	 */
	void updateOperateEvent(OperateEventVo operateEvent);
	
	/**
	 * 运作详情更新
	 * @param operateEvent
	 */
	void updateOperateByEvent(OperateEventVo operateEvent);
	
	/**
	 * 客户更新
	 * @param operateEvent
	 */
	void updateOperateByCustomer(OperateEventVo operateEvent);
	
	/**
	 * 根据id查询
	 * @param id
	 * @return 
	 */
	OperateEventVo getById(Integer id);
	
	/**
	 * 运费结算更新
	 * @param operateEvent
	 */
	void updateBySettle(OperateEventVo operateEvent);
	
	/**
	 * 删除
	 * @param operateEvent
	 */
	void delete(OperateEventVo operateEvent);

}
