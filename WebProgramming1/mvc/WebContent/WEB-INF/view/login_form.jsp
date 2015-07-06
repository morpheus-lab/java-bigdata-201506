<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
</head>
<body>

<form action="login.do" method="post">
	아 이 디: <input type="text" name="userId" /><br/>
	비밀번호: <input type="password" name="userPw" /><br/>
	<input type="submit" value="로그인" />
</form>

</body>
</html>