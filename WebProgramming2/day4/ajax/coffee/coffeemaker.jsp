<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%><%

String name = request.getParameter("name");
String size = request.getParameter("size");
String beverage = request.getParameter("beverage");
String whichCoffeemaker = request.getParameter("coffeemaker");
try {
	Thread.sleep(10000);
} catch (InterruptedException e) {}

%><%= whichCoffeemaker %><%= name %>