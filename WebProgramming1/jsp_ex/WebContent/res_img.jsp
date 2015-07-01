<%@ page import="java.io.*" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	try {
		//response.setContentType("image/jpeg");
		String filename = application.getRealPath("/") + "\\images\\애쉬.jpg";
		
		response.setContentType(application.getMimeType(filename));
		response.addHeader("Content-Transfer-Encoding", "binary");
		
		FileInputStream fis = new FileInputStream(filename);
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		byte[] buf = new byte[1024];
		for (int i = 0; (i = fis.read(buf)) != -1;) {
			bos.write(buf, 0, i);
		}
		bos.flush();
		fis.close();
	} catch (IOException e) {
		response.setContentType("text/html;charset=utf-8");
		out.println("Error: " + e.getMessage());
	}
%>