<%-- index.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>트위터</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
	<script src="<%=request.getContextPath()%>/js/jquery-1.11.3.js"></script>
	<script>
		$(document).ready(function() {
			getTimeline();
			
			$("#btnTweet").click(function() {
				$("#newTweet").show();
			});
			$("#btnCancelNewTweet").click(function() {
				$("#newTweetContent").val("");
				$("#newTweet").hide();
			});
		});
		
		function getTimeline() {
			// 전체 타임라인 조회
			$.get("<%=request.getContextPath()%>/timeline.do",
					null,
					function(list) {
						console.log(list);
						// 기존 타임라인 비우기
						$("#twits").html("");
						// "#twits"의 자식 노드로 넣기
						$(list).each(function(index, element) {
							var html = '<li>';
							html += '<div class="bold" style="width: 30px">' + element.twitSeq + '</div>';
							html += '<div class="twit-content">' + element.content + '</div>';
							html += '<div class="bg-gray">' + element.regDtm + '</div>';
							html += '</li>';
							$("#twits").append(html);
						});
					}
			);
		}
		
		function submitNewTweet() {
			$.ajax({
				url: "<%=request.getContextPath()%>/write.do",
				method: "post",
				data: {content: $("#newTweetContent").val()},
				success: function(result) {
					console.log("새 트윗 등록 성공 여부: " + result);
					if (result) {
						$("#newTweetContent").val("");
						$("#newTweet").hide();
						getTimeline();
					} else {
						alert("트윗 등록 실패. 잠시 후 다시 시도하거나 관리자에게 문의!");
					}
				},
				error: function(xhr) {
					console.log(xhr);
					// switch(xhr.status) {
					// case 400: ...;
					// case 401: ...;
					// }
				},
				statusCode: {
					400: function() {	// content가 비어 있는 경우
						alert("내용을 입력해야 함");
						$("#newTweetContent").focus();
					},
					401: function() {	// 로그인 안된 경우
						alert("트윗을 남기려면 로그인 해야합니다");
					},
					500: function() {	// 서버측 에러
						alert("서버 에러가 발생! 잠시 후 다시 시도하거나 지속되면 관리자에게 문의");
					}
				}
			});
			
			return false;	// 폼이 전송되지 않도록
		}
	</script>
</head>
<body>

<div id="top" style="height: 30px;">
	<jsp:include page="/WEB-INF/views/modules/loginForm.jsp" />
</div>
<div id="timeline">
	<button id="btnTweet">트윗하기</button>
	<ul id="twits">
		<!-- <li><span>트윗번호</span><span>트윗 내용</span><span>시간</span></li> -->
	</ul>
</div>
<div id="newTweet">
	<form id="newTweetForm" onsubmit="return submitNewTweet()">
		<textarea id="newTweetContent" style="width: 395px; height: 40px"></textarea>
		<button id="btnSubmitNewTweet" type="submit">트윗</button>
		<button id="btnCancelNewTweet" type="reset">취소</button>
		<!-- <input type="submit" value="트윗" id="btnSubmitNewTweet" /> -->
		<!-- <input type="reset" value="취소" id="btnCancelNewTweet" /> -->
	</form>
</div>

</body>
</html>




