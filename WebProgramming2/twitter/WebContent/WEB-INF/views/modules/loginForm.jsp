<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function submitLoginForm() {
		// jQuery ajax 이용 로그인 처리
		var params = {
				login_id: $("#login_id").val(),
				login_pw: $("#login_pw").val()
				};
		var reqUrl = "<%=request.getContextPath()%>/login.do";
		// $.post(url, data, success);
		/*
		$.post(	url,
				params,
				function(result) {
					console.log(result);
				}
		);
		*/
		$.ajax({
			url: reqUrl,
			method: 'post',
			data: params,
			success: function(result) {
				console.log("로그인 성공!!!");
				console.log("이름: " + result.name);
				console.log("이메일: " + result.email);
				console.log("닉네임: " + result.nickname);
				
				$("#loginForm").hide();
				$("#memberName").text(result.name);
				$("#loginMemberInfo").show();
			},
			error: function(xhr) {
				alert("로그인 실패!\n\n아이디 또는 비밀번호를 확인하세요.");
				console.log(xhr.status + " 에러 발생!!!");
				console.log(xhr);
			}
		});
		
		return false;
	}
</script>
<form id="loginForm" onsubmit="return submitLoginForm()">
	<label for="login_id">아이디</label>
	<input type="text" name="login_id" id="login_id" />
	<label for="login_pw">비밀번호</label>
	<input type="password" name="login_pw" id="login_pw" />
	<input type="submit" value="로그인" />
	<input type="button" value="회원가입" />
</form>
<div id="loginMemberInfo" style="display: none">
	<span id="memberName"></span>님 어서오세요.
</div>