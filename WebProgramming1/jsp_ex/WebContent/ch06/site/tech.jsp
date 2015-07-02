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
			그레이브스 공략<br/>
			<table>
				<tr>
					<td colspan="6">최종 아이템</td>
				</tr>
				<tr>
					<td width="80"><img width="64" src="images/item/boots_of_speed.png"/></td>
					<td width="80"><img width="64" src="images/item/boots_of_swiftness.png"/></td>
					<td width="80"><img width="64" src="images/item/last_whisper.png"/></td>
					<td width="80"><img width="64" src="images/item/poachers_knife.png"/></td>
					<td width="80"><img width="64" src="images/item/soulsight_lantern.png"/></td>
					<td width="80"><img width="64" src="images/item/stalkers_blade.png"/></td>
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
