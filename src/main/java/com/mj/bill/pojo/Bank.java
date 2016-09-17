package com.mj.bill.pojo;

public class Bank{
 
 
	 /**
     * 描述:主键id     
     * 字段: id  BIGINT(19)  
     */	
	private java.lang.Long id;
 
	 /**
     * 描述:交易流水号     
     * 字段: serial_number  BIGINT(19)  
     */	
	private java.lang.Long serialNumber;
 
	 /**
     * 描述:转账时间     
     * 字段: exchange_date  BIGINT(19)  
     */	
	private java.lang.Long exchangeDate;
 
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
     * 描述:对方账号id     
     * 字段: his_account_id  BIGINT(19)  
     */	
	private java.lang.Long hisAccountId;
 
	 /**
     * 描述:交易状态0代表收入 1代表支出     
     * 字段: exchange_flag  TINYINT(3)  
     */	
	private Integer exchangeFlag;
 
	 /**
     * 描述:业务类型     
     * 字段: service_type  VARCHAR(100)  
     */	
	private java.lang.String serviceType;
 
	 /**
     * 描述:备注     
     * 字段: remark  VARCHAR(255)  
     */	
	private java.lang.String remark;
 
	 /**
     * 描述:状态 0 启用 1 禁用     
     * 字段: status  TINYINT(3)  
     */	
	private Integer status;
 
	 /**
     * 描述:创建人id     
     * 字段: create_user_id  BIGINT(19)  
     */	
	private java.lang.Long createUserId;
 
	 /**
     * 描述:创建时间     
     * 字段: create_date  BIGINT(19)  
     */	
	private java.lang.Long createDate;
 
	 /**
     * 描述:创建人名字     
     * 字段: create_user_name  VARCHAR(100)  
     */	
	private java.lang.String createUserName;
 
	 /**
     * 描述:更新人id     
     * 字段: update_user_id  BIGINT(19)  
     */	
	private java.lang.Long updateUserId;
 
	 /**
     * 描述:更新人名称     
     * 字段: update_user_name  VARCHAR(100)  
     */	
	private java.lang.String updateUserName;
 
	 /**
     * 描述:更新时间     
     * 字段: update_date  BIGINT(19)  
     */	
	private java.lang.Long updateDate;
 

	public Bank(){
	}

	public Bank(
		java.lang.Long id
	){
		this.id = id;
	}

	public void setId(java.lang.Long id) {
		this.id = id;
	}
	
	public java.lang.Long getId() {
		return this.id;
	}
	
    
    
	public void setSerialNumber(java.lang.Long serialNumber) {
		this.serialNumber = serialNumber;
	}
	
	public java.lang.Long getSerialNumber() {
		return this.serialNumber;
	}
	
    
    
	public void setExchangeDate(java.lang.Long exchangeDate) {
		this.exchangeDate = exchangeDate;
	}
	
	public java.lang.Long getExchangeDate() {
		return this.exchangeDate;
	}
	
    
    
	public void setExchangeMoney(java.lang.Long exchangeMoney) {
		this.exchangeMoney = exchangeMoney;
	}
	
	public java.lang.Long getExchangeMoney() {
		return this.exchangeMoney;
	}
	
    
    
	public void setHisAccount(java.lang.Long hisAccount) {
		this.hisAccount = hisAccount;
	}
	
	public java.lang.Long getHisAccount() {
		return this.hisAccount;
	}
	
    
    
	public void setHisAccountName(java.lang.String hisAccountName) {
		this.hisAccountName = hisAccountName;
	}
	
	public java.lang.String getHisAccountName() {
		return this.hisAccountName;
	}
	
    
    
	public void setHisAccountId(java.lang.Long hisAccountId) {
		this.hisAccountId = hisAccountId;
	}
	
	public java.lang.Long getHisAccountId() {
		return this.hisAccountId;
	}
	
    
    
	public void setExchangeFlag(Integer exchangeFlag) {
		this.exchangeFlag = exchangeFlag;
	}
	
	public Integer getExchangeFlag() {
		return this.exchangeFlag;
	}
	
    
    
	public void setServiceType(java.lang.String serviceType) {
		this.serviceType = serviceType;
	}
	
	public java.lang.String getServiceType() {
		return this.serviceType;
	}
	
    
    
	public void setRemark(java.lang.String remark) {
		this.remark = remark;
	}
	
	public java.lang.String getRemark() {
		return this.remark;
	}
	
    
    
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getStatus() {
		return this.status;
	}
	
    
    
	public void setCreateUserId(java.lang.Long createUserId) {
		this.createUserId = createUserId;
	}
	
	public java.lang.Long getCreateUserId() {
		return this.createUserId;
	}
	
    
    
	public void setCreateDate(java.lang.Long createDate) {
		this.createDate = createDate;
	}
	
	public java.lang.Long getCreateDate() {
		return this.createDate;
	}
	
    
    
	public void setCreateUserName(java.lang.String createUserName) {
		this.createUserName = createUserName;
	}
	
	public java.lang.String getCreateUserName() {
		return this.createUserName;
	}
	
    
    
	public void setUpdateUserId(java.lang.Long updateUserId) {
		this.updateUserId = updateUserId;
	}
	
	public java.lang.Long getUpdateUserId() {
		return this.updateUserId;
	}
	
    
    
	public void setUpdateUserName(java.lang.String updateUserName) {
		this.updateUserName = updateUserName;
	}
	
	public java.lang.String getUpdateUserName() {
		return this.updateUserName;
	}
	
    
    
	public void setUpdateDate(java.lang.Long updateDate) {
		this.updateDate = updateDate;
	}
	
	public java.lang.Long getUpdateDate() {
		return this.updateDate;
	}
	
    
    
 
}

