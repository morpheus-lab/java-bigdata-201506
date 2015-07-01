<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<html>
<body>
	1. 서버 정보: <%=application.getServerInfo()%> <br />
	2. 서블릿 API 버전 정보: <%=application.getMajorVersion() + "."
					+ application.getMinorVersion()%>
	<br />
	
	JSP API Ver.:
		<%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>
	<br/>
	로그 기록 남김
	<%
		application.log("appl.jsp 실행");
	%>
</body>
</html>
