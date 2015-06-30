<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");	// 한글 처리용
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>(form1.jsp)</title>
</head>
<body>

입력한 정보는 아래와 같습니다.<br/>
ID: <%= request.getParameter("id") %><br/>
PW: <%= request.getParameter("pw") %><br/>
자기소개: <%= request.getParameter("desc") %>

</body>
</html>