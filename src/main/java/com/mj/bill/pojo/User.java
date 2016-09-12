package com.mj.bill.pojo;

import java.util.ArrayList;
import java.util.List;

public class User{
 
 
	 /**
     * 描述:id     
     * 字段: id  INT(10)  
     */	
	private java.lang.Integer id;
 
	 /**
     * 描述:登录名     
     * 字段: login_name  VARCHAR(40)  
     */	
	private java.lang.String loginName;
 
	 /**
     * 描述:password     
     * 字段: password  VARCHAR(50)  
     */	
	private java.lang.String password;
 
	 /**
     * 描述:userName     
     * 字段: user_name  VARCHAR(100)  
     */	
	private java.lang.String userName;
 
	 /**
     * 描述:手机号     
     * 字段: mobile  VARCHAR(20)  
     */	
	private java.lang.String mobile;
 
	 /**
     * 描述:邮箱     
     * 字段: email  VARCHAR(50)  
     */	
	private java.lang.String email;
 
	 /**
     * 描述:家庭住址     
     * 字段: address  VARCHAR(200)  
     */	
	private java.lang.String address;
 
	 /**
     * 描述:职位     
     * 字段: position  VARCHAR(200)  
     */	
	private java.lang.String position;
 
	 /**
     * 描述:工号     
     * 字段: work_code  VARCHAR(255)  
     */	
	private java.lang.String workCode;
 
	 /**
     * 描述:age     
     * 字段: age  INT(10)  
     */	
	private java.lang.Integer age;
 
	 /**
     * 描述:状态 0 可用 1 禁用     
     * 字段: status  TINYINT UNSIGNED(3)  
     */	
	private Integer status;
 
	 /**
     * 描述:部门     
     * 字段: department  VARCHAR(100)  
     */	
	private java.lang.String department;
	
	private List<String> ids = new ArrayList<String>();
 

	public User(){
	}

	public User(
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
	
    
    
	public void setUserName(java.lang.String userName) {
		this.userName = userName;
	}
	
	public java.lang.String getUserName() {
		return this.userName;
	}
	
    
    
	public void setMobile(java.lang.String mobile) {
		this.mobile = mobile;
	}
	
	public java.lang.String getMobile() {
		return this.mobile;
	}
	
    
    
	public void setEmail(java.lang.String email) {
		this.email = email;
	}
	
	public java.lang.String getEmail() {
		return this.email;
	}
	
    
    
	public void setAddress(java.lang.String address) {
		this.address = address;
	}
	
	public java.lang.String getAddress() {
		return this.address;
	}
	
    
    
	public void setPosition(java.lang.String position) {
		this.position = position;
	}
	
	public java.lang.String getPosition() {
		return this.position;
	}
	
    
    
	public void setWorkCode(java.lang.String workCode) {
		this.workCode = workCode;
	}
	
	public java.lang.String getWorkCode() {
		return this.workCode;
	}
	
    
    
	public void setAge(java.lang.Integer age) {
		this.age = age;
	}
	
	public java.lang.Integer getAge() {
		return this.age;
	}
	
    
    
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getStatus() {
		return this.status;
	}
	
    
    
	public void setDepartment(java.lang.String department) {
		this.department = department;
	}
	
	public java.lang.String getDepartment() {
		return this.department;
	}

	public List<String> getIds() {
		return ids;
	}

	public void setIds(List<String> ids) {
		this.ids = ids;
	}

	
}

