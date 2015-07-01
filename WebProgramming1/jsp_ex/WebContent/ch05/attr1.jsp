<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>attr1.jsp - application 기본 객체에 속성 저장</title>
</head>
<body>

<%
application.setAttribute("appName", "JSP 실습");
application.setAttribute("appVersion", 1.0);
%>
application에 속성 저장 완료
</body>
</html>