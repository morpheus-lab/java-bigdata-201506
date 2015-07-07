<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberBean" type="com.bit.mvc.model.Member" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료</title>
</head>
<body>

로그인 OK<br/><br/>

${memberBean.id} (<%= memberBean.getEmail() %>) 님 로그인하셨습니다.<br/><br/>

<a href="logout.do">로그아웃</a>

</body>
</html>