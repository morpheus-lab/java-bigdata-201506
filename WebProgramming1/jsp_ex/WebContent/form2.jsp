<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");	// 요청 파라미터를 UTF-8의 방법으로 복호화 하라
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>form2.jsp</title>
</head>
<body>
<%
	String[] items = request.getParameterValues("chk");
%>
관심제품: <%
	for (int i = 0; i < items.length; i++) {
		out.print(items[i] + ", ");
	}
%><br>
요금제: <%= request.getParameter("rate") %>
	
</body>
</html>