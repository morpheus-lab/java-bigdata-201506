<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.StringTokenizer" %>
<html>
<head>
<title>StringTokenizer</title>
</head>
<body>
	<%
		String str = "2015/06/30";
		StringTokenizer st = new StringTokenizer(str, "/");
	%>
	st.countTokens() = <%=st.countTokens()%>
	<br />
	<%
		while (st.hasMoreTokens()) {
			out.println("st.nextToken() = " + st.nextToken() + "<br/>");
		}
	%>
</body>
</html>
