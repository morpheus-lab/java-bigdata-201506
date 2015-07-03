<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.bit.jdbc.ConnectionContext"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 목록</title>
</head>
<body>

<table border="1">
	<tr>
		<td>이름</td>
		<td>타입</td>
		<td>체력</td>
		<td>공격력</td>
		<td>등록일</td>
		<td>관리</td>
	</tr>
<%
String sql = "SELECT no, name, type, health, damage, regdate FROM champ";
Connection conn = ConnectionContext.getConnection();
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
while (rs.next()) {
%>
	<tr>
		<td><%= rs.getString("name") %></td>
		<td><%= rs.getString("type") %></td>
		<td><%= rs.getString("health") %></td>
		<td><%= rs.getString("damage") %></td>
		<td><%= rs.getDate("regdate") %></td>
		<td>
			<a href="">수정</a> / <a href="">삭제</a>
		</td>
	</tr>
<%
}
stmt.close();
conn.close();
%>
</table>

</body>
</html>








