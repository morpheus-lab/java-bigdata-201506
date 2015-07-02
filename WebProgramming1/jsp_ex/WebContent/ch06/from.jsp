<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--@ page buffer="none" --%><%-- 버퍼 크기가 0이면 예외 발생 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp:forward</title>
</head>
<body>

여기는 from.jsp~~!!
<jsp:forward page="/ch06/forward/to.jsp" /><%-- 절대경로 (현재 웹 애플리케이션 루트를 기준으로 절대 경로) --%>
<%-- <jsp:forward page="forward/to.jsp" /><!-- 상대경로 --> --%>
<%-- <jsp:forward page="./forward/to.jsp" /><!-- 상대경로 --> --%>

</body>
</html>