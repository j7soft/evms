<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
<script type="text/javascript" >
	$(function(){
		console.log("${pri[0]}~~${pri[1]}");
		$("#CNT").val($("#b").val()+","+$("#s").val());
		$(".CNT").change(function(){
			$("#PRICE").val((parseInt($("#b").val())*"${pri[0]}")+(parseInt($("#s").val())*"${pri[1]}") );
		})
		$("#trabtn").click(function(){			
			if(!$("#c1").prop("checked") || !$("#c2").prop("checked")){
				alert("동의가 필요합니다.");	
				return;
			
			
			
			
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			}else{
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
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation learning3">
			<form id="frm" name="frm">
				<
				<div class="content_h3bx">
					<h3>현장학습</h3>
					<div class="h3_icon">
						<img src="/img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
					</div>
				</div>
				<div class="request_area">
					<h4>${vo.TITLE }</h4>
					<p class="edu_summary">${vo.SIMPLECONTENT }</p>
					<input type="hidden" name="NAME" value="${vo.BBS_ID }" />
					<div class="edu_location clear">
						<%-- <img src="/uploadStorage/file/${ }"> --%>
						<textarea readonly="readonly" rows="20" cols="50">${vo.CONTENT }</textarea>
						
					</div>
					<input type="hidden" name="MBER_ID" value="${lvo.id }">
					<div class="edu_request">
						<ul>
							<li><div>
									<span class="redstar">예약자</span><input id="t1" type="text" value="${lvo.name }">
								</div></li>
							<li>
								<div class="width48">
									<span class="redstar">연락처</span><input id="t2" type="text" value="${lvo.tel }">
								</div>
								<div class="width48">
									<span>이메일</span><input id="t3" type="text" value="${lvo.email }">
								</div>
							</li>
							
							<li>
								<div>
									<span class="redstar">예약자소속</span><input id="t4" type="text" name="PTB">
								</div>
							</li>
							<li><span class="redstar">인원</span>
								<input type="hidden" id="CNT" name="CNT"/>
								<div class="width43">
									<span>성인</span><input value="0" class="CNT" type="number" id="b" name="" step="1" min="0" max="50" 	class="edu_number">
								</div>
								<div class="width43">
									<span>아동</span><input value="0" class="CNT" type="number" id="s" name="" step="1" min="0" max="50" 
										class="edu_number">
								</div></li>
							<li><div>
									<span>금액</span><input id="t5" type="text" name="PRICE" id="PRICE">
								</div></li>
						</ul>
					</div>
					<div class="edu_agree">
						<ul>
							<li><input type="checkbox" name="" class=""  id="c1"><label
								for="">개인정보 이용동의</label><a href="">[개인정보 이용동의서]</a></li>
							<li><input type="checkbox" name="" class=""  id="c2"><label
								for="">사진촬영 동의</label></li>
						</ul>
						<button type="button" id="trabtn">예약 신청하기</button>
					</div>
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>