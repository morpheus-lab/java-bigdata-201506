<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리디렉션되어 온 페이지</title>
</head>
<body>

전달 받은 정수: <%= request.getParameter("num") %>
<br>
hello: <%= request.getAttribute("hello") %>

</body>
</html>