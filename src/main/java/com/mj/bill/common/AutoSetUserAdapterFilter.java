package com.mj.bill.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mj.bill.pojo.User;
public class AutoSetUserAdapterFilter implements Filter {


    /**
     * 保存用户信息到Session
     *
     * @param user
     */
    public static void saveUserToSession(HttpSession session, User user) {
        session.setAttribute("user", user);
    }


    /**
     * 获取当前登录的用户
     *
     * @param session
     * @return
     */
    public static User getCurrentUser(HttpSession session) {
        Object sessionUser = session.getAttribute("user");
        if (sessionUser == null) {
            return null;
        }
        User user = (User) sessionUser;
        return user;
    }

    /**
     * 从session中移除用户
     */
    public static void removeUserFromSession(HttpSession session) {
        session.removeAttribute("user");
    }


    /**
     * 如果不存在使用用户查询接口查询出用户对象并设置在Session中
     *
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();


        // 当前登录用户
        User sessionUser = getCurrentUser(session);
        String url = httpRequest.getServletPath();
        if(sessionUser == null){
        	if(!url.equals("/login.do")){
        		httpResponse.sendRedirect("index.do");
        	}else{
        		chain.doFilter(request, response);
        	}
        }else{
        	session.setAttribute("user", sessionUser);
        	chain.doFilter(request, response);
        }
        

    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }


	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
