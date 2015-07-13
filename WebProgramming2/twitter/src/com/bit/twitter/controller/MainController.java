package com.bit.twitter.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.twitter.action.ICommandAction;

public class MainController extends HttpServlet {
	
	private Map<String, Object> commandMap = new HashMap<>(); // 명령어와 명령어 처리 클래스를 쌍으로 저장

	public void init(ServletConfig config) throws ServletException {
		// properties 파일
		loadProperties("com/bit/twitter/properties/Command");
	}

	// properties 설정
	private void loadProperties(String path) {

		ResourceBundle rb = ResourceBundle.getBundle(path);
		Enumeration<String> actionEnum = rb.getKeys();

		while (actionEnum.hasMoreElements()) {
			String command = actionEnum.nextElement();
			String className = rb.getString(command);
			try {
				Class commandClass = Class.forName(className);
				Object commandInstance = commandClass.newInstance();
				commandMap.put(command, commandInstance); // Map 객체인 commandMap에 객체 저장
			} catch (ClassNotFoundException e) {
				continue; // error
				// throw new ServletException(e);
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response); // get방식과 post방식을 모두 processRequest로 처리
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		processRequest(request, response);

	}

	// 사용자의 요청을 분석해서 해당 작업을 처리
	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String view = null;
		ICommandAction com = null;
		try {
			String command = request.getRequestURI();
			if (command.indexOf(request.getContextPath()) == 0) {
				command = command.substring(request.getContextPath().length());
			}
			com = (ICommandAction) commandMap.get(command);
			if (com == null) {
				System.out.println("not found : " + command);
				return;
			}
			view = com.processRequest(request, response);
			if (view == null) {
				return;
			}
		} catch (Throwable e) {
			throw new ServletException(e);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}
}
