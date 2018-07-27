<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/sliderstyle.css">
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<script type="text/javascript">
	$(function() {
		$/*(".rad").click(function(){
			$("#name").val($(this).val());
			$("#TITLE").val($(this).attr("data-title"));
		});*/
		$("#bbtn").click(function() {
		/*	if (1 != 1) {

			} else if (!checkForm($("#name"), "상품을 ")) {
				return;
			} else if (!checkForm($("#t1"), "인원을")) {
				return;
			} else if (!checkForm($("#t2"), "일자를")) {
				return;
			} else if (!checkForm($("#t3"), "단체명을")) {
				return;
			} else if (!checkForm($("#t4"), "직위를")) {
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
			} else {*/
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());
				$("#STIME").val($("#shour").val() + ":" + $("#smin").val());
				$("#frm").attr({
					"method" : "post",
					"action" : "/bookinsert2.do"
				});
				$("#frm").submit();
			

		});
		$(".rad").click(function() {

		});

	});
/*
	 $(".dateInput").on("input",function(){
		 console.log("111111");
		 console.log(this.nodeName);
		 return false;
		if($(this).val().length>0){
        $(this).addClass("full");
        }else{
            $(this).removeClass("full");
        }
        });*/
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
				<input type="hidden" id="BBS_ID" name="NTT_ID" value="${NTT_ID }" />
				<input type="hidden" id="TITLE" name="TITLE" />
				<input type="hidden" id="FTIME" name="FTIME" />
				<input type="hidden" id="STIME" name="STIME" />
				<input type="hidden" id="name" name="NAME" />
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
                                        <input type="number" name="CNT" id="CNT" placeholder="0" required >
                                    </div>
                                </li>
                                <li>
                                    <h2>일자</h2>
                                    <div>
                                        <input type="date" name="FDATE" id="FDATE" class="dateInput" required placeholder="일자를 입력해 주세요">
                                    </div>
                                </li>
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
												정부 및 산하기간
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
                                    <div><!--placeholder="신청자 명을 기입해 주세요"-->
                                        <input type="text" name="dd7" id="dd7" value="${lvo.id }" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>연락처</h2>
                                    <div>
                                        <input type="text" name="dd8" id="dd8" value="${lvo.tel }" required>
                                    </div>
                                </li>
                                <li>
                                    <h2>이메일</h2>
                                    <div>
                                        <input type="text" name="dd9" id="dd9" value="${lvo.email }" required>
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
												<input type="radio" name="ENTRYFEE" id="ENTRYFEE">
												유료
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="ENTRYFEE" id="ENTRYFEE">
												무료
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="ENTRYFEE" id="ENTRYFEE">
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
												<input type="radio" name="ITEM" id="ITEM">
												있음
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="ITEM" id="ITEM">
												없음
											</label>
										</li>
									</ul> 
									<p>＊설물 설치 및 변경 (현수막,안내물,가설물 등),물품 반입 등의 사항이 있을 시 계획서를 작성하여 사용 전 미리 협의 하여 주시기 바랍니다. (케이터링 등 음식반입은 불가합니다.)</p>
									<p>＊현재내, 외부 현수막 설치는 불가합니다.</p>  
								</li>								
								<li class="radio_box_hr">
									<label for="da">개인정보 수집 및 이용 동의<a href="#"><strong style="margin-left:8px;" onclick="javascript:document.getElementById('wrap_agree').style.display='block';">개인정보 이용약관</strong></a></label>
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
					<div class="btn_h">
				        <button id="bbtn">신청하기</button>
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
						input.dateInput{color:lightgray;}
						input.dateInput.full{color:black;}
						#shour, #smin, .dateInput{border:1px solid #ddd;}
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