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
	
	/**
     * 描述:转账时间     
     * 字段: exchange_date  BIGINT(19)  
     */	
	private java.lang.String strExchangeDate;
 
	 /**
     * 描述:交易金额     
     * 字段: exchange_money  BIGINT(19)  
     */	
	private java.lang.Long exchangeMoney;
 
	 /**
     * 描述:对方账号     
     * 字段: his_account  BIGINT(19)  
     */	
	private java.lang.Long hisAccount;
 
	 /**
     * 描述:对方账号名称     
     * 字段: his_account_name  VARCHAR(100)  
     */	
	private java.lang.String hisAccountName;
	
	/**
	 * 结算气费
	 */
	private Float settlePrice ;
	
	/**
	 * 气差
	 */
	private Float gasDiff ;
	
	/**
	 * 气损
	 */
	private Float gasMiss ;
	
	
	private String strLoadBeginDate ;
	
	private String strLoadEndDate ;
	
	private Long  loadBeiginDate ;
	
	private Long loadEndDate ;
	
	private Integer  pageSize ;
	
	private Integer beginRow ;
	
	

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
	

	public java.lang.String getStrExchangeDate() {
		return strExchangeDate;
	}

	public void setStrExchangeDate(java.lang.String strExchangeDate) {
		this.strExchangeDate = strExchangeDate;
	}

	public java.lang.Long getExchangeMoney() {
		return exchangeMoney;
	}

	public void setExchangeMoney(java.lang.Long exchangeMoney) {
		this.exchangeMoney = exchangeMoney;
	}

	public java.lang.Long getHisAccount() {
		return hisAccount;
	}

	public void setHisAccount(java.lang.Long hisAccount) {
		this.hisAccount = hisAccount;
	}

	public java.lang.String getHisAccountName() {
		return hisAccountName;
	}

	public void setHisAccountName(java.lang.String hisAccountName) {
		this.hisAccountName = hisAccountName;
	}

    
	public Float getGasDiff() {
		return gasDiff;
	}

	public void setGasDiff(Float gasDiff) {
		this.gasDiff = gasDiff;
	}


	public String getStrLoadBeginDate() {
		return strLoadBeginDate;
	}

	public void setStrLoadBeginDate(String strLoadBeginDate) {
		this.strLoadBeginDate = strLoadBeginDate;
	}

	public String getStrLoadEndDate() {
		return strLoadEndDate;
	}

	public void setStrLoadEndDate(String strLoadEndDate) {
		this.strLoadEndDate = strLoadEndDate;
	}

	public Long getLoadBeiginDate() {
		return loadBeiginDate;
	}

	public void setLoadBeiginDate(Long loadBeiginDate) {
		this.loadBeiginDate = loadBeiginDate;
	}

	public Long getLoadEndDate() {
		return loadEndDate;
	}

	public void setLoadEndDate(Long loadEndDate) {
		this.loadEndDate = loadEndDate;
	}

	public Float getGasMiss() {
		return gasMiss;
	}

	public void setGasMiss(Float gasMiss) {
		this.gasMiss = gasMiss;
	}

	public Float getSettlePrice() {
		return settlePrice;
	}

	public void setSettlePrice(Float settlePrice) {
		this.settlePrice = settlePrice;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getBeginRow() {
		return beginRow;
	}

	public void setBeginRow(Integer beginRow) {
		this.beginRow = beginRow;
	}
	
	
}
