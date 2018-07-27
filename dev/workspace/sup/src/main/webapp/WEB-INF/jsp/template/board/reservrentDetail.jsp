<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	$(function() {
		/* $(".stbtn").click(function(){
			var st =  $(this).val();
			if(confirm(st+" 하시겠습니까?")){
				location.href="/admin/stupdate.do?NTT_ID=${vo.NTT_ID}&BBS_ID=${vo.BBS_ID}&ONOFF="+st;
			}
		}); */

	});
	
</script>

<section class="width625">

	<div id="b_office_Reservation3">


		<div class="title_box">
			<h3>대관 예약</h3>
			<a href="javascript:history.go(-1)"><img
				src="../img/community/list_icon.png" alt="목록보기 아이콘"> 목록보기</a>
		</div>
		<div class="head">
			<input type="text" name="" class="date" readonly value="${vo.FDATE }">
			/&nbsp;&nbsp;&nbsp; <input type="text" name="" class="time" readonly
				value="${vo.FTIME }~${vo.STIME }">
			<div>
				<input type="text" name="" class="place" readonly
					value="${pvo.TITLE }">
			</div>
		</div>

		<div class="form_group">
			<span>인원</span> <span><input type="text" name="" readonly
				value="${vo.CNT }"></span>
		</div>
		<div class="form_group">
			<span>단체명</span> <span><input type="text" name="" readonly
				value="${vo.TEAMNAME }"></span>
		</div>
		<div class="form_group">
			<span>사업자등록번호</span> <span><input type="text" name="" readonly
				value="${vo.CRNUM }"></span>
		</div>
		<div class="form_group">
			<span>단체소개</span> <span><input type="text" name="" readonly
				value="${vo.TEAMCONTENT }"></span>
		</div>
		<!--<div class="form_group">
			<span>주소</span> <span><input type="text" name="" readonly value="${vo.ADDRESS }"></span>
		</div>-->
		<div class="form_group">
			<p>
				서울새활용플라자관련 민간협력기관, 입주기업, 협력사 해당 여부<span>대관시 대관료 할인 여부 판단용입니다.</span>
			</p>
			<input type="text" name="" readonly value="${vo.COMPANIES }">
		</div>

		<div class="box">
			<div class="form_group">
				<span>신청자</span> <span><input type="text" name="" readonly
					value="${lvo.name }"></span>
			</div>
			<div class="form_group">
				<span>직위</span> <span><input type="text" name="" readonly
					value="${vo.CAPTAINNAME }"></span>
			</div>
			<div class="form_group">
				<span>연락처</span> <span><input type="text" name="" readonly
					value="${lvo.tel }"></span>
			</div>
			<div class="form_group">
				<span>이메일</span> <span><input type="text" name="" readonly
					value="${lvo.email }"></span>
			</div>
		</div>

		<div class="box2">
			<div class="form_group">
				<span>대관 행사명</span> <span><input type="text" name="" readonly
					value="${vo.EVENTNAME }"></span>
			</div>
			<div class="form_group">
				<span>용도</span> <span><input type="text" name=""
					value="${vo.USAGE }" readonly></span>
			</div>
			<div class="form_group">
				<span>행사 참가 대상</span> <span><input type="text" name=""
					value="${vo.TARGET }" readonly></span>
			</div>
			<div class="form_group">
				<span>행사 참가비 유/무 여부</span> <span><input type="text" name=""
					value="${vo.ENTRYFEE }" readonly></span>
			</div>
			<div class="form_group">
				<span>시설물(현수막,배너) 설치 및 물품 반입 계획 및 여부</span> <span><input
					type="text" name="" readonly value="${vo.ITEM }"></span>
			</div>
		</div>
		<!--<p>* 시설물 설치 및 변경(현수막, 안내물, 가설물 등), 물품 반입 등의 사항이 있을 시 계획서를 작성하여 사용
			전 미리 협의하여 주시기 바랍니다.</p>
		<p>(케이터링 등 음식반입은 불가합니다.) - 현재 내, 외부 현수막 설치는 불가합니다.</p>-->
		<!-- 
		<div class="form_group">
			<input type="button" class="stbtn" value="승인"> 
			<input type="button" class="stbtn" value="거절">
		</div> -->

	</div>

</section>

<style>
section.width625 {
	display: block;
	margin: 100px auto;
	float: none;
}

#b_office_Education3>.form_group:last-of-type {
	text-align: left;
	margin-top: 0;
}

.title_box {
	margin-bottom: 40px;
}

.title_box h3 {
	display: inline-block;
}

.title_box a {
	float: right;
	display: inline-block;
	font-size: 0.8em;
}

.title_box a img {
	width: 23px;
	margin-top: -1px;
}
</style>
