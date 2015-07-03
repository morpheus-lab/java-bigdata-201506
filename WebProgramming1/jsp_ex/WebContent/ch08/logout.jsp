<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>

<%
session.removeAttribute("AdminId");	// 로그인 여부 지표인 AdminId 어트리뷰트 삭제
%>

로그아웃되었습니다.<br/>
<a href="login_form.jsp">로그인 하기</a><br/>
<a href="login_chk.jsp">로그인 체크</a>

</body>
</html>









