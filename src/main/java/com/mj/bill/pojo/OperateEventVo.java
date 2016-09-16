package com.mj.bill.pojo;

public class OperateEventVo extends OperateEvent {
	
	/**
	 * 客户简称
	 */
	private String customerShortName ;
	
	/**
	 * 客户地区
	 */
	private String customerAddress ;
	
	/**
	 * 承运车号
	 */
	private String carNum ;
	
	/**
	 * 承运单位简称
	 */
	private String compangShortName ;
	
	/**
	 * 出厂地简称
	 */
	private String factoryShortName ;
	
	/**
	 * 装车时间
	 */
	private String strLoadDate ;
	
	/**
	 * 卸车时间
	 */
	private String strUploadDate ;

	public String getCustomerShortName() {
		return customerShortName;
	}

	public void setCustomerShortName(String customerShortName) {
		this.customerShortName = customerShortName;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getCarNum() {
		return carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	public String getCompangShortName() {
		return compangShortName;
	}

	public void setCompangShortName(String compangShortName) {
		this.compangShortName = compangShortName;
	}

	public String getFactoryShortName() {
		return factoryShortName;
	}

	public void setFactoryShortName(String factoryShortName) {
		this.factoryShortName = factoryShortName;
	}

	public String getStrLoadDate() {
		return strLoadDate;
	}

	public void setStrLoadDate(String strLoadDate) {
		this.strLoadDate = strLoadDate;
	}

	public String getStrUploadDate() {
		return strUploadDate;
	}

	public void setStrUploadDate(String strUploadDate) {
		this.strUploadDate = strUploadDate;
	}
	
}
