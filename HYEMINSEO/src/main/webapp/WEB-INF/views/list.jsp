<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="resources/css/font.css">
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="resources/css/list.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="resources/js/head_foot.js"></script>
<script type="text/javascript">
	$(function(){
		// 로그인 여부 체크
		var member_no = "";
		var url = window.location.search.substring(1);
		if (url.indexOf("member_no=") >= 0) {
			member_no = url.split("member_no=")[1];
			if (window.sessionStorage) {
				window.sessionStorage.setItem("member_no", member_no);
			}
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
            var modal = document.getElementsByClassName("modal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
		
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
		
		// 영화 목록 가져오는 ajax
		var arr;
		$.ajax({url: "listMV", success: function(data) {
			arr = eval("("+data+")");
			var n = 24;
			infiniteScroll(n);
			
			$(window).scroll(function(){
				if ($(window).scrollTop() + $(window).height() + 30 > $(document).height()) {
					n = n + 24;
					infiniteScroll(n);
				}
			});
			$(".loader").css("display", "none");
		}});
		
		function infiniteScroll(n) {
			for (var a = n - 24; a < n; a++) {
				loadList(a);
			}
		}
		
		function loadList(n) {
			var content = $("<div></div>").addClass("list-content");
			var img = $("<img/>").attr({src: arr[n].movie_image_url, title: arr[n].movie_title});
			$(content).append(img);
			$("#list").append(content);
			
			// 영화 상세보기 modal 창 열기
			$(content).click(function() {
				$(".modal").attr("id", "modal"+n);
				$("#modal"+n).css("display", "block");

				// 찜, 좋아요, 싫어요 유지
				$.ajax({url: "checkZ?member_no="+member_no, success: function(data) {
					list1 = eval("("+data+")");
					if (list1.length > 0) {
						$.each(list1, function(i, cz) {
							if (cz.movie_no == arr[n].movie_no) {
								$("#zzim"+n).css("display", "block");
								$("#nzzim"+n).css("display", "none");
							}
						});
					}
				}});
				$.ajax({url: "checkG?member_no="+member_no, success: function(data) {
					list2 = eval("("+data+")");
					if (list2.length > 0) {
						$.each(list2, function(i, gz) {
							if (gz.movie_no == arr[n].movie_no) {
								$("#good"+n).css("display", "block");
								$("#ngood"+n).css("display", "none");
							}
						});
					}
				}});
				$.ajax({url: "checkB?member_no="+member_no, success: function(data) {
					list3 = eval("("+data+")");
					if (list3.length > 0) {
						$.each(list3, function(i, bz) {
							if (bz.movie_no == arr[n].movie_no) {
								$("#bad"+n).css("display", "block");
								$("#nbad"+n).css("display", "none");
							}
						});
					}
				}});
				
				var poster = $("<div></div>").addClass("poster");
				var img = $("<img/>").attr({src: arr[n].movie_image_url, title: arr[n].movie_title});
				var play_url = $("<a><i class='far fa-play-circle'></i></a>").attr("href", arr[n].movie_play_url).attr("target", "_blank").attr("title", "클릭 시 VOD 재생 창이 열려요 :)");
				$(poster).append(img, play_url);
				
				var title = $("<h1></h1>").html(arr[n].movie_title);
				var titleEng = $("<h5></h5>").html(arr[n].movie_titleEng);
				
				var icons = $("<div></div>").addClass("icons");
				var icon_zzim = $("<button class='btn_zzim'><i id='nzzim"+n+"' class='far fa-heart' title='다음에 보고싶은 영화 미리 찜하기!'></i><i id='zzim"+n+"' class='fas fa-heart zzim' title='찜하기 취소 :('></i></button>");
				var icon_good = $("<button class='btn_good'><i id='ngood"+n+"' class='far fa-thumbs-up' title='좋아요는 철수의 취향 분석에 반영됩니다 :)'></i><i id='good"+n+"' class='fas fa-thumbs-up good' title='좋아요 취소 :('></i></button>");
				var icon_bad = $("<button class='btn_bad'><i id='nbad"+n+"' class='far fa-thumbs-down' title='싫어요는 추천 시 제외됩니다 :)'></i><i id='bad"+n+"' class='fas fa-thumbs-down bad' title='싫어요 취소 :('></i></button>");
				$(icons).append(icon_zzim, icon_good, icon_bad);
				
				var info_spec = $("<div></div>").addClass("info_spec");
				var info = $("<span></span><br>").html('[개요]&nbsp;&nbsp;&nbsp;' + arr[n].movie_genre + ' &nbsp;&nbsp;|&nbsp;&nbsp;' + arr[n].movie_runtime + '&nbsp;&nbsp;|&nbsp;&nbsp;' + arr[n].movie_nation);
				var grade = $("<span></span><br>").html('[등급]&nbsp;&nbsp;&nbsp;' + arr[n].movie_grade);
				var opendate = $("<span></span><br>").html('[개봉일]&nbsp;&nbsp;&nbsp;' + arr[n].movie_opendate);
				var director = $("<span></span><br>").html('[감독]&nbsp;&nbsp;&nbsp;' + arr[n].movie_director);
				var actor = $("<span></span><br><br>").html('[배우]&nbsp;&nbsp;&nbsp;' + arr[n].movie_actor);
				var content = $("<br><span class='content'><i class='fas fa-quote-left' ></i>&nbsp;&nbsp;줄거리&nbsp;&nbsp;<i class='fas fa-quote-right' ></i></span>").append($("<p></p>").html(arr[n].movie_content));
				
				$(info_spec).append(info, grade, opendate, director, actor);
				$(".detail").append(poster, title, titleEng, icons, info_spec, content);
				
				// modal 창 button 동작 - zzim
				$("#nzzim"+n).click(function(){
					if ($("#zzim"+n).css("display") != "block") {
						$("#zzim"+n).css("display", "block");
						$("#nzzim"+n).css("display", "none");
						$.ajax({url: "zzim?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							if (data == "success") {
								$("#zzimok").fadeIn(400);
								$("#zzimok").delay(600).fadeOut(400);
							}
						}});
					}
				});
				$("#zzim"+n).click(function(){
					$("#nzzim"+n).css("display", "block");
					$("#zzim"+n).css("display", "none");
					$.ajax({url: "nzzim?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
					}});
				});
				// modal 창 button 동작 - good
				$("#ngood"+n).click(function(){
					if ($("#good"+n).css("display") != "block" && $("#bad"+n).css("display") == "block") {
						$("#good"+n).css("display", "block");
						$("#ngood"+n).css("display", "none");
						$("#bad"+n).css("display", "none");
						$("#nbad"+n).css("display", "block");
						$.ajax({url: "good?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							if (data == "success") {
								$("#goodok").fadeIn(400);
								$("#goodok").delay(600).fadeOut(400);
							}
						}});
						$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
						}});
					}
					else if ($("#good"+n).css("display") != "block") {
						$("#good"+n).css("display", "block");
						$("#ngood"+n).css("display", "none");
						$.ajax({url: "good?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							if (data == "success") {
								$("#goodok").fadeIn(400);
								$("#goodok").delay(600).fadeOut(400);
							}
						}});
					}
					// 좋아요 누른 상태에서 싫어요 누를 때
					else {
						$("#nbad"+n).click(function(){
							$("#bad"+n).css("display", "block");
							$("#good"+n).css("display", "none");
							$("#ngood"+n).css("display", "block");
							$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							}});
							$.ajax({url: "bad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
								if (data == "success") {
									$("#badok").fadeIn(400);
									$("#badok").delay(600).fadeOut(400);
								}
							}});
						});
					}
				});
				$("#good"+n).click(function(){
					$("#ngood"+n).css("display", "block");
					$("#good"+n).css("display", "none");
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
					}});
				});
				// modal 창 button 동작 - bad
				$("#nbad"+n).click(function(){
					if ($("#bad"+n).css("display") != "block" && $("#good"+n).css("display") == "block") {
						$("#bad"+n).css("display", "block");
						$("#nbad"+n).css("display", "none");
						$("#ngood"+n).css("display", "block");
						$("#good"+n).css("display", "none");
						$.ajax({url: "bad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							if (data == "success") {
								$("#badok").fadeIn(400);
								$("#badok").delay(600).fadeOut(400);
							}
						}});
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
						}});
					}
					else if ($("#bad"+n).css("display") != "block") {
						$("#bad"+n).css("display", "block");
						$("#nbad"+n).css("display", "none");
						$("#ngood"+n).css("display", "block");
						$("#good"+n).css("display", "none");
						$.ajax({url: "bad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							if (data == "success") {
								$("#badok").fadeIn(400);
								$("#badok").delay(600).fadeOut(400);
							}
						}});
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
						}});
					}
					// 싫어요 누른 상태에서 좋아요 누를 때
					else {
						$("#ngood"+n).click(function(){
							$("#good"+n).css("display", "block");
							$("#bad"+n).css("display", "none");
							$("#nbad"+n).css("display", "block");
							$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
							}});
							$.ajax({url: "good?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
								if (data == "success") {
									$("#goodok").fadeIn(400);
									$("#goodok").delay(600).fadeOut(400);
								}
							}});
						});
					}
				});
				$("#bad"+n).click(function(){
					$("#nbad"+n).css("display", "block");
					$("#bad"+n).css("display", "none");
					$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+arr[n].movie_no, success: function(data) {
					}});
				});
			});
			$(".close").click(function() {
				$("#modal"+n).css("display", "none");
				$(".detail").html("");
			});
		}
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
    	<div class="loader"></div>
	    <div id="list" class="list">
			<div class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<div class="detail">
					</div>
				</div>
			</div>
	    </div>
	    <div id="zzimok" class="btns"><i class="fas fa-heart"></i><p>누리집의 찜 목록을<br>확인하세요 :)</p></div>
		<div id="goodok" class="btns"><i class="fas fa-thumbs-up"></i><p>철수의 취향 분석에<br>반영됩니다 :)</p></div>
		<div id="badok" class="btns"><i class="fas fa-thumbs-down"></i><p>철수의 취향 분석에<br>제외됩니다 :(</p></div>
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