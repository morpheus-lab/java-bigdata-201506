<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>appl_stream.jsp</title>
</head>
<body>
	<pre>
<%
	InputStreamReader isr = new InputStreamReader(
			application.getResourceAsStream("/ch05/test.txt"));
	int c = -1;
	while ((c = isr.read()) != -1) {
		out.print((char) c);
	}
	isr.close();
%>
	</pre>
</body>
</html>