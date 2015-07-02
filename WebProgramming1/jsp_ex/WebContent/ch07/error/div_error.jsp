<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- exception 객체를 사용하기 위해서는
isErrorPage가 반드시 true여야 함 --%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친절한 오류 안내문</title>
</head>
<body>

나누기 연산 중 오류가 발생하였습니다.<br/><br/>
정수만 입력해야하며, 나누는 수에 0을 입력하면 안됩니다.

<hr/>
<%= exception.getMessage() %>
<hr/>
<!--
<%
	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	exception.printStackTrace(pw);
	out.print(sw.toString());
	sw.close();
	pw.close();
%>
-->
</body>
</html>