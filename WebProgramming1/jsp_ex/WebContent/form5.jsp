<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Form 전송 방식 차이점</title>
</head>
<body>

<h4>전송 방식: <%= request.getContentType() %></h4><!-- Request Header의 Content-Type을 꺼내줌 -->
Request Body에 담겨 있는 데이터:<br>
<%
	InputStream in = request.getInputStream();	// Request Body의 내용을 읽을 수 있는 InputStream
	int c = -1;
	while ((c = in.read()) > -1) {
		out.print((char) c);
	}
%>
<hr/>

</body>
</html>