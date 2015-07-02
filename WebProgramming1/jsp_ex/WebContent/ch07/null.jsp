<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NullPointerException 발생</title>
</head>
<body>

<%
String p1 = request.getParameter("p1");
%>
<%= p1.charAt(0) %>

</body>
</html>