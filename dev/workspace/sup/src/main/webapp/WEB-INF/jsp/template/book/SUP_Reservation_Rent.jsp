<%@page import="java.io.Console"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link href='/css/cal/fullcalendar.min.css' rel='stylesheet' />
<link href='/css/cal/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/js/cal//moment.min.js'></script>
<!-- <script src='/js/cal/jquery.min.js'></script> -->
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
	max-width: 900px;
	margin: 0 auto;
}
.fc-unthemed th{pointer-events:none;}
</style>


<link rel="stylesheet" href="/css/sliderstyle.css">
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<script type="text/javascript">
$(function(){
	
	$(document).ready(function(){
		

		var viewNM = '';
		
		$('#calendar').fullCalendar({
			header : {
				left : 'prev,next today',
				center : 'title',
				right : ""
			},
			//header: { left: 'prev,next,today', center: 'title', right: 'month,basicWeek,basicDay' },
			defaultView :"agendaWeek",
			defaultDate : new Date(),
			minTime : "09:00:00",
			maxTime : "19:30:00",
			navLinks : true, // can click day/week names to navigate views
			editable : false,
			eventLimit : true, // allow "more" link when too many events
			locale : 'ko',
			events : [
{ title: 'All Day Event', start: '2018-04-01' }, 
{ title: 'Long Event', start: '2018-04-07', end: '2017-04-10' },
{ id: 999, title: 'Repeating Event', start: '2018-04-09T16:00:00' }

			],
			timeFormat: 'H:mm',
			eventRender : function(event, element) {
// 				console.log('event', event);
				nttid=event._id;
				if (viewNM != 'month' && event.description != undefined)
					element.find('.fc-title').append("<br/>" + event.description);

				switch (event._id) {
					case 'reservrent':
						element.css({
							'background-color' : getBackgroundColorForRsvRent(event.room),
							'border-color' : '#333333'
						});
						break;
					case 'reservedu':
						element.css({
							'background-color' : '#aae506',
							'border-color' : '#333333'
						});
						break;
					case 'reservbus':
						element.css({
							'background-color' : '#1720d1',
							'border-color' : '#333333'
						});
						break;
					case 'reservtrip':
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
		<c:forEach items="${reservRentList}" var="item">
		/*
		
		이부분이 캘린더 데이터 가져오는 부분 입니다.
		/egovCommon/src/main/webapp/cal/examples 부분에서 샘플 확인하실 수 있습니다.
		
		*/
		if("${item.NTT_ID == 'reservrent'}"){
			var json = new Object();
			json._id = "${item.NTT_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
			json.room = "${item.ROOM}";
			//json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			
			list.push(json); 
		}else if("${item.NTT_ID == 'reservedu'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
			//json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}else if("${item.NTT_ID == 'reservtrip'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			//json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}else if("${item.NTT_ID == 'reservbus'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			//json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}
// 		console.log(json);
	</c:forEach>
	
	$('.mobile_calendar').fullCalendar({
			 defaultView: 'listWeek',
			 header : {
				left : 'prev,next',
				center : 'title',
				right : 'today'
			}
	}); 

	$('#calendar, .mobile_calendar').fullCalendar('addEventSource', list);
// 	console.log($('#calendar').fullCalendar('clientEvents'));
	});
	
	$(document).on('click','.fc-day-number',function(){
		var date = $(this).attr("data-goto");
		var json = JSON.parse(date);
		$(this).attr("href","/admin/selectBoard.do?NTT_ID="+nttid+"&date="+json.date);
	});
});
	
/**
*	대관의 구분은 'ROOM'으로 한다. ROOM에 BSS_ID를 매핑함
*	rent : BBS_ID
*	BBS_ID		TITLE					background-color
*	837		1층 미디어룸					#F78181
*	836		4층 공용스튜디오 미팅룸1		#F7BE81
*	835		4층 공용스튜디오 미팅룸2		#F4FA58
*	834		4층 공용스튜디오 피팅룸1		#ACFA58
*	833		4층 공용스튜디오 피팅룸2		#2EFEF7
*	832		4층 공용스튜디오 체험실			#2E2EFE
*	831		4층 교육실						#CC2EFA
*	606		5층 교육실						#A4A4A4
*/
function getBackgroundColorForRsvRent(roomCd) {
	var rgbCode = '';
	switch(roomCd) {
		case '837' :
			rgbCode = '#F7CB15';
			break;
		case '836' :
			rgbCode = '#78C3FB';
			break;
		case '835' :
			rgbCode = '#D1345B';
			break;
		case '834' :
			rgbCode = '#B47EB3';
			break;
		case '833' :
			rgbCode = '#92D1C3';
			break;
		case '832' :
			rgbCode = '#C9C19F';
			break;
		case '831' :
			rgbCode = '#CC2EFA';
			break;
		case '606' :
			rgbCode = '#C9C19F';
			break;
		case '838' :
			rgbCode = '#78C3FB';
			break;
		default :
			rgbCode = '#C9C19F';
			break;
	}
	console.log(roomCd, rgbCode);
	return rgbCode;
}
	/*$(".reservBtn").click(function() {
		//if (1 != 1) 
		//alert('${loginVO.id}')
		var loginId = '${loginVO.id}'
		if (loginId == "") {
			location.href='/loginUsr.do';
		} else {
			location.href="bookinsert.do?NTT_ID=rent&BBS_ID="+$(this).attr("data-num");

		}
	
	});*/
	
	
</script>

<div id="main_wrap">
	<!--  Header 영역  -->

	<!--  //Header 영역  -->
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation office">
			<div class="content_h3bx">
				<h3>대관</h3>
				<ul class="route">
                    <li>홈</li>
                    <li>대관 및 예약</li>
                    <li>대관</li>
                </ul>
			</div>

			<div class="tep_list_box">
			   <p class="select_title">선택</p>
				<ul class="tep_list clear">
					<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
						<c:if test="${i.index == 0 }">
							<li><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
						<c:if test="${i.index != 0 }">
							<li><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>

			<div class="tep_wrap" >
				<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
					<c:if test="${not empty rentlist[i.index].BBS_ID}" >
					<div class="tep_box tep_box${i.index }">
						<c:set value="${fn:split(rentlist[i.index].ITEM_IMAGE,';') }" var="im" />
						<section class="sub_slider slider${i.index }">
							<c:forEach begin="0" end="${fn:length(im)-1 }" varStatus="y">
								<c:if test="${y.index == 0 }" >
									<img class="center" src="/uploadStorage/file/${im[y.index] }" />
								</c:if>
								<c:if test="${y.index != 0 && im[y.index]!='null'}" >
									<img src="/uploadStorage/file/${im[y.index]}" />
								</c:if>
								
							</c:forEach>
						</section>

						<div class="info_box">
						<!-- 이전 대관 정보 들어오는 형식 레이아웃 숨김처리 -->
							<!-- <ul class="info_list clear">
								<li>
									<h3>${rentlist[i.index].TITLE }</h3>
								</li>
								<li>
									<h4>운영시간</h4>
									<p>${rentlist[i.index].FDAY}<br>${rentlist[i.index].FTIME}
										~ ${rentlist[i.index].STIME}
									</p>
								</li>
								<li>
									<h4>사용 가능 인원</h4>
									<p>${rentlist[i.index].CNT }</p>
								</li>
													
								<li>
									<h4>이용료</h4> <c:set var="big"
										value="${fn:split(rentlist[i.index].PRICE,',')}" />
									<p>
										${big[0] }<br>아동 : ${big[1] }
									</p>
								</li>
								<li>
									<h4>특이사항</h4>
									<p>${rentlist[i.index].CONTENT }</p>
								</li>
								<li>
									<h4>담당자</h4>
									<p>${rentlist[i.index].PTB }</p>
								</li>
							</ul> -->

							<!-- 예약현황 테이블  -->
					<div class="btn_group">
								<div class="btn">
									<p class="reserv_btn" onclick="location.href='/studio.do?type=Studio_Rent';"><!--http://61.97.54.228/studio.do?type=Studio_Rent-->
										상세보기
									</p>
								</div>
								<div class="btn">
									<p class="reserv_btn" onclick="javascript:document.getElementById('rentPopWrap').style.display='block';">
										예약하기
									</p>
								</div>
							</div>
						</div>
					</div>
					</c:if>
				</c:forEach>

			</div>

		</article>
	</section>
</div>

<div id='calendar'></div>
<div class="mobile_calendar"></div>

<style>
	.mobile_calendar{display:none;}

	
	@media all and (max-width:768px) {
		.mobile_calendar{display:block;}
		#calendar{display:none;}
		.fc button .fc-icon{margin:0 2.2em;}
		.mobile_calendar div.fc-right button.fc-corner-right{right:0;left:0;top:-40px;}
	}

</style>

<script src="/js/slider.jquery.js"></script>
<!--
<script>

/* ++++++++++++++++++++++++++++++++++++++
* DOM 제작기 
* 
+++++++++++++++++++++++++++++++++++++++ */
iDom = function(){};
iDom = {
	make : function(tagName,styleClass,oTitle) {
		var node;
		node = document.createElement(tagName);
		node.className = styleClass;	
		if (typeof oTitle != 'undefined' ) {
			node.setAttribute("title",oTitle);
		}
		return node;
	},
	makeInputBtn : function(textvalue,styleClass) {
		var node;
		node = document.createElement('input');
		node.setAttribute("type","button");
		node.className = styleClass;
		node.value = textvalue;
		if (typeof oTitle != 'undefined' ) {
			node.setAttribute("title",textvalue);
		}
		return node;
	},
	makeInputHidden : function(inputname,textvalue) {
		var node;
		node = document.createElement('input');
		node.setAttribute("type","hidden");
		node.setAttribute("name",inputname);
		node.value = textvalue;
		if (typeof oTitle != 'undefined' ) {
			node.setAttribute("title",textvalue);
		}
		return node;
	},
	ImgMake : function(oSrc,oTitle ,styleClass) { // 이미지 생성 
		var node;
		node = document.createElement('img');
		node.src = oSrc;
		node.className = styleClass;	
		if (typeof oTitle != 'undefined' ) {
			node.setAttribute("alt",oTitle);
			node.setAttribute("title",oTitle);
		}
		return node;	
	},	
	attach : function(element, type, fn) {
		if (element.addEventListener){
			element.addEventListener(type, fn, false);
		} else if (element.attachEvent){
			element.attachEvent('on' + type, fn);
		}	
	},
	detach : function(element, type, fn) {
		if (element.removeEventListener){
			element.removeEventListener(type, fn, false);
		} else if (element.attachEvent){
			element.detachEvent('on' + type, fn);
		}
	},
	preventDefault : function(e) {
		if (e.preventDefault){
			e.preventDefault();
		} else{
			e.returnValue = false;
		}
	}
}










	var rentObj = new Array();
	function tep_list() {
		objli = document.getElementById('tep_list');
		
		for (i = 0 ; i < objli.childNodes.length ; i++) {
			if( objli.childNodes[i].nodeName == "LI" ) {
				console.log("----------");
				console.log(objli.childNodes[i].nodeName);
				// 
				obj = objli.childNodes[i];
				
			}
		}
	}
	
	tep_list();



	*/
	$('.tep_list li').click(function() {

		$(this).addClass('active').siblings().removeClass('active');
		var tep = $(this).index();

		// alert('.tep_box' + tep);
		$('.tep_box').hide();
		$('.tep_box' + tep).show();

	});
/*
	// $('.tep_list li:nth-of-type(1)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box1').show();

	// });

	// $('.tep_list li:nth-of-type(2)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box2').show();

	// });

	// $('.tep_list li:nth-of-type(3)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box3').show();

	// });

	// $('.tep_list li:nth-of-type(4)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box4').show();

	// });
</script>
<script>
$('.icon_box_hr').click(function (){
    var val = $('#calendar').offset();
    $('html, body').animate({scrollTop:val.top - 70},600)
});
</script>


<script type="text/javascript">
	
	
	/*
	
	selectBox 제어 및 이미지 prev / next 시 양방향 제어
	dk 
	
	*/
		$('#selectrent').on('change', function(ev) {


			$("#selectrent").find("option").each(function() {
				var tt = $(this)[0].value ;

				if(tt =='#') {

				};

				var tv = $( "#selectrent option:selected" ).index();
					if($( "#selectrent option:selected" ).val() == this.value){
				    	$("#"+tt).attr('class' , 'center');
				    }else {
				    	var previd = tv-1;
				    	var nextid = tv+1;

				    	if(previd < 0) {previd = $("#selectrent option").size()-1;}

				    	if(nextid > $("#selectrent option").size()-1) {nextid = 0;}

				    	$("#"+tt).attr('class' , '');
				    	$("#id"+previd).attr('class' , 'left');
				    	$("#id"+nextid).attr('class' , 'right');
				    }
			});

		});

	
		$('#prev').on('click', function(ev) {

			var tv = $( "#selectrent option:selected" ).index();
			if(tv > 0) {
				$("#selectrent").val("id"+(tv-1));
			}else{
				tv = $("#selectrent option").size();
			  $("#selectrent").val("id"+(tv-1));
			}
		});

		
		$('#next').on('click', function(ev) {

			var tv = $( "#selectrent option:selected" ).index();
		
			if(tv < $("#selectrent option").size()-1) {
				$("#selectrent").val("id"+(tv+1));
			}else{
				tv = 0;
			  
			  $("#selectrent").val("id"+(tv));
			}
		});


</script>
-->
<script>
$('.tep_list li').click(function() {

		$(this).addClass('active').siblings().removeClass('active');
		var tep = $(this).index();

		// alert('.tep_box' + tep);
		$('.tep_box').hide();
		$('.tep_box' + tep).show();

	}); 
</script>
<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>
<style>
.fc button .fc-icon{margin: 0 2.2em;}
/* .fc-event .fc-bg{    background: #3a87ad;  opacity: .8;} */
.sub_slider{height:500px !important;}
@media all and (max-width:1201px){
	.sub_slider{height:400px !important;}
}
@media all and (max-width:1020px){
	.sub_slider{height:350px !important;}
}
@media all and (max-width:850px){
	.sub_slider{height:330px !important;}
}
@media all and (max-width:680px){
	.sub_slider{height:280px !important;}
}
@media all and (max-width:580px){
	.sub_slider{height:230px !important;}
}
@media all and (max-width:500px){
	.sub_slider{height:180px !important;}
}
@media all and (max-width:400px){
	.sub_slider{height:140px !important;}
}
</style>
