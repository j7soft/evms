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
			eventRender : function(event, element) {
				console.log(event._id);
				nttid=event._id;
				if (viewNM != 'month' && event.description != undefined)
					element.find('.fc-title').append("<br/>" + event.description);

				switch (event._id) {
					case 'reservrent':
						element.css({
							'background-color' : '#aae506',
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
		<c:forEach items="${rentlist}" var="item">
		/*
		
		이부분이 캘린더 데이터 가져오는 부분 입니다.
		/egovCommon/src/main/webapp/cal/examples 부분에서 샘플 확인하실 수 있습니다.
		
		*/
		if("${item.NTT_ID == 'rent'}"){
			var json = new Object();
			json._id = "${item.NTT_ID}";
			json.title = "${item.TITLE}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
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
		console.log(json);
	</c:forEach>
	$('#calendar').fullCalendar('addEventSource', list);
	console.log($('#calendar').fullCalendar('clientEvents'));
	});
	
	$(document).on('click','.fc-day-number',function(){
		var date = $(this).attr("data-goto");
		var json = JSON.parse(date);
		$(this).attr("href","/admin/selectBoard.do?NTT_ID="+nttid+"&date="+json.date);
	});
	
	
	$(".reservBtn").click(function() {
		//if (1 != 1) 
		//alert('${loginVO.id}')
		var loginId = '${loginVO.id}'
		if (loginId == "") {
			location.href='/loginUsr.do';
		} else {
			location.href="bookinsert.do?NTT_ID=rent&BBS_ID="+$(this).attr("data-num");

		}
	
	});
	
	
	/*
	
	selectBox 제어 및 이미지 prev / next 시 양방향 제어
	dk 
	
	*/
		$('select').on('change', function(ev) {


			$("select").find("option").each(function() {
				var tt = $(this)[0].value ;
				var tv = $( "select option:selected" ).index();
					if($( "select option:selected" ).val() == this.value){
				    	$("#"+tt).attr('class' , 'center');
				    }else {
				    	var previd = tv-1;
				    	var nextid = tv+1;
				    	if(previd < 0) {previd = $("select option").size();}
				    	if(nextid > $("select option").size()) {nextid = 0;}
				    	$("#"+tt).attr('class' , '');
				    	$("#id"+previd).attr('class' , 'left');
				    	$("#id"+nextid).attr('class' , 'right');
				    }
			});

		});

	
		$('#prev').on('click', function(ev) {
			var tv = $( "select option:selected" ).index();
			if(tv > 0) {
				$("select").val("id"+(tv-1));
			}else{
				tv = $("select option").size();
			  $("select").val("id"+(tv-1));
			}
		});

		
		$('#next').on('click', function(ev) {

			var tv = $( "select option:selected" ).index();
		
			if(tv < $("select option").size()-1) {
				$("select").val("id"+(tv+1));
			}else{
				tv = 0;
			  
			  $("select").val("id"+(tv));
			}
		});



});
</script>
<style>

</style>
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

			<div class="tep_list_box tep_wrap">
			   <p class="select_title">선택</p>
				<ul id="tep_list"  class="tep_list clear">
					<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
						<c:if test="${i.index == 1 }">
							<li class="select_depth1" value ="id${i.index}"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
						<c:if test="${i.index != 1 }">
							<li value ="id${i.index}"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
				</ul>
<select>
					<c:forEach begin="0" end="${rentlist.size()-1 }" varStatus="i">
						<c:if test="${i.index == 1 }">
							<option class="select_depth1" value ="id${i.index}"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
						<c:if test="${i.index != 1 }">
							<option value ="id${i.index}"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
</select>
				<span style="cursor:pointer;" class="icon_box_hr"></span>
			</div>



			<div class="tep_wrap" >
				<c:forEach begin="0" end="${rentlist.size()-1 }" varStatus="i">
					<c:if test="${not empty rentlist[i.index].BBS_ID}" >
					<div class="tep_box tep_box${i.index }">
						<c:set value="${fn:split(rentlist[i.index].ITEM_IMAGE,';') }" var="im" />
						<section class="sub_slider slider${i.index }" style="height: 500px;"> 
							<c:forEach begin="0" end="${fn:length(im)-1 }" varStatus="y">
								<c:if test="${y.index == 0 }" >
									<img id ="id${y.index}" class="center" src="/uploadStorage/file/${im[y.index] }" />
								</c:if>
								<c:if test="${y.index != 0 && im[y.index]!='null'}" >
									<img id ="id${y.index}" src="/uploadStorage/file/${im[y.index]}" />
								</c:if>
							</c:forEach>
						</section>

						<div class="info_box">
							<!-- 예약현황 테이블  -->
					<div class="btn_group">
								<div class="btn">
									<p class="reserv_btn" onclick="location.href='/studio.do?type=Studio_Rent';"><!--http://61.97.54.228/studio.do?type=Studio_Rent-->
										상세보기
									</p>
								</div>
								<div class="btn">
									<p class="reserv_btn reservBtn" data-num='${rentlist[i.index].BBS_ID }'>
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

<script src="/js/slider.jquery.js"></script>

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



	/*
	$('.tep_list li').click(function() {

		$(this).addClass('active').siblings().removeClass('active');
		var tep = $(this).index();

		// alert('.tep_box' + tep);
		$('.tep_box').hide();
		$('.tep_box' + tep).show();

	});
	*/

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


<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>
<style>
.fc button .fc-icon{margin: 0 2.2em;}
.fc-event .fc-bg{    background: #3a87ad;  opacity: .8;}
</style>