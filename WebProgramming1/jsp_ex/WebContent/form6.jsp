<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form6.jsp (File Upload)</title>
</head>
<body>
<%
	// 파일 저장 경로 (서버 파일시스템 경로)
	String savePath = application.getRealPath("/upload");
	// 업로드 파일 크기 제한
	int sizeLimit = 5 * 1024 * 1024;	// 5MB
	
	// multipart/form-data인지 확인
	if (request.getContentType().startsWith("multipart/form-data")) {
		MultipartRequest mr = new MultipartRequest(
									request,	// 현재 jsp 페이지에서 사용중인 request 객체
									savePath,	// 사용자가 보내온 파일 데이터를 저장할 경로
									sizeLimit,	// 파일 사이즈 제한
									"utf-8",	// request의 characterEncoding
									new DefaultFileRenamePolicy());
		File file = mr.getFile("attach");
		String fileName = file.getName();	// 저장된 파일 이름
		long fileSize = file.length();		// 저장된 파일 사이즈
		
		if (fileName == null) {
			// 파일 업로드 실패
			out.println("<b>파일 업로드 실패</b>");
		} else {
			// 파일 업로드 성공
			out.println("파일이름: " + fileName + "<br>");
			out.println("파일크기: " + fileSize + " 바이트<br>");
			out.println("파일설명: " + mr.getParameter("desc") + "<br>");
			//out.println("<a href=\"./upload/" + fileName + "\">파일보기</a>");
%>
<a href="./upload/<%= fileName %>">파일보기</a>
<%
		}
	}
%>


</body>
</html>