package com.mj.bill.pojo;

public class OperateEvent{
 
 
	 /**
     * 描述:主键     
     * 字段: id  INT(10)  
     */	
	private java.lang.Integer id;
 
	 /**
     * 描述:运单编号     
     * 字段: operate_num  INT(10)  
     */	
	private java.lang.Integer operateNum;
 
	 /**
     * 描述:外键  查询出客户和目的地     
     * 字段: customer_id  INT(10)  
     */	
	private java.lang.Integer customerId;
 
	 /**
     * 描述:磅差/100     
     * 字段: pounds_diff  VARCHAR(10)  
     */	
	private java.lang.Long poundsDiff;
 
	 /**
     * 描述:装车时间     
     * 字段: load_date  BIGINT(19)  
     */	
	private java.lang.Long loadDate;
 
	 /**
     * 描述:装车皮重/100     
     * 字段: load_skin  BIGINT(19)  
     */	
	private java.lang.Long loadSkin;
 
	 /**
     * 描述:装车净重/100     
     * 字段: load_empty  BIGINT(19)  
     */	
	private java.lang.Long loadEmpty;
 
	 /**
     * 描述:卸车时间     
     * 字段: upload_date  BIGINT(19)  
     */	
	private java.lang.Long uploadDate;
 
	 /**
     * 描述:卸车毛重/100     
     * 字段: upload_hair  BIGINT(19)  
     */	
	private java.lang.Long uploadHair;
 
	 /**
     * 描述:卸车皮重/100     
     * 字段: update_skin  BIGINT(19)  
     */	
	private java.lang.Long updateSkin;
 
	 /**
     * 描述:卸车净重/100     
     * 字段: upload_empty  BIGINT(19)  
     */	
	private java.lang.Long uploadEmpty;
 
	 /**
     * 描述:承运单位id 取出承运单位     
     * 字段: company_id  INT(10)  
     */	
	private java.lang.Integer companyId;
 
	 /**
     * 描述:是否含税     
     * 字段: isOrNotTax  TINYINT(3)  
     */	
	private Integer isOrNotTax;
 
	 /**
     * 描述:承运车号id     
     * 字段: car_id  INT(10)  
     */	
	private java.lang.Integer carId;
 
	 /**
     * 描述:工厂id 获取工厂信息     
     * 字段: factory_id  INT(10)  
     */	
	private java.lang.Integer factoryId;
 
	 /**
     * 描述:出厂价/100     
     * 字段: factory_price  BIGINT(19)  
     */	
	private java.lang.Long factoryPrice;
 
	 /**
     * 描述:优惠价/100     
     * 字段: activity_price  BIGINT(19)  
     */	
	private java.lang.Long activityPrice;
 
	 /**
     * 描述:运到价/100     
     * 字段: customer_price  BIGINT(19)  
     */	
	private java.lang.Long customerPrice;
 
	 /**
     * 描述:运费/100     
     * 字段: car_fee  BIGINT(19)  
     */	
	private java.lang.Long carFee;
 
	 /**
     * 描述:实际结算量/100     
     * 字段: fact_weight  BIGINT(19)  
     */	
	private java.lang.Long factWeight;
 
	 /**
     * 描述:运作事件备注     
     * 字段: event_remark  VARCHAR(255)  
     */	
	private java.lang.String eventRemark;
 
	 /**
     * 描述:客户备注     
     * 字段: customer_remark  VARCHAR(255)  
     */	
	private java.lang.String customerRemark;
	

	public OperateEvent(){
	}

	public OperateEvent(
		java.lang.Integer id
	){
		this.id = id;
	}

	public void setId(java.lang.Integer id) {
		this.id = id;
	}
	
	public java.lang.Integer getId() {
		return this.id;
	}
	
    
    
	public void setOperateNum(java.lang.Integer operateNum) {
		this.operateNum = operateNum;
	}
	
	public java.lang.Integer getOperateNum() {
		return this.operateNum;
	}
	
    
    
	public void setCustomerId(java.lang.Integer customerId) {
		this.customerId = customerId;
	}
	
	public java.lang.Integer getCustomerId() {
		return this.customerId;
	}
	
    
    
	public java.lang.Long getPoundsDiff() {
		return poundsDiff;
	}

	public void setPoundsDiff(java.lang.Long poundsDiff) {
		this.poundsDiff = poundsDiff;
	}

	public void setLoadDate(java.lang.Long loadDate) {
		this.loadDate = loadDate;
	}
	
	public java.lang.Long getLoadDate() {
		return this.loadDate;
	}
	
    
    
	public void setLoadSkin(java.lang.Long loadSkin) {
		this.loadSkin = loadSkin;
	}
	
	public java.lang.Long getLoadSkin() {
		return this.loadSkin;
	}
	
    
    
	public void setLoadEmpty(java.lang.Long loadEmpty) {
		this.loadEmpty = loadEmpty;
	}
	
	public java.lang.Long getLoadEmpty() {
		return this.loadEmpty;
	}
	
    
    
	public void setUploadDate(java.lang.Long uploadDate) {
		this.uploadDate = uploadDate;
	}
	
	public java.lang.Long getUploadDate() {
		return this.uploadDate;
	}
	
    
    
	public void setUploadHair(java.lang.Long uploadHair) {
		this.uploadHair = uploadHair;
	}
	
	public java.lang.Long getUploadHair() {
		return this.uploadHair;
	}
	
    
    
	public void setUpdateSkin(java.lang.Long updateSkin) {
		this.updateSkin = updateSkin;
	}
	
	public java.lang.Long getUpdateSkin() {
		return this.updateSkin;
	}
	
    
    
	public void setUploadEmpty(java.lang.Long uploadEmpty) {
		this.uploadEmpty = uploadEmpty;
	}
	
	public java.lang.Long getUploadEmpty() {
		return this.uploadEmpty;
	}
	
    
    
	public void setCompanyId(java.lang.Integer companyId) {
		this.companyId = companyId;
	}
	
	public java.lang.Integer getCompanyId() {
		return this.companyId;
	}
	
    
    
	public void setIsOrNotTax(Integer isOrNotTax) {
		this.isOrNotTax = isOrNotTax;
	}
	
	public Integer getIsOrNotTax() {
		return this.isOrNotTax;
	}
	
    
    
	public void setCarId(java.lang.Integer carId) {
		this.carId = carId;
	}
	
	public java.lang.Integer getCarId() {
		return this.carId;
	}
	
    
    
	public void setFactoryId(java.lang.Integer factoryId) {
		this.factoryId = factoryId;
	}
	
	public java.lang.Integer getFactoryId() {
		return this.factoryId;
	}
	
    
    
	public void setFactoryPrice(java.lang.Long factoryPrice) {
		this.factoryPrice = factoryPrice;
	}
	
	public java.lang.Long getFactoryPrice() {
		return this.factoryPrice;
	}
	
    
    
	public void setActivityPrice(java.lang.Long activityPrice) {
		this.activityPrice = activityPrice;
	}
	
	public java.lang.Long getActivityPrice() {
		return this.activityPrice;
	}
	
    
    
	public void setCustomerPrice(java.lang.Long customerPrice) {
		this.customerPrice = customerPrice;
	}
	
	public java.lang.Long getCustomerPrice() {
		return this.customerPrice;
	}
	
    
    
	public void setCarFee(java.lang.Long carFee) {
		this.carFee = carFee;
	}
	
	public java.lang.Long getCarFee() {
		return this.carFee;
	}
	
    
    
	public void setFactWeight(java.lang.Long factWeight) {
		this.factWeight = factWeight;
	}
	
	public java.lang.Long getFactWeight() {
		return this.factWeight;
	}
	
    
    
	public void setEventRemark(java.lang.String eventRemark) {
		this.eventRemark = eventRemark;
	}
	
	public java.lang.String getEventRemark() {
		return this.eventRemark;
	}
	
    
    
	public void setCustomerRemark(java.lang.String customerRemark) {
		this.customerRemark = customerRemark;
	}
	
	public java.lang.String getCustomerRemark() {
		return this.customerRemark;
	}

}

