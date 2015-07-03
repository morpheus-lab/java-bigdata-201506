<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userid = "";
// 쿠키에 저장된 id가 있는지
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie c : cookies) {
		if (c.getName().equals("userid")) {	// 쿠키의 이름이 "userid"이면
			userid = c.getValue();	// 그 쿠키에 저장된 값을 userid 변수에 저장하고
			break;	// 반복문 나가기
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 (아이디 기억 옵션 제공)</title>
</head>
<body>

관리자 로그인<br/>
<form action="login2.jsp" method="post">
	아 이 디: <input type="text" name="userid" value="<%= userid %>" />
	<input type="checkbox" name="storeid" checked="checked">아이디 저장<br/>
	비밀번호: <input type="password" name="userpw" /><br/>
	<input type="submit" value="로그인">
</form>
<%
	session.setMaxInactiveInterval(10);
%>
Session Timeout: <%= session.getMaxInactiveInterval() %> sec.

</body>
</html>