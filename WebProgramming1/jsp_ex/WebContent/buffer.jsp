<%@ page contentType="text/html;charset=utf-8"%>
<%@ page buffer="1kb" autoFlush="true"%>
<html>
<head>
<title>버퍼 테스트</title>
</head>
<body>
	<%
		for (int i = 0; i < 2000; i++) {
			out.print("DATA");
		}
	%>
</body>
</html>