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
	Integer count = (Integer) application.getAttribute("count");
	if (count == null) {
		application.setAttribute("count", 1);
	} else {
		if (session.isNew()) {
			count = count + 1;
			application.setAttribute("count", count);
		}
	}
%>
방문자수:
<%=application.getAttribute("count")%>
</body>
</html>