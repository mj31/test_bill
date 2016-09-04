/*
* BillUser.java 2012-09-03
* Copyright  © 2001-2012 必联网
* 京ICP备09004729号京公网安备110108008196号
*/
package com.mj.user.model;


public class BillUser {
 
	 /**
     * 描述:id     
     * 字段: id  BIGINT(19)  
     */	
	private java.lang.Integer id;
 
	 /**
     * 描述:登录名     
     * 字段: login_name  VARCHAR(100)  
     */	
	private java.lang.String loginName;
 
	 /**
     * 描述:密码     
     * 字段: password  VARCHAR(100)  
     */	
	private java.lang.String password;
 
	 /**
     * 描述:昵称     
     * 字段: name  VARCHAR(100)  
     */	
	private java.lang.String name;
 
	 /**
     * 描述:是否有效 0：有效  1无效     
     * 字段: is_delete  TINYINT(3)  
     */	
	private Integer isDelete;
 
	 /**
     * 描述:手机号     
     * 字段: phone  VARCHAR(20)  
     */	
	private java.lang.String phone;
 
    
	public java.lang.Integer getId() {
		return id;
	}

	public void setId(java.lang.Integer id) {
		this.id = id;
	}

	public void setLoginName(java.lang.String loginName) {
		this.loginName = loginName;
	}
	
	public java.lang.String getLoginName() {
		return this.loginName;
	}
	
    
    
	public void setPassword(java.lang.String password) {
		this.password = password;
	}
	
	public java.lang.String getPassword() {
		return this.password;
	}
	
    
    
	public void setName(java.lang.String name) {
		this.name = name;
	}
	
	public java.lang.String getName() {
		return this.name;
	}
	
    
    
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	
	public Integer getIsDelete() {
		return this.isDelete;
	}
	
    
    
	public void setPhone(java.lang.String phone) {
		this.phone = phone;
	}
	
	public java.lang.String getPhone() {
		return this.phone;
	}
 
}

