<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>out 기본 객체 사용</title>
</head>
<body>

	1. out.print 를 통한 출력 : <% out.print("print"); %><br/>
	2. 설정된 버퍼크기 : <%= out.getBufferSize() %><br/>
	3. 남아있는 버퍼크기 : <%=out.getRemaining()%><br/>
	<%
		out.flush();
	%>
	4. flush 후 남아있는 버퍼크기 : <%=out.getRemaining()%><br/>
	5. out.print 를 통한 출력 : <% out.print("print"); %><br/>
	<%
		out.clear();
	%>
	6. clear 후 남아있는 버퍼크기 : <%=out.getRemaining()%><br/>
	<%
	 	out.close();
	%>
	7. close 후 남아있는 버퍼크기 : <%=out.getRemaining()%><br/>

</body>
</html>