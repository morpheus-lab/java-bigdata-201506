<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 파라미터 추가 전달</title>
</head>
<body>

<%
String value = request.getParameter("p1");
if (value == null) {
	value = "NOPARAM";
}
%>
<jsp:forward page="forward/paramTo.jsp">
	<jsp:param name="p2" value="<%= value %>" />
</jsp:forward>

</body>
</html>