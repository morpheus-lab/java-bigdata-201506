package com.bit.mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ICommandAction {
	
	String processRequest(HttpServletRequest requst, HttpServletResponse response)
			throws Throwable;
	
}
