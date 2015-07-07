package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {
		HttpSession session = request.getSession();
		session.invalidate();
		return "/WEB-INF/view/login_form.jsp";	// 위 모든 경우에 해당하지 않는 요청이라면
	}

}
