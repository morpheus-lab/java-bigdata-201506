<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>회원가입 - 트위터 비슷한 앱</title>
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<script src="js/jquery-1.11.3.js"></script>
	<script>
		var id_checked = false;
		
		function isSamePassword() {
			if ($("#loginPw").val() == "" && $("#loginPw2").val() == "") {
				// 비밀번호, 비밀번호확인 둘 다 입력이 안된 경우,
				// 일치/불일치 문구 제거
				$("#pw_check_result").text("");
				return false;
			}
			if ($("#loginPw").val() == $("#loginPw2").val()) {
				$("#pw_check_result").css("color", "green");
				$("#pw_check_result").text("비밀번호가 일치합니다.");
				return true;
			}
			$("#pw_check_result").css("color", "red");
			$("#pw_check_result").text("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		function validate() {
			var loginId = $("#loginId").val();
			var loginPw = $("#loginPw").val();
			var isSamePW = isSamePassword();
			
			// 아이디 입력했는지 체크
			if (!loginId) {
				alert("아이디를 입력하세요.");
				$("#loginId").focus();
				return false;	// form submit 안되도록
			}
			
			// 비밀번호 입력했는지 체크
			if (!loginPw) {
				alert("비밀번호를 입력하세요.");
				$("#loginPw").focus();
				return false;	// form submit 안되도록
			}
			
			// 비밀번호 일치여부 체크
			if (!isSamePW) {
				alert("비밀번호를 확인하십시오.");
				$("#loginPw2").focus();
				return false;	// form submit 안되도록
			}
			
			// 아이디 중복검사 여부 체크
			if (!id_checked) {
				alert("아이디 중복 검사를 하십시오.");
				return false;	// form submit 안되도록
			}
			
			// 이름 입력 여부 체크
			if (!($("#userName").val())) {
				alert("이름을 입력하십시오.");
				$("#userName").focus();
				return false;	// form submit 안되도록
			}
			
			return true;	// 위의 모든 체크를 통과했다면 form submit 되도록
		}
		
		function checkId() {
			$.get("check_id.jsp",
					{loginId: $("#loginId").val()},
					function(available) {
						if (available) {
							alert("아이디 사용 가능");
							id_checked = true;
						} else {
							alert("아이디 사용 불가능!!!");
							id_checked = false;
						}
					});
		}
	</script>
</head>
<body>

	<h2><a href="<%=request.getContextPath()%>/" style="text-decoration: none;">트위터</a></h2>

	<div id="page_title">회원가입</div>

	<form action="signup_process.jsp" method="post" onsubmit="return validate()">
		<label for="loginId">아이디</label>
		<input name="loginId" id="loginId" type="text" onchange="id_checked = false"
			placeholder="사용할 아이디를 입력하세요">
		<input type="button" value="중복검사" onclick="checkId()">
		<span id="id_check_result"></span><br/>
		
		<label for="loginPw">비밀번호</label>
		<input name="loginPw" id="loginPw" type="password" onkeyup="isSamePassword()"
			placeholder="비밀번호를 입력하세요"><br/>
			
		<label for="loginPw2">비밀번호확인</label>
		<input id="loginPw2" type="password" onkeyup="isSamePassword()"
			placeholder="비밀번호를 한번 더 입력하세요">
		<span id="pw_check_result"></span><br/>
		
		<label for="userName">이름</label>
		<input name="userName" id="userName" type="text"><br/>
		
		<input type="submit" value="가입신청">
		<input type="reset" value="취소"
			onclick="location.href='<%=request.getContextPath()%>/'">
	</form>

</body>
</html>