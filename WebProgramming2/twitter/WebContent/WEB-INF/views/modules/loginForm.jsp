<%@page import="com.bit.twitter.model.Member"%>
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
				console.log(result);
				//console.log("이름: " + result.name);
				//console.log("이메일: " + result.email);
				//console.log("닉네임: " + result.nickname);
				
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
	
	$(document).ready(function() {
		// 로그아웃 버튼 이벤트 핸들러
		$("#btnLogout").click(function() {
			// 로그인 폼에 입력된 내용 제거
			$("#login_id").val("");
			$("#login_pw").val("");
			
			// 화면 전환 없이 로그아웃 처리
			$.get("<%=request.getContextPath()%>/logout.do",
					null,
					function() {
						// 화면 전환이 없더라도, 화면 내용이 바뀌도록(로그인 폼 다시 나오고, 회원정보 사라지게) 처리
						$("#memberName").html("");
						$("#loginMemberInfo").hide();
						$("#loginForm").show();
					}
			);
		});
	});
</script>
<%
Member memberInfo = (Member) session.getAttribute("memberInfo");
%>
<form id="loginForm" onsubmit="return submitLoginForm()"
		style="<%=memberInfo != null ? "display: none" : ""%>">
	<label for="login_id">아이디</label>
	<input type="text" name="login_id" id="login_id" />
	<label for="login_pw">비밀번호</label>
	<input type="password" name="login_pw" id="login_pw" />
	<input type="submit" value="로그인" />
	<input type="button" value="회원가입" />
</form>
<div id="loginMemberInfo" style="<%=memberInfo == null ? "display: none" : ""%>">
	<span id="memberName"><%=memberInfo != null ? memberInfo.getName() : ""%></span>님 어서오세요.
	<button id="btnLogout">로그아웃</button>
</div>



