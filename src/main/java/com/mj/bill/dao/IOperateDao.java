package com.mj.bill.dao;

import java.util.List;

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

}
