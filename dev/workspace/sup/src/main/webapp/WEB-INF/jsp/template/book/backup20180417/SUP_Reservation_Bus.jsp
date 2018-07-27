<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<link rel="stylesheet" href="/css/SUP_Introduction.css">

<link href='/css/cal/fullcalendar.min.css' rel='stylesheet' />

<link href='/css/cal/fullcalendar.print.min.css' rel='stylesheet' media='print' />
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
	max-width: 900px;
	margin: 0 auto;
}
</style>
<script src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#tbtn").click(function(){
			$.ajax({
				type:"GET",
				url:"/ajaxSelect.do",
				data:{
					"BBS_ID": "387"			
				},
				error: function(date) {
					alert(date);
				},
			});
			console.log("${data.NTT_ID}");
		
			
			
		/* 	var  url = "/ajaxSelect.do";
			$.getJSON(url,"data="+387, function(data){
				
			}).fail(function(){
				
			}); */
		});
		
		
		
		
		
		$("#busbtn").click(function() {
			/*if (1 != 1) {
				
			}else if(!checkForm($("#tel"),"비상연락처를" )){
				return;
			}else if(!inputVerify(3,$("#tel"))){
				
			
			}else if(!checkForm($("#fhour"),"시간을" )){
				return;
			}else if(!checkForm($("#fmin"),"분을" )){
				return;
			}else if(!checkForm($("#FDATE"),"일시를 " )){
				return;
			}else if(!checkForm($("#t1"),"이용목적을" )){
				return;
			}else if(!checkForm($("#t2"),"출발지를" )){
				return;
			}else if(!checkForm($("#t3"),"인원을" )){
				return;
			}else if(!checkForm($("#t4"),"기타 요청사항을" )){
				return;
			}else {*/
				
				console.log(${"#FDATE"}.val());
				console.log(${"#FTIME"}.val());
				console.log(${"#FOBJECT"}.val());
				console.log(${"#STARTING"}.val());
				console.log(${"#CNT"}.val());
				console.log(${"#TEL_SEC"}.val());
				console.log(${"#REQUEST"}.val());
		
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());

				$("#frm").attr({
					"method" : "post",
					"action" : "bookinsert2.do"
				});
				$("#frm").submit();
			}

		});

	});
</script>
<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation bus">

			<form id="frm" name="frm">
				<div class="content_h3bx">
					<h3>셔틀버스</h3>
					<ul class="route">
						<li>홈</li>
						<li>대관 및 예약</li>
						<li>셔틀버스</li>
					</ul>
				</div>
				<div class="request_area">
					<article class="shuttle_bus_box">

						<div class="bus_info_box">
						  <ul>
							<li class="bus_info1">
							   <p>셔틀버스 운영사항</p>
								<dl>
									<dt>1호(25인승)</dt>
									<dd>새활용플라자 → 장한평역 8번출구 → 새활용플라자</dd>
								</dl>
								<dl>
									<dt>2호(45인승)</dt>
									<dd>단체 방문차 픽업서비스용(2018년 4월 중 운행 시작 예정)</dd>
									<dd>화~일요일 운행(매주 월요일 휴무)</dd>
								</dl>
							</li>
							<li class="bus_info2">
							   <p>셔틀버스 운영시간</p>
								<dl>
									<dt>1호(25인승)</dt>
									<dd>08:50 ~ 18:20</dd>
									<dd>장한평역 매시 20분, 50분 출발. 30분 단위 운행</dd>
								</dl>
								<dl>
									<dt>2호(45인승)</dt>
									<dd>2018년 4월 중 운행 시작 예정<span>(서울시내 및 인근 수도권 대상)</span></dd>
									<dd>30인 이상 단체 교육 및 프로그램 참여자를 위한 픽업서비스</dd>
								</dl>
							</li>
						  </ul>
						</div>

					</article>

					<!-- 버스 캘린더 start -->
					<article class="bus_reservation">

					<h4>셔틀버스 신청하기</h4>


<script type="text/javaScript" >
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
			navLinks : true, // can click day/week names to navigate views
			editable : false,
			eventLimit : true, // allow "more" link when too many events
			locale : 'ko',
			events : [
					 
			],
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
		console.log($('#calendar').fullCalendar('clientEvents'));
		
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

					
<div id="calendar" class="fc fc-unthemed fc-ltr"><div class="fc-toolbar fc-header-toolbar"><div class="fc-left"><div class="fc-button-group"><button type="button" class="fc-prev-button fc-button fc-state-default fc-corner-left" aria-label="prev"><span class="fc-icon fc-icon-left-single-arrow"></span></button><button type="button" class="fc-next-button fc-button fc-state-default fc-corner-right" aria-label="next"><span class="fc-icon fc-icon-right-single-arrow"></span></button></div><button type="button" class="fc-today-button fc-button fc-state-default fc-corner-left fc-corner-right fc-state-disabled" disabled="">오늘</button></div><div class="fc-right"><div class="fc-button-group"><button type="button" class="fc-month-button fc-button fc-state-default fc-corner-left fc-state-active">월</button><button type="button" class="fc-agendaWeek-button fc-button fc-state-default">주</button><button type="button" class="fc-agendaDay-button fc-button fc-state-default">일</button><button type="button" class="fc-listWeek-button fc-button fc-state-default fc-corner-right">일정목록</button></div></div><div class="fc-center"><h2>2018년 3월</h2></div><div class="fc-clear"></div></div><div class="fc-view-container" style=""><div class="fc-view fc-month-view fc-basic-view" style=""><table class=""><thead class="fc-head"><tr><td class="fc-head-container fc-widget-header"><div class="fc-row fc-widget-header"><table class=""><thead><tr><th class="fc-day-header fc-widget-header fc-sun"><span>일</span></th><th class="fc-day-header fc-widget-header fc-mon"><span>월</span></th><th class="fc-day-header fc-widget-header fc-tue"><span>화</span></th><th class="fc-day-header fc-widget-header fc-wed"><span>수</span></th><th class="fc-day-header fc-widget-header fc-thu"><span>목</span></th><th class="fc-day-header fc-widget-header fc-fri"><span>금</span></th><th class="fc-day-header fc-widget-header fc-sat"><span>토</span></th></tr></thead></table></div></td></tr></thead><tbody class="fc-body"><tr><td class="fc-widget-content"><div class="fc-scroller fc-day-grid-container" style="overflow: hidden; height: 630px;"><div class="fc-day-grid fc-unselectable"><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-other-month fc-past" data-date="2018-02-25"></td><td class="fc-day fc-widget-content fc-mon fc-other-month fc-past" data-date="2018-02-26"></td><td class="fc-day fc-widget-content fc-tue fc-other-month fc-past" data-date="2018-02-27"></td><td class="fc-day fc-widget-content fc-wed fc-other-month fc-past" data-date="2018-02-28"></td><td class="fc-day fc-widget-content fc-thu fc-past" data-date="2018-03-01"></td><td class="fc-day fc-widget-content fc-fri fc-past" data-date="2018-03-02"></td><td class="fc-day fc-widget-content fc-sat fc-past" data-date="2018-03-03"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-other-month fc-past" data-date="2018-02-25"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-02-25&quot;,&quot;type&quot;:&quot;day&quot;}">25</a></td><td class="fc-day-top fc-mon fc-other-month fc-past" data-date="2018-02-26"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-02-26&quot;,&quot;type&quot;:&quot;day&quot;}">26</a></td><td class="fc-day-top fc-tue fc-other-month fc-past" data-date="2018-02-27"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-02-27&quot;,&quot;type&quot;:&quot;day&quot;}">27</a></td><td class="fc-day-top fc-wed fc-other-month fc-past" data-date="2018-02-28"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-02-28&quot;,&quot;type&quot;:&quot;day&quot;}">28</a></td><td class="fc-day-top fc-thu fc-past" data-date="2018-03-01"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-01&quot;,&quot;type&quot;:&quot;day&quot;}">1</a></td><td class="fc-day-top fc-fri fc-past" data-date="2018-03-02"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-02&quot;,&quot;type&quot;:&quot;day&quot;}">2</a></td><td class="fc-day-top fc-sat fc-past" data-date="2018-03-03"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-03&quot;,&quot;type&quot;:&quot;day&quot;}">3</a></td></tr></thead><tbody><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table></div></div><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-past" data-date="2018-03-04"></td><td class="fc-day fc-widget-content fc-mon fc-past" data-date="2018-03-05"></td><td class="fc-day fc-widget-content fc-tue fc-past" data-date="2018-03-06"></td><td class="fc-day fc-widget-content fc-wed fc-past" data-date="2018-03-07"></td><td class="fc-day fc-widget-content fc-thu fc-past" data-date="2018-03-08"></td><td class="fc-day fc-widget-content fc-fri fc-past" data-date="2018-03-09"></td><td class="fc-day fc-widget-content fc-sat fc-past" data-date="2018-03-10"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-past" data-date="2018-03-04"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-04&quot;,&quot;type&quot;:&quot;day&quot;}">4</a></td><td class="fc-day-top fc-mon fc-past" data-date="2018-03-05"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-05&quot;,&quot;type&quot;:&quot;day&quot;}">5</a></td><td class="fc-day-top fc-tue fc-past" data-date="2018-03-06"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-06&quot;,&quot;type&quot;:&quot;day&quot;}">6</a></td><td class="fc-day-top fc-wed fc-past" data-date="2018-03-07"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-07&quot;,&quot;type&quot;:&quot;day&quot;}">7</a></td><td class="fc-day-top fc-thu fc-past" data-date="2018-03-08"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-08&quot;,&quot;type&quot;:&quot;day&quot;}">8</a></td><td class="fc-day-top fc-fri fc-past" data-date="2018-03-09"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-09&quot;,&quot;type&quot;:&quot;day&quot;}">9</a></td><td class="fc-day-top fc-sat fc-past" data-date="2018-03-10"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-10&quot;,&quot;type&quot;:&quot;day&quot;}">10</a></td></tr></thead><tbody><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table></div></div><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-past" data-date="2018-03-11"></td><td class="fc-day fc-widget-content fc-mon fc-past" data-date="2018-03-12"></td><td class="fc-day fc-widget-content fc-tue fc-past" data-date="2018-03-13"></td><td class="fc-day fc-widget-content fc-wed fc-past" data-date="2018-03-14"></td><td class="fc-day fc-widget-content fc-thu fc-past" data-date="2018-03-15"></td><td class="fc-day fc-widget-content fc-fri fc-past" data-date="2018-03-16"></td><td class="fc-day fc-widget-content fc-sat fc-past" data-date="2018-03-17"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-past" data-date="2018-03-11"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-11&quot;,&quot;type&quot;:&quot;day&quot;}">11</a></td><td class="fc-day-top fc-mon fc-past" data-date="2018-03-12"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-12&quot;,&quot;type&quot;:&quot;day&quot;}">12</a></td><td class="fc-day-top fc-tue fc-past" data-date="2018-03-13"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-13&quot;,&quot;type&quot;:&quot;day&quot;}">13</a></td><td class="fc-day-top fc-wed fc-past" data-date="2018-03-14"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-14&quot;,&quot;type&quot;:&quot;day&quot;}">14</a></td><td class="fc-day-top fc-thu fc-past" data-date="2018-03-15"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-15&quot;,&quot;type&quot;:&quot;day&quot;}">15</a></td><td class="fc-day-top fc-fri fc-past" data-date="2018-03-16"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-16&quot;,&quot;type&quot;:&quot;day&quot;}">16</a></td><td class="fc-day-top fc-sat fc-past" data-date="2018-03-17"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-17&quot;,&quot;type&quot;:&quot;day&quot;}">17</a></td></tr></thead><tbody><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table></div></div><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-past" data-date="2018-03-18"></td><td class="fc-day fc-widget-content fc-mon fc-past" data-date="2018-03-19"></td><td class="fc-day fc-widget-content fc-tue fc-past" data-date="2018-03-20"></td><td class="fc-day fc-widget-content fc-wed fc-past" data-date="2018-03-21"></td><td class="fc-day fc-widget-content fc-thu fc-past" data-date="2018-03-22"></td><td class="fc-day fc-widget-content fc-fri fc-past" data-date="2018-03-23"></td><td class="fc-day fc-widget-content fc-sat fc-past" data-date="2018-03-24"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-past" data-date="2018-03-18"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-18&quot;,&quot;type&quot;:&quot;day&quot;}">18</a></td><td class="fc-day-top fc-mon fc-past" data-date="2018-03-19"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-19&quot;,&quot;type&quot;:&quot;day&quot;}">19</a></td><td class="fc-day-top fc-tue fc-past" data-date="2018-03-20"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-20&quot;,&quot;type&quot;:&quot;day&quot;}">20</a></td><td class="fc-day-top fc-wed fc-past" data-date="2018-03-21"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-21&quot;,&quot;type&quot;:&quot;day&quot;}">21</a></td><td class="fc-day-top fc-thu fc-past" data-date="2018-03-22"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-22&quot;,&quot;type&quot;:&quot;day&quot;}">22</a></td><td class="fc-day-top fc-fri fc-past" data-date="2018-03-23"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-23&quot;,&quot;type&quot;:&quot;day&quot;}">23</a></td><td class="fc-day-top fc-sat fc-past" data-date="2018-03-24"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-24&quot;,&quot;type&quot;:&quot;day&quot;}">24</a></td></tr></thead><tbody><tr><td rowspan="2"></td><td rowspan="2"></td><td class="fc-event-container">

</td><td rowspan="2"></td><td rowspan="2"></td><td rowspan="2"></td><td rowspan="2"></td></tr><tr><td class="fc-event-container">


</td></tr></tbody></table></div></div><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-past" data-date="2018-03-25"></td><td class="fc-day fc-widget-content fc-mon fc-past" data-date="2018-03-26"></td><td class="fc-day fc-widget-content fc-tue fc-past" data-date="2018-03-27"></td><td class="fc-day fc-widget-content fc-wed fc-past" data-date="2018-03-28"></td><td class="fc-day fc-widget-content fc-thu fc-past" data-date="2018-03-29"></td><td class="fc-day fc-widget-content fc-fri fc-today " data-date="2018-03-30"></td><td class="fc-day fc-widget-content fc-sat fc-future" data-date="2018-03-31"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-past" data-date="2018-03-25"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-25&quot;,&quot;type&quot;:&quot;day&quot;}">25</a></td><td class="fc-day-top fc-mon fc-past" data-date="2018-03-26"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-26&quot;,&quot;type&quot;:&quot;day&quot;}">26</a></td><td class="fc-day-top fc-tue fc-past" data-date="2018-03-27"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-27&quot;,&quot;type&quot;:&quot;day&quot;}">27</a></td><td class="fc-day-top fc-wed fc-past" data-date="2018-03-28"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-28&quot;,&quot;type&quot;:&quot;day&quot;}">28</a></td><td class="fc-day-top fc-thu fc-past" data-date="2018-03-29"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-29&quot;,&quot;type&quot;:&quot;day&quot;}">29</a></td><td class="fc-day-top fc-fri fc-today " data-date="2018-03-30"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-30&quot;,&quot;type&quot;:&quot;day&quot;}">30</a></td><td class="fc-day-top fc-sat fc-future" data-date="2018-03-31"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-03-31&quot;,&quot;type&quot;:&quot;day&quot;}">31</a></td></tr></thead><tbody><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table></div></div><div class="fc-row fc-week fc-widget-content fc-rigid" style="height: 105px;"><div class="fc-bg"><table class=""><tbody><tr><td class="fc-day fc-widget-content fc-sun fc-other-month fc-future" data-date="2018-04-01"></td><td class="fc-day fc-widget-content fc-mon fc-other-month fc-future" data-date="2018-04-02"></td><td class="fc-day fc-widget-content fc-tue fc-other-month fc-future" data-date="2018-04-03"></td><td class="fc-day fc-widget-content fc-wed fc-other-month fc-future" data-date="2018-04-04"></td><td class="fc-day fc-widget-content fc-thu fc-other-month fc-future" data-date="2018-04-05"></td><td class="fc-day fc-widget-content fc-fri fc-other-month fc-future" data-date="2018-04-06"></td><td class="fc-day fc-widget-content fc-sat fc-other-month fc-future" data-date="2018-04-07"></td></tr></tbody></table></div><div class="fc-content-skeleton"><table><thead><tr><td class="fc-day-top fc-sun fc-other-month fc-future" data-date="2018-04-01"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-01&quot;,&quot;type&quot;:&quot;day&quot;}">1</a></td><td class="fc-day-top fc-mon fc-other-month fc-future" data-date="2018-04-02"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-02&quot;,&quot;type&quot;:&quot;day&quot;}">2</a></td><td class="fc-day-top fc-tue fc-other-month fc-future" data-date="2018-04-03"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-03&quot;,&quot;type&quot;:&quot;day&quot;}">3</a></td><td class="fc-day-top fc-wed fc-other-month fc-future" data-date="2018-04-04"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-04&quot;,&quot;type&quot;:&quot;day&quot;}">4</a></td><td class="fc-day-top fc-thu fc-other-month fc-future" data-date="2018-04-05"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-05&quot;,&quot;type&quot;:&quot;day&quot;}">5</a></td><td class="fc-day-top fc-fri fc-other-month fc-future" data-date="2018-04-06"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-06&quot;,&quot;type&quot;:&quot;day&quot;}">6</a></td><td class="fc-day-top fc-sat fc-other-month fc-future" data-date="2018-04-07"><a class="fc-day-number" data-goto="{&quot;date&quot;:&quot;2018-04-07&quot;,&quot;type&quot;:&quot;day&quot;}">7</a></td></tr></thead><tbody><tr><td class="fc-event-container">

</td><td></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table></div></div></div></div></td></tr></tbody></table></div></div></div>

				<!-- 버스 캘린더 end -->

					<!-- 신청하기 폼 -->
					<div class="input_hr">
							<ul>
								<li>
									<h2>신청자명</h2>
									<div>
										<input type="text" name="bus_user_name" id="bus_user_name" value="${lvo.name }" required placeholder="신청자 명을 기입해 주세요">
									</div>
								</li>
							<!-- 	<li>
									<h2>일자</h2>
									<div>
										<input type="email" name="bus_user_day" id="bus_user_day" required placeholder="일자를 기입해 주세요">
									</div> -->
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="tel" name="bus_user_tel" id="bus_user_tel" required value="${lvo.tel }" placeholder="연락처를 기입해 주세요">
								</li>
								<li>
									<h2>이용날짜</h2>
									<div>
										<input class="timeInput" type="text" name="FDATE" id="FDATE" required>
								</li>
								<li>
									<h2>이용시간</h2>
									<div>
										<input type="time" name="FTIME" id="FTIME" required placeholder="이용시간을 선택하세요">
								</li>
								<li>
									<h2>이용목적</h2>
									<div>
										<input type="text" name="FOBJECT" id="FOBJECT" required placeholder="이용목적을 기입해 주세요">
									</div>
								</li>
								<li>
									<h2>출발지</h2>
									<div>
										<input type="text" name="STARTING" id="STARTING" required placeholder="출발지를 기입해 주세요">
									</div>
								</li>
								<li>
									<h2>탑승인원</h2>
									<div>
										<input type="number" name="CNT" id="CNT" placeholder="0">
									</div>
								</li>
								<li>
									<h2>비상연락처</h2>
									<div>
										<input type="text" name="TEL_SEC" id="TEL_SEC" placeholder="ex) 010-0000-0000">
									</div>
								</li>
								<li>
									<h2>기타요청사항</h2>
									<div>
										<textarea name="REQUEST" id="REQUEST" required></textarea>
									</div>
								</li>
								
							</ul>
	
					</div>



					<div class="btn_h">
				        <button>신청하기</button>
			        </div>


					</article>
						<style>
						input.dateInput{color:lightgray;}
						input.dateInput.full{color:black;}
						input.timeInput{color:lightgray;}
						input.timeInput.full{color:black;}
					</style>
					<script>
							 		
	 $(".dateInput").on("input",function(){
		if($(this).val() != ""){
        $(this).addClass("full");
        }else{
            $(this).removeClass("full");
        }
        });

								 		
	 $(".timeInput").on("input",function(){
		if($(this).val() != ""){
        $(this).addClass("full");
        }else{
            $(this).removeClass("full");
        }
        });



			
					</script>
					


					
					
					


				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/index.js"></script>