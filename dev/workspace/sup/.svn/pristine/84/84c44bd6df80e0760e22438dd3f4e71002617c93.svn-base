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
			timeFormat: 'H:mm',
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
				<ul class="tep_list clear">
					<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
						<c:if test="${i.index == 1 }">
							<li class="select_depth1"><span>${rentlist[i.index].TITLE }</span>
								<ul>
									<li>A room</li>
									<li>B room</li>
									<li>C room</li>
									<li>D room</li>
									<li>E room</li>
								</ul>
							</li>
						</c:if>
						<c:if test="${i.index != 1 }">
							<li><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
				</ul>
				<span style="cursor:pointer;" class="icon_box_hr"></span>
			</div>

			<div class="tep_wrap" >
				<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
					<c:if test="${not empty rentlist[i.index].BBS_ID}" >
					<div class="tep_box tep_box${i.index }">
						<c:set value="${fn:split(rentlist[i.index].ITEM_IMAGE,';') }" var="im" />
						<div class="tep_list_box">
				<ul class="tep_list clear">
					<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
						<c:if test="${i.index == 0 }">
							<li class="active"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
						<c:if test="${i.index != 0 }">
							<li><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>

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
									<!--<c:if test="${empty loginVO.id }">
										<p class="reserv_btn" onclick="location.href='/loginUsr.do';">
										예약하기
										</p>
									</c:if>
									<c:if test="${not empty loginVO.id }">	
										<p class="reserv_btn" data-num='${rentlist[i.index].BBS_ID }'>
										예약하기
										</p>
									</c:if>-->
									
									<p class="reserv_btn reservBtn" data-num='${rentlist[i.index].BBS_ID }'>
										예약하기
									</p>
								</div>
							</div>
							<!-- <div class="schedule">

             <div class="schedule_head">
                <div class="month">
				  <ul>
					  <li><p class="year">2018 April</p>
						   <p><span style="background-color: #929497"></span>예약대기</p>
						  <p><span ></span>예약완료</p></li>
					  <li>
						 <h3><span><a href="#"></a></span><span><a href="#"></a></span></h3>  
					  </li>
				  </ul>
                 
                </div>
              </div>
              <div class="table_box">
                <table>
                  <tr>
                    <th>TIME</th>
                    <th><span>MON</span>2</th>
                    <th><span>TUE</span>3</th>
                    <th><span>WED</span>4</th>
                    <th><span>THU</span>5</th>
                    <th><span>TRI</span>6</th>
                    <th><span>SAT</span>7</th>
                    <th><span>SUN</span>8</th>
                  </tr>
                  <tr>
                    <th>9</th>
                    <td>
                      <div class="schedule_a">
                      <p>홍길동</p>
                      </div>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>10</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>11</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>12</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>13</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>14</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>15</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>16</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>17</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>18</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <th>19</th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
                </table>
              </div>
            </div>-->



							
							
						
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
	$('.tep_list li').click(function() {

		$(this).addClass('active').siblings().removeClass('active');
		var tep = $(this).index();

		// alert('.tep_box' + tep);
		$('.tep_box').hide();
		$('.tep_box' + tep).show();

	});

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

</style>