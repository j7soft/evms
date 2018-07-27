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
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
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
				<h3>마켓예약</h3>
				<ul class="route">
	                <li>홈</li>
	                <li>대관 및 예약</li>
	                <li>마켓예약</li>
	            </ul>
			</div>
		</article>
		<div class="Rent_3">
                <div class="topBox clear">
                        <h1>마켓예약</h1>
                        <span class="h1_css"></span>
                        <div class="input_hr input_hr_2">
                                <ul>
                                    <li>
                                        <h2>성명</h2>
                                        <div>
                                            <input type="text" name="dn1" id="dn1" placeholder="성명을 입력하세요" required>
                                        </div>
                                    </li>
                                    <li>
                                        <h2>소속(학교)</h2>
                                        <div>
                                            <input type="text" name="dn2" id="dn2" placeholder="소속을 입력하세요">
                                        </div>
                                    </li>
                                    <li>
                                        <h2>직책(학년)</h2>
                                        <div>
                                            <input type="text" name="dn3" id="dn3" placeholder="직책을 입력하세요">
                                        </div>
                                    </li>
                                     <li>
                                        <h2>기타사항</h2>
                                        <div>
                                            <input type="text" name="dn4" id="dn4" placeholder="기타를 입력하세요">
                                        </div>
                                    </li>
                                    <li>
                                        <h2>연락처</h2>
                                        <div>
                                            <input type="text" name="dn5" id="dn5" placeholder="연락처를 입력하세요">
                                        </div>
                                    </li>
                                    <li>
                                        <h2>이메일</h2>
                                        <div>
                                            <input type="text" name="dn6" id="dn6" placeholder="이메일을 입력하세요">
                                        </div>
                                    </li>
                                    <li class="radio_box_hr">
                                        <ul>
                                            <li>
                                                <input type="checkbox" name="da" id="da">
                                                <label for="da">개인정보 이용동의 <a href="#"><strong>개인정보 이용약관</strong></a></label>
                                            </li>
                                        </ul>     
                                    </li>						
                                </ul>

                        </div>
                        <div class="btn_h">
                            <button>신청하기</button>
                        </div>
                    </div>
                </div>
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