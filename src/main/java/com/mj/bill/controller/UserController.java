package com.mj.bill.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mj.bill.common.MD5Util;
import com.mj.bill.common.ResponseUtils;
import com.mj.bill.pojo.User;
import com.mj.bill.service.IUserService;

@Controller
public class UserController {
	@Resource
	private IUserService userService;
	
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
		System.out.println();
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
			json.put("status",1);
		}
	     ResponseUtils.responseJson(response, json.toString());
	}
	
	
	
	
	
	public static void main(String[] args) {
		String str = "123456";
		System.out.println(MD5Util.MD5Encode(str, "utf-8"));
		
	}
	
	
}
