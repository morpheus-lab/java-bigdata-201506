<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모듈화</title>
</head>
<body>

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
			<!-- Welcome 텍스트, lol 로고 -->
			소환사의 협곡에 오신 것을 환영합니다.<br/>
			<img src="images/lol_logo.png" width="300"/>
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