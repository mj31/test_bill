package com.mj.bill.pojo;

public class Menu{
 
 
	 /**
     * 描述:id     
     * 字段: id  BIGINT(19)  
     */	
	private java.lang.Long id;
 
	 /**
     * 描述:路径     
     * 字段: menu_url  VARCHAR(100)  
     */	
	private java.lang.String menuUrl;
 
	 /**
     * 描述:菜单名称     
     * 字段: menu_name  VARCHAR(100)  
     */	
	private java.lang.String menuName;
 
	 /**
     * 描述:状态0可用 1无用     
     * 字段: status  TINYINT(3)  
     */	
	private Integer status;
 

	public Menu(){
	}

	public Menu(
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
	
    
    
	public void setMenuUrl(java.lang.String menuUrl) {
		this.menuUrl = menuUrl;
	}
	
	public java.lang.String getMenuUrl() {
		return this.menuUrl;
	}
	
    
    
	public void setMenuName(java.lang.String menuName) {
		this.menuName = menuName;
	}
	
	public java.lang.String getMenuName() {
		return this.menuName;
	}
	
    
    
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getStatus() {
		return this.status;
	}
	
    
    
 
}

