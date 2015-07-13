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
			
		});
	</script>
</head>
<body>

<div id="top">
	<jsp:include page="/WEB-INF/views/modules/loginForm.jsp" />
</div>

</body>
</html>