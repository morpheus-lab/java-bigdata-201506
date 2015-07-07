<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실패</title>
</head>
<body>

로그인에 실패하였습니다.<br/><br/>
<%= request.getAttribute("LOGIN_FAIL_MESSAGE") %>

</body>
</html>