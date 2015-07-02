<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String code = request.getParameter("code");
String viewPageURI = null;
if ("1".equals(code)) {
	viewPageURI = "/ch06/forward/1.jsp";
}
else if ("2".equals(code)) {
	viewPageURI = "/ch06/forward/2.jsp";
}
%>
<%
if (viewPageURI != null) {
%>
	<jsp:forward page="<%= viewPageURI %>" />
<%
}
%>
포워드 안됐음
</body>
</html>