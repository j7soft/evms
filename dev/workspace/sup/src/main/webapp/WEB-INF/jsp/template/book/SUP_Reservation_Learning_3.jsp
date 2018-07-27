<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Reservation.css">
<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
<c:set value="${vo.CNT - vo.RDCNT}" var="pbCnt"/>
<script type="text/javascript" >
	$(function(){
		/* $("#CNT").val($("#b").val()+","+$("#s").val());
		$(".CNT").change(function(){
			$("#PRICE").val((parseInt($("#b").val())*"${pri[0]}")+(parseInt($("#s").val())*"${pri[1]}") );
		}) */
		$("#trabtn").click(function(){			
			var loginId = '${loginVO.id}'
			if(loginId == ""){
				location.href='/loginUsr.do';
				return false;
			}else if($("#b").val() == "" || $("#s").val() == ""){
				alert("인원을 입력해주세요");
				return false;		
			}else if(!$("#etr1").prop("checked")){
				alert("동의가 필요합니다.");
				return false;
			}else{
				var rcnt = parseInt($("#b").val()) + parseInt($("#s").val());
				if (rcnt == "" ){
					alert("인원을 입력해주세요");
					return false;
				}else if(rcnt > "${pbCnt}"){
					alert("인원을 초과하였습니다.\n"
					     +"현재접수인원 :${vo.RDCNT}\n"
					     +"접수가능인원 :${pbCnt}");
					return false;
				}
				$("#CNT").val($("#b").val()+","+$("#s").val());
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
			<form id="frm" name="frm" action="mypage.do" method="post">
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
					<input type="hidden" id="NTT_ID" name="NTT_ID" value="trip" />
					<input type="hidden" id="NTT_NO" name="NTT_NO" value="${vo.BBS_ID }" />
					<input type="hidden" id="TITLE" name="TITLE" value="${vo.TITLE }" />
					<input type="hidden" id="FDATE" name="FDATE" value="${vo.FDATE }" />
					<input type="hidden" id="FTIME" name="FTIME" value="${vo.FTIME }" />
					<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
					<input type="hidden" id="CNT" name="CNT" value="" />
					<div class="edu_location clear">
						<%-- <img src="/uploadStorage/file/${ }"> --%>
						<textarea readonly="readonly" rows="20" cols="50">${vo.CONTENT }</textarea>
						
					</div>
					<div class="input_hr">
							<ul>
								<li>
									<h2>성명</h2>
									<div>
										<input type="text" name="NAME" id="NAME" value="${lvo.name }">
									</div>
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="text" name="CHARGE_TEL" id="CHARGE_TEL" value="${lvo.tel }">
									</div>
								</li>
								<li>
									<h2>이메일</h2>
									<div>
										<input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }">
									</div>
								</li>
								<li>
									<h2>인원</h2>
										

									<div>
										<input type="number" name="bb" step="1" id="b" min="0" max="50" placeholder="성인인원을 입력하세요.">
										<input type="number" name="ss" id="s" placeholder="아동인원을 입력하세요." style="margin-top: 10px;">
									</div>
								</li>
								
								<li class="radio_box_hr">
									<ul>
										<li>
											<label>
												<input type="checkbox" name="eat1" id="etr1">
												개인정보 이용동의 <a href="#"><strong style="margin-left:8px;" onclick="javascript:document.getElementById('wrap_agree').style.display='block';">개인정보 이용약관</strong></a>
											</label>
										</li>
									<!--	<li>
											<label>
												<input type="checkbox" name="eat1" id="etr2">
												사진촬영 동의
											</label>
										</li>				-->					
										
										</ul> 
								</li>
							</ul>
	
					</div>
				<div class="btn_h">
					<button type="submit" id="trabtn">신청하기</button>
					<!-- onclick="window.location.href='mypage.do'" -->
			    </div>
            </div>
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>
<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>
<style>
 #b, #s{width:45%;} 
  .learning3 .request_area .edu_location textarea{padding:10px;}
@media all and (max-width:1201px){
}
</style>