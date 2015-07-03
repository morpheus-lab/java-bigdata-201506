<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.bit.jdbc.ConnectionContext"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 한글 처리 위해서
request.setCharacterEncoding("UTF-8");

// 폼에서 넘어오는 Req 파라미터 뽑아내기
String name = request.getParameter("name");
String type = request.getParameter("type");
int health = Integer.parseInt(
		request.getParameter("health"));
int damage = Integer.parseInt(
		request.getParameter("damage"));

// DB에 INSERT
String sql = "INSERT INTO champ (no, name, type, health, damage) "
			+ "VALUES (seq_champ.NEXTVAL, ?, ?, ?, ?)";
Connection conn = ConnectionContext.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, name);
pstmt.setString(2, type);
pstmt.setInt(3, health);
pstmt.setInt(4, damage);
int result = pstmt.executeUpdate();	// insert 성공이면 1, 실패면 0 리턴
// DB 자원 반납
pstmt.close();
conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챔피언 정보 등록 처리 (DB 작업)</title>
</head>
<body>

쿼리 결과: <%= result %>개 레코드 등록<br/>
<a href="list.jsp">리스트 보기</a>

</body>
</html>