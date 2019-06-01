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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Noto+Sans+KR:400,500,700,900&amp;subset=korean">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/font.css">
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/updateMember.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/head_foot.js"></script>
<script type="text/javascript">
	data1 = "false";
	data2 = "false";
	dataPwd1 = "false";

	// nickname 중복 체크
	function nickname() {
		var member_nickname = $("#member_nickname").val();
		if (member_nickname == null || member_nickname == "") {
			$("#nick_check").text("아무것도 안썼군.");
			$("#nick_check").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			$("#saveBtn").attr("disabled", true);
			data1 = "true";
		}
		else {
			$.ajax({url: "checkNick", data: {member_nickname: member_nickname}, type: "post", success: function(data) {
				if (data == "true") {
					$("#nick_check").text("중복, 따라하지마 기집애야");
					$("#nick_check").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
					$("#saveBtn").attr("disabled", true);
					data1 = data;
				}
				else {
					$("#nick_check").text("좋아. 제안을 받아들이지.");
					$("#nick_check").css({"color": "white", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
					$("#saveBtn").attr("disabled", false);
					data1 = "false";
				}}, error : function() {console.log("실패");}
			});
		}
	}
	
	// 현재 비밀번호 검사
	function pwdCheck() {
		var member_no = $("#member_no").val();        
		var member_nowpwd = $("#member_nowpwd").val();
		if (!member_nowpwd) {
			$("#pwdCheck_span").text("말하지 않으면 몰라요!");
			$("#pwdCheck_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			data2 = "false";
		} 
		else {
			$.ajax({url:"pwdCheck", data: {member_no: member_no, member_pwd: member_nowpwd}, type: "post", success:function(data) {
				if (data == "true") {
					$("#pwdCheck_span").html("&nbsp;&nbsp;");
					data2 =data;
				}
				else {
					$("#pwdCheck_span").text("틀렸어. 수정하고싶지 않구나?");
					$("#pwdCheck_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
					data2 = data;
				}
			}});
		}
	}
	 
	// 새 비밀번호 정규식 테스트
	function pwddo() {
		// 비밀번호 정규식
		var pwJ = /^[A-Za-z0-9]{4,12}$/;
		if (pwJ.test($("#member_newpwd").val())) {
			console.log("true");
			$("#newPwd_span").html("&nbsp;&nbsp;");
			dataPwd1 = "true";
		}
		else {
			console.log("false");
			$("#newPwd_span").text("영희야 4.자.이.상 적어줄래^^?");
			$("#newPwd_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			dataPwd1 = "false";
		}
	}

	function btn_click() {
		if (document.getElementById("member_nowpwd").value == "" && document.getElementById("member_newpwd").value == "") {
			$("#pwdCheck_span").text("말하지 않으면 몰라요!");
			$("#pwdCheck_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			$("#newPwd_span").text("못해ㅋ 안해ㅎ");
			$("#newPwd_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
			return false;
		}
		else {
			if (document.getElementById("member_nowpwd").value == "" || document.getElementById("member_newpwd").value == "") {
				if (document.getElementById("member_nowpwd").value == "") {
					$("#pwdCheck_span").text("말하지 않으면 몰라요!");
					$("#pwdCheck_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
				}
				if (document.getElementById("member_newpwd").value == "") {
					$("#newPwd_span").text("못해ㅋ 안해ㅎ");
					$("#newPwd_span").css({"color": "rgb(236, 196, 136)", "font-size": "12px", "font-family": "'Noto Sans KR', sans-serif"});
				}
				return false;
			}
			else {
				if (data2 =="true" && dataPwd1=="true") {
					document.sub1.submit();
				}
				else {
					return false;
				}
			}
		}
	}
	
	// 저장 버튼 눌렀을 때 비활성화
	$(function(){
		var nick = $(".nickname").html();   
		var member_nickname = $("#member_nickname").val();
		$("#saveBtn").click(function() {      
			if (data1 == "false") {
				$("#saveBtn").submit();
			}
			else {
				return false;
			}
		});
	});
</script>
<script type="text/javascript">
	$(function(){
		// 로그인 여부 체크
		var url = window.location.search.substring(1);
		if (url.indexOf("member_no=") >= 0) {
			member_no = url.split("member_no=")[1];
			if (window.sessionStorage) {
				window.sessionStorage.setItem("member_no", member_no);
			}
		}
		$("#logout").click(function() {
			if (window.sessionStorage) {
				window.sessionStorage.setItem("member_no", 0);
			}
			location.href="start.jsp";
		});
		
		// 좋아요 없으면 취향 분석 페이지 아이콘 보이지 않기
		$.ajax({url: "goodlist?member_no="+member_no, success: function(data) {
			g_arr = eval("("+data+")");
			if (g_arr.length == 0) {
				$(".btn_eval").css("display", "none");
				$(".eval_close").css("display", "none");
			}
		}});
		
		// 취향 분석 페이지 아이콘 닫기
		$("#eval_close").click(function() {
			$(".btn_eval").css("display", "none");
			$(".eval_close").css("display", "none");
		});
		
		var nick = $(".nickname").html();
		if (nick != null) {
			$("#update_ddB").css("display", "block");
			$("#update_ddI").css("display", "none");
		}
		$("#update_BtnUpdt").click(function() {
			$("#update_ddB").css("display", "none");
			$("#update_ddI").css("display", "block");
		});
		
		// 취소버튼 눌렀을때 원래 nick값 유지, 코멘트 null값 처리
		$("#update_BtnReset").click(function() {
			$("#nick_check").text("");
			$("#member_nickname").val(nick);
			$("#update_ddB").css("display", "block");
			$("#update_ddI").css("display", "none");
		});
		   
		var info;
		var member_no = $("#member_no").val();
		$.ajax({url: "session", data: {member_no: member_no}, success: function(data) {
			info = eval("("+data+")");
			$(".dropbtn").html("☆"+info.member_nickname+"☆&nbsp;&nbsp;<i class='fas fa-sort-amount-down' style='font-size: 16px;'></i>");
		}});
		
		var modal = document.getElementById("modal");
		var content = null;
		 
		// modal 창 닫기
		window.onclick = function(event) {
			if (event.target == modal) {
				$("#pwdCheck_span").css("display", "none");
				$("#pwdCheck_span").html("&nbsp;&nbsp;");
				$("#newPwd_span").html("&nbsp;&nbsp;");
				$("#member_nowpwd").val(content);
				$("#member_newpwd").val(content);
				modal.style.display = "none";
			}
		}        
		$("#close").click(function() {
			$("#pwdCheck_span").html("&nbsp;&nbsp;");
			$("#newPwd_span").html("&nbsp;&nbsp");
			$("#member_nowpwd").val(content);
			$("#member_newpwd").val(content);
			modal.style.display = "none";
		});

		// 모달창 
		$("#modal_udt").click(function() {
			$("#modal").css("display", "block");
			if ($("#member_nowpwd").val() != null) {
				$("#pwdCheck_span").css("display", "block");
			}
			else {
				$("#pwdCheck_span").css("display", "none");
			}
			if ($("#member_newpwd").val() != null) {
				$("#newPwd_span").css("display", "block");
			}
			else {
				$("#newPwd_span").css("display", "none");
			}
		});
		 
		// 탈퇴 confirm
		$("#delete_Member").click(function() {
			if (confirm("다시한번 말해줄래 ? 안들려. ")) {
				alert("잘가 영희..");
				$("#delete_Member").submit();
			}
			else {
				return false;
			}
		});
	});
</script>
</head>
<body>
    <header>
        <div id="header" class="header">
            <a href="main?member_no=${member_no}"><img src="resources/images/logo_finish_2.svg"></a>
        </div>
        <nav id="navbar" class="navbar">
            <div class="navbar-logo">
                <a href="main?member_no=${member_no}"><img src="resources/images/logo_nav_finish.svg"></a>
            </div>
            <div class="navbar-list">
                <a href="main?member_no=${member_no}"><i class="fas fa-home"></i>&nbsp;&nbsp;누리-집</a>
                <a href="list?member_no=${member_no}"><i class="material-icons">movie_filter</i>&nbsp;&nbsp;영화-목록</a>
                <div class="dropdown">
                    <button class="dropbtn">☆${member_nickname}☆&nbsp;&nbsp;<i class="fas fa-sort-amount-down" style="font-size: 16px;"></i></button>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="updateMember?member_no=${member_no}"><i class="fas fa-pen"></i>&nbsp;&nbsp;정보-고침</a>
                        <a href="http://203.236.209.108:5000/board?member_no=${member_no}"><i class="fas fa-thumbtack"></i>&nbsp;&nbsp;알림-판</a>
                        <a href="start.jsp" id="logout"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;접속-해지</a>
                    </div>
                </div>
            </div>
            <div class="searchbar">
                <form action="search" method="POST">
                    <input type="text" name="search" placeholder="검색">
                </form>
            </div>
        </nav>
        <button class="btn-menu"><i id="icon-menu" class="fas fa-bars"></i></button>
        <div id="sidebar" class="sidebar">
            <i id="icon-close" class="fas fa-times"></i>
            <a href="main?member_no=${member_no}"><i class="fas fa-home"></i>&nbsp;&nbsp;&nbsp;누리-집</a>
            <a href="list?member_no=${member_no}"><i class="fas fa-heart"></i>&nbsp;&nbsp;&nbsp;영화-목록</a>
            <a href="updateMember?member_no=${member_no}"><i class="fas fa-pen"></i>&nbsp;&nbsp;&nbsp;정보-고침</a>
            <a href="http://203.236.209.108:5000/board?member_no=${member_no}"><i class="fas fa-thumbtack"></i>&nbsp;&nbsp;&nbsp;&nbsp;알림-판</a>
            <a href="start.jsp" id="logout"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;&nbsp;접속-해지</a>
        </div>
    </header>

	<main>
		<div id="main">
			<h2 id="h2">정보 - 수정</h2>
			<div class="input-container">
				<i class="fa fa-user icon"></i>
				<div id="update_ddB">
					<div class="nicknameDiv">
						<span class="nickname" id="member_info">${mbv.member_nickname}</span>
						<button class="btn_" id="update_BtnUpdt">변경</button>
					</div>
				</div>
				
				<form action="updateMember" method="post" name="nicknameUpdate">
					<div class="desc_myinfo" id="update_ddI">
						<input type="hidden" name="member_no" id="member_no" value="${mbv.member_no}">
						<input type="text" name="member_nickname" id="member_nickname" class="input-field" value="${mbv.member_nickname}" onchange="nickname()">
						<input type="hidden" name="member_email" id="member_email" value="${mbv.member_email}">
						<input type="hidden" name="member_pwd" id="member_pwd" value="${mbv.member_pwd}">
						<button type="submit" class="btn_" id="saveBtn" disabled="">저장</button>
						<button type="button" class="btn_" id="update_BtnReset">취소</button>
					</div>
				</form>
			</div>
  
			<div id="nick_check"></div><br>
			<div class="input-container">
				<i class="fa fa-envelope icon"></i>
				<span id="member_info">${mbv.member_email}</span>
					<a class="btn_" id="delete_Member" href="deleteMember?member_no=${mbv.member_no}">탈퇴</a>
			</div><br>
			
			<!-- modal  -->
			<div id="modal" class="modal">
				<div class="modal-content">
					<form action="updateNewPwd" method="post" id="modal-form" name="sub1">
						<strong>비밀번호 변경</strong>
						<span id="close" class="close">&times;</span>
						<input type="hidden" name="memberno" id="member_no" value="${mbv.member_no}">
						<input type="hidden" name="member_nickname" id="pw_member_nickname" value="${mbv.member_nickname}">
						<p id="member_info_pwd">현재 비밀번호 입력</p>
						<input type="password" name="member_nowpwd" id="member_nowpwd" class="input-field-modal" placeholder="현재 비밀번호 입력" onchange="pwdCheck()">
						<span id="pwdCheck_span">&nbsp;&nbsp;</span>
						<p id="member_info_pwd" >새 비밀번호 입력</p>
						<input type="password" name="member_pwd" id="member_newpwd" class="input-field-modal" placeholder="비밀번호 (4자리 이상)" onchange="pwddo()">
						<span id="newPwd_span">&nbsp;&nbsp;</span><br>
						<input type="button" id="pwdup" class="btn_" onclick="btn_click()" value="변경 완료">
					</form>
				</div>
			</div>
  
			<div class="input-container" id="input-container_pwd">
				<i class="fa fa-key icon"></i>
				<span id="member_info">비밀번호 변경</span>
				<button class="btn_" id="modal_udt">변경</button>
			</div>
		</div>
		<div class="btn_eval"><a href="http://203.236.209.108:5000/result?member_no=${member_no}" target="_blank"><i class="fa fa-heartbeat"></i><p>영희야, 철수 보고싶니?<br>그럼 클릭해봐!</p></a></div>
        <span id="eval_close" class="eval_close">&times;</span>
        <button id="btn_top"><i class="fas fa-arrow-circle-up" style="color: rgba(236, 196, 136, 0.8);"></i></button>
	</main>

    <footer>
        <div id="footer" class="footer">
            <ul class="footer-ul">
                <li class="footer-li"><a href="main?member_no=${member_no}"><img src="resources/images/logo_nav_finish.svg"></a></li>
                <li class="footer-li">&copy; 철수와 영화 2019</li>
                <li class="footer-li">慧珉庶 (hyeminseo)&nbsp;<i class="far fa-smile" style="font-size: 14px; color: rgb(236, 196, 136);"></i></li>
            </ul>
        </div>
    </footer>
</body>
</html>