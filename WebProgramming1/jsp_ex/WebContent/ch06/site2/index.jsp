<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String target = request.getParameter("target");
if (target == null
		|| (!target.equals("home") && !target.equals("champ") && !target.equals("tech"))) {
	target = "home";
}
target += ".jsp";
%>

<table border="1" width="800">
	<tr>
		<td colspan="2">
			<!-- TOP 메뉴 -->
			<jsp:include page="include/top.jsp" flush="false" />
		</td>
	</tr>
	<tr>
		<td width="120" valign="top">
			<!-- MENU -->
			<jsp:include page="include/menu.jsp" flush="false" />
		</td>
		<td>
			<jsp:include page="<%=target%>" flush="false" />
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<!-- BOTTOM 메뉴 -->
			<jsp:include page="include/bottom.jsp" flush="false" />
		</td>
	</tr>
</table>

</body>
</html>