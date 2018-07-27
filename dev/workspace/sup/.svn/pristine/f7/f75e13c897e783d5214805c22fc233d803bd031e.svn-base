<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/sliderstyle.css">
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<script type="text/javascript">
	$(function() {
		$(".rad").click(function(){
			$("#name").val($(this).val());
		});
		$("#btn").click(function() {
			if (1 != 1) {

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
		$(".rad").click(function() {

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
		<article class="reservation Rent_3">
			<div class="content_h3bx">
				<h3>대관</h3>
				<div class="h3_icon">
					<img src="../img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
				</div>
			</div>
			<form id="frm" name="frm">
				<input type="hidden" id="MBER_ID" name="MBER_ID" value="${lvo.id }" />
				<input type="hidden" id="BBS_ID" name="BBS_ID" value="대관예약" />
				<input type="hidden" id="name" name="NAME" />
				<div class="topBox clear">
					<div class="Box1">
						<p>대관 장소</p>
						<br />
						<c:forEach begin="0" end="${list.size() }" varStatus="i">
							<c:if test="${not empty list[i.index].TITLE}">
								<label for="" id="radio${i.index }">
									<p>
										<input type="radio" class="rad" id="radio${i.index }"
											 value="${list[i.index].BBS_ID }" />${list[i.index].TITLE}
										(운영요일:${list[i.index].FDATE} /
										운영시간:${list[i.index].FTIME}:${list[i.index].STIME} / 사용가능
										인원:${list[i.index].TITLE} / 가격:${list[i.index].PRICE} /
										담당자:${list[i.index].PTB})
									</p>
								</label>
							</c:if>
						</c:forEach>
					</div>
					<div class="box2">
						<ul>
							<li><span>인원</span> <input type="number" id="t1" name="CNT"
								placeholder="숫자를 기입해주세요."></li>
							<li><span>일자</span> <input type="date" id="t2" name="FDATE">
							<li><span>시간</span> <input type="hidden"  id="FTIME"
								name="FTIME" value="00:00" /> <select id="fhour">
									<c:forEach begin="9" end="18" varStatus="i">
										<option class="hourbtn" value="${i.index }">${i.index }</option>
									</c:forEach>
							</select> <select id="fmin">
									<option class="minbtn" value="00">00</option>
									<option class="minbtn" value="30">30</option>
							</select> <input type="hidden" id="STIME" name="STIME" value="00:00" /> <select
								id="shour">
									<c:forEach begin="9" end="18" varStatus="i">
										<option class="hourbtn" value="${i.index }">${i.index }</option>
									</c:forEach>
							</select> - <select id="smin">
									<option class="minbtn" value="00">00</option>
									<option class="minbtn" value="30">30</option>
							</select> <small>평일 및 공휴일 09~19시 사이</small></li>



							<li><span>단체명</span><input type="text" id="t3"  name="TEAMNAME"
								placeholder="신청하려는 대표 단체명을 기입해주세요."></li>
							<li><span>직위</span><input type="text"  id="t4"  name="CAPTAINNAME"
								placeholder="없을 경우 공란"></li>
							<li><span>사업자 번호</span><input type="text"id="t5"  name="CRNUM"
								placeholder="없을 경우 공란"></li>
							<li><span>단체소개</span> <input type="text" id="t6" name="TEAMCONTENT"
								placeholder="대관 심의시 참고합니다."></li>
							<li><span>주소</span> <input type="text" id="t7" name="ADDRESS"></li>
						</ul>
					</div>
					<div class="box3">
						<p>
							서울새활용플라자관련 민간협력기관, 입주기업, 협력사 해당 여부 <span>대관시 대관료 할인 여부
								판단용입니다</span>
						</p>
						<input type="hidden" id="" name="" value="" />
						<ul>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="정부 및 산하기관"> 정부 및 산하기관
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="서울시"> 서울시
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="서울시 산하기관 등 공공기관"> 서울시 산하기관 등 공공기관
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="서울새활용플라자 입주기업"> 서울새활용플라자 입주기업
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="서울새활용플라자 민간협력기관"> 서울새활용플라자 민간협력기관
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="서울새활용플라자 협력사"> 서울새활용플라자 협력사
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES" value="기타">
										기타
									</p></label></li>
							<li><label for="" id=""><p>
										<input type="radio" id="COMPANIES" name="COMPANIES"
											value="해당사항 없음"> 해당사항 없음
									</p></label></li>
							<li class="inputli"></li>
						</ul>
					</div>
					<div class="box4">
						<ul>
							<li><span>신청자명</span><input type="text" value="${lvo.name }"
								readonly="readonly"></li>
							<li><span>연락처</span><input type="text" value="${lvo.tel }"
								readonly="readonly"></li>
							<li><span>이메일</span><input type="text" value="${lvo.email }"
								readonly="readonly"></li>
							<li class="inputli"></li>
							
						</ul>
					</div>
					<div class="box5">
						<ul>
							<li><p>
									대관 행사명 <input type="text" id="t8"  name="EVENTNAME">
								</p> <small>* 교육, 회의, 워크샵 용도 외의 대관은 받지 않으며 교육시 상품, 유료 서비스의
									홍보와 계약 유도, 판매를 주된 목적으로 하는 사용은 불가합니다. (새활용관련 유료 교육 프로그램은 가능)</small></li>
							<li><p>
									행사 참가 대상 <input type="text"id="t9"  name="t9">
								</p></li>
							<li><p>
									행사참가비 유/무 여부 <label for="f"><input type="radio"
										name="ENTRYFEE" value="유료" id="f"></label> <span>유료</span> <label
										for="s"><input type="radio" name="ENTRYFEE" value="무료"
										id="s"></label> <span>무료</span> <label for="t"><input
										type="radio" name="ENTRYFEE" value="기타" id="t"></label> <span>무료이나
										기타조건이 필요</span>
								</p></li>
							<li class="inputli"></li>
							<li><p>
									시설물(현수막,배너) 설치 및 물품 반입 계획 및 여부 <label for=""> <input
										type="radio" name="ITEM" id="ITEM"></label> <span>있음</span> <label
										for=""> <input type="radio" name="ITEM" id="ITEM"></label>
									<span>없음</span>
								</p> <small>* 설물 설치 및 변경(현수막, 안내물, 가설물 등), 물품 반입 등의 사항이 있을 시
									계획서를 작성하여 사용 전 미리 협의하여 주시기 바랍니다. (케이터링 등 음식반입은 불가합니다.) -현재 내,
									외부 현수막 설치는 불가합니다.</small></li>
						</ul>
					</div>
					<div class="box6">
						<p>
							개인정보 수집 및 이용 동의 <label for=""><input type="radio" id=""
								name="radio0"></label> <span>동의</span> <label for=""><input
								type="radio" id="" name="radio0"></label> <span>동의하지 않음</span>
						</p>
						<small>* 서울새활용플라자 대관 시설 이용객의 편의/예약 신청/사용 등과 관련된 내용 이외엔
							개인정보를 사용하지 않습니다</small>
						<p>
							승인 여부 안내 <label for=""><input type="radio" id=""
								name="radio01"></label> <span>동의</span> <label for=""><input
								type="radio" id="" name="radio01"></label> <span>동의하지않음</span>
						</p>
						<small>* 대관 신청이 승인되면, 담당자 메일로 대관 신청서 및 대관 운영 계획, 대관 계약서,
							대관 입금안내서 등을 보내드립니다. 기 확정된 대관이 있거나 미승인시에는 대관 불가 안내 문자를 보내드리니
							참고바랍니다.</small>
					</div>
					<div class="btn">
						<button id="btn" type="button">신청</button>
					</div>
				</div>
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->