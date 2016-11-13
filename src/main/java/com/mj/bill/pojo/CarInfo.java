package com.mj.bill.pojo;

public class CarInfo{
 
 
	 /**
     * 描述:主键     
     * 字段: id  INT(10)  
     */	
	private java.lang.Integer id;
 
	 /**
     * 描述:主车号     
     * 字段: header_number  VARCHAR(10)  
     */	
	private java.lang.String headerNumber;
 
	 /**
     * 描述:挂车号     
     * 字段: trailer_number  VARCHAR(10)  
     */	
	private java.lang.String trailerNumber;
 
	 /**
     * 描述:车类型 0代表气头 1代表油头     
     * 字段: car_type  TINYINT UNSIGNED(3)  
     */	
	private Integer carType;
 
	 /**
     * 描述:行车证荷载量 单位t(吨)/100     
     * 字段: load  BIGINT(19)  
     */	
	private java.lang.Long weight;
 
	 /**
     * 描述:槽车容量 单位m3/100     
     * 字段: capacity  BIGINT(19)  
     */	
	private java.lang.Long capacity;
 
	 /**
     * 描述:随车电话     
     * 字段: car_phone  VARCHAR(20)  
     */	
	private java.lang.String carPhone;
 
	 /**
     * 描述:驾驶员名字     
     * 字段: driver_name  VARCHAR(20)  
     */	
	private java.lang.String driverName;
 
	 /**
     * 描述:驾驶员电话     
     * 字段: driver_phone  VARCHAR(20)  
     */	
	private java.lang.String driverPhone;
 
	 /**
     * 描述:押运员名字     
     * 字段: follower_name  VARCHAR(20)  
     */	
	private java.lang.String followerName;
 
	 /**
     * 描述:押运员电话     
     * 字段: follower_phone  VARCHAR(20)  
     */	
	private java.lang.String followerPhone;
 
	 /**
     * 描述:备用电话     
     * 字段: backup_phone  VARCHAR(20)  
     */	
	private java.lang.String backupPhone;
 
	 /**
     * 描述:车辆信息到期时间      
     * 字段: expired_date  DATETIME(19)  
     */	
	private Long expiredDate;
	
	private String strExpiredDate ;
	
	 /**
     * 描述:备注     
     * 字段: remark  VARCHAR(255)  
     */	
	private java.lang.String remark;
	
	private Integer status ;
	
	private Integer  pageSize ;
		
	private Integer beginRow ;
 

	public CarInfo(){
	}

	public CarInfo(
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
	
    
    
	public void setHeaderNumber(java.lang.String headerNumber) {
		this.headerNumber = headerNumber;
	}
	
	public java.lang.String getHeaderNumber() {
		return this.headerNumber;
	}
	
    
    
	public void setTrailerNumber(java.lang.String trailerNumber) {
		this.trailerNumber = trailerNumber;
	}
	
	public java.lang.String getTrailerNumber() {
		return this.trailerNumber;
	}
	
    
    
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	
	public Integer getCarType() {
		return this.carType;
	}
	
    
	public void setCapacity(java.lang.Long capacity) {
		this.capacity = capacity;
	}
	
	public java.lang.Long getCapacity() {
		return this.capacity;
	}
	
    
    
	public void setCarPhone(java.lang.String carPhone) {
		this.carPhone = carPhone;
	}
	
	public java.lang.String getCarPhone() {
		return this.carPhone;
	}
	
    
    
	public void setDriverName(java.lang.String driverName) {
		this.driverName = driverName;
	}
	
	public java.lang.String getDriverName() {
		return this.driverName;
	}
	
    
    
	public void setDriverPhone(java.lang.String driverPhone) {
		this.driverPhone = driverPhone;
	}
	
	public java.lang.String getDriverPhone() {
		return this.driverPhone;
	}
	
    
    
	public void setFollowerName(java.lang.String followerName) {
		this.followerName = followerName;
	}
	
	public java.lang.String getFollowerName() {
		return this.followerName;
	}
	
    
    
	public void setFollowerPhone(java.lang.String followerPhone) {
		this.followerPhone = followerPhone;
	}
	
	public java.lang.String getFollowerPhone() {
		return this.followerPhone;
	}
	
    
    
	public void setBackupPhone(java.lang.String backupPhone) {
		this.backupPhone = backupPhone;
	}
	
	public java.lang.String getBackupPhone() {
		return this.backupPhone;
	}

	
	public Long getExpiredDate() {
		return expiredDate;
	}

	public void setExpiredDate(Long expiredDate) {
		this.expiredDate = expiredDate;
	}

	public void setRemark(java.lang.String remark) {
		this.remark = remark;
	}
	
	public java.lang.String getRemark() {
		return this.remark;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public java.lang.Long getWeight() {
		return weight;
	}

	public void setWeight(java.lang.Long weight) {
		this.weight = weight;
	}

	public String getStrExpiredDate() {
		return strExpiredDate;
	}

	public void setStrExpiredDate(String strExpiredDate) {
		this.strExpiredDate = strExpiredDate;
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

