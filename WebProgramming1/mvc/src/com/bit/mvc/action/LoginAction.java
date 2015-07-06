package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		HttpSession session = request.getSession();
		// 로그인 여부 체크
		if (session.getAttribute("LOGIN_ID") != null) {
			// 이미 로그인 되어 있으면
			return "WEB-INF/view/login_ok.jsp";
		}
		else {
			// 로그인 되어 있지 않다면
			if (request.getMethod().equals("GET")) {	// GET 요청이라면
				return "WEB-INF/view/login_form.jsp";
			}
			else if (request.getMethod().equals("POST")) {	// POST 요청이라면
				String userId = request.getParameter("userId");
				String userPw = request.getParameter("userPw");
				// userId와 userPw가 맞는지 체크
				// 로그인 정보가 맞다면 세션에 어트리뷰트 추가
				session.setAttribute("LOGIN_ID", userId);
				return "WEB-INF/view/login_ok.jsp";
			}
		}
		return "WEB-INF/view/error.jsp";	// 위 모든 경우에 해당하지 않는 요청이라면
	}

}
