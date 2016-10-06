package com.mj.bill.dao;

import java.util.List;

import com.mj.bill.pojo.CarInfo;
import com.mj.bill.pojo.OperateEvent;
import com.mj.bill.pojo.OperateEventVo;

public interface IOperateDao {
	
	/**
	 * 根据条件 查询记录
	 * @param operateEvent
	 * @return
	 */
	List<OperateEventVo> queryOperateByCondition(OperateEventVo operateEvent);
	
	/**
	 * 根据条件查询总条数
	 * @param operateEvent
	 * @return
	 */
	Integer queryOperateByConditionTotal(OperateEventVo operateEvent);

	Integer queryOperateNum(String operateNum);
	
	/**
	 * 保存
	 * @param operateEvent
	 * @return
	 */
	int insert(OperateEventVo operateEvent);
	
	/**
	 * 更新
	 * @param operateEvent
	 */
	void update(OperateEventVo operateEvent);
	
	/**
	 * 运作事件更新
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
