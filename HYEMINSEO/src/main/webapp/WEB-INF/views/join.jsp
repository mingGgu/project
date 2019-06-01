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
<link rel="stylesheet" href="resources/css/font.css">
<link rel="stylesheet" href="resources/css/join.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	data1 = "true";
	dataMail = "true";
	dataPwd1 = "true";
	dataPwd2 = "true";
	dataPwd3 = "true";

	// nickname 중복 체크
	function logindo() {
		var member_nickname = $("#member_nickname").val();
		if (member_nickname == null || member_nickname == "") {
			$("#nick_check").text("닉네임을 입력해주세요 :(");
			$("#nick_check").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			data1 = "true";
		}
		else {
			$.ajax({url: "checkNick", data: {member_nickname: member_nickname}, type: "post", success: function(data) {
				if (data == "true") {
					$("#nick_check").text("중복: 쿸 한발 늦었군.ㅋ :(");
					$("#nick_check").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
					data1 = data;
				}
				else {
					$("#nick_check").text("사용가능한 닉네임입니다 :p");
					$("#nick_check").css({"color": "white", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
					data1 = "false";
				}}, error : function() {console.log("실패");}
			});
		}
	}
	
	function emaildo() {
		var textMail;
		var member_email = $("#member_email").val();
		if (member_email == null || member_email == "") {
			$("#id_check").text("아이디를 입력해주세요 :(");
			$("#id_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
			dataMail = "true";
		}
		else {
			$.ajax({url: "checkMail", data: {member_email : member_email}, type: 'post', success: function(data) {
				if (data == "true") {
					$("#id_check").text("사용중인 아이디입니다 :(");
					$("#id_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
					dataMail = data;
				}
				else {
					// var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					var mailJ =  /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
					
					//#m_email이 정규식에 맞으면
					if (mailJ.test($("#member_email").val())) {
						console.log("true");
						$("#id_check").text("사용가능한 아이디입니다 :p");
						$("#id_check").css({'color' : 'white', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
						dataMail = "false";
					}
					else {
						console.log("false");
						$("#id_check").text("서울특별시 강남구 역삼동 강남대로 388(안과)");
						$("#id_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
						dataMail = data;
					}
				}}, error : function() {console.log("실패");}
			});
		}
	}
	
	function pwddo() {
		// 비밀번호 정규식
		var pwJ = /^[A-Za-z0-9]{4,12}$/;
		
		// 비밀번호 검사
		var member_pwd = $("#member_pwd").val();
		if (pwJ.test($("#member_pwd").val())) {
			console.log("true");
			$("#pwd_check").text("");
			dataPwd1 = "false";
		}
		else {
			console.log("false");
			$("#pwd_check").text("확실히 입력해주세요 :(");
			$("#pwd_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
			dataPwd1 = "true";
		}
		
		if ($("#member_pwd").val() != $("#psw_repeat").val()) {
			$("#psw_check").text("비밀번호가 일치하지 않습니다 :(");
			$("#psw_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
			dataPwd1 = "true";
		}
		else {
			$("#psw_check").text("");
			dataPwd1 = "false";
		}
	}
	
	function pwdrepeatdo() {
		if ($("#member_pwd").val() != $("#psw_repeat").val()) {
			$("#psw_check").text("비밀번호가 일치하지 않습니다 :(");
			$("#psw_check").css({'color' : 'rgb(236, 196, 136)', 'font-size' : '12px', "font-family": "'Noto Sans KR', sans-serif"});
			dataPwd2 = "true";
		}
		else {
			$("#psw_check").text('');
			dataPwd2 = "false";
			dataPwd1 = "false";
		}
	}
	
	$(function(){
		$("#join_btn").click(function() {
			if (data1 == "true") {return false;}
		 	if (dataMail == "true") {return false;}
		 	if (dataPwd1 == "true") {return false;}
			if (dataPwd2 == "true") {return false;}
         	else {
         		alert("넌 나의 노예 ☞= ☆");
         		$("#join_btn").submit();
         	}
		});
	});
</script>
</head>
<body>
	<form action="join" method="post" class="box">
		<h1>회원-가입!</h1>
		<input type="text" placeholder="별명" id="member_nickname" name="member_nickname" onchange="logindo()">
		<!-- onchange의 역할은 input 안의 값이 바뀔 때 실행되는 이벤트. 여기서는 안의 값이 바뀔때마다 함수를 호출 -->
		<div id="nick_check"></div>
		<input type="text" placeholder="전자_우편 (xxx@mail.com)" id="member_email" name="member_email" onchange="emaildo()">
		<div id="id_check"></div>
		<input type="password" placeholder="비밀번호 (4자리 이상)" id="member_pwd" name="member_pwd" onchange="pwddo()">
		<div id="pwd_check"></div>
		<input type="password" placeholder="비밀번호 확인" id="psw_repeat" onchange="pwdrepeatdo()">
		<div id="psw_check"></div><br>
		<input type="submit" id="join_btn" value="가입">       
	</form>
</body>
</html>