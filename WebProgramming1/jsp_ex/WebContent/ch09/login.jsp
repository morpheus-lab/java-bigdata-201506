<%@page import="com.bit.bean.User"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");

String beanId = null;
String beanPw = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>역직렬화 이용 로그인 처리</title>
</head>
<body>
<%
	File userInfoFile = new File(application.getRealPath("/ch09/user/user_" + userid));
	if (!userInfoFile.exists()) {
		out.println("회원정보가 존재하지 않습니다.");
	} else {
		ObjectInputStream ois = new ObjectInputStream(new FileInputStream(userInfoFile));
		User user = (User) ois.readObject();
		ois.close();
		beanId = user.getId();
		beanPw = user.getPw();
		if (beanId.equals(userid) && beanPw.equals(userpw)) {
			// 로그인 성공
			out.println("로그인 성공");
			session.setAttribute("userId", userid);
		} else/*  if (beanId.equals(userid)) */ {
			// 패스워드가 틀린 경우
			out.println("<script>alert('패스워드가 틀렸습니다.');history.back();</script>");
		}
	}
%>
</body>
</html>




