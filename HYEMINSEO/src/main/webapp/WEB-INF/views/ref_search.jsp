<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>철수와 영화</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Noto+Sans+KR:400,500,700,900&amp;subset=korean">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="resources/css/font.css">
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/search.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="resources/js/head_foot.js"></script>
<script type="text/javascript">
	$(function(){
		// 로그인 여부 체크
		var member_no = ${member_no}; 
		if (window.sessionStorage) {
			window.sessionStorage.setItem("member_no", member_no);
		}
		if (window.sessionStorage) {
			memberno = window.sessionStorage.getItem("member_no");
		}
		$("#logout").click(function() {
			if (window.sessionStorage) {
				window.sessionStorage.setItem("member_no", 0);
			}
			location.href="start.jsp";
		});
		
		// 화면 어디든 클릭시 modal 창 닫기
		window.onclick = function(event) {
            var modal = document.getElementById("modal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
		
		 // modal index 가져오기
		var arr = new Array();
		<c:forEach items="${list}" var="mv" varStatus="i">
			arr.push("${i.index}");
		</c:forEach>
		
		$(".search-content").click(function() {
			$(".modal").css("display", "block");
			
			// modal 창 button 동작 - zzim
			$("#nzzim").click(function(){
				$("#zzim").css("display", "block");
				$("#nzzim").css("display", "none");
			});
			$("#zzim").click(function(){
				$("#nzzim").css("display", "block");
				$("#zzim").css("display", "none");
			});
			
			// modal 창 button 동작 - good
			$("#ngood").click(function(){
				$("#good").css("display", "block");
				$("#ngood").css("display", "none");
				
				if ($("#good").css("display") == "block") {
					$("#nbad").click(function(){
						$("#bad").css("display", "block");
						$("#good").css("display", "none");
						$("#ngood").css("display", "block");
					});
				}
			});
			$("#good").click(function(){
				$("#ngood").css("display", "block");
				$("#good").css("display", "none");
			});
			
			// modal 창 button 동작 - bad
			$("#nbad").click(function(){
				$("#bad").css("display", "block");
				$("#nbad").css("display", "none");
				
				if ($("#bad").css("display") == "block") {
					$("#ngood").click(function(){
						$("#good").css("display", "block");
						$("#bad").css("display", "none");
						$("#nbad").css("display", "block");
					});
				}
			});
			$("#bad").click(function(){
				$("#nbad").css("display", "block");
				$("#bad").css("display", "none");
			});
		});
		$("#close").click(function() {
			$(".detail${i.index}").removeData();
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
                        <a href="http://203.236.209.108:5000/board"><i class="fas fa-thumbtack"></i>&nbsp;&nbsp;알림-판</a>
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
            <a href="http://203.236.209.108:5000/board"><i class="fas fa-thumbtack"></i>&nbsp;&nbsp;&nbsp;&nbsp;알림-판</a>
            <a href="start.jsp" id="logout"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;&nbsp;접속-해지</a>
        </div>
    </header>

    <main>
    	<div class="main">
    		<h2>'${search}'에 대한 검색 결과</h2>
	    	<div id="search" class="search">
				<c:choose>
					<c:when test="${cnt ne 0}">
						<c:forEach items="${list}" var="mv" varStatus="i">
							<div class="search-content">
								<div class="search-wrapper">
									<img class="poster_img" src="${mv.movie_image_url}" title="${mv.movie_title}">
								</div>
			    				<h4>${mv.movie_title}</h4>
							</div>
							
							<div id="modal" class="modal">
								<div class="modal-content">
									<span id="close" class="close">&times;</span>
									<div class="detail${i.index}">
										<div class="poster">
											<img src="${mv.movie_image_url}" title="${mv.movie_title}">
											<a href="${mv.movie_play_url}" target="_blank" title="클릭 시 VOD 재생 창이 열려요 :)"><i class="far fa-play-circle"></i></a>
										</div>
										<h1>${mv.movie_title}</h1>
										<h5>${mv.movie_titleEng}</h5>
										<div class="icons">
											<button id="btn_zzim"><i id="nzzim" class="far fa-heart" title="다음에 보고싶은 영화 미리 찜하기!"></i><i id="zzim" class="fas fa-heart" title="찜하기 취소 :("></i></button>
											<button id="btn_good"><i id="ngood" class="far fa-thumbs-up" title="좋아요는 철수의 취향 분석에 반영됩니다 :)"></i><i id="good" class="fas fa-thumbs-up" title="좋아요 취소 :("></i></button>
											<button id="btn_bad"><i id="nbad" class="far fa-thumbs-down" title="싫어요는 추천 시 제외됩니다 :)"></i><i id="bad" class="fas fa-thumbs-down" title="싫어요 취소 :("></i></button>
										</div>
										<span>[개요]&nbsp;&nbsp;&nbsp;${mv.movie_genre}&nbsp;&nbsp;|&nbsp;&nbsp;${mv.movie_runtime}&nbsp;&nbsp;|&nbsp;&nbsp;${mv.movie_nation}</span><br>
										<span>[등급]&nbsp;&nbsp;&nbsp;${mv.movie_grade}</span><br>
										<span>[개봉일]&nbsp;&nbsp;&nbsp;${mv.movie_opendate}</span><br>
										<span>[감독]&nbsp;&nbsp;&nbsp;${mv.movie_director}</span><br>
										<span>[배우]&nbsp;&nbsp;&nbsp;${mv.movie_actor}</span><br><br><br>
										<span id="content">
											<i class="fas fa-quote-left"></i>&nbsp;&nbsp;줄거리&nbsp;&nbsp;<i class="fas fa-quote-right"></i>
											<p>${mv.movie_content}</p>
										</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<h3>아쉽게도 저희에겐 '${search}'에 대한 정보가 없어요 ㅠㅠ</h3>
					</c:otherwise>
				</c:choose>
	    	</div>
		</div>
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