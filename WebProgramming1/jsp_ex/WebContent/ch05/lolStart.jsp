<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String sGold;
	int gold;
	
	public void jspInit() {	// jsp 페이지 객체가 초기화 될 때 호출됨
		ServletConfig config = getServletConfig();
		sGold = config.getInitParameter("시작골드");
		gold = Integer.parseInt(sGold);
	}
	
	public void jspDestroy() {	// jsp 페이지가 메모리에서 해제될 때 호출됨
		gold = Integer.parseInt(sGold);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOL Start</title>
</head>
<body>
	현재 골드: <%= gold %>
	<%
		gold += 10;
	%>
</body>
</html>














