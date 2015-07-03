<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 체크</title>
</head>
<body>

<%
boolean isLogin = false;

// 로그인 여부 판단
String adminId = (String) session.getAttribute("AdminId");
if (adminId != null) {
	// 로그인 된 상태
	isLogin = true;
}

if (isLogin) {
	out.println("로그인 된 상태<br/>");
	out.println("<a href=\"logout.jsp\">로그아웃</a>");
} else {
	out.println("로그아웃 상태<br/>");
	out.println("<a href=\"login_form.jsp\">로그인하기</a>");
}
%>

</body>
</html>






















