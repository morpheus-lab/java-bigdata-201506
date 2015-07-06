package com.bit.mvc.control;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.mvc.action.ICommandAction;

public class MainController extends HttpServlet {

	private Map<String, Object> commandMap = new HashMap<>();
	
	@Override
	public void init() throws ServletException {
		loadProperties("com/bit/mvc/properties/Commands");
		super.init();
	}
	
	private void loadProperties(String path) {
		ResourceBundle rb = ResourceBundle.getBundle(path);
		Enumeration<String> actions = rb.getKeys();
		while (actions.hasMoreElements()) {
			String command = actions.nextElement();
			String className = rb.getString(command);
			try {
				Class commandClass = Class.forName(className);
				Object commandInstance = commandClass.newInstance();
				
				commandMap.put(command, commandInstance);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Request URI에 따라서 알맞은 CommandAction 객체로 그 처리를 위임
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Request URI에 따라서 알맞은 CommandAction 객체로 그 처리를 위임
		process(req, resp);
	}

	private void process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String view = null;
		ICommandAction action = null;
		
		try {
			String command = req.getRequestURI();
			if (command.indexOf(req.getContextPath()) == 0) {
				command = command.substring(req.getContextPath().length());
			}
			action = (ICommandAction) commandMap.get(command);
			if (action == null) {
				System.out.println("ACTION NOT FOUND: " + command);
				return;
			}
			view = action.processRequest(req, resp);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		if (view == null) {
			return;
		}
		
		// action이 리턴한 view로 req와 resp를 보냄
		RequestDispatcher dispatcher = req.getRequestDispatcher(view);
		dispatcher.forward(req, resp);
	}
	
}










