<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
<script type="text/javascript">
	$(function() {
		/* $(".CNT").change(
				function() {
					$("#PRICE").val(
							(parseInt($("#b").val()) * "${pri[0]}")
									+ (parseInt($("#s").val()) * "${pri[1]}"));

				}) */
		$("#trabtn").click(function() {
			if (!$("#c1").prop("checked") || !$("#c2").prop("checked")) {
				alert("동의가 필요합니다.");
				return;
			} else {
				$("#CNT").val($("#b").val() + "," + $("#s").val());
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());
				$("#STIME").val($("#fhour").val() + ":" + $("#fmin").val());

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
							<ul>
								<li class="radio_box_hr">
									<ul>
										<li>
											<label>
												<input type="radio" name="aa1" id="ar1">
												일반단체
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="aa1" id="ar2">
												학생단체
											</label>
										</li>
									</ul>     
								</li>
								<li>
									<h2>단체명</h2>
									<div>
										<input type="text" name="d1" id="d1" placeholder="">
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
									<select>
										<option>시작일</option>
										<option>9</option>
										<option>9</option>
									</select>
									<span>|</span>
									<select>
										<option>마지막일</option>
										<option>00</option>
										<option>00</option>
									</select>
									
									<label>
										<input type="checkbox" name="aq1" id="aq1">
										당일
									</label>
									</div>
								</li>
								<li>
									<h2>시간</h2>
									<div>
										<select>
											<option>9</option>
											<option>9</option>
											<option>9</option>
										</select>
										<select>
											<option>00</option>
											<option>00</option>
											<option>00</option>
										</select>
										<span>|</span>
										<select>
											<option>9</option>
											<option>9</option>
											<option>9</option>
										</select>
										<select>
											<option>00</option>
											<option>00</option>
											<option>00</option>
										</select>
										
										<p>*평일 및 공휴일 09 ~ 19시 사이</p>
									</div>
								</li>
								<li>
									<h2>예약자</h2>
									<div>
										<input type="text" name="d4" id="d4" placeholder="">
									</div>
								</li>
								<li>
									<h2>예약자 소속</h2>
									<div>
										<input type="text" name="d5" id="d5" placeholder="예) 새활용초등학교(7세이상부터 관람 가능합니다.)">
									</div>
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="text" name="d6" id="d6" placeholder="">
									</div>
								</li>
								<li>
									<h2>이메일</h2>
									<div>
										<input type="text" name="d7" id="d7" placeholder="">
									</div>
								</li>
								<li>
									<h2>단체소개</h2>
									<div>
										<input type="text" name="f7" id="f7" placeholder="">
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
									<textarea></textarea>
								</li>
								<!-- <li>
									<h2>금액</h2>
									<div>
										<span>10,000원</span>
									</div>
								</li> -->
								<li class="radio_box_hr">
									<ul>
										<li>
											<input type="checkbox" name="da" id="da">
											<label for="da">개인정보 이용동의 <a href="#"><strong>개인정보 이용약관</strong></a></label>
										</li>
										<li>
											<input type="checkbox" name="da2" id="da2">
											<label for="da2">사진촬영 동의</label>
										</li>
										<li>
											<input type="checkbox" name="da3" id="da3">
											<label for="da3">셔틀버스이용 (무료)</label>
										</li>
									</ul>     
								</li>						
							</ul>
	
					</div>
					<div class="btn_h">
				        <button>신청하기</button>
			        </div>
				</div>
			</form>




		</article>
	</section>
	<!--  //Main section 영역  -->
	</form>
</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/index.js"></script>