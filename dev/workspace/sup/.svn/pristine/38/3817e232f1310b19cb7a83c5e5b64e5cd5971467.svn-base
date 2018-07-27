<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="price"/>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<link rel="stylesheet" href="/css/sliderstyle.css">
<script type="text/javascript" >
	$(function(){
		$("#btn").click(function(){
			if(1!=1){
				
				
			}else if(!$("#fff").prop("checked") || !$("#sss").prop("checked")){
				alert("동의가 필요합니다.")
				return;
			}else{
				$("#CNT").val($("#bb").val()+","+$("#ss").val());
				$("#frm").attr({
					"method":"post",
					"action":"/bookinsert2.do"
				});
				$("#frm").submit();
				
				
				
			}
			
			
		});
		
		$(".edu_number").change(function(){
			$("#PRICE").val((parseInt("${price[0]}")*$("#bb").val())+(parseInt("${price[1]}")*$("#ss").val()));
			
		});
		
		
		
	});
</script>
<style>
#map {
	height: 400px;
	width: 100%;
}
</style>
 <div id="reserve_wrap">
    <!--  Main section 영역  -->
    <section id="section">
        <div class="sub_bg"><h3>서브메인 이미지</h3></div>
        <article class="reservation education">
        	<form id="frm" name="frm"  >
            <div class="content_h3bx">
                <h3>${type }</h3>
                <div class="h3_icon"><img src="/img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지"></div>
            </div>
            <input type="hidden" name="NAME" vlaue="${vo.BBS_ID }" />
            <div class="request_area">
                <h4>${vo.TITLE }</h4>
                <p class="edu_summary">${vo.SIMPLECONTENT }</p>
                <ul class="edu_date">
                  <li>${vo.FDATE }</li>
                  <li>${vo.FTIME } ~ ${vo.STIME }</li>
                  <li>${vo.POSITION}</li>
                  <li>성인 ${price[0] }원 / 아동 ${price[1] }원</li>
                </ul>
                <div class="edu_explain">${vo.CONTENT }</div>
                <div class="edu_location clear">
                    <div id="map"></div>
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
                    <div class="edu_map_explain">서울시 새활용 프라자</div>
                </div>
                <div class="edu_request">
                <input type="hidden" name="MBER_ID" value="${lvo.id }" />
                <input type="hidden" name="NTT_ID" value="${NTT_ID }" />
                    <h5>신청하기</h5>
                    <ul>
                      <li>
                      	<div><span>성명</span><input type="text" value="${lvo.name }"> </div>
                          <div class="width48"><span>연락처</span><input type="text" value="${lvo.tel }"> </div>
                          <div class="width48"><span>이메일</span><input type="text" value="${email }"> </div>
                      </li>
                      <li>
                          <div class="width32"><span>기관/단체/회사명</span><input type="text" name="TEAMNAME"> </div>
                          <div class="width32"><span>담당부서</span><input type="text" name="CAPTAINNAME"> </div>
                          <div class="width32"><span>직책/직급</span><input type="text" name="PTB"> </div>                      
                      </li>
                      
					  <input type="hidden" name="CNT" id="CNT" />
                      <li><span class="redstar">인원</span>
                          <div class="width43"><span>성인</span><input type="number" id="bb" step="1" id="b" min="0" max="50" class="edu_number"></div>
                          <div class="width43"><span>아동</span><input type="number" id="ss" step="1" id="s" min="0" max="50" class="edu_number"></div>
                      </li>
                      <li><div><span>금액</span><input type="text" id="PRICE" name="PRICE" ></div></li>
                    </ul>
                </div>
                <div class="edu_agree">
                    <ul>
                      <li><input type="checkbox" name="" class="" onClick="" id="fff"><label for="">개인정보 이용동의</label><a href="">[개인정보 이용동의서]</a></li>
                      <li><input type="checkbox" name="" class="" onClick="" id="sss"><label for="">사진촬영 동의</label></li>
                    </ul>
                    <button type="button" id="btn">등록/결제</button>
                </div>
            </div>
            </form>
        </article>
    </section>	
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIb4yJMkcoQCHF-luIoXjHZ1KwS5d85qw&callback=initMap"></script>
    <!--  //Main section 영역  -->
    </div>