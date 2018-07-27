<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currDate" value="${now}" pattern="yyyy-MM-dd" />
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${vo.CNT - vo.RDCNT}" var="pbCnt"/>
<link rel="stylesheet" href="/css/sliderstyle.css">
<link rel="stylesheet" href="/css/SUP_Reservation.css">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>

$(document).ready(function(){
	 $('.dateInput').datepicker({dateFormat:'yy-mm-dd'});
  });

  /*
  $( function() {
    $( ".dateInput" ).datepicker();
  } );*/
  </script>
<script>
	$(function() {
	     $("#FDATE").change(function(){
			
		 	/* if("${currDate}" > $("#FDATE").val()){
				alert("true");
			}else alert("false");  */
	    	if("${currDate}" > $("#FDATE").val()){
					alert("현재일 이전날짜는 선택할 수 없습니다");
					$("#FDATE").val("${currDate}");
			}
		}); 
        
        $("#shour").change(function(){
            if($(this).val() == 19){
                $("#smin").children("option:nth-child(2)").css("display","none");
                }else{
                    $("#smin").children("option:nth-child(2)").css("display","block");
                }
        });
		$("#bbtn").click(function() {
				$("#TITLE").val($("#selectrent option:selected").text().trim());
				$("#ROOM").val($("#selectrent option:selected").val().trim());
				$("#COMPANIES").val($("#companySelect").val());
				
				
				$("#ENTRYFEE").val($('input[name=rad2]:checked').val() );
				$("#ITEM").val($('input[name=rad2]:checked').val() );
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
				$("#TARGET").val($('input[name=rad1]:checked').val() );
				$("#USAGE").val($('input[name=rad]:checked').val() );

				
			 
			if (1 != 1) {
			} else if (!checkForm($("#CNT"), "인원을")) {
				return false;
			} else if (!checkForm($("#FDATE"), "일자를")) {
				return false;
			} else if (!checkForm($("#TEAMNAME"), "단체명을")) {
				return false;
			}  else if (!checkForm($("#TEAMCONTENT"), "단체 소개를")) {
				return false;
			} else if (!checkForm($("#EVENTNAME"), "대관 행사명을")) {
				return false;
			} else if (!checkForm($("#USAGE"), "용도를")) {
				return false;
			}else if(!$("#fk1").prop("checked")){
				alert("개인정보 수집 동의가 필요합니다.");
				return false;
			}else if(!$("#fj1").prop("checked")){
				alert("승인 여부 안내 동의가 필요합니다.");
				return false;
			}else {
				 


				$("#frm").attr({
					"method" : "post",
					"action" : "/bookinsert2.do"
				});

				
				$("#frm").submit();
			}

		});
		$(".rad").click(function() {

		});
		$("#CRNUM").keypress(function (e) {
    
				if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
						alert('숫자를 입력하세요.');
						return false;
					}
   });


	});
	
</script>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<div id="reserve_wrap">

	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation Rent_3">
			<div class="content_h3bx">
				<h3>대관 예약</h3>
				<ul class="route">
                    <li>홈</li>
                    <li>대관 및 예약</li>
                    <li>대관 예약</li>
                </ul>
			</div>
			<form id="frm" name="frm">
				<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
				<input type="hidden" id="BBS_ID" name="BBS_ID" value="" />
				<input type="hidden" id="NTT_ID" name="NTT_ID" value="${NTT_ID }" />
				<input type="hidden" id="TITLE" name="TITLE" />
				<input type="hidden" id="FTIME" name="FTIME" />
				<input type="hidden" id="STIME" name="STIME" />
				<input type="hidden" id="NAME" name="NAME" />
				<input type="hidden" id="ENTRYFEE" name="ENTRYFEE" />
				<input type="hidden" id="TARGET" name="TARGET" />
				<input type="hidden" id="ITEM" name="ITEM" />
				<input type="hidden" id="COMPANIES" name="COMPANIES" />
				<input type="hidden" id="ROOM" name="ROOM" />
				<input type="hidden" id="USAGE" name="USAGE" />
				<div class="topBox clear">
					<!--<div class="Box1">
						<p>대관 장소dddddddddddddd</p>
						<br />
						<c:forEach begin="0" end="${list.size() }" varStatus="i">
							<c:if test="${not empty list[i.index].TITLE}">
								<label for="" id="radio${i.index }">
									<p>
									<input type="hidden" id="TITLE" name="TITLE" />
										<input data-title="${list[i.index].TITLE}" type="radio" class="rad" id="radio${i.index }"
											 value="${list[i.index].BBS_ID }" />${list[i.index].TITLE}
										(운영요일:${list[i.index].FDATE} /
										운영시간:${list[i.index].FTIME}:${list[i.index].STIME} / 사용가능
										인원:${list[i.index].TITLE} / 가격:${list[i.index].PRICE} /
										담당자:${list[i.index].PTB})
									</p>
								</label>
							</c:if>
						</c:forEach>
					</div>-->
					<style>
						.input_hr ul li p.alert{width:auto; float:right;display:inline-block;margin-top:0;}
					</style>


					<div class="topBox clear">
					<h1>대관예약</h1>
					<span class="h1_css"></span>
					
					<div class="input_hr input_hr_2">
							<ul>
								<li>
                                    <h2>대관선택</h2>
                                    <div>
                                        <select class="select_title" id = "selectrent">
					<c:forEach begin="0" end="${list.size()-1 }" varStatus="i">
							<option class="select_depth1" value ="${list[i.index].BBS_ID }" readonly><span>${list[i.index].TITLE }</span></li>
					</c:forEach>
				</select>
				<!-- x<span style="cursor:pointer;" class="icon_box_hr"></span>-->
                                    </div>
                                </li>
								<li>
                                    <h2>인원</h2>
                                    <div>
                                        <input type="number" name="CNT" id="CNT" placeholder="0" required>
										<p class="alert">최대인원 <span id="maxNum" style="margin:0;color:inherit;">10</span>명</p>
                                    </div>
                                </li>
                                <li>
                                    <h2>일자</h2>
                                    <div>
                                        <input class="dateInput" type="text" name="FDATE" id="FDATE" required>
                                    </div>
                                </li>
								<li><h2>시간</h2> <div>
							<small style="color:#c8c8c8;">시작</small>
							<!--<input type="hidden" id="FTIME" name="FTIME" value="00:00" /> -->
							<c:set value="${fn:split(FTIME,':') }" var="FTIME"/>
							<select id="fhour" value="${FTIME[0] }">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select> 
							<select id="fmin" value="${FTIME[1] }">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
							<small style="color:#c8c8c8;" >종료</small>
							<c:set value="${fn:split(STIME,':') }" var="STIME"/>
							<!--<input type="hidden" id="STIME" name="STIME" value="00:00" />-->
							<select id="shour" value="${STIME[0] }">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select>
							 <select id="smin" value="${STIME[1] }">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
							</div>
							</li>
                                 <!--<li>
                                    <h2>시작시간</h2>
                                    <div>
                                        <input type="number" name="fhour" id="fhour" required>
                                        <input type="number" name="fmin" id="fmin" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>종료시간</h2>
                                    <div>
                                        <input type="number"  name="shour" id="shour" required>
                                        <input type="number" name="smin" id="smin" required>
                                    </div>
                                </li>-->
                                <li>
                                    <h2>단체명</h2>
                                    <div>
                                        <input type="text" name="TEAMNAME" id="TEAMNAME" placeholder="신청하려는 대표 단체명" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>직위</h2>
                                    <div>
                                        <input type="text" name="CAPTAINNAME" id="CAPTAINNAME" placeholder="없을경우 공란">
                                    </div>
                                </li>
                                <li>
                                    <h2>사업자 번호</h2>
                                    <div>
                                        <input type="text" name="CRNUM" id="CRNUM" placeholder="없을경우 공란">
                                    </div>
                                </li>
                                <li>
                                    <h2>단체소개</h2>
                                    <div>
                                        <input type="text" name="TEAMCONTENT" id="TEAMCONTENT" placeholder="대관 심의시 참고합니다">
                                    </div>
                                </li>
								<!--<li>
                                    <h2>주소</h2>
                                    <div>
                                        <input type="text" name="ADDRESS" id="ADDRESS" placeholder="주소를 입력해 주세요" required>
                                    </div>
                                </li>-->
								<li class="radio_box_hr">
								    <h3>서울새활용플라자관련</h3>
                                    <p>＊민간협력기관,입주기업,협력사 해당 여부 대관시 대관료 할인 여부 판단용 입니다</p>		
									<select class="cooperative" id="companySelect">
										<option value="서울새활용플라자 민간협력기관">서울새활용플라자 민간협력기관</option>
										<option value="서울새활용플라자 입주기업">서울새활용플라자 입주기업</option>
										<option value="서울새활용플라자 협력사">서울새활용플라자 협력사</option>
										<option value="서울새활용플라자 협력사">서울특별시 주관·주최 행사</option>
										<option value="서울새활용플라자 협력사">서울특별시 후원 행사</option>
										<option value="해당사항 없음">해당사항 없음</option>
									</select>
									<!--<ul>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa1">
												정부 및 산하기관
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa2">
												서울시
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa3">
												서울시 산하기관 등 공공기관
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa4">
												서울새활용플라자 입주기업
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa5">
												서울새활용플라자 민간협력기관
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa6">
												서울새활용플라자 협력사
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa7">
												기타
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fd1" id="fa8">
												해당사항 없음
											</label>
										</li>
									</ul>-->
								</li>
								<li>
                                    <h2>신청자명</h2>
                                    <div>
                                        <input type="text" name="NAME" id="NAME" value="${lvo.name }" readonly placeholder="신청자 명을 기입해 주세요" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>연락처</h2>
                                    <div>
                                        <input type="text" name="CHARGE_TEL" id="CHARGE_TEL" value="${lvo.tel }" readonly placeholder="연락처를 기입해 주세요" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>이메일</h2>
                                    <div>
                                        <input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }" readonly placeholder="이메일을 기입해 주세요" required>
                                    </div>
                                </li>
                                 <li>
                                    <h2>대관 행사명</h2>
                                    <div>
                                        <input type="text" name="EVENTNAME" id="EVENTNAME" placeholder="대관 행사명을 기입해 주세요" required>
                                    </div>
                                    <p>＊교육,회의,워크샵 용도 외의 대관은 받지 않으며 교육시 상품,유료 서비스의 홍보와 계약유도, 판매를 주된 목적으로 하는 사용은 불가합니다.(새활용관련 유료 교육 프로그램은 가능)</p>
                                </li>
                                <li class="radio_box_hr">
                                    <h3>용도</h3>
									<ul>
										<li>
											<label>
												<input type="radio" name="rad" id="ff1" value = "회의용">
												회의용
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="rad" id="ff2" value = "교육용">
												교육용
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="rad" id="ff3" value = "기타">
												기타
											</label>
										</li>
									</ul>    
								</li>
                                <li class="radio_box_hr">
                                    <h3>행사 참가 대상 행사참가비 유/무</h3>
									<ul>
										<li>
											<label>
												<input type="radio" name="rad1" id="fw1" value = "유료">
												유료
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="rad1" id="fw2" value = "무료">
												무료
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="rad1" id="fw3" value = "조건부">
												무료이나 기타조건이 필요
											</label>
										</li>
									</ul>    
								</li>
								<li class="radio_box_hr">
                                    <h3>시설물(현수막,배너) 설치 및 물품 반입 계획 및 여부</h3>
									<ul>
										<li>
											<label>
												<input type="radio" name="rad2" id="fu1" value = "있음">
												있음
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="rad2" id="fu2" value = "없음">
												없음
											</label>
										</li>
									</ul> 
									<p>＊설물 설치 및 변경 (현수막,안내물,가설물 등),물품 반입 등의 사항이 있을 시 계획서를 작성하여 사용 전 미리 협의 하여 주시기 바랍니다. (케이터링 등 음식반입은 불가합니다.)</p>
									<p>＊현재내, 외부 현수막 설치는 불가합니다.</p>  
								</li>								
								<li class="radio_box_hr">
								    <h3>개인정보 수집 및 이용 동의</h3>
									<ul>
										<li>
											<label>
												<input type="radio" name="fk" id="fk1">
												동의
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fk" id="fk2">
												동의하지 않음
											</label>
										</li>
										<p>＊서울새활용플라자 대관 시설 이용객의 편의/예약 신청/사용 등과 관련된 내용 이외엔 개인 정보를 사용하지 않습니다</p>
									</ul>     
								</li>
								<li class="radio_box_hr">
								    <h3>승인 여부 안내</h3>
									<ul>
										<li>
											<label>
												<input type="radio" name="fj" id="fj1">
												동의
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fj" id="fj2">
												동의하지 않음
											</label>
										</li>
										<!--<p>＊대관 신청이 승인되면, 담당자 메일로 대관 신청서 및 대관 운영 계획, 대관 계약서, 대관 입금 안내서 등을 보내드립니다. 확정된 대관이 있거나 미승인시에는 대관 불가 안내 문자를 보내드리니 참고 바랍니다.</p>-->
									</ul>     
								</li>												
							</ul>
	
					</div>
					<div id="bbtn" class="btn_h">
				        <button>신청하기</button>
			        </div>
				</div>
					
					
					
					
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->

	<script src="/js/jquery.bxslider.min.js"></script>
	<script src="/js/index.js"></script>
	
	
<style>
	.input_hr ul li:first-of-type div{width:42%;}
	.input_hr ul li div select{width:100%;background:#fff url(../img/select.png) no-repeat 100% 50%;}
	#shour, #smin, .dateInput{border:1px solid #ddd;}
</style>

<style>
	.input_hr ul li div input.dateInput{color:lightgray;width:45%;}
	.input_hr ul li div input.dateInput.full, .input_hr ul li div select#fhour.full, .input_hr ul li div select#fmin.full, .input_hr ul li div select#shour.full, .input_hr ul li div select#smin.full{color:black;}
	#fhour, #fmin, #shour, #smin{width:10%;}
	.cooperative{padding: 5px;padding-right:25px; margin-top: 5px;}
</style>
<script>
 $(".dateInput, #fhour, #fmin, #shour, #smin").change("input",function(){
		if($(this).val() != ""){
			$(this).addClass("full");
			}else{
			$(this).removeClass("full");
			}
});
 $(".select_title").change(function() {
	 var text = $(this).val();
	 //var changeTxt = $("#maxNum").html();
 //$("#maxNum").html("${vo.CNT}");
	 
	if(text == "1335"){ //1층미디어룸 
		  $("#maxNum").html("20");
	 }else if(text == "1892"){  //4층공용스튜디오
		 $("#maxNum").html("10");
	 }else if(text == "910" ){ //5층교육실
		  $("#maxNum").html("70");
	 }else{
		$("#maxNum").html("40");
	 }
    });

</script>