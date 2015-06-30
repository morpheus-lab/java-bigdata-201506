<%@page contentType="text/html;charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String noodle = request.getParameter("noodle");
	String pie = request.getParameter("pie");
	String[] game = request.getParameterValues("game");
%>
선택한 항목은 다음과 같습니다.
<br />
면류:
<%=noodle%><br />
빵류:
<%=pie%><br />
게임:
<%
	if (game != null) {
		for (int i = 0; i < game.length; i++) {
			out.println(game[i]);
		}
	}
%><br />
</body>
</html>
