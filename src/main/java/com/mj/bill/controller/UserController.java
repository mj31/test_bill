package com.mj.bill.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.MD5Util;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.Menu;
import com.mj.bill.pojo.User;
import com.mj.bill.service.IMenuService;
import com.mj.bill.service.IUserService;

@Controller
public class UserController {
	
	private final static Logger logger = LoggerFactory.getLogger(UserController.class); 
	
	@Resource
	private IUserService userService;
	
	@Resource
	private IMenuService menuService;
	
	
	
	@RequestMapping("/login")
	public String index(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		model.addAttribute("user", user);
		return "login/login";
	}
	
	
	@RequestMapping("/loginOut")
	public String toIndex(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		return "login/login";
	}
	
	
	@RequestMapping("/loginin")
	public String login(HttpServletRequest request,HttpServletResponse response,Model model,User user)throws Exception{
		String  file = "login/index" ;
		HttpSession session = request.getSession();
		User queryUser = this.userService.queryUserByLoginName(user.getLoginName());
		
		if(queryUser != null){
			String password = queryUser.getPassword();
			//检验密码是否正确
			if(MD5Util.MD5Encode(user.getPassword(), "utf-8").equals(password)){
				session.setAttribute("user", queryUser);
				model.addAttribute("user", queryUser);
					List<Menu> menuList = new ArrayList<Menu>();
					String menuIds = queryUser.getMenuIds() ;
					if(!StringUtils.isEmpty(menuIds)){
						String ids[] = menuIds.split(",");
						Menu menu = null ;
						for(int i = 0 ; i < ids.length ;i++ ){
							menu = new Menu();
							menu.setId(Long.parseLong(ids[i]));
							menu.setStatus(0);
							List<Menu> newMenuList = menuService.findPage(menu) ;
							if(!CollectionUtils.isEmpty(newMenuList)){
								menuList.add(newMenuList.get(0)) ;
							}
						}
					}
				model.addAttribute("menuList", menuList);
				session.setAttribute("menuList", menuList);
				return file ;
			}else{
				response.sendRedirect(request.getContextPath()
						+ "/login.do?flag="+false);
				return null;
			}
		}else{
			response.sendRedirect(request.getContextPath()
					+ "/login.do?flag="+false);
			return null;
		}
		
	}
	
	/**
	 * 用户列表页
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/list")
	public String toIndex(HttpServletRequest request,Model model,User newUser){
		HttpSession session = request.getSession();
		model.addAttribute("newUser", newUser);
		//目的是让top显示用户信息
		User user = (User)session.getAttribute("user");
		model.addAttribute("user", user);
		return "user/user_index";
	}
	
	/**
	 * 用户列表页查询
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/search")
	@ResponseBody
	public void search(HttpServletRequest request,HttpServletResponse response,User user){
		 List<User> userList = this.userService.queryUserByCondition(user);
		 Integer total = this.userService.queryUserByConditionTotal(user);
		 JSONObject json = new JSONObject();
		 json.put("data",userList);
		 /*json.put("loginName",queryUser.getLoginName());
		 json.put("userName",queryUser.getUserName());*/
		 json.put("total",total);
		 json.put("page",1);
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/delete")
	@ResponseBody
	public void delete(HttpServletRequest request,HttpServletResponse response,String ids){
		JSONObject json = new JSONObject();
		try {
			if(ids != null){
				if(ids.contains(",")){
					String[] id =  ids.split(",") ;
					for(int i = 0 ; i < id.length ;i++){
						this.userService.updateUserById(id[i]);
					}
				}else{
					this.userService.updateUserById(ids);
				}
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("修改用户信息==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 保存用户
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/save")
	@ResponseBody
	public void save(HttpServletRequest request,HttpServletResponse response,User user){
		JSONObject json = new JSONObject();
		try {
			
			if(user != null){
				user.setStatus(0);
				user.setPassword(MD5Util.MD5Encode("123456", "utf-8"));
				this.userService.saveUser(user);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("保存用户信息==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 用户列表页查询
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/checkLoginName")
	@ResponseBody
	public void checkLoginNames(HttpServletRequest request,HttpServletResponse response,User user){
		JSONObject json = new JSONObject();
		try {
				List<User> userList = this.userService.findPage(user);
				if(userList.size() > 0){
					json.put("status",1);
				}else{
					json.put("status",0);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("检查用户存不存在==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	/**
	 * 修改用户
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/update")
	@ResponseBody
	public void update(HttpServletRequest request,HttpServletResponse response,User user){
		JSONObject json = new JSONObject();
		try {
			
			if(user != null){
				String password = user.getPassword();
				if(StringUtils.isNotBlank(password)){
					user.setPassword(MD5Util.MD5Encode(password, "utf-8")) ;
				}
				this.userService.updateUser(user);
				json.put("status",0);
			}else{
				json.put("status",1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("修改用户信息==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
	/**
	 * 查询权限数据
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/menu")
	@ResponseBody
	public void queryMenu(HttpServletRequest request,HttpServletResponse response,User user){
		JSONObject json = new JSONObject();
		try {
				Menu menu = new Menu();
				menu.setStatus(0);
				List<Menu> menuList = this.menuService.findPage(menu);
				List<User> userList = this.userService.queryUserByCondition(user);
				
				if(menuList.size() > 0){
					json.put("status",0);
					json.put("menuList",menuList);
					if(!CollectionUtils.isEmpty(userList)){
						json.put("menuIds", userList.get(0).getMenuIds());;
					}
					
				}else{
					json.put("status",1);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("检查权限==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	/**
	 * 查询权限数据
	 * @param request
	 * @param response
	 */
	@RequestMapping("/user/updateUserMenu")
	@ResponseBody
	public void updateUserMenu(HttpServletRequest request,HttpServletResponse response,@RequestParam("menuIds[]") String menuIds ,Integer id){
		JSONObject json = new JSONObject();
		HttpSession session = request.getSession();
		try {
				User user = new User();
				user.setId(id);
				user.setMenuIds(menuIds);
				this.userService.updateUserRight(user);
			    json.put("status",0);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("检查权限==="+e);
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
	
	
	
	public static void main(String[] args) {
		String str = "123456";
		System.out.println(MD5Util.MD5Encode(str, "utf-8"));
		
	}
	
	
}
