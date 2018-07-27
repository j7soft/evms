<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Reservation.css">

<script type="text/javascript">
	$(function() {
		$("#busbtn").click(function() {
			if (1 != 1) {
				
			}else if(!checkForm($("#tel"),"비상연락처를" )){
				return;
			}else if(!inputVerify(3,$("#tel"))){
				
			
			}else if(!checkForm($("#fhour"),"시간을" )){
				return;
			}else if(!checkForm($("#fmin"),"분을" )){
				return;
			}else if(!checkForm($("#FDATE"),"일시를 " )){
				return;
			}else if(!checkForm($("#t1"),"이용목적을" )){
				return;
			}else if(!checkForm($("#t2"),"출발지를" )){
				return;
			}else if(!checkForm($("#t3"),"인원을" )){
				return;
			}else if(!checkForm($("#t4"),"기타 요청사항을" )){
				return;
			}else {
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());

				$("#frm").attr({
					"method" : "post",
					"action" : "bookinsert2.do"
				});
				$("#frm").submit();
			}

		});

	});
</script>
<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation bus">

			<form id="frm" name="frm">
				<div class="content_h3bx">
					<h3>${type }</h3>
					<div class="h3_icon">
						<img src="../img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
					</div>
				</div>
				<div class="request_area">
					<div class="bus_info clear"></div>
					<div class="bus_request">
						<h4>셔틀버스 신청하기</h4>
						<input type="hidden" name="NTT_ID" value="${NTT_ID }">
						<ul>
							<li><div>
									<span>신청자명</span><input type="text" value="${lvo.name }"
										readonly="readonly">
								</div> <input type="hidden" name="MBER_ID" value="${lvo.id }" /></li>
							<li class="border_none bus_email">
								<div>
									<span>이메일</span><input type="text" value="${lvo.email }"
										readonly="readonly"> <span>연락처</span><input
										type="text"  value="${lvo.tel }" readonly="readonly">
								</div>
							</li>
							<li><div>
									<span>비상연락처</span><input type="text" name="TEL_SEC" id="tel"
										placeholder="010-0000-0000식으로 입력">
								</div></li>

							<li>
								<div>
									<span>일시</span><input type="date" id="FDATE"  name="FDATE">
									<input type="hidden" id="FTIME" name="FTIME" value="00:00" />
									 <span>시간</span>
									<select id="fhour">
										<c:forEach begin="0" end="23" varStatus="i">
											<option class="hourbtn" value="${i.index }">${i.index }</option>
										</c:forEach>
									</select> <select id="fmin">
										<option class="minbtn" value="00">00</option>
										<option class="minbtn" value="30">30</option>
									</select>
								</div>
							</li>
							<li><div>
									<span>이용목적</span><input type="text" id="t1" name="FOBJECT">
								</div></li>
							<li><div>
									<span>츨발지</span><input type="text"id="t2"   name="STARTING">
								</div></li>
							<li><div>
									<span>인원</span><input type="text"id="t3"   name="CNT">
								</div></li>
							<li class="border_none bux_box"><div>
									<span>기타 요청사항</span>
								</div> <textarea name="REQUEST" id="t4"  cols="30" rows="10"></textarea></li>
						</ul>
					</div>
					<div class="edu_agree">
						<button type="button" id="busbtn">신청</button>
					</div>
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>