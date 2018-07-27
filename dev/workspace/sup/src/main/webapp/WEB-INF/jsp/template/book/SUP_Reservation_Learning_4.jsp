<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">
	$(function() {
		/* $(".CNT").change(
				function() {
					$("#PRICE").val(
							(parseInt($("#b").val()) * "${pri[0]}")
									+ (parseInt($("#s").val()) * "${pri[1]}"));

				}) */


		
		$(document).ready(function(){
					 $('.dateInput').datepicker({dateFormat:'yy-mm-dd'});
		 });	
			
		$("#trabtn").click(function() {

			if(!$("#aa1").prop("checked") && !$("#aa2").prop("checked")){
				alert("일반단체/학생단체 중 선택해주세요.");
				return false;
			}else if (!checkForm($("#TEAMNAME"), "단체명을")){
				return false;
			}else if($("#d2").val() + $("#d3").val() == 0){
				alert("인원을 입력해주세요");
				return false;
			}else if (!checkForm($("#FDATE"), "일자를")){
				return false;
			}else if (!checkForm($("#TEAMCONTENT"), "단체소개를")){
				return false;
			}else if(!$("#fr1").prop("checked") && !$("#fr2").prop("checked") && !$("#fr3").prop("checked") && !$("#fr4").prop("checked")){
				alert("상품명을 선택해주세요.");
				return false;
			}else if(!$("#c1").prop("checked")){
				alert("개인정보 이용 동의가 필요합니다.");
				return false;
			}else{	
				/*var rcnt = $("#d2").val() + $("#d3").val();
				if (rcnt == 0 ){
					alert("인원을 입력해주세요");
					return false;
				}else if(rcnt > "${pbCnt}"){
					alert("인원을 초과하였습니다.\n"
					     +"현재접수인원 :${vo.RDCNT}\n"
					     +"접수가능인원 :${pbCnt}");
					return false;
				}*/


				$("#CNT").val($("#d2").val() + "," + $("#d3").val());
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());
				$("#FTYPE").val($('input[name=aa1]:checked').val() );
				$("#frm").attr({
					"method" : "post",
					"action" : "/bookinsert2.do"
				});
				$("#frm").submit();
			}	
		});

		$(".tbtn").change(function(){
			if($(this).prop("checked")){
				$("#FTYPE").val($(this).val());
			}
		});
		

		$(".bbsbtn").change(function(){
			if($(this).prop("checked")){
				$("#BBS_ID").val($(this).val());
				$("#TITLE").val($(this).attr("data-title"));
			}
		});
		$(".ONOFF").change(function(){
			if($(this).prop("checked")){
				$("#ONOFF").val("ON");
			}else{
				$("#ONOFF").val("OFF");
			}
		});
		
		
		
	});
</script>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<div id="reserve_wrap">
<form name="frm" id="frm"  >
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation learning4">
			<div class="content_h3bx">
				<h3>현장학습</h3>
				<ul class="route">
                    <li>홈</li>
                    <li>대관 및 예약</li>
                    <li>현장학습</li>
                </ul>
			</div>
			<div class="request_area">
				<div class="edu_location clear"></div>

	   <form id="frm" name="frm">
				<div class="topBox clear">
					<h1>단체예약 현장학습</h1>
					<span class="h1_css"></span>
					<div class="input_hr input_hr_2">
					<input type="hidden" id="NTT_ID" name="NTT_ID" value="tripT" />
					<input type="hidden" id="NTT_NO" name="NTT_NO" value="${vo.BBS_ID }" />
					<input type="hidden" id="TITLE" name="TITLE" value="단체 현장학습" />
					<input type="hidden" id="FTIME" name="FTIME" value="${vo.FTIME }" />
					<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
					<input type="hidden" id="CNT" name="CNT" value="" />
					<input type="hidden" id="FTYPE" name="FTYPE" value="" />
							<ul>
								<li class="radio_box_hr">
									<ul>
										<li>
											<label>
												<input type="radio" name="aa1" id="aa1" value = "일반단체">
												일반단체
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="aa1" id="aa2"  value = "학생단체">
												학생단체
											</label>
										</li>
									</ul>     
								</li>
								<li>
									<h2>단체명</h2>
									<div>
										<input type="text" name="TEAMNAME" id="TEAMNAME" placeholder="단체명을 기입해 주세요" required>
									</div>
								</li>
								<li>
									<h2>인원</h2>
									<div>
										<input type="text" name="d2" id="d2" placeholder="성인인원을 입력하세요.">
										<input type="text" name="d3" id="d3" placeholder="아동인원을 입력하세요." style="margin-top: 10px;">
									</div>
								</li>
								<li>
                                    <h2>일자</h2>
                                    <div>
                                        <input class="dateInput" type="text" name="FDATE" id="FDATE">
                                    </div>
								</li>
								
                                 <li>
                                    <h2>시간</h2>
                                    <div>
								<c:set value="${fn:split(FTIME,':') }" var="FTIME"/>
							<select id="fhour" value="${FTIME[0] }" >
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select> 
							<select id="fmin" value="${FTIME[1] }" >
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
                                      <!--  <input type="number" name="fhour" id="fhour" required>
                                        <input type="number" name="fmin" id="fmin" required>-->
										<p>*평일 및 공휴일 09 ~ 19시 사이</p>
									</div>
								</li>
								<li>
									<h2>예약자</h2>
									<div>
										<input type="text" name="NAME" id="NAME" value="${lvo.id }" placeholder="예약자를 기입해 주세요" >
									</div>
								</li>
								<li>
									<h2>예약자 소속</h2>
									<div>
										<input type="text" name="PTB" id="PTB" placeholder="예) 새활용초등학교(7세이상부터 관람 가능합니다.)" >
									</div>
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="text" name="CHARGE_TEL" id="CHARGE_TEL"  value="${lvo.tel }"  placeholder="연락처를 기입해 주세요" >
									</div>
								</li>
								<li>
									<h2>이메일</h2>
									<div>
										<input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }" placeholder="이메일을 기입해 주세요" >
									</div>
								</li>
								<li>
									<h2>단체소개</h2>
									<div>
										<input type="text" name="TEAMCONTENT" id="TEAMCONTENT" placeholder="단체소개를 기입해 주세요" >
									</div>
								</li>
								<li class="radio_box_hr">				
									<ul>
										<li>
											<label>
												<input type="radio" name="fa1" id="fr1">
												새활용플라자<em>(1시간)</em>
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fa1" id="fr2">
												새활용플라자 + 아름다운가게<em>(평일,1시간20분)</em>
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fa1" id="fr3">
												새활용플라자 + 서울시금속회수센터<em>(평일 월 1회,2시간)</em>
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="fa1" id="fr4">
												새활용플라자 + 아름다운가게 + 서울하수도과학관 + 서울도시금속회수센터<em>(평일 월1회,4시간)</em>
											</label>
										</li>
									</ul>
										<p>
											1. 현장학습 소요시간은 코스별 1시간에서 4시간 있습니다 단체일정으로 인한 소요시간 조정이 가능합니다.
										</p>
										<p>
											2.전후 일정이 있으시다면 기재해주시기 바랍니다. 예약된 시간은 당일 번경 불가하므로 시간을 엄수해 주시기 바랍니다.
										</p>
										<p >
											3.유모차,휠체어 유무 등 투어 진행에 참고할 기타 사항도 기재해주시기 바랍니다.
										</p>
								</li>
								<li class="radio_box_hr">
									<h3>요청사항</h3>
									<textarea id = "REQUEST" name = "REQUEST"  ></textarea>
								</li>
								<!--<li>
									<h2>금액</h2>
									<div>
										<span>10,000원</span>
									</div>
								</li>-->
								<li class="radio_box_hr">
									<ul>
										<li>
											<input type="checkbox" name="c1" id="c1">
											<label for="da">개인정보 이용동의  <a href="#"><strong onclick="javascript:document.getElementById('wrap_agree').style.display='block';">개인정보 이용약관</strong></a></label>
										</li>
										<!--<li>
											<input type="checkbox" name="c2" id="c2">
											<label for="da2">사진촬영 동의</label>
										</li>
										<li>
											<input type="checkbox" name="da3" id="da3">
											<label for="da3">셔틀버스이용 (무료)</label>
										</li>-->
									</ul>     
								</li>						
                        </ul>
					</div>
					<div class="btn_h">
				        <button id = "trabtn">신청하기</button>
			        </div>
				</div>
			</form>




		</article>
	</section>
	<!--  //Main section 영역  -->
	</form>
</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>