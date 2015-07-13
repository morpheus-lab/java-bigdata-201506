package com.bit.twitter.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ICommandAction {

	public String processRequest(HttpServletRequest request, HttpServletResponse response) 
			throws Throwable;

}
