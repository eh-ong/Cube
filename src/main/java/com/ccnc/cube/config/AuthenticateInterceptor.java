package com.ccnc.cube.config;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthenticateInterceptor implements HandlerInterceptor{
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//세션에 회원 정보가 존재하는지 확인
		HttpSession session = request.getSession(false);  //세션이 없으면 null 반환
				
		if(session == null || session.getAttribute("login_user") == null) {
			//로그인하지 않은 경우 로그인 페이지로 리다이렉트
			response.sendRedirect("/login");
			return false;  //이후의 처리를 하지 않기 위해 false 반환
		}
		return true;  //로그인한 경우에는 요청 처리 계속
	}

}
