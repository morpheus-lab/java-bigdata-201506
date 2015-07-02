<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 파라미터 추가 전달</title>
</head>
<body>

p1 파라미터 : <%=request.getParameter("p1")%><br/>
p2 파라미터 : <%=request.getParameter("p2")%> 

</body>
</html>