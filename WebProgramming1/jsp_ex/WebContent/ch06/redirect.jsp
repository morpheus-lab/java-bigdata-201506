<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리디렉션</title>
</head>
<body>
<%
Random random = new Random();
int rInt = random.nextInt();	// 랜덤 정수 발생
String number = Integer.toString(rInt);

request.setAttribute("hello", "안녕");

response.sendRedirect(request.getContextPath() + "/ch06/res_rv.jsp?num=" + number);
%>


</body>
</html>