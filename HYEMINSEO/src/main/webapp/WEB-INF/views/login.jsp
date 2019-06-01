<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>철수와 영화</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Noto+Sans+KR:400,500,700,900&amp;subset=korean">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="resources/css/font.css">
<link rel="stylesheet" href="resources/css/login.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var member_no = ${member_no};
		if (member_no == -1) {
			alert("영희야 힘내! 다시 도전해보자!!");
		}
	});
</script>
</head>
<body>
	<form action="login" method="post" class="box">
		<span><a href="join" id="linked"><i class="fas fa-user" style="font-size: 17px"></i>&nbsp;가입-하기</a></span>
		<h1>접-속!</h1>
		<input type="text" placeholder="전자_우편 (xxx@mail.com)" name="member_email" id="member_email">
		<input type="password" placeholder="비밀번호 (4자리 이상)" name="member_pwd" id="member_pwd">
		<input type="hidden" name="member_no" id="member_no" value="${member_no}"><br>
		<input type="hidden" name="member_nickname" id="member_nickname"  value="${member_nickname}">
		<input type="submit" value="입장-하기">
	</form>				
</body>
</html>
