<%@page import="com.bit.nosql.redis.twitter.RedisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userSeq = (String) session.getAttribute("user_seq");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>트위터 비슷한 앱</title>
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
	
	<h2><a href="<%=request.getContextPath()%>/" style="text-decoration: none;">트위터</a></h2>
	
	<div class="msg"></div>
	
	<div class="info">
		<%--
			로그인 전이라면 로그인 폼을, 후라면 사용자 정보를 여기에 출력
			로그인 판단 기준: session의 "user_id" 속성을 이용
		--%>
		<% if (userSeq == null) { %>
		<form action="login.jsp" method="post">
			<label for="loginId">아이디</label>
			<input name="loginId" id="loginId" type="text"><br/>
			<label for="loginPw">패스워드</label>
			<input name="loginPw" id="loginPw" type="password"><br/>
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='signup.jsp'">
		</form>
		<% } else {	%>
		<button onclick="location.href='logout.jsp'">로그아웃</button>
		<% } %>
	</div>
	
<%-- 로그인 된 상태라면, 트윗 등록 폼 --%>
<% if (userSeq != null) { %>
	<form id="writeTwit" action="twit.jsp" method="post">
		<textarea name="message" style="width: 200px; height: 40px;"></textarea>
		<input type="submit" value="트윗" style="height: 40px;">
	</form>
<% } %>
	
	<div id="page_title">
		<% if (userSeq == null) { %>
		전체 타임라인
		<% } else {	%>
		<%= RedisDAO.getUserNameByUserSeq(userSeq) %>님의 타임라인
		<% } %>
	</div>
	
	<%-- 타임라인 --%>
	<div>
		<div class="timeline_user"></div><%-- 글쓴이 정보 --%>
		<div class="timeline_body"></div><%-- 글 내용 --%>
		<div style="clear: left;"></div>
		<div class="timeline_date"></div><%-- 글 작성 일시 --%>
	</div>
	
</body>
</html>
























