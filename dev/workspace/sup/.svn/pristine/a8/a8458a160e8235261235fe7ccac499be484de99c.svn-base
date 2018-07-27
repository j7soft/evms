<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		
		<!--IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. http://code.google.com/--> 
		<!--[if lt IE 9]>
			<script src="/resources/include/js/html5shiv.js"></script>
		<![endif]--> 
		<script type="text/javascript" src = "/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" >
			
		</script>
		<style type="text/css">
			
		</style>
		
		<title>  </title>
	</head><%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currDate" value="${now}" pattern="yyyy-MM-dd" />
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
		
		
		
		$("#bbtn").click(function() {
			
			

			
			
			/* if( 1==1 ) {  
				
				$("#ENTRYFEE").val($('input[name=rad1]:checked').val());
				
		    	alert("-------> " + $('#ENTRYFEE').val());  
		    	
		    	
		    	return ;
		    	
		    //	 여기다가 아까 말한거 그 ID 값만 나오게끔 작업해주면 
		    	//되는데이런 부분이 하나도 안되어있으니 제가 잘 모르니 속도가 아예 안나오죠.. 
		    	
		    //	이렇게만// 저장해놓고
		    	
		    	
		    	
		    	}   */
			
				$("#TITLE").val($("#selectrent").val());
				
				
				$("#ENTRYFEE").val($('input[name=rad1]:checked').val() );
				$("#ITEM").val($('input[name=rad2]:checked').val() );
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
			
			
			 
			if (1 != 1) {

			} else if (!checkForm($("#CNT"), "인원을")) {
				return;
			} else if (!checkForm($("#FDATE"), "일자를")) {
				return;
			} else if (!checkForm($("#TEAMNAME"), "단체명을")) {
				return;
			} /* else if (!checkForm($("#t4"), "직위를")) {
				return;
			} else if (!checkForm($("#t5"), "사업자 번호를")) {
				return;
			} else if (!checkForm($("#t6"), "단체 소개를")) {
				return;
			} else if (!checkForm($("#t7"), "주소를")) {
				return;
			} else if (!checkForm($("#t8"), "대관 행사명을")) {
				return;
			} else if (!checkForm($("#t9"), "행사 참가 대상을")) {
				return;
			}   */else {

				$("#frm").attr({
					"method" : "post",
					"action" : "/bookinsert2.do"
				});

				
				$("#frm").submit();
			}

		});
		$(".rad").click(function() {

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
			<
			<form id="frm" name="frm">
				<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
				<input type="hidden" id="BBS_ID" name="BBS_ID" value="" />
				<input type="hidden" id="BBS_ID" name="NTT_ID" value="${NTT_ID }" />
				<input type="hidden" id="TITLE" name="TITLE" />
				<input type="hidden" id="FTIME" name="FTIME" />
				<input type="hidden" id="STIME" name="STIME" />
				<input type="hidden" id="NAME" name="NAME" />
				<input type="hidden" id="ENTRYFEE" name="ENTRYFEE" />
				<input type="hidden" id="ITEM" name="ITEM" />
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
							<option class="select_depth1" value ="${list[i.index].TITLE }"><span>${list[i.index].TITLE }</span></li>
					</c:forEach>
				</select>
				<!-- x<span style="cursor:pointer;" class="icon_box_hr"></span>-->
                                    </div>
                                </li>
				
					
							
								<li>
                                    <h2>인원</h2>
                                    <div>
                                        <input type="number" name="CNT" id="CNT" placeholder="0" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>일자</h2>
                                    <div>
                                        <input class="dateInput" type="text" name="FDATE" id="FDATE"  readonly required>
                                    </div>
                                </li>
								<li><span>시간</span> 
							<small>시작</small>
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
							<small>종료</small>
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
                                        <!-- <input type="text" name="da3" id="da3" placeholder="신청하려는 대표 단체명" required> -->
                                        <input type="text" name="TEAMNAME" id="TEAMNAME" placeholder="신청하려는 대표 단체명" required="required"><br/>
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
                                        <input type="number" name="CRNUM" id="CRNUM" placeholder="없을경우 공란">
                                    </div>
                                </li>
                                <li>
                                    <h2>단체소개</h2>
                                    <div>
                                        <input type="text" name="TEAMCONTENT" id="TEAMCONTENT" placeholder="대관 심의시 참고합니다" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>주소</h2>
                                    <div>
                                        <input type="text" name="ADDRESS" id="ADDRESS" placeholder="주소를 입력해 주세요" required>
                                    </div>
                                </li>
								<li class="radio_box_hr">
								    <h3>서울새활용플라자관련</h3>
                                    <p>＊민간협력기관,입주기업,협력사 해당 여부 대관시 대관료 할인 여부 판단용 입니다</p>				
									<ul>
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
									</ul>
								</li>
								<li>
                                    <h2>신청자명</h2>
                                    <div>
                                        <input type="text" name="NAME" id="NAME" value="${lvo.name }" placeholder="신청자 명을 기입해 주세요" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>연락처</h2>
                                    <div>
                                        <input type="text" name=CHARGE_TEL id="CHARGE_TEL" value="${lvo.tel }" placeholder="연락처를 기입해 주세요" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>이메일</h2>
                                    <div>
                                        <input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }" placeholder="이메일을 기입해 주세요" required>
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
										<p>＊대관 신청이 승인되면, 담당자 메일로 대관 신청서 및 대관 운영 계획, 대관 계약서, 대관 입금 안내서 등을 보내드립니다. 확정된 대관이 있거나 미승인시에는 대관 불가 안내 문자를 보내드리니 참고 바랍니다.</p>
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
	<script src="/js/common.js"></script>
	<script src="/js/index.js"></script>
	
	
<style>
	.input_hr ul li:first-of-type div{width:32%;}
	.input_hr ul li div select{width:100%;background:#fff url(../img/select.png) no-repeat 100% 50%;}
	#shour, #smin, .dateInput{border:1px solid #ddd;}
</style>

<style>
	.input_hr ul li div input.dateInput{color:lightgray;width:45%;}
	.input_hr ul li div input.dateInput.full{color:black;}
	#fhour, #fmin, #shour, #smin{width:40%;}
</style>
<script>
 $(".dateInput").change("input",function(){
		if($(this).val() != ""){
			$(this).addClass("full");
			}else{
			$(this).removeClass("full");
			}
});
</script>
	
	<body>
		
		
		
		
	</body>
</html>