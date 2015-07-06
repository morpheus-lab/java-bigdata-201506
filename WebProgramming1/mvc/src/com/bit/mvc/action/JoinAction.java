package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest requst,
			HttpServletResponse response) throws Throwable {
		
		return "join_ok.jsp";
	}

}
