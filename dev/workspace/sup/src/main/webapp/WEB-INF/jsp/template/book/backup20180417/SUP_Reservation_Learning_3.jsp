<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link rel="stylesheet" href="/css/SUP_Reservation.css">
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
<script type="text/javascript" >
	$(function(){
		/* $("#CNT").val($("#b").val()+","+$("#s").val());
		$(".CNT").change(function(){
			$("#PRICE").val((parseInt($("#b").val())*"${pri[0]}")+(parseInt($("#s").val())*"${pri[1]}") );
		}) */
		$("#trabtn").click(function(){			
			if(!$("#etr1").prop("checked") || !$("#etr2").prop("checked")){
				alert("동의가 필요합니다.");	
				return;
			
			
			} else if (!checkForm($("#NAME"), "예약자명을")) {
				return;
			} else if (!checkForm($("#CHARGE_TEL"), "연락처를")) {
				return;
			} else if (!checkForm($("#EMAIL"), "이메일을")) {
				return;
			} else if (!checkForm($("#bb"), "성인 인원을")) {
				return;
			} else if (!checkForm($("#ss"), "아동 인원을")) {
				return;
			}else{
			
				console.log($('#MBER_ID').val());
				console.log($('#et2').val());
				console.log($('#et3').val());
				console.log($('#b').val());
				console.log($('#s').val());

				
				$("#CNT").val($("#bb").val() + "," + $("#ss").val());
				
				$("#frm").attr({
					"method":"post",
					"action":"/bookinsert2.do"
				});
				$("#frm").submit();
			}
		});
	});
</script>


<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="reservation learning3">
			<form id="frm" name="frm">
				<div class="content_h3bx">
					<h3>현장학습</h3>
					<ul class="route">
	                    <li>홈</li>
	                    <li>대관 및 예약</li>
	                    <li>현장학습</li>
	                </ul>
				</div>
				<div class="request_area">
					<h4>${vo.TITLE }</h4>
					<p class="edu_summary">${vo.SIMPLECONTENT }</p>
					<input type="hidden" name="NTT_NO" value="${vo.BBS_ID }" />
					<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
					<input type="hidden" name="NTT_ID" value="trip" />
					<input type="hidden" name="TITLE" value="${vo.TITLE }" />
					<input type="hidden" name="FDATE" value="${vo.FDATE }" />
					<input type="hidden" name="FTIME" value="${vo.FTIME }" />
					<input type="hidden" name="STIME" value="${vo.FTIME }" />
					
		            <input type="hidden" id = "CNT"  name="CNT" value="" />
		            <input type="hidden" id = "PRICE"  name="PRICE" value="" />
					
					<div class="edu_location clear">
						<%-- <img src="/uploadStorage/file/${ }"> --%>
						<textarea readonly="readonly" rows="20" cols="50">${vo.CONTENT }</textarea>
						
					</div>
					<div class="input_hr">
							<ul>
								<li>
									<h2>성명</h2>
									<div>
										<input type="text" name="NAME" id="NAME" value="${lvo.name }" placeholder="성명을 입력해주세요" required>
									</div>
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="text" name="CHARGE_TEL" id="CHARGE_TEL" value="${lvo.tel }" placeholder="연락처를 입력해주세요" required>
									</div>
								</li>
								<li>
									<h2>이메일</h2>
									<div>
										<input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }" placeholder="이메일을 입력해주세요" required>
									</div>
								</li>
								<li>
									<h2>인원</h2>
									<div>
										<input type="text" name="bb" id="bb" placeholder="성인인원을 입력하세요.">
										<input type="text" name="ss" id="ss" placeholder="아동인원을 입력하세요." style="margin-top: 10px;">
									</div>
								</li>
								
								<li class="radio_box_hr">
									<ul>
										<li>
											<label>
												<input type="checkbox" name="eat1" id="etr1" required>
												개인정보 이용동의 <a href="#"><strong>개인정보 이용동의서</strong></a>
											</label>
										</li>
										<li>
											<label>
												<input type="checkbox" name="eat2" id="etr2">
												사진촬영 동의
											</label>
										</li>
									</ul> 
								</li>
							</ul>
	
					</div>
				<div id = "trabtn" class="btn_h">
					<button>신청하기</button>
			    </div>
            </div>
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/index.js"></script>
<style>
 #bb, #ss{width:45%;} 

</style>