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
			챔피언을 선택하십시오.<br/>
			<!-- 챔피언 정보 -->
			<table>
				<tr>
					<td width="100"><img width="64" src="images/champ/Graves.jpg"/></td>
					<td width="100"><img width="64" src="images/champ/Rumble.jpg"/></td>
					<td width="100"><img width="64" src="images/champ/Leona.jpg"/></td>
					<td width="100"><img width="64" src="images/champ/Malphite.jpg"/></td>
					<td width="100"><img width="64" src="images/champ/Blitzcrank.jpg"/></td>
				</tr>
				<tr>
					<td>그레이브즈</td>
					<td>럼블</td>
					<td>레오나</td>
					<td>말파이트</td>
					<td>블리츠크랭</td>
				</tr>
			</table>
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