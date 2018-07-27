﻿<%@page import="java.awt.Window"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.bx-wrapper .bx-pager {
	bottom: 10px;
}

.bx-wrapper .bx-pager.bx-default-pager a:hover, .bx-wrapper .bx-pager.bx-default-pager a.active,
	.bx-wrapper .bx-pager.bx-default-pager a:focus {
	background-color: #63b746;
}

.bx-wrapper .bx-pager.bx-default-pager a {
	background: #fff;
}
</style>

<link href='/css/cal/fullcalendar.min.css' rel='stylesheet' />
<link href='/css/cal/fullcalendar.print.min.css' rel='stylesheet'
	media='print' />
<script src='/js/cal//moment.min.js'></script>
<script src='/js/cal/jquery.min.js'></script>
<script src='/js/cal/fullcalendar.js'></script>
<script src='/js/cal/locale-all.js'></script>
<style>
.fc-sat {
	color: blue;
}

.fc-sun {
	color: red;
}

body {
	padding: 0;
}

#calendar {
	max-width: 350px;
	margin: 0 auto;
	font-size: 14px;
	position: relative;
	top: -10px;
}

.fc-toolbar.fc-header-toolbar {
	margin-bottom: 0
}

.fc button {
	height: 1.9em
}

.fc-center h2 {
	font-size: 16px
}

.fc-head-container {
	height: 23px;
}

.fc-view-container {
	position: relative;
	top: -10px;
}

.fc-basic-view .fc-body .fc-row {
	min-height: 2em;
}

.main_plan .plan_wrap>div .title a.moreNotice {
	display: inline-block;
	margin-top: 5px;
}

.main_plan .plan_wrap>div.notice .title h3 {
	display: inline-block;
}

.bx-wrapper .bx-controls-direction a {
	display: block !important;
}
</style>
<script type="text/javaScript">
var tag ="";
$(function(){
	$(document).ready(function(){
		var viewNM = '';
		$('#calendar').fullCalendar({
			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'month,agendaWeek,agendaDay,listWeek'
			},
			defaultDate : new Date(),
			minTime : "09:00:00",
			maxTime : "19:30:00",
			navLinks : false, // can click day/week names to navigate views
			editable : false,
			eventLimit : false, // allow "more" link when too many events
			locale : 'ko',
			events : [
					 
			],
			timeFormat: 'H:mm',
			eventRender : function(event, element) {
				console.log(event._id);
				if (viewNM != 'month' && event.description != undefined)
					element.find('.fc-title').append("<br/>" + event.description);

				switch (event._id) {
					case 'rent':
						element.css({
							'background-color' : '#f22404',
							'border-color' : '#333333'
						});
						break;
					case 'edu':
						element.css({
							'background-color' : '#aae506',
							'border-color' : '#333333'
						});
						break;
					case 'bus':
						element.css({
							'background-color' : '#1720d1',
							'border-color' : '#333333'
						});
						break;
					case 'trip':
						element.css({
							'background-color' : '#f97cc3',
							'border-color' : '#333333'
						});
						break;
				}
			},
			viewRender : function(view, element) {
				viewNM = view.name;
			}
		});
		var list = new Array();
		<c:forEach items="${list}" var="item">
			var json = new Object();
			json._id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
			json.bbs = "${item.BBS_ID}";
			json.url = "/bookinsert.do?NTT_ID=${item.NTT_ID}&BBS_ID=${item.BBS_ID}";
			list.push(json); 
			
		</c:forEach>
		$('#calendar').fullCalendar('addEventSource', list);
// 		console.log($('#calendar').fullCalendar('clientEvents'));
		
	});
		

	$(document).on('mouseover','.fc-day-grid-event',function(){
		var atag = $(this);
		if(atag.hasClass('on') == true){
			return;
		}else{
			atag.addClass("on");
		}
		var k = "";
		var bbs = "";

		k = $(this).attr("href");
		if(k.indexOf(")") == -1){
			bbs = k.substring(k.lastIndexOf('=')+1,k.length);
		}else{
			bbs = k.substring(k.lastIndexOf('=')+1,k.lastIndexOf("'"));
		}
		console.log(bbs);
		var title = "";
		var rdcnt = "";
		var cnt = "";
		var fdate = "";
		var ftime = "";
		var stime = "";
		var image = "";
		var bbsid = "";
		var nttid = "";
		var simplecontent ="";
		$.ajax({
		    type: "GET",
		    url: "/ajaxSelect.do",
		    dataType: "JSON",
		    data: "BBS_ID="+bbs,
		    success: function(data) {
				title = data.TITLE;
				rdcnt = data.RDCNT;
				cnt = data.CNT;
				fdate = data.FDATE;
				ftime = data.FTIME;
				stime = data.STIME;
				image = data.IMAGE;
				bbsid = data.BBS_ID;
				nttid = data.NTT_ID;
				simplecontent = data.SIMPLECONTENT;
				tag =  "<div class='simple_schedule'><div class='img_box'><img width='110' height='80' src='/uploadStorage/file/"+image+"' alt=''/></div><div class='content_box'><div class='btn_wrap'>";
				if(rdcnt < cnt){
					tag+="<p href='/bookinsert.do?NTT_ID="+nttid+"&BBS_ID="+bbsid+"'>접수중</p>";
				}else{
					tag+="<p>접수불가</p>";
					atag.attr("href","javascript:alert('접수인원이 초과 됐습니다. \nerror="+bbs+"');");
				}
				tag+="</div><div class='text_box'><dl><dt>"+title+"</dt><dd>간단설명 : "+simplecontent+"</dd><dd>교육일 : "+fdate+"/"+ftime+"~"+stime+"</dd><dd>신청인원 : "+rdcnt+"/"+cnt+"</dd></dl></div></div></div>"
				
				atag.append(tag);
				
				atag.css({
					'z-index': 100,
					'position': 'relative',
				});
				atag.parent('td').css({
					'z-index': 100,
					'position': 'relative',
				});
				atag.parents('.fc-row').css({
					'z-index': 100,
					'position': 'relative',
				});
		    }
		});
	});

		$(document).on('mouseleave','.fc-day-grid-event',function(){
			
			$(this).removeClass('on');
			$('.simple_schedule').remove();
			$(this).css({
				'z-index': 1,
				'position': 'relative',
			});
			$(this).parent('td').css({
				'z-index': 1,
				'position': 'relative',
			});
			$(this).parents('.fc-row').css({
				'z-index': 1,
				'position': 'relative',
			});
		});
		$(document).on('click','.fc-day-number',function(){
			$(this).attr("data-goto",null);
		});
	
	
	
	
});

	function getDateRange(startDate, endDate, listDate){
		var dateMove = new Date(startDate);
		var strDate = startDate;
		if (startDate == endDate){
			var strDate = dateMove.toISOString().slice(0, 10);
			listDate.push(strDate);
		}else{
			while (strDate < endDate)
			{
				var strDate = dateMove.toISOString().slice(0, 10);
				listDate.push(strDate);
				dateMove.setDate(dateMove.getDate() + 1);
			}
		}
		return listDate;
	};

</script>




<body>

	<%-- 	<jsp:include page="/html/index_popup.jsp"></jsp:include> --%>

	<!--  Main section 영역  -->
	<section id="section">
		<article class="visual_area">
			<ul class="visual_slider">
				<!--
                <li><a href=""><img src="http://shapl.com/1/1.jpg" /></a></li>
                <li><a href=""><img src="http://shapl.com/1/2.jpg" /></a></li>
                <li><a href=""><img src="http://shapl.com/1/3.jpg" /></a></li>
			-->

				<!-- 메인 슬라이드 들어갈 자리 -->
				<c:forEach begin="0" end="${bannerlist.size() }" varStatus="i">
					<c:if test="${not empty bannerlist[i.index] }">
						<li><a href="${bannerlist[i.index].LINK_URL}"><img
								src="/uploadStorage/file/${bannerlist[i.index].BANNER_IMAGE_FILE }"
								alt="배너${i.index+1 }"></a></li>
					</c:if>
				</c:forEach>

			</ul>
		</article>
		<article class="main_inform">
			<!-- <div class="main_notice">
				<div class="main_noticebx clear">
					<div class="main_noticett clear">NOTICE</div>
					<div class="main_noticelist">
						<div class="slide_notice">
							<ul>
								<li><a href="">최신 공지사항이 올라옵니다.1</a></li>
								<li><a href="">최신 공지사항이 올라옵니다.2</a></li>
								<li><a href="">최신 공지사항이 올라옵니다.3</a></li>
								<li><a href="">최신 공지사항이 올라옵니다.4</a></li>
								<li><a href="">최신 공지사항이 올라옵니다.5</a></li>
							</ul>
						</div>
						<img src="../img/main/icon_arrow_up.png" alt="지나간 공지사항 되돌리기 아이콘">
					</div>
					<div class="main_noticebtn">
						<img src="../img/main/icon_pause.png" alt="공지사항 슬라이드 중지 아이콘">
					</div>
				</div>
			</div> -->
			<div class="main_program">
				<h2>: 새소식</h2>
				<ul class="clear">
					<!--
                    <li><a href=""><img src="http://shapl.com/1/img1.png" /></a></li>
                    <li><a href=""><img src="http://shapl.com/1/img2.png" /></a></li>
                    <li><a href=""><img src="http://shapl.com/1/img3.png" /></a></li>
                    <li><a href=""><img src="http://shapl.com/1/img4.png" /></a></li>
                    <li><a href=""><img src="http://shapl.com/1/img5.png" /></a></li>
                    <li><a href=""><img src="http://shapl.com/1/img6.png" /></a></li>
				-->

					<c:forEach begin="0" end="${programlist.size() }" varStatus="i">
						<c:if test="${not empty programlist[i.index] }">
							<li><a href="${programlist[i.index].LINK_URL }"><img
									height="auto" width="250" alt="프로그램 이미지"
									src="/uploadStorage/file/${programlist[i.index].BANNER_IMAGE_FILE }"></a>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</article>
		<article class="main_slider">
			<h2>: 새활용 플라자와 함께하기</h2>
			<ul class="slider clear">
				<li class="slide">
					<h3>시설대관</h3> <a href="/book.do?type=rent"><img
						src="/img/main/reservation_Office_2.png" alt=""></a>
					<p>
						미디어룸/교육실/공용스튜디오<br>
						<!-- <span>설치 및 철거일 동일요금 적용,<br>
					10:00~21:00 사용 기준</span></p> -->
				</li>
				<li class="slide">
					<h3>교육신청</h3> <a
					href="/book.do?type=edu"><img
						src="/img/main/main_slider_img1.png" alt=""></a>
					<p>
						새활용플라자 교육 프로그램<br>
						<!-- <span>설치 및 철거일 동일요금 적용,<br>
					10:00~21:00 사용 기준</span></p> -->
				</li>
				<li class="slide active">
					<h3>새활용탐방신청</h3> <a href="/book.do?type=trip"><img
						src="/img/main/reservation_learning_3.png" alt=""></a>
					<p>
						새활용플라자 투어 프로그램(20명이하)<br>
						<!-- <span>설치 및 철거일 동일요금 적용,<br>
					10:00~21:00 사용 기준</span></p> -->
				</li>
				<li class="slide">
					<h3>꿈꾸는 공장</h3> <a href="/display.do?type=Display_Fablab"><img
						src="/img/main/slider_4.png" alt=""></a>
					<p>
						새활용플라자 팹랩(FAB LAB)<br>
						<!-- <span>설치 및 철거일 동일요금 적용,<br>
					10:00~21:00 사용 기준</span></p> -->
				</li>
				<li class="slide">
					<h3>셔틀버스</h3>
					<a class="busBtn"><img src="/img/main/slider_5.png" alt=""></a>
					<p>
						셔틀버스 신청하러 가기<br>
						<!-- <span>설치 및 철거일 동일요금 적용,<br>
					10:00~21:00 사용 기준</span></p> -->
				</li>
			</ul>
		</article>

		<!-- <article class="tab_area">
			<div class="main_tab">
				<h4>
					<a href="#t1" class="tab tab1 tabOn">전체시설</a>
				</h4>
				<div class="tab_box tab_box1">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t2" class="tab tab2">스튜디오</a>
				</h4>
				<div class="tab_box tab_box2">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t3" class="tab tab3">카페</a>
				</h4>
				<div class="tab_box tab_box3">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t4" class="tab tab4">레스토랑</a>
				</h4>
				<div class="tab_box tab_box4">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t5" class="tab tab5">장비</a>
				</h4>
				<div class="tab_box tab_box5">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t6" class="tab tab6">종합안내실</a>
				</h4>
				<div class="tab_box tab_box6">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
				<h4>
					<a href="#t7" class="tab tab7">대피동선안내</a>
				</h4>
				<div class="tab_box tab_box7">
					<img src="../img/main/tab_box1.png" alt="">
				</div>
			</div>
		</article> -->
		<article class="main_plan">
			<div class="plan_wrap clear">
				<div class="time">
					<div class="title">
						<h3>운영시간</h3>
						<a href="/introduce.do?type=Location" class="hidden">오시는 길</a>
					</div>
					<ul>
						<li><span>화 ~ 일요일 </span> 10:00AM ~ 6:00PM</li>
						<li><span>금 , &nbsp;토요일 </span> 10:00AM ~ 6:00PM</li>
					</ul>
					<p>*매주 월요일, 설날, 추석 당일 휴관</p>
					<div class="location">
						<a href="/introduce.do?type=Location"> <span>오시는 길</span>
						</a>

					</div>
				</div>


				<div class="notice">
					<div class="title">
						<h3>공지사항</h3>
						<a class="moreNotice" href="/board.do?type=notice">더보기</a>
					</div>
					<c:forEach begin="0" end="4" varStatus="i">
						<c:if test="${not empty noticeList[i.index]  }">
							<ul>
								<li class="clear"><span> <a
										href="/detail.do?NTT_ID=${noticeList[i.index].NTT_ID }&BBS_ID=${noticeList[i.index].BBS_ID }">
											${noticeList[i.index].TITLE} </a>
								</span> <span>${noticeList[i.index].PUSHDATE }</span></li>
							</ul>
						</c:if>
					</c:forEach>
				</div>

				<!--				<div class="notice">
					<div class="title"><h3>공지사항</h3><a href="#" class="hidden">더보기</a></div>
					<ul>
						<li class="clear"><span>[답변공유] 스튜디오  입주 등 문z의 답변</span><span>2018-01-26</span></li>
						<li class="clear"><span>[답변공유] 스튜디오  입주 등 문의 답변</span><span>2018-01-26</span></li>
						<li class="clear"><span>[답변공유] 스튜디오  입주 등 문의 답변</span><span>2018-01-26</span></li>
						<li class="clear"><span>[답변공유] 스튜디오  입주 등 문의 답변</span><span>2018-01-26</span></li>
						<li class="clear"><span>[답변공유] 스튜디오  입주 등 문의 답변</span><span>2018-01-26</span></li>
					</ul>
				</div> -->
				<!-- <div class="calender"></div> -->
				<div class="calender1">
					<!-- 작은 달력 스타일 -->
					<div id='calendar'></div>
					<!-- // 작은 달력 스타일 -->
				</div>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->

	<c:forEach items="${popuplist}" var="item" varStatus="i">
		<c:set var="position" value="${item.POSITION}"/>
		<c:set var="idx" value="${ fn:indexOf(position, ',') }"/>
		<form name="notice_form" id="notice_form${i.index}" 
				style="top:${ fn:substring(position, 0, idx) }px; left:${ fn:substring(position, idx, -1) }px;">
			<div id="mainPop">
				<div class="popup_close">
					<span>오늘 하루 보지 않기</span>
					<input type="checkbox" name="chkbox" id="chkbox${i.index}"
						onclick="javascript:closeWin(this);"/>
					<div class="rentPopcloseBtnDiv"
						onclick="javascript:document.getElementById('notice_form${i.index}').style.display='none';">
						<div></div>
						<div></div>
					</div>
				</div>
				<img src="/uploadStorage/file/${item.BANNER_IMAGE_FILE}" alt="팝업이미지"
					onclick="javascript:location.href='${item.LINK_URL}';"/>
			</div>
		</form>
	</c:forEach>

</body>
<style>
#notice_form0, #notice_form1, #notice_form2, #notice_form3, #notice_form4, #notice_form5 {
	width: 30%;
	position: absolute;
	z-index: 99999;
/* 	top: 141px; top left 위치 지정은 관리자 화면에서 지정한 좌표(포지션) 값으로 대체함 */
/* 	left: 0; */
}

#notice_form0 img, #notice_form1 img , #notice_form2 img , #notice_form3 img , #notice_form4 img , #notice_form5 img {
	width: 100%;
	cursor: pointer;
}

.popup_close {
	background: #5a5a5a;
	padding: 0.2% 0;
}

.popup_close span {
	color: #fff;
	margin: 0 2%;
}

#notice_form0 .rentPopcloseBtnDiv>div, #notice_form1 .rentPopcloseBtnDiv>div, #notice_form2 .rentPopcloseBtnDiv>div
, #notice_form3 .rentPopcloseBtnDiv>div, #notice_form4 .rentPopcloseBtnDiv>div, #notice_form5 .rentPopcloseBtnDiv>div {
	background: #fff;
	top: 2px;
	right: 15px;
}
/*@media all and (max-width:1279px) {
.main_program ul li a{text-align:center;}
.main_program ul li a img{width: initial;}
}*/
@media all and (max-width:900px) {
	.main_program ul li a img {
		width: 100%;
	}
}

@media all and (max-width:760px) {
	#mainPop {
		display: none;
	}
}
</style>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>
<script type="text/javascript">

	var list = new Array(); 
	<c:forEach items="${popuplist}" var="item" varStatus="i">
		var json = new Object();
		json.BANNER_ID="${item.BANNER_ID}";
		json.LINK_URL="${item.LINK_URL}";
		json.REFLCT_AT="${item.REFLCT_AT}";
		json.BANNER_IMAGE_FILE="${item.BANNER_IMAGE_FILE}";
		json.POSITION="${item.POSITION}";
		json.FDATE="${item.FDATE}";
		json.SDATE="${item.SDATE}";
		list.push(json);
		
		
		// 테스트용(쿠키 삭제하기) 평소에는 주석처리 해둘것!
// 		deleteCookie('notice_form${i.index}');
		
// 		console.log('getCookies : notice_form${i.index} - ', getCookie('notice_form${i.index}') );
		// hide 체크된 팝업 숨기기
		if( getCookie('notice_form${i.index}') == 'done' ) {
			$('#' + 'notice_form${i.index}').hide();
		}
	</c:forEach>
	
	

	$(".busBtn").click(function() {
		var loginId = '${loginVO.id}'
		if (loginId == "") {
			location.href='/loginUsr.do';
		} else{
			location.href="/bookinsert.do?NTT_ID=bus&BBS_ID=";
		}
	});
	
	$(".alltrip").click(function() {
		var loginId = '${loginVO.id}'
		if (loginId == "") {
			location.href='/loginUsr.do';
		} else{
			location.href="/mvpage.do?NTT_ID=tripT";
		}
	});
	
	/**
	*	팝업 클로즈 이벤트
	*	parameter : clicked Element
	*	click Event : true -> popup hide 
	*/
	function closeWin(object) {
		
		var checkboxChecked = $(object).is(":checked");
		var formElem = $(object).parents('form[name="notice_form"]')[0];
		var formId = $(formElem).attr('id');
		
// 		console.log('checkboxChecked', checkboxChecked);
// 		console.log('formId', formId);
		if (checkboxChecked) {
			setCookie(formId, "done", 1);
			$(formElem).hide();
		}
	}
	
	/**
	*	쿠기 설정
	*	parameter : formId - 해당 폼id를 구분으로 쿠키 expiredays 셋팅
	*/
	function setCookie(formId, value, expiredays) {
		var todayDate2 = new Date();
		todayDate2.setDate(todayDate2.getDate() + expiredays);
		document.cookie = formId + "=" + escape(value) + "; path=/; expires=" + todayDate2.toGMTString() + ";";
	}
		
	/**
	*	쿠키 설정 가져오기
	*/
	function getCookie(cName) {
        cName = cName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cName);
        var cValue = '';
        if(start != -1){
            start += cName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cValue = cookieData.substring(start, end);
        }
        return unescape(cValue);
    }
	
	 /**
	  * 쿠키 삭제
	  * @param cookieName 삭제할 쿠키명
	  */
	 function deleteCookie( cookieName ) {
	  var expireDate = new Date();
	  
	  //어제 날짜를 쿠키 소멸 날짜로 설정한다.
	  expireDate.setDate( expireDate.getDate() - 1 );
	  document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
	 }
</script>