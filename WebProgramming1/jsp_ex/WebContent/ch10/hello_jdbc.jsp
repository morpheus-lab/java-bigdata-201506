<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.bit.jdbc.ConnectionContext"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello, JDBC</title>
</head>
<body>
<%
String msg = null;
Connection conn = ConnectionContext.getConnection();
String sql = "SELECT 'HELLO JDBC' AS MSG FROM DUAL";
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
if (rs.next()) {
	msg = rs.getString(1);
}
pstmt.close();
rs.close();
conn.close();
%>
SQL: <%= sql %><br/>
MSG: <%= msg %>
</body>
</html>