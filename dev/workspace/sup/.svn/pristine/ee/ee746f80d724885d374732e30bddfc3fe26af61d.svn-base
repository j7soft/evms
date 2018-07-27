<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Backoffice.css">



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
.aprrove_box_stl{
	float:left; 
	width:60px; 
	border-radius: 6px; 
	text-align:center;
}
.approved{
	color:#fff;
	background-color:#1A1B41;
}
.disapproved1{
	background-color:#e0e0e0;
}
.disapproved2{
	background-color:#e0e0e0;
}
.disapproved3{
	background-color:#e0e0e0;
}
.aprrove_box_stl2{
	float:left; 
	width:5px; 
	height:20px;
}
#calendar .fc-content{overflow:hidden;}
.fc-event{border:0;}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
var nttid="";
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
			timeFormat: 'H:mm',
			eventRender : function(event, element) {
				console.log(event._id);
				nttid=event._id;
				if (viewNM != 'month' && event.description != undefined)
					element.find('.fc-title').append("<br/>" + event.description);

				switch (event._id) {
					case 'reservrent':
						element.css({
							'background-color' : getApprovedBackgroundColor('#aae506', event.onOff)
							
						});
						break;
					case 'reservedu':
						element.css({
							'background-color' : getApprovedBackgroundColor('#aae506', event.onOff)
							
						});
						break;
					case 'reservbus':
						element.css({
							'background-color' : getApprovedBackgroundColor('#58D3F7', event.onOff)
							
						});
						break;
					case 'reservtrip':
						element.css({
							'background-color' : getApprovedBackgroundColor('#f97cc3', event.onOff)
						
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
		/*
		
		이부분이 캘린더 데이터 가져오는 부분 입니다.
		/egovCommon/src/main/webapp/cal/examples 부분에서 샘플 확인하실 수 있습니다.
		
		*/
		if("${item.NTT_ID == 'reservrent'}"){
			var json = new Object();
			json._id = "${item.NTT_ID}";
			json.title = "${item.TITLE}";
			json.onOff = "${item.ONOFF}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
			json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			
			list.push(json); 
		}else if("${item.NTT_ID == 'reservedu'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.onOff = "${item.ONOFF}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.end = "${item.FDATE}T${item.STIME}:00";
			json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}else if("${item.NTT_ID == 'reservtrip'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.onOff = "${item.ONOFF}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}else if("${item.NTT_ID == 'reservtripT'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.onOff = "${item.ONOFF}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}else if("${item.NTT_ID == 'reservbus'}"){
			var json = new Object();
			json.id = "${item.BBS_ID}";
			json.title = "${item.TITLE}";
			json.onOff = "${item.ONOFF}";
			json.start = "${item.FDATE}T${item.FTIME}:00";
			json.url = "/admin/cont/detailPage.do?BBS_ID=${item.BBS_ID}&NTT_ID=${item.NTT_ID}";
			list.push(json); 
		}
		
	</c:forEach>
	$('#calendar').fullCalendar('addEventSource', list);
	console.log($('#calendar').fullCalendar('clientEvents'));
	});
	
	$(document).on('click','.fc-day-number',function(){
		var date = $(this).attr("data-goto");
		var json = JSON.parse(date);
		$(this).attr("href","/admin/selectBoard.do?NTT_ID="+nttid+"&date="+json.date);
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
	
	/**
	*	관리자 화면에서의 색상은 카테고리별로 지정되어있는데
	*	카테고리(대관예약, 교육예약, 현장학습, 셔틀버스)
	*	해당 예약의 완료상태일때는 다른 색상으로 변경함.
	*	변경전 색상 : defaultColor
	*	변경후 색상 : #0101DF(파랑색)
	*/
	function getApprovedBackgroundColor(defaultColor, onOff) {
		var rgbCode = defaultColor;
		if( onOff == 'Y' ) {
			rgbCode = '#1A1B41';
			return rgbCode;
		}else if(onOff == "N"){
			rgbCode = '#e0e0e0';
			return rgbCode;
		}else{
			//rgbCode = '#0101DF';
			//return rgbCode;
		}
	}
</script>

<div id="b_office_Rent">
	<div class="title_box">
		<h3>${BBS_NM }예약</h3>
	</div>
	<div>
		<c:if test="${NTT_ID eq 'reservrent'}">
			<div class="aprrove_box_stl disapproved1">미승인</div>
			<div class="aprrove_box_stl2"></div>
			<div class="aprrove_box_stl approved">승인</div>
		</c:if>
		<c:if test="${NTT_ID eq 'reservedu'}">
			<div class="aprrove_box_stl disapproved1">미승인</div>
			<div class="aprrove_box_stl2"></div>
			<div class="aprrove_box_stl approved">승인</div>
		</c:if>
		<c:if test="${NTT_ID eq 'reservbus'}">
			<div class="aprrove_box_stl disapproved2">미승인</div>
			<div class="aprrove_box_stl2"></div>
			<div class="aprrove_box_stl approved">승인</div>
		</c:if>
		<c:if test="${NTT_ID eq 'reservtrip'}">
			<div class="aprrove_box_stl disapproved3">미승인</div>
			<div class="aprrove_box_stl2"></div>
			<div class="aprrove_box_stl approved">승인</div>
		</c:if>
		<c:if test="${NTT_ID eq 'reservtripT'}">
			<div class="aprrove_box_stl disapproved3">미승인</div>
			<div class="aprrove_box_stl2"></div>
			<div class="aprrove_box_stl approved">승인</div>
		</c:if>
	</div>
</div>

	<div id='calendar'></div>
