<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
<script type="text/javascript">
	$(function() {
		console.log("${pri[0]}~~${pri[1]}");
		$("#CNT").val($("#b").val() + "," + $("#s").val());
		$(".CNT").change(
				function() {
					$("#PRICE").val(
							(parseInt($("#b").val()) * "${pri[0]}")
									+ (parseInt($("#s").val()) * "${pri[1]}"));

				})
		$("#trabtn").click(function() {
			if (!$("#c1").prop("checked") || !$("#c2").prop("checked")) {
				alert("동의가 필요합니다.");
				return;
			} else {

				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());
				$("#STIME").val($("#shour").val() + ":" + $("#smin").val());

				$("#frm").attr({
					"method" : "post",
					"action" : "/bookinsert2.do"
				});
				$("#frm").submit();
			}
		});
	});
</script>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation learning4">
			<div class="content_h3bx">
				<h3>현장학습</h3>
				<div class="h3_icon">
					<img src="../img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
				</div>
			</div>
			<div class="request_area">
				<h4>${vo.TITLE }</h4>
				<p class="edu_summary">${vo.SIMPLECONTENT }</p>
				<div class="edu_location clear"></div>






				<div class="edu_request edu_request1">
					<h5>단체예약 현장학습</h5>

					<div class="form_group">
						<label for="">일반단체</label> <input type="radio" name="TYPE"
							value="일단단체"> <label for="">학생단체</label> <input
							type="radio" name="TYPE" value="학생단체">
					</div>

					<ul>

						<li><div>
								<span>단체명</span><input type="text" name="TEAMNAME">
							</div></li>
						<li><span class="left">인원</span> <input type="hidden"
							id="CNT" name="CNT" />
							<div class="width43">
								<span>성인</span><input value="0" class="CNT" type="number" id="b"
									name="" step="1" min="0" max="50" class="edu_number">
							</div>
							<div class="width43">
								<span>아동</span><input value="0" class="CNT" type="number" id="s"
									name="" step="1" min="0" max="50" class="edu_number">
							</div></li>
						<li><span class="left">일자</span>
							<div class="width35">
								<input type="date" name="FDATE" />
							</div></li>

						<input type="hidden" id="FTIME" name="FTIME" value="00:00" />
						<input type="hidden" id="STIME" name="STIME" value="00:00" />
						<li><span class="left">시간</span>
							<div class="width10">
								<select id="fhour">
									<c:forEach begin="9" end="18" varStatus="i">
										<option class="hourbtn" value="${i.index }">${i.index }</option>
									</c:forEach>
								</select>
							</div>
							<div class="width10">
								<select id="fmin">
									<option class="minbtn" value="00">00</option>
									<option class="minbtn" value="30">30</option>
								</select>
							</div> <%-- 
                          <span class="left bar">-</span>
                          <div class="width10">	<select id="shour">
								<c:forEach begin="9" end="18" varStatus="i">
									<option class="hourbtn" value="${i.index }">${i.index }</option>
								</c:forEach>
							</select> </div>
                          <div class="width10">
                          <select id="smin">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select><</div> --%> <span class="left text"> 평일 및 공휴일
								09~19시 사이 </span></li>
					</ul>

				</div>

				<div class="edu_request edu_request2">
					<input type="hidden" name="MBER_ID" value="${lvo.id }" />
					<ul>
						<li><div>
								<span>예약자</span><input type="text" value="${lvo.name }" >
							</div></li>
						<li>
							<div class="width48">
								<span>연락처</span><input type="text" value="${lvo.tel }">
							</div>
							<div class="width48">
								<span>이메일</span><input type="text" value="${lvo.email }">
							</div>
						</li>
						
						<li>
							<div>
								<span>예약자소속</span><input type="text" name="PTB">
							</div>
						</li>
					</ul>
				</div>

				<div class="check_box">
					<div class="form_group">
						<input type="checkbox" name=""> <label for="">새활용플라자<span>(1시간)</span></label>
					</div>
					<div class="form_group">
						<input type="checkbox" name=""> <label for="">새활용플라자
							+ 아름다운가게<span>(평일, 1시간 20분)</span>
						</label>
					</div>
					<div class="form_group">
						<input type="checkbox" name=""> <label for="">새활용플라자
							+ 서울도시금속회수센터<span>(평일 월 1회, 2시간)</span>
						</label>
					</div>
					<div class="form_group">
						<input type="checkbox" name=""> <label for="">새활용플라자
							+ 아름다운가게 + 서울하수도과학관 + 서울도시금속회수센터<span>(평일 월1회, 4시간)</span>
						</label>
					</div>

					<div class="text_box">
						<p>
							1. 현장학습 소요시간은 코스별 1시간에서 4시간까지 있습니다.<br> 단체 일정으로 인한 소요시간 조정
							가능합니다.
						</p>
						<p>
							2. 전후 일정이 있으시다면 기재해주시기 바랍니다.<br> 예약된 시간은 당일 변경 불가하므로 시간을 엄수해
							주시기 바랍니다.
						</p>
						<p>3. 유모차, 휠체어 유무 등 투어 진행에 참고할 기타 사항도 기재해주시기 바랍니다.</p>
					</div>
				</div>

				<div class="form_group">
					<h5>요청사항</h5>
					<textarea name="REQUEST" cols="30" rows="10"></textarea>
				</div>

				<div class="edu_agree">

					<ul>
						<li><div>
								<h5>금액</h5>
								<span class="right"><span>10,000</span> 원</span>
							</div></li>

						<li><input type="checkbox" name="" class="" onClick="" id=""><label
							for="">개인정보 이용동의</label><a href="">[개인정보 이용동의서]</a></li>
						<li><input type="checkbox" name="" class="" onClick="" id=""><label
							for="">사진촬영 동의</label></li>
						<li><input type="checkbox" name="" class="" onClick="" id=""><label
							for="">셔틀버스이용(무료)</label></li>
					</ul>
					<button>예약 신청하기</button>
				</div>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>