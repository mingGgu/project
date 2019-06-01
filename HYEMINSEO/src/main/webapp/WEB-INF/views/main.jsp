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
<link rel="stylesheet" href="resources/css/flickerplate.css">
<link rel="stylesheet" href="resources/css/lightslider.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
            var modal1 = document.getElementById("modal1");
            var modal2 = document.getElementById("modal2");
            var modal3 = document.getElementById("modal3");
            if (event.target == modal1) {
                modal1.style.display = "none";
            }
            if (event.target == modal2) {
                modal2.style.display = "none";
            }
            if (event.target == modal3) {
                modal3.style.display = "none";
            }
        }
		
		// 취향 분석 페이지 아이콘 닫기
		$("#eval_close").click(function() {
			$(".btn_eval").css("display", "none");
			$(".eval_close").css("display", "none");
		});
		
		function flicker(n) {
			// 박스오피스 현재 상영작 Top 3 flicker - 찜, 좋아요, 싫어요 유지
			var mvno = $("#mvno"+n).val();
			$.ajax({url: "checkZ?member_no="+member_no, success: function(data) {
				list1 = eval("("+data+")");
				if (list1.length > 0) {
					$.each(list1, function(i, cz) {
						if (cz.movie_no == mvno) {
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
						if (gz.movie_no == mvno) {
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
						if (bz.movie_no == mvno) {
							$("#bad"+n).css("display", "block");
							$("#nbad"+n).css("display", "none");
						}
					});
				}
			}});

			// 박스오피스 현재 상영작 Top 3 flicker button 동작 - zzim
			$("#nzzim"+n).click(function(){
				if ($("#zzim"+n).css("display") != "block") {
					$("#zzim"+n).css("display", "block");
					$("#nzzim"+n).css("display", "none");
					$.ajax({url: "zzim?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						if (data == "success") {
							$("#zzimok").fadeIn(400);
							$("#zzimok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
			});
			$("#zzim"+n).click(function(){
				$("#nzzim"+n).css("display", "block");
				$("#zzim"+n).css("display", "none");
				$.ajax({url: "nzzim?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// 박스오피스 현재 상영작 Top 3 flicker button 동작 - good
			$("#ngood"+n).click(function(){
				if ($("#good"+n).css("display") != "block" && $("#bad"+n).css("display") == "block") {
					$("#good"+n).css("display", "block");
					$("#ngood"+n).css("display", "none");
					$("#bad"+n).css("display", "none");
					$("#nbad"+n).css("display", "block");
					$.ajax({url: "good?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						if (data == "success") {
							$("#goodok").fadeIn(400);
							$("#goodok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						setTimeout(function(){location.reload();}, 1400);
					}});
				}
				else if ($("#good"+n).css("display") != "block") {
					$("#good"+n).css("display", "block");
					$("#ngood"+n).css("display", "none");
					$.ajax({url: "good?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						if (data == "success") {
							$("#goodok").fadeIn(400);
							$("#goodok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
				// 좋아요 누른 상태에서 싫어요 누를 때
				else {
					$("#nbad"+n).click(function(){
						$("#bad"+n).css("display", "block");
						$("#good"+n).css("display", "none");
						$("#ngood"+n).css("display", "block");
						$.ajax({url: "bad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
							if (data == "success") {
								$("#badok").fadeIn(400);
								$("#badok").delay(600).fadeOut(400);
								setTimeout(function(){location.reload();}, 1400);
							}
						}});
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#good"+n).click(function(){
				$("#ngood"+n).css("display", "block");
				$("#good"+n).css("display", "none");
				$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// 박스오피스 현재 상영작 Top 3 flicker button 동작 - bad
			$("#nbad"+n).click(function(){
				if ($("#bad"+n).css("display") != "block" && $("#good"+n).css("display") == "block") {
					$("#bad"+n).css("display", "block");
					$("#nbad"+n).css("display", "none");
					$("#ngood"+n).css("display", "block");
					$("#good"+n).css("display", "none");
					$.ajax({url: "bad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						if (data == "success") {
							$("#badok").fadeIn(400);
							$("#badok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						setTimeout(function(){location.reload();}, 1450);
					}});
				}
				else if ($("#bad"+n).css("display") != "block") {
					$("#bad"+n).css("display", "block");
					$("#nbad"+n).css("display", "none");
					$("#ngood"+n).css("display", "block");
					$("#good"+n).css("display", "none");
					$.ajax({url: "bad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						if (data == "success") {
							$("#badok").fadeIn(400);
							$("#badok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
					}});
				}
				// 싫어요 누른 상태에서 좋아요 누를 때
				else {
					$("#ngood"+n).click(function(){
						$("#good"+n).css("display", "block");
						$("#bad"+n).css("display", "none");
						$("#nbad"+n).css("display", "block");
						$.ajax({url: "good?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
							if (data == "success") {
								$("#goodok").fadeIn(400);
								$("#goodok").delay(600).fadeOut(400);
								setTimeout(function(){location.reload();}, 1400);
							}
						}});
						$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
						}});
					});
				}
			});
			$("#bad"+n).click(function(){
				$("#nbad"+n).css("display", "block");
				$("#bad"+n).css("display", "none");
				$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+mvno, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
		}
		
		for (var i = 0; i <= 2; i++) {
			flicker(i);
		}
		
		// 찜 목록
		var movie_no = 0;
		$.ajax({url: "zzimlist?member_no="+member_no, success: function(data) {
			z_arr = eval("("+data+")");
			if (z_arr.length == 0) {
				$("#item1").html("아직 찜 해놓은 작품이 없어요!<br>보고 싶은 작품을 미리 찜 <i class='far fa-heart'></i> 해놓으면 여기서 바로 확인이 가능해요 :)")
			}
			$.each(z_arr, function(i, mv) {
				var li1 = $("<li></li>").attr("idx", i).attr("id", "li1");
				var div = $("<div></div>");
				var img = $("<img/>").attr({src: z_arr[i].movie_image_url, title: z_arr[i].movie_title}).css({width: "153", height: "auto"});
				var h3 = $("<h3></h3>").html(z_arr[i].movie_title);
				$(div).append(img);
				$(li1).append(div, h3);
				
				// 영화 상세보기 modal 창 열기
				$(li1).click(function() {
					$("#modal1").css("display", "block");
					var idx = $(li1).attr("idx");
					var dt1 = z_arr[idx];
					
					// 찜, 좋아요, 싫어요 유지
					$.ajax({url: "checkZ?member_no="+member_no, success: function(data) {
						list1 = eval("("+data+")");
						if (list1.length > 0) {
							$.each(list1, function(i, cz) {
								if (cz.movie_no == dt1.movie_no) {
									$("#zzim4").css("display", "block");
									$("#nzzim4").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkG?member_no="+member_no, success: function(data) {
						list2 = eval("("+data+")");
						if (list2.length > 0) {
							$.each(list2, function(i, gz) {
								if (gz.movie_no == dt1.movie_no) {
									$("#good4").css("display", "block");
									$("#ngood4").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkB?member_no="+member_no, success: function(data) {
						list3 = eval("("+data+")");
						if (list3.length > 0) {
							$.each(list3, function(i, bz) {
								if (bz.movie_no == dt1.movie_no) {
									$("#bad4").css("display", "block");
									$("#nbad4").css("display", "none");
								}
							});
						}
					}});
					$("#poster_img1").attr({src: dt1.movie_image_url, title: dt1.movie_title});
					$("#play_url1").attr({href: dt1.movie_play_url, title: "클릭 시 VOD 재생 창이 열려요 :)"});
					$("#h1_title1").html(dt1.movie_title);
					$("#h5_titleEng1").html(dt1.movie_titleEng);
					$("#info_sum1").html("[개요]&nbsp;&nbsp;&nbsp;" + dt1.movie_genre + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt1.movie_runtime + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt1.movie_nation);
					$("#info_grade1").html("[등급]&nbsp;&nbsp;&nbsp;" + dt1.movie_grade);
					$("#info_opendate1").html("[개봉일]&nbsp;&nbsp;&nbsp;" + dt1.movie_opendate);
					$("#info_director1").html("[감독]&nbsp;&nbsp;&nbsp;" + dt1.movie_director);
					$("#info_actor1").html("[배우]&nbsp;&nbsp;&nbsp;" + dt1.movie_actor);
					$("#info_cont1").html(dt1.movie_content);
					movie_no = dt1.movie_no;
				});
				$("#close1").click(function() {
					$("#modal1").css("display", "none");
				});
				$("#content-slider1").append(li1);
			});
			$("#content-slider1").lightSlider({
				item:9, loop: true, keyPress: false, easing: 'cubic-bezier(0.25, 0, 0.25, 1)', enableTouch: true, auto: true, pauseOnHover: true, responsive : [
					{breakpoint: 1366, settings: {item: 8, slideMove: 1, slideMargin: 9}},
					{breakpoint: 1240, settings: {item: 7, slideMove: 1, slideMargin: 8}},
					{breakpoint: 1080, settings: {item: 6, slideMove: 1, slideMargin: 7}},
					{breakpoint: 960, settings: {item: 5, slideMove: 1, slideMargin: 6}},
					{breakpoint: 800, settings: {item: 4, slideMove: 1, slideMargin: 5}},
					{breakpoint: 640, settings: {item: 3, slideMove: 1, slideMargin: 4}},
					{breakpoint: 420, settings: {item: 2, slideMove: 1, slideMargin: 3}},
					{breakpoint: 320, settings: {item: 1, slideMove: 1, slideMargin: 3}}
		    ]});
	
			// modal 창 button 동작 - zzim
			$("#nzzim4").click(function(){
				if ($("#zzim4").css("display") != "block") {
					$("#zzim4").css("display", "block");
					$("#nzzim4").css("display", "none");
					$.ajax({url: "zzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#zzimok").fadeIn(400);
							$("#zzimok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
			});
			$("#zzim4").click(function(){
				$("#nzzim4").css("display", "block");
				$("#zzim4").css("display", "none");
				$.ajax({url: "nzzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - good
			$("#ngood4").click(function(){
				if ($("#good4").css("display") != "block") {
					$("#good4").css("display", "block");
					$("#ngood4").css("display", "none");
					$.ajax({url: "good?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#goodok").fadeIn(400);
							$("#goodok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
				// 좋아요 누른 상태에서 싫어요 누를 때
				else {
					$("#nbad4").click(function(){
						$("#bad4").css("display", "block");
						$("#good4").css("display", "none");
						$("#ngood4").css("display", "block");
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#good4").click(function(){
				$("#ngood4").css("display", "block");
				$("#good4").css("display", "none");
				$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - bad
			$("#nbad4").click(function(){
				if ($("#bad4").css("display") != "block" && $("#good4").css("display") == "block") {
					$("#bad4").css("display", "block");
					$("#nbad4").css("display", "none");
					$("#ngood4").css("display", "block");
					$("#good4").css("display", "none");
					$.ajax({url: "bad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#badok").fadeIn(400);
							$("#badok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						setTimeout(function(){location.reload();}, 1400);
					}});
				}
				// 싫어요 누른 상태에서 좋아요 누를 때
				else {
					$("#ngood4").click(function(){
						$("#good4").css("display", "block");
						$("#bad4").css("display", "none");
						$("#nbad4").css("display", "block");
						$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#bad4").click(function(){
				$("#nbad4").css("display", "block");
				$("#bad4").css("display", "none");
				$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});

		}});
		
		// 좋아요 목록
		$.ajax({url: "goodlist?member_no="+member_no, success: function(data) {
			g_arr = eval("("+data+")");
			if (g_arr.length == 0) {
				$("#item2").html("아직 좋아요를 하나도 누르지 않으셨네요!<br>내 취향과 찰떡인 작품에 좋아요 <i class='far fa-thumbs-up'></i> 를 누르면 여기서 바로 확인이 가능해요 :)")
				$(".btn_eval").css("display", "none");
				$(".eval_close").css("display", "none");
			}
			$.each(g_arr, function(i, mv) {
				var li2 = $("<li></li>").attr("idx", i).attr("id", "li2");
				var div = $("<div></div>");
				var img = $("<img/>").attr({src: g_arr[i].movie_image_url, title: g_arr[i].movie_title}).css({width: "153", height: "auto"});
				var h3 = $("<h3></h3>").html(g_arr[i].movie_title);
				$(div).append(img);
				$(li2).append(div, h3);
				
				// 영화 상세보기 modal 창 열기
				$(li2).click(function() {
					$("#modal2").css("display", "block");
					var idx = $(li2).attr("idx");
					var dt2 = g_arr[idx];
					
					// 찜, 좋아요, 싫어요 유지
					$.ajax({url: "checkZ?member_no="+member_no, success: function(data) {
						list1 = eval("("+data+")");
						if (list1.length > 0) {
							$.each(list1, function(i, cz) {
								if (cz.movie_no == dt2.movie_no) {
									$("#zzim5").css("display", "block");
									$("#nzzim5").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkG?member_no="+member_no, success: function(data) {
						list2 = eval("("+data+")");
						if (list2.length > 0) {
							$.each(list2, function(i, gz) {
								if (gz.movie_no == dt2.movie_no) {
									$("#good5").css("display", "block");
									$("#ngood5").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkB?member_no="+member_no, success: function(data) {
						list3 = eval("("+data+")");
						if (list3.length > 0) {
							$.each(list3, function(i, bz) {
								if (bz.movie_no == dt2.movie_no) {
									$("#bad5").css("display", "block");
									$("#nbad5").css("display", "none");
								}
							});
						}
					}});
					$("#poster_img2").attr({src: dt2.movie_image_url, title: dt2.movie_title});
					$("#play_url2").attr({href: dt2.movie_play_url, title: "클릭 시 VOD 재생 창이 열려요 :)"});
					$("#h1_title2").html(dt2.movie_title);
					$("#h5_titleEng2").html(dt2.movie_titleEng);
					$("#info_sum2").html("[개요]&nbsp;&nbsp;&nbsp;" + dt2.movie_genre + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt2.movie_runtime + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt2.movie_nation);
					$("#info_grade2").html("[등급]&nbsp;&nbsp;&nbsp;" + dt2.movie_grade);
					$("#info_opendate2").html("[개봉일]&nbsp;&nbsp;&nbsp;" + dt2.movie_opendate);
					$("#info_director2").html("[감독]&nbsp;&nbsp;&nbsp;" + dt2.movie_director);
					$("#info_actor2").html("[배우]&nbsp;&nbsp;&nbsp;" + dt2.movie_actor);
					$("#info_cont2").html(dt2.movie_content);
					movie_no = dt2.movie_no;
				});
				$("#close2").click(function() {
					$("#modal2").css("display", "none");
				});
				$("#content-slider2").append(li2);
			});
			$("#content-slider2").lightSlider({
				item:9, loop: true, keyPress: false, easing: 'cubic-bezier(0.25, 0, 0.25, 1)', enableTouch: true, auto: true, pauseOnHover: true, responsive : [
					{breakpoint: 1366, settings: {item: 8, slideMove: 1, slideMargin: 9}},
					{breakpoint: 1240, settings: {item: 7, slideMove: 1, slideMargin: 8}},
					{breakpoint: 1080, settings: {item: 6, slideMove: 1, slideMargin: 7}},
					{breakpoint: 960, settings: {item: 5, slideMove: 1, slideMargin: 6}},
					{breakpoint: 800, settings: {item: 4, slideMove: 1, slideMargin: 5}},
					{breakpoint: 640, settings: {item: 3, slideMove: 1, slideMargin: 4}},
					{breakpoint: 420, settings: {item: 2, slideMove: 1, slideMargin: 3}},
					{breakpoint: 320, settings: {item: 1, slideMove: 1, slideMargin: 3}}
		    ]});
			
			// modal 창 button 동작 - zzim
			$("#nzzim5").click(function(){
				if ($("#zzim5").css("display") != "block") {
					$("#zzim5").css("display", "block");
					$("#nzzim5").css("display", "none");
					$.ajax({url: "zzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#zzimok").fadeIn(400);
							$("#zzimok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
			});
			$("#zzim5").click(function(){
				$("#nzzim5").css("display", "block");
				$("#zzim5").css("display", "none");
				$.ajax({url: "nzzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - good
			$("#ngood5").click(function(){
				if ($("#good5").css("display") != "block") {
					$("#good5").css("display", "block");
					$("#ngood5").css("display", "none");
					$.ajax({url: "good?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#goodok").fadeIn(400);
							$("#goodok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
				// 좋아요 누른 상태에서 싫어요 누를 때
				else {
					$("#nbad5").click(function(){
						$("#bad5").css("display", "block");
						$("#good5").css("display", "none");
						$("#ngood5").css("display", "block");
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#good5").click(function(){
				$("#ngood5").css("display", "block");
				$("#good5").css("display", "none");
				$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - bad
			$("#nbad5").click(function(){
				if ($("#bad5").css("display") != "block" && $("#good5").css("display") == "block") {
					$("#bad5").css("display", "block");
					$("#nbad5").css("display", "none");
					$("#ngood5").css("display", "block");
					$("#good5").css("display", "none");
					$.ajax({url: "bad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#badok").fadeIn(400);
							$("#badok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						setTimeout(function(){location.reload();}, 1400);
					}});
				}
				// 싫어요 누른 상태에서 좋아요 누를 때
				else {
					$("#ngood5").click(function(){
						$("#good5").css("display", "block");
						$("#bad5").css("display", "none");
						$("#nbad5").css("display", "block");
						$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#bad5").click(function(){
				$("#nbad5").css("display", "block");
				$("#bad5").css("display", "none");
				$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
		}});
	
		// 박스오피스 top 10 목록
		$.ajax({url: "boxoffice", success: function(data) {
			b_arr = eval("("+data+")");
			$.each(b_arr, function(i, mv) {
				var li3 = $("<li></li>").attr("idx", i).attr("id", "li3");
				var div = $("<div></div>");
				var img = $("<img/>").attr({src: b_arr[i].movie_image_url, title: b_arr[i].movie_title}).css({width: "153", height: "auto"});
				var h3 = $("<h3></h3>").html(b_arr[i].movie_title);
				$(div).append(img);
				$(li3).append(div, h3);
				
				// 영화 상세보기 modal 창 열기
				$(li3).click(function() {
					$("#modal3").css("display", "block");
					var idx = $(li3).attr("idx");
					var dt3 = b_arr[idx];
					
					// 찜, 좋아요, 싫어요 유지
					$.ajax({url: "checkZ?member_no="+member_no, success: function(data) {
						list1 = eval("("+data+")");
						if (list1.length > 0) {
							$.each(list1, function(i, cz) {
								if (cz.movie_no == dt3.movie_no) {
									$("#zzim6").css("display", "block");
									$("#nzzim6").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkG?member_no="+member_no, success: function(data) {
						list2 = eval("("+data+")");
						if (list2.length > 0) {
							$.each(list2, function(i, gz) {
								if (gz.movie_no == dt3.movie_no) {
									$("#good6").css("display", "block");
									$("#ngood6").css("display", "none");
								}
							});
						}
					}});
					$.ajax({url: "checkB?member_no="+member_no, success: function(data) {
						list3 = eval("("+data+")");
						if (list3.length > 0) {
							$.each(list3, function(i, bz) {
								if (bz.movie_no == dt3.movie_no) {
									$("#bad6").css("display", "block");
									$("#nbad6").css("display", "none");
								}
							});
						}
					}});
					$("#poster_img3").attr({src: dt3.movie_image_url, title: dt3.movie_title});
					$("#play_url3").attr({href: dt3.movie_play_url, title: "클릭 시 VOD 재생 창이 열려요 :)"});
					$("#h1_title3").html(dt3.movie_title);
					$("#h5_titleEng3").html(dt3.movie_titleEng);
					$("#info_sum3").html("[개요]&nbsp;&nbsp;&nbsp;" + dt3.movie_genre + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt3.movie_runtime + "&nbsp;&nbsp;|&nbsp;&nbsp;" + dt3.movie_nation);
					$("#info_grade3").html("[등급]&nbsp;&nbsp;&nbsp;" + dt3.movie_grade);
					$("#info_opendate3").html("[개봉일]&nbsp;&nbsp;&nbsp;" + dt3.movie_opendate);
					$("#info_director3").html("[감독]&nbsp;&nbsp;&nbsp;" + dt3.movie_director);
					$("#info_actor3").html("[배우]&nbsp;&nbsp;&nbsp;" + dt3.movie_actor);
					$("#info_cont3").html(dt3.movie_content);
					movie_no = dt3.movie_no;
				});
				$("#close3").click(function() {
					$("#modal3").css("display", "none");
				});
				$("#content-slider3").append(li3);
			});
			$("#content-slider3").lightSlider({
				item:9, loop: true, keyPress: false, easing: 'cubic-bezier(0.25, 0, 0.25, 1)', enableTouch: true, auto: true, pauseOnHover: true, responsive : [
					{breakpoint: 1366, settings: {item: 8, slideMove: 1, slideMargin: 9}},
					{breakpoint: 1240, settings: {item: 7, slideMove: 1, slideMargin: 8}},
					{breakpoint: 1080, settings: {item: 6, slideMove: 1, slideMargin: 7}},
					{breakpoint: 960, settings: {item: 5, slideMove: 1, slideMargin: 6}},
					{breakpoint: 800, settings: {item: 4, slideMove: 1, slideMargin: 5}},
					{breakpoint: 640, settings: {item: 3, slideMove: 1, slideMargin: 4}},
					{breakpoint: 420, settings: {item: 2, slideMove: 1, slideMargin: 3}},
					{breakpoint: 320, settings: {item: 1, slideMove: 1, slideMargin: 3}}
		    ]});
			
			// modal 창 button 동작 - zzim
			$("#nzzim6").click(function(){
				if ($("#zzim6").css("display") != "block") {
					$("#zzim6").css("display", "block");
					$("#nzzim6").css("display", "none");
					$.ajax({url: "zzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#zzimok").fadeIn(400);
							$("#zzimok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
			});
			$("#zzim6").click(function(){
				$("#nzzim6").css("display", "block");
				$("#zzim6").css("display", "none");
				$.ajax({url: "nzzim?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - good
			$("#ngood6").click(function(){
				if ($("#good6").css("display") != "block") {
					$("#good6").css("display", "block");
					$("#ngood6").css("display", "none");
					$.ajax({url: "good?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#goodok").fadeIn(400);
							$("#goodok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
				}
				// 좋아요 누른 상태에서 싫어요 누를 때
				else {
					$("#nbad6").click(function(){
						$("#bad6").css("display", "block");
						$("#good6").css("display", "none");
						$("#ngood6").css("display", "block");
						$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#good6").click(function(){
				$("#ngood6").css("display", "block");
				$("#good6").css("display", "none");
				$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
			// modal 창 button 동작 - bad
			$("#nbad6").click(function(){
				if ($("#bad6").css("display") != "block" && $("#good6").css("display") == "block") {
					$("#bad6").css("display", "block");
					$("#nbad6").css("display", "none");
					$("#ngood6").css("display", "block");
					$("#good6").css("display", "none");
					$.ajax({url: "bad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						if (data == "success") {
							$("#badok").fadeIn(400);
							$("#badok").delay(600).fadeOut(400);
							setTimeout(function(){location.reload();}, 1400);
						}
					}});
					$.ajax({url: "ngood?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
						setTimeout(function(){location.reload();}, 1400);
					}});
				}
				// 싫어요 누른 상태에서 좋아요 누를 때
				else {
					$("#ngood6").click(function(){
						$("#good6").css("display", "block");
						$("#bad6").css("display", "none");
						$("#nbad6").css("display", "block");
						$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
							setTimeout(function(){location.reload();}, 1400);
						}});
					});
				}
			});
			$("#bad6").click(function(){
				$("#nbad6").css("display", "block");
				$("#bad6").css("display", "none");
				$.ajax({url: "nbad?member_no="+member_no+"&movie_no="+movie_no, success: function(data) {
					setTimeout(function(){location.reload();}, 1400);
				}});
			});
		}});
	});
</script>
<script type="text/javascript" src="resources/js/head_foot.js"></script>
<script type="text/javascript" src="resources/js/flickerplate.js"></script>
<script type="text/javascript" src="resources/js/lightslider.js"></script>
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
        <div class="flicker-example" data-block-text="false">
            <ul>
            	<c:forEach items="${list}" var="mv" varStatus="i">
            		<li data-background="resources/images/slide0${i.index}.jpg">
            			<input type="hidden" id="mvno${i.index}" value="${mv.movie_no}">
            			<div class="slide_icons">
							<button class="slide_zzim"><i id="nzzim${i.index}" class="far fa-heart" title="다음에 보고싶은 영화 미리 찜하기!"></i><i id="zzim${i.index}" class="fas fa-heart zzim" title="찜하기 취소 :("></i></button>
							<button class="slide_good"><i id="ngood${i.index}" class="far fa-thumbs-up" title="좋아요는 철수의 취향 분석에 반영됩니다 :)"></i><i id="good${i.index}" class="fas fa-thumbs-up good" title="좋아요 취소 :("></i></button>
							<button class="slide_bad"><i id="nbad${i.index}" class="far fa-thumbs-down" title="싫어요는 추천 시 제외됩니다 :)"></i><i id="bad${i.index}" class="fas fa-thumbs-down bad" title="싫어요 취소 :("></i></button>
						</div>
	                    <div class="flick-title">${mv.movie_title}</div>
	                    <div class="flick-sub-text">
	                        <p>${mv.movie_content}</p>
	                    </div>
                	</li>
            	</c:forEach>
            </ul>
        </div>
        
        <h2>${member_nickname} 님의 <i class="fas fa-heart"></i>&nbsp;목록</h2>
        <div class="demo">
			<div id="item1" class="item">
				<ul id="content-slider1" class="content-slider">
				
				</ul>
			</div>
		</div>
		<div id="modal1" class="modal">
			<div class="modal-content">
				<span id="close1" class="close">&times;</span>
				<div class="detail">
					<div class="poster">
						<img id="poster_img1" class="poster_img">
						<a id="play_url1" class="play_url" target="_blank"><i class="far fa-play-circle"></i></a>	
					</div>
					<h1 id="h1_title1" class="h1_title"></h1>
					<h5 id="h5_titleEng1" class="h5_titleEng"></h5>
					<div class="icons">
						<button id="btn_zzim"><i id="nzzim4" class="far fa-heart" title="다음에 보고싶은 영화 미리 찜하기!"></i><i id="zzim4" class="fas fa-heart zzim" title="찜하기 취소 :("></i></button>
						<button id="btn_good"><i id="ngood4" class="far fa-thumbs-up" title="좋아요는 철수의 취향 분석에 반영됩니다 :)"></i><i id="good4" class="fas fa-thumbs-up good" title="좋아요 취소 :("></i></button>
						<button id="btn_bad"><i id="nbad4" class="far fa-thumbs-down" title="싫어요는 추천 시 제외됩니다 :)"></i><i id="bad4" class="fas fa-thumbs-down bad" title="싫어요 취소 :("></i></button>
					</div>
					<div class="info_spec">
						<span id="info_sum1" class="info_sum"></span><br>
						<span id="info_grade1" class="info_grade"></span><br>
						<span id="info_opendate1" class="info_opendate"></span><br>
						<span id="info_director1" class="info_director"></span><br>
						<span id="info_actor1" class="info_actor"></span><br><br><br>
					</div>
					<span id="content">
						<i class="fas fa-quote-left"></i>&nbsp;&nbsp;줄거리&nbsp;&nbsp;<i class="fas fa-quote-right"></i>
						<p id="info_cont1" class="info_cont"></p>
					</span>
				</div>
			</div>
		</div>
		
		<h2>${member_nickname} 님의 <i class="fas fa-thumbs-up"></i>&nbsp;목록</h2>
        <div class="demo">
			<div id="item2" class="item">
				<ul id="content-slider2" class="content-slider">
				
				</ul>
			</div>
		</div>
		<div id="modal2" class="modal">
			<div class="modal-content">
				<span id="close2" class="close">&times;</span>
				<div class="detail">
					<div class="poster">
						<img id="poster_img2" class="poster_img">
						<a id="play_url2" class="play_url" target="_blank"><i class="far fa-play-circle"></i></a>	
					</div>
					<h1 id="h1_title2" class="h1_title"></h1>
					<h5 id="h5_titleEng2" class="h5_titleEng"></h5>
					<div class="icons">
						<button id="btn_zzim"><i id="nzzim5" class="far fa-heart" title="다음에 보고싶은 영화 미리 찜하기!"></i><i id="zzim5" class="fas fa-heart zzim" title="찜하기 취소 :("></i></button>
						<button id="btn_good"><i id="ngood5" class="far fa-thumbs-up" title="좋아요는 철수의 취향 분석에 반영됩니다 :)"></i><i id="good5" class="fas fa-thumbs-up good" title="좋아요 취소 :("></i></button>
						<button id="btn_bad"><i id="nbad5" class="far fa-thumbs-down" title="싫어요는 추천 시 제외됩니다 :)"></i><i id="bad5" class="fas fa-thumbs-down bad" title="싫어요 취소 :("></i></button>
					</div>
					<div class="info_spec">
						<span id="info_sum2" class="info_sum"></span><br>
						<span id="info_grade2" class="info_grade"></span><br>
						<span id="info_opendate2" class="info_opendate"></span><br>
						<span id="info_director2" class="info_director"></span><br>
						<span id="info_actor2" class="info_actor"></span><br><br><br>
					</div>
					<span id="content">
						<i class="fas fa-quote-left"></i>&nbsp;&nbsp;줄거리&nbsp;&nbsp;<i class="fas fa-quote-right"></i>
						<p id="info_cont2" class="info_cont"></p>
					</span>
				</div>
			</div>
		</div>
		
		<h2>바로 지금! 영화관&nbsp;<i class="fas fa-star"></i> 화제의 인기작 <i class="fas fa-star"></i>&nbsp;10편!!</h2>
        <div class="demo">
			<div id="item3" class="item">
				<ul id="content-slider3" class="content-slider">
				
				</ul>
			</div>
		</div>
		<div id="modal3" class="modal">
			<div class="modal-content">
				<span id="close3" class="close">&times;</span>
				<div class="detail">
					<div class="poster">
						<img id="poster_img3" class="poster_img">
						<a id="play_url3" class="play_url" target="_blank"><i class="far fa-play-circle"></i></a>	
					</div>
					<h1 id="h1_title3" class="h1_title"></h1>
					<h5 id="h5_titleEng3" class="h5_titleEng"></h5>
					<div class="icons">
						<button id="btn_zzim"><i id="nzzim6" class="far fa-heart" title="다음에 보고싶은 영화 미리 찜하기!"></i><i id="zzim6" class="fas fa-heart zzim" title="찜하기 취소 :("></i></button>
						<button id="btn_good"><i id="ngood6" class="far fa-thumbs-up" title="좋아요는 철수의 취향 분석에 반영됩니다 :)"></i><i id="good6" class="fas fa-thumbs-up good" title="좋아요 취소 :("></i></button>
						<button id="btn_bad"><i id="nbad6" class="far fa-thumbs-down" title="싫어요는 추천 시 제외됩니다 :)"></i><i id="bad6" class="fas fa-thumbs-down bad" title="싫어요 취소 :("></i></button>
					</div>
					<div class="info_spec">
						<span id="info_sum3" class="info_sum"></span><br>
						<span id="info_grade3" class="info_grade"></span><br>
						<span id="info_opendate3" class="info_opendate"></span><br>
						<span id="info_director3" class="info_director"></span><br>
						<span id="info_actor3" class="info_actor"></span><br><br><br>
					</div>
					<span id="content">
						<i class="fas fa-quote-left"></i>&nbsp;&nbsp;줄거리&nbsp;&nbsp;<i class="fas fa-quote-right"></i>
						<p id="info_cont3" class="info_cont"></p>
					</span>
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