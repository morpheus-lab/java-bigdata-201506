<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.bit.jdbc.ConnectionContext"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name="", type="";
int health=0, damage=0;
// no 파라미터
long no = Long.parseLong(request.getParameter("no"));
// DB 작업
String sql = "SELECT name, type, health, damage FROM champ WHERE no=?";
Connection conn = ConnectionContext.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setLong(1, no);
ResultSet rs = pstmt.executeQuery();
if (rs.next()) {
	name = rs.getString("name");
	type = rs.getString("type");
	health = rs.getInt("health");
	damage = rs.getInt("damage");
}
rs.close();
pstmt.close();
conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 정보 수정</title>
</head>
<body>

<form action="editx.jsp" method="post">
	<input type="hidden" name="no" value="<%= no %>"/>
	챔프명: <input type="text" name="name" value="<%= name %>"/><br/>
	타입: <input type="text" name="type" value="<%= type %>"/><br/>
	체력: <input type="text" name="health" value="<%= health %>"/><br/>
	공격력: <input type="text" name="damage" value="<%= damage %>"/><br/>
	<input type="submit" value="수정"/>
	<input type="reset" value="초기화"/>
</form>

</body>
</html>