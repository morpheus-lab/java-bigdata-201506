<%@page import="com.bit.nosql.redis.twitter.RedisDAO" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginId = request.getParameter("loginId");
%>
<%= RedisDAO.idAvailable(loginId) %>