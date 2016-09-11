package com.mj.bill.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.mj.bill.pojo.User;

@Component("controllerInterceptor")
public class ControllerInterceptor implements HandlerInterceptor {

	/**
	 * 在业务处理器处理请求之前被调用 如果返回false 从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
	 * 
	 * 如果返回true 执行下一个拦截器,直到所有的拦截器都执行完毕 再执行被拦截的Controller 然后进入拦截器链,
	 * 从最后一个拦截器往回执行所有的postHandle() 接着再从最后一个拦截器往回执行所有的afterCompletion()
	 */

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		// 检测用户token
		try {
			// 获得在下面代码中要用的request,response,session对象
			HttpServletRequest servletRequest = (HttpServletRequest) request;
			HttpServletResponse servletResponse = (HttpServletResponse) response;
			HttpSession session = servletRequest.getSession();
			// 获得用户请求的URI
			String path = servletRequest.getRequestURI();
			
			if (path.indexOf("/login.do") > -1) {
				return true;
			} else {
				User user = (User) session.getAttribute("user");
				if (user != null) {
					return true;
				} else {
					// 代表登陆按钮操作
					if (path.indexOf("/loginin.do") > -1) {
						return true;
					} else {
						servletResponse.sendRedirect(servletRequest
								.getContextPath()
								+ "/login.do?fail="
								+ false);
					}
					return false;
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}

	}

	// 在业务处理器处理请求执行完成后,生成视图之前执行的动作

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在DispatcherServlet完全处理完请求后被调用
	 * 
	 * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()
	 */

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

	private boolean validate(Object userObj) {
		try {

			return true;
		} catch (Exception e) {
			return false;
		}
	}

}