<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Enumeration"%>
<html>
<head>
<title>form3 jsp</title>
</head>
<body>
	당싞이 선택한 제품은
	<%
	Enumeration enums = request.getParameterNames();
	while (enums.hasMoreElements()) {
		String name = (String) enums.nextElement();
		if (name.startsWith("chk")) {
			String value = request.getParameter(name);
			out.println("<b>" + value + "</b>, ");
		}
	}
%>
	입니다.
</body>
</html>
