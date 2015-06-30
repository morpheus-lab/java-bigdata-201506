<%@ page contentType="text/html;charset=utf-8"%>
<%!
	String title = "선언 예제";
	public double calc(double n1, double n2, String op) {
		double result = 0.0;
		if (op.equals("+")) {
			result = n1 + n2;
		} else if (op.equals("-")) {
			result = n1 - n2;
		} else if (op.equals("*")) {
			result = n1 * n2;
		} else if (op.equals("/")) {
			//result = n1 / n2;
		}
		return result;
	}
%>
<html>
<head>
<title><%=title%></title>
</head>
<body>
	1+2 = <%=calc(1, 2, "+")%><br />
	<%-- 1-2 = <%=calc(1, 2, "-")%><br /> --%>
	<!-- 1*2 = <%=calc(1, 2, "*")%><br /> -->
	1/2 = <%=calc(1, 2, "/")%>
</body>
</html>
