<%@page import="com.bit.nosql.redis.twitter.RedisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>팔로우하기</title>
	<script>
<%
	String userSeq = (String) session.getAttribute("user_seq");
	if(userSeq == null) {	// 로그인 해제된 경우
%>
		alert("잘못된 접근!");
<%	} else {
		String followee = request.getParameter("userSeq");	// 팔로우 당하는 사용자
		String follower = userSeq;	// 팔로우 하는 사용자 = 현재 로그인 사용자
		
		RedisDAO.follow(followee, follower);
	}	%>
		location.href = "<%=request.getContextPath()%>/";
	</script>
</head>
<body>

</body>
</html>