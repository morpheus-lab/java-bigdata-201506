<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request 기본 객체 테스트</title>
</head>
<body>
	<table border=1 cellspacing="1" cellpadding="5">
		<tr>
			<td>닉네임</td>
			<td><%=request.getParameter("nick")%></td>
		</tr>
		<tr>
			<td>챔피언</td>
			<td><%=request.getParameter("champ")%></td>
		</tr>
		<tr>
			<td>특성</td>
			<td>
				<%
					String props[] = request.getParameterValues("prop");
					for (int i = 0; i < props.length; i++) {
						out.println(props[i] + "<br/>");
					}
				%>
			</td>
		</tr>
	</table>
	<hr>
	1. 클라이언트 IP 주소: <%=request.getRemoteAddr()%><br />
	2. 요청 메서드: <%=request.getMethod()%><br />
	3. 프로토콜: <%=request.getProtocol()%><br />
	4. 서버 호스트 이름: <%=request.getServerName()%><br />
	5. 서버 포트: <%=request.getServerPort()%><br />
	6. 요청 URI: <%=request.getRequestURI()%><br />
	7. 요청 URL: <%=request.getRequestURL()%><br />
	8. 요청 URL 중 쿼리 스트링: <%=request.getQueryString()%><br />
	9. 컨텍스트 패스 정보: <%= request.getContextPath() %><br />
	10. Referer: <%= request.getHeader("referer") %>
</body>
</html>