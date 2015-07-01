<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>attr2.jsp - application 기본 객체에 저장된 모든 속성 나열</title>
</head>
<body>
<%
Enumeration<String> attrNames = application.getAttributeNames();
while (attrNames.hasMoreElements()) {
	String attrName = attrNames.nextElement();
	Object attrValue = application.getAttribute(attrName);
	out.println("<b>" + attrName + "</b> : " + attrValue + "<br/>");
}
%>
</body>
</html>