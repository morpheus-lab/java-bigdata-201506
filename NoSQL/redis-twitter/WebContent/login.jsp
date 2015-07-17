<%@page import="com.bit.nosql.redis.twitter.RedisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그인 처리</title>
	<script>
<%	if(!request.getMethod().toUpperCase().equals("POST")) {	%>
		alert("잘못된 접근!");
<%	} else {
		String loginId = request.getParameter("loginId");
		String loginPw = request.getParameter("loginPw");
		
		// Redis에서 조회
		String userSeq = RedisDAO.login(loginId, loginPw);
		if (userSeq != null) {
			session.setAttribute("user_seq", userSeq);
		} else {
%>
		alert("아이디 또는 비밀번호가 맞지 않습니다.");
<%
		}
	}
%>
		location.href = "<%=request.getContextPath()%>/";
	</script>
</head>
<body>

</body>
</html>