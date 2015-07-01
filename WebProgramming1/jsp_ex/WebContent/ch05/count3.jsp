<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카운터 (파일에 저장)</title>
</head>
<body>
<%
	String file = "/ch05/count.txt";
	String path = application.getRealPath(file);
	BufferedReader reader = null;
	PrintWriter writer = null;
	String count = null;
	
	try {
		reader = new BufferedReader(new FileReader(path));	// count.txt로부터 데이터 읽는 reader 객체 생성
		count = reader.readLine().trim();	// count.txt에 저장된 데이터 읽음
		reader.close();	// reader 닫기
		
		if (session.isNew()) {	// 새 방문자라면
			int c = Integer.parseInt(count) + 1;	// count + 1
			writer = new PrintWriter(new FileWriter(path));	// count.txt에 데이터 쓰는 writer 객체 생성
			writer.println(c);	// count.txt에 데이터 쓰기
			writer.close();	// writer 닫기
			
			count = Integer.toString(c);
		}
	} catch (Exception e) {
		out.println("에러발생: " + e.getMessage());
	}
%>
방문자수: <%= count %>
</body>
</html>
