<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 속성을 이용한 데이터 전달</title>
</head>
<body>

<%
Calendar cal = Calendar.getInstance();
request.setAttribute("cal", cal);

request.setAttribute("name", "우르곳");
%>
<jsp:forward page="forward/recv_attr.jsp"/>

</body>
</html>