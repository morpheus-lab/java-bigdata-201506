<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("user_seq");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그아웃</title>
	<script>
		alert("로그아웃되었습니다.");
		location.href = "<%=request.getContextPath()%>/";
	</script>
</head>
<body>

</body>
</html>