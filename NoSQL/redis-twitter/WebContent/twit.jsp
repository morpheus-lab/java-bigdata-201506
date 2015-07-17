<%@page import="com.bit.nosql.redis.twitter.RedisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>트위터 등록</title>
	<script>
<%
	String userSeq = (String) session.getAttribute("user_seq");
	if(!request.getMethod().toUpperCase().equals("POST")	// POST가 아닌 경우
		|| userSeq == null) {	// 로그인 해제된 경우
%>
		alert("잘못된 접근!");
<%	} else {
		request.setCharacterEncoding("UTF-8");
		String message = request.getParameter("message");
		
		RedisDAO.twit(userSeq, message);
%>
		alert("새 트윗이 등록되었습니다.");
<%
	}	%>
		location.href = "<%=request.getContextPath()%>/";
	</script>
</head>
<body>

</body>
</html>