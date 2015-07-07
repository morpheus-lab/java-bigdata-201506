package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardListAction implements ICommandAction {

	@Override
	public String processRequest(HttpServletRequest requst,
			HttpServletResponse response) throws Throwable {
		return "/WEB-INF/view/board_list.jsp";
	}
	
	
	
}
