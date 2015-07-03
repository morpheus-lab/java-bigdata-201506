<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 사용자가 입력한 아이디 & 패스워드
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");

// 관리자 아이디 & 패스워드를 context param으로부터 가져오기
String adminId = application.getInitParameter("AdminId");
String adminPw = application.getInitParameter("AdminPw");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>

<%
if (adminId.equals(userid) && adminPw.equals(userpw)) {
	// 로그인 성공
	session.setAttribute("AdminId", userid);	// 로그인 여부의 지표로 삼을 어트리뷰트 설정
	out.println("로그인에 성공하였습니다.<br/>");
	out.println("<a href=\"login_chk.jsp\">로그인 체크</a>");
	
	String storeid = request.getParameter("storeid");
	if (storeid != null) {
		// 아이디저장 체크박스 체크 된 경우라면
		
		Cookie c = new Cookie("userid", userid);
		c.setMaxAge(3600);	// 쿠키의 유효 시간 (초 단위)
		response.addCookie(c);	// 응답 헤더에 "Set-Cookie: userid=jsp_ex" 들어감
	} else {
		// 아이디저장 체크박스 체크 해제된 경우라면
		
		Cookie c = new Cookie("userid", null);
		c.setMaxAge(0);	// 쿠키의 유효 시간 (초 단위)
		response.addCookie(c);
	}
	
} else if (adminId.equals(userid)) {
	// 비밀번호 틀림
	out.println("비밀번호가 틀렸습니다.<br/>");
	out.println("<a href=\"login_form2.jsp\">로그인 폼으로</a>");
} else {
	// 아이디 틀림
	out.println("<script>");
	out.println("  alert('아이디가 틀렸습니다.');");
	out.println("  history.back();");
	out.println("</script>");
}
%>

</body>
</html>