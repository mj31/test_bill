package com.mj.bill.pojo;

public class Company{
 
 
	 /**
     * 描述:主键     
     * 字段: id  INT(10)  
     */	
	private java.lang.Integer id;
 
	 /**
     * 描述:公司地址 ：裝液地 卸液地 承运单位     
     * 字段: company_address  VARCHAR(100)  
     */	
	private java.lang.String companyAddress;
 
	 /**
     * 描述:公司名称     
     * 字段: company_name  VARCHAR(100)  
     */	
	private java.lang.String companyName;
 
	 /**
     * 描述:0代表裝液地 1代表卸液地 2承运单位     
     * 字段: flag  TINYINT(3)  
     */	
	private Integer flag;
 
	 /**
     * 描述:状态 0 正常 1废弃     
     * 字段: status  TINYINT(3)  
     */	
	private Integer status;
	
	/**
	 * 简称
	 */
	private String shortName ;
 

	public Company(){
	}

	public Company(
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
	
    
    
	public void setCompanyAddress(java.lang.String companyAddress) {
		this.companyAddress = companyAddress;
	}
	
	public java.lang.String getCompanyAddress() {
		return this.companyAddress;
	}
	
    
    
	public void setCompanyName(java.lang.String companyName) {
		this.companyName = companyName;
	}
	
	public java.lang.String getCompanyName() {
		return this.companyName;
	}
	
    
    
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
	public Integer getFlag() {
		return this.flag;
	}
	
    
    
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	
}

