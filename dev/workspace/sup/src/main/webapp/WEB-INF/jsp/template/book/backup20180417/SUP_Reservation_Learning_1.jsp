<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Reservation.css">
<style>
#map {
	height: 100%;
	width: 100%;
}
</style>
<link href='/css/cal/fullcalendar.min.css' rel='stylesheet' />
<link href='/css/cal/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/js/cal//moment.min.js'></script>
<script src='/js/cal/jquery.min.js'></script>
<script src='/js/cal/fullcalendar.min.js'></script>
<script src='/js/cal/locale-all.js'></script>
<style>
	.fc-sat { color:blue; }
	.fc-sun { color:red;  }

  body {
    
  }

  #calendar {
    max-width: 500px;
    margin: 0 auto;
  }

	.fc-time{
		display:none;
	}

</style>

<script type="text/javaScript" language="javascript" defer="defer">






$(document).ready(function() {
    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay,listWeek'
      },
      defaultDate: new Date(), 
      minTime: "09:00:00",
      maxTime: "19:30:00",
      businessHours: true, // display business hours
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      locale : 'ko',
      events: [
		/* <c:forEach items="${list}" var="item">
			{
		        title: '${item.TITLE}',
		        start: '${item.FDATE}',
		        end: '${item.FDATE}',
		        
		    },
		</c:forEach>   */   
       
      ],
      eventRender: function(event, element) { 
          console.log(event._id);
          if(viewNM != 'month' && event.description != undefined) element.find('.fc-title').append("<br/>" + event.description);
         
			switch(event._id){
				case 'rent':
					element.css({ 'background-color': '#f22404', 'border-color': '#333333' });
					break;
				case 'edu':
					element.css({ 'background-color': '#aae506', 'border-color': '#333333' });
					break;
				case 'bus':
					element.css({ 'background-color': '#1720d1', 'border-color': '#333333' });
					break;
				case 'trip':
					element.css({ 'background-color': '#f97cc3', 'border-color': '#333333' });
					break;
			}
               
          },
	  viewRender : function (view, element) {
	   
	        viewNM = view.name;
	        
	  }
    });
    
    var list = new Array();
    
<c:forEach items="${list}" var="item">
	console.log("${item.INTRO}")
	if("${item.INTRO}" != 't'){
		var json = new Object();
		json.id = "${item.BBS_ID}";
		json.title = "${item.TITLE}";
		json.start = "${item.FDATE}T${item.FTIME}:00";
		json.end = "${item.FDATE}T${item.STIME}:00";
		json.url = "javascript:callFunction('${item.BBS_ID}','${item.FTIME}','${item.STIME}' )";
		list.push(json); 
	}
</c:forEach>

$('#calendar').fullCalendar( 'addEventSource', list );


  });



function callFunction(data,ftime,stime){
	$(".bbsbtn").html("<button type='button'  data-bbs='"+data+"' data-time='"+ftime+"' class='chkbbs' >"+ftime+"</button> &nbsp;&nbsp;&nbsp; <button type='button' data-bbs='"+data+"' data-time='"+stime+"' class='chkbbs' >"+stime+"</button>");
}

 


function getDateRange(startDate, endDate, listDate)

{

    var dateMove = new Date(startDate);

    var strDate = startDate;

    

    if (startDate == endDate)

    {

        var strDate = dateMove.toISOString().slice(0,10);

        listDate.push(strDate);

    }

    else

    {

        while (strDate < endDate)

        {

            var strDate = dateMove.toISOString().slice(0, 10);

            listDate.push(strDate);

            dateMove.setDate(dateMove.getDate() + 1);

        }

    }

    return listDate;

};

removeClass('fc-corner-right');

</script>
<script type="text/javascript" >
var bbs="";
var ti="";
var chk="";
	$(function(){

		$(document).on("click",".chkbbs",function(){
			bbs = $(this).attr("data-bbs");
			ti = $(this).attr("data-time");
			chk = "ok";
			$(this).addClass('on').siblings().removeClass('on');
		});
		
		$("#tbook_btn").click(function(){
			location.href="/mvpage.do?NTT_ID=tripT";
		});
		$("#sbook_btn").click(function(){
			if(chk!='ok'){
				alert("시간을 선택 해주세요.");
				return;
			}else{
				location.href="/tripsole.do?NTT_ID=trip&BBS_ID="+bbs+"&time="+ti;
			}
			
		});
		
		

		
	});
	
</script>

<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation Learning">
			<div class="content_h3bx">
				<h3>현장학습</h3>
				<ul class="route">
	                <li>홈</li>
	                <li>대관 및 예약</li>
	                <li>현장학습</li>
	            </ul>
			</div>

			<div class="topBox clear">
				<div class="leftBox leftBox1">
					<img src="/img/reservation/reservation_learning_1.jpg" style="width: 100%;" alt="컨텐츠이미지">
				</div>
				<div class="leftBox leftBox2">
                    <div class="img_box" style="overflow: hidden; border: 0;">
                        <img src="/img/reservation/reservation_learning_1.jpg" style="width: 100%;position: relative;top: -88%;" alt="컨텐츠이미지">
                    </div>
                    <div class="text_Box">
                        <h3>${vo.TITLE }새활용플라자 현장학습</h3>
                        <ul>
                            <li>2018년 서울 새활용플라자 정기현장학습 예약 프로그램입니다.</li>
                            <li>요일 : 월, 화, 수, 목</li>
                            <li>시간 : 10:00, 14:30(2회)</li>
                            <li>장소 : 서울새활용플라자 1층 안내데스크</li>
                            <li>소요시간 : 50분</li>
                            <li>대상인원 : 7세 이상 20명 내외</li>
                        </ul>
                    </div>
                </div>
				<div class="rightBox rightBox1">
					<h3>${vo.TITLE }서울새활용플라자 현장학습_새활용 이야기</h3>
					<textarea rows="20" cols="70" readonly>${vo.SIMPLECONTENT }*현장학습 대상연령: 7세이상
서울새활용플라자 깊이 알기
-
21세기 현재 지구환경문제는 점점 더 심각한 상태로 진입하고 있습니다.
이제 자원기반을 보전하고 에너지와 자원을 효율적으로 이용하며 폐기물을 최소화하는 일은 인류생존의 필수조건입니다.
서울새활용플라자는 ‘폐기물 0% 서울’, ‘재활용 100% 서울’을 상상합니다.
이런 상상들을 시민들과 함께 교감하며, 공감하려 합니다.
시민여러분들을 서울새활용플라자로 초대합니다. 공간에 숨어 있는 새활용 디자인 이야기를 함께하려 합니다. 
-
* 새활용 이야기는 100% 사전예약제로 운영됩니다.
-
오전 프로그램 : 매일 1회 >>> 화-금 10:00-10:50(50분)
오후 프로그램 : 매일 1회 >>> 화-금 14:30-15:20(50분)
-
* 휴관일 제외 주 4일 운영
* 20명 선착순 예약 우선 , 5명 미만 예약시 취소
-
</textarea>
<span id="url3d-1"></span>
<a id="url3d-2" target="_blank" href="http://blog.naver.com/supeducation/221056705075">
자세히 보기
</a>
					<div class="btn clear">
						<button>예약하기</button>
						<button id="tbook_btn">단체예약</button>
					</div>
				</div>
				<div class="rightBox rightBox2">
					
					<div id='calendar'></div>
					<div class="bbsbtn"></div>
                    <div class="btn clear">
                        <button id="sbook_btn">다음단계</button>
                    </div>
                </div>
				<p class="small">* 20명 이상 30명 이하는 단체로 예약해주시기 바랍니다</p>
				<p class="small">* 단체예약 전 셔틀버스를 확인하시길 바랍니다</p>
				
				
<!-- 				<div class="contentBox clear">
					<h3>현장학습 후기</h3>
					<ul>
						<c:forEach begin="0" items="${reviewlist }" varStatus="i">
							<c:if test="${reviewlist[i.index].ONOFF =='ON' && reviewlist[i.index].FTYPE == 'reservtrip' }" >
					                        <li>
					                           <p>
						                            ${reviewlist[i.index].CONTENT }
					                           </p>
					                           <p>${reviewlist[i.index].NAME } <span> / ${reviewlist[i.index].FDATE }방문</span></p>
					                        </li>
					                        </c:if>
						</c:forEach>
				                       
				                    </ul>
					<%-- <table border="1">
						<c:forEach begin="0" end="${reviewlist.size() }" varStatus="i">
							<tr>
								<th>${i.index+1 }</th>
								<th>${reviewlist[i.index].NAME }</th>
								<th>${reviewlist[i.index].CONTENT }</th>
								<th>${reviewlist[i.index].PUSHDATE }</th>
							</tr>
						</c:forEach>
						
					</table> --%>
				
				
				</div> -->
				
				<div class="contentBox3 clear">
					<div class="mapBox" style="border: 0;">
						<div id="map"></div>
						<!-- <div id="map"></div>
						<script>
							function initMap() {
								var uluru = {
									lat : 37.558577, 
									lng : 127.058236
								};
								var map = new google.maps.Map(document
										.getElementById('map'), {
									zoom : 16,
									center : uluru
								});
								var marker = new google.maps.Marker({
									position : uluru,
									map : map
									
								});
							}
						</script>
						<script async defer
							src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIb4yJMkcoQCHF-luIoXjHZ1KwS5d85qw&callback=initMap">
							
						</script> -->

					</div>
					<div class="addreBox">
						<h3>서울새활용플라자  위치</h3>
						<p>
							주소 : 서울특별시 성동구 용담동 249-35<br/>
							도로명 : 서울특별시 성동구 자동차시장길 49
						</p>
						<p>
							전화 : 02-2153-0400<br/>
							전화문의 가능시간 : 월~금 10~12, 13~17시 (토, 일 휴무)
						</p>
						<div class="btn clear bus_reservation">
						  <button>버스 예약하기</button>
					</div>
					</div>

				</div>
			</div>

		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<script>
        
        $(function(){
        	
        	$('.rightBox2').hide();
        	$('.leftBox2').hide();

            $('.rightBox1 .btn button:nth-of-type(1)').click(function(){

                $('.rightBox1').hide();
                $('.rightBox2').show();
                $('.leftBox1').hide();
                $('.leftBox2').show();

            });

        });

    </script>

	<script src="/js/jquery.bxslider.min.js"></script>
	<script src="/js/common.js"></script>
	<script src="/js/index.js"></script>

	<script>
      function initMap() {
        var uluru = {lat: 37.558937 , lng: 127.058179};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD2YyLn52yCseiu2f1N1ks0VkvVB9vaMEc&callback=initMap">
    </script>
