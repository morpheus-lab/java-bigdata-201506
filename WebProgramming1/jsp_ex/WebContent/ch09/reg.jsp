<%@page import="com.bit.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="com.bit.bean.User" />
<%--
	com.bit.bean.User user = pageContext.getAttribute("user");
	if (user == null) {
		user = new com.bit.bean.User();
		pageContext.setAttribute("user", user);
	}
--%>
<jsp:setProperty name="user" property="*" />
<jsp:setProperty name="user" property="regDate" value="<%=new Date()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입처리</title>
</head>
<body>

	회원 가입 처리 완료
	<br />
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>아이디</td>
			<td><jsp:getProperty name="user" property="id" /></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><jsp:getProperty name="user" property="name" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><jsp:getProperty name="user" property="email" /></td>
		</tr>
		<tr>
			<td>가입일시</td>
			<td><jsp:getProperty name="user" property="regDate" /></td>
		</tr>
	</table>

<!-- bean이 어디에 저장되나? -->
<%
	User u = (User) pageContext.getAttribute("user");
%>
<%= u.getId() %>
</body>
</html>

















