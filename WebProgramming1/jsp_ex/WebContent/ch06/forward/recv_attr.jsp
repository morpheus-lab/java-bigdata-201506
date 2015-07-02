<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 속성을 이용한 데이터 전달</title>
</head>
<body>
<%
Calendar cal = (Calendar) request.getAttribute("cal");
String name = (String) request.getAttribute("name");
%>

<%= name %> 부활시간은 
<%= cal.get(Calendar.HOUR) %>시
<%= cal.get(Calendar.MINUTE) %>분
<%= cal.get(Calendar.SECOND) %>초입니다.

</body>
</html>