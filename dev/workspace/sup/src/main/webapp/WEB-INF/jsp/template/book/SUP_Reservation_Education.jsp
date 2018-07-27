<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currDate" value="${now}" pattern="yyyy-MM-dd" />
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
.fc-content{color:#3a87ad !important;}
.fc-ltr .fc-basic-view .fc-day-top .fc-day-number{pointer-events:none;}
</style>
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
			eventDrop: function (event, delta) {
		        alert(event.title + ' was moved ' + delta + ' days\n' +
		            '(should probably update your database)');
		},
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
			$('.mobile_calendar').fullCalendar({
			 defaultView: 'listWeek',
			 header : {
				left : 'prev,next',
				center : 'title',
				right : 'today'
			}
		});



		$('#calendar, .mobile_calendar').fullCalendar('addEventSource', list);
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
		//console.log(k);
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
				currdate = "${currDate}";
				simplecontent = data.SIMPLECONTENT;
				tag =  "<div class='simple_schedule'><div class='content_box'><div class='btn_wrap'>";/*<div class='img_box'><img width='110' height='80' src='/uploadStorage/file/"+image+"' alt=''/></div>*/
				if(currdate > fdate){
					tag+="<p>접수불가</p>";
					atag.attr("onclick","javascript:alert('이전교육은 신청할 수 없습니다.'); return false;");
				}else if(rdcnt < cnt){
					tag+="<p href='/bookinsert.do?NTT_ID="+nttid+"&BBS_ID="+bbsid+"'>접수중</p>";
				}else{
					tag+="<p>접수불가</p>";
					atag.attr("onclick","javascript:alert('접수인원이 초과 됐습니다.'); return false;");
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

<link rel="stylesheet" href="/css/SUP_Reservation.css">
<link rel="stylesheet" href="/css/sliderstyle.css">
<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation education">
			<div class="content_h3bx">
				<h3>교육</h3>
				<ul class="route">
	                <li>홈</li>
	                <li>대관 및 예약</li>
	                <li>교육</li>
	            </ul>
			</div>
		</article>
	</section>
	<div id='calendar'></div>
	<div class="mobile_calendar"></div>

</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>
<style>

	 .simple_schedule{width:auto !important;padding:5px;}
</style>
<script>
	$(".fc-h-event").click(function() {
			var loginId = '${loginVO.id}'
			if (loginId == "") {
				$(this).attr("href", '/loginUsr.do');
				//location.href='/loginUsr.do';
			} 
			
		});

</script>
<style>
	.mobile_calendar{display:none;}
	.fc-week:last-of-type{display:none;]}
	#calendar .fc-content{overflow:hidden;}

	
	@media all and (max-width:768px) {
		.mobile_calendar{display:block;}
		#calendar{display:none;}
		.fc button .fc-icon{margin:0 2.2em;}
		.mobile_calendar div.fc-right button.fc-corner-right{right:0;left:0;top:-40px;}
	}
		@media all and (max-width:347px) {
		
		.mobile_calendar div.fc-right button.fc-corner-right{top:-94px;}
		}

</style>