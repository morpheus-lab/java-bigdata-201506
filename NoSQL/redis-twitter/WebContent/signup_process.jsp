<%@page import="com.bit.nosql.redis.twitter.RedisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>회원가입처리</title>
	<script>
<%	if(!request.getMethod().toUpperCase().equals("POST")) {	%>
		alert("잘못된 접근!");
<%	} else {
		request.setCharacterEncoding("UTF-8");
		String loginId = request.getParameter("loginId");
		String loginPw = request.getParameter("loginPw");
		String userName = request.getParameter("userName");
		
		// Redis에 회원 가입정보 저장
		RedisDAO.registerUserInfo(loginId, loginPw, userName);
%>
		alert("회원가입이 완료되었습니다.");
<%
	}
%>
		location.href = "<%=request.getContextPath()%>/";
	</script>
</head>
<body>

</body>
</html>