<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">


<section class="width625">

	<div id="b_office_Education3">

		<div class="title_box">
			<h3>교육 예약</h3>
		</div>
		<div class="head">
			<input type="text" name="" class="date" readonly
				value="${pvo.FDATE } - ${pvo.SDATE}"> /&nbsp;&nbsp;&nbsp; <input
				type="text" name="" class="time" readonly value="${pvo.FTIME} - ${pvo.STIME}">
			<div>
				<input type="text" name="" class="place" readonly value="${pvo.TITLE }">
			</div>
		</div>

		<div class="form_group">
			<span>신청자명</span> <span><input type="text" name="" value="${uvo.name }"
				readonly></span>
		</div>
		<div class="form_group">
			<span>기관/부서/직급</span> <span><input type="text" name=""
				value="${vo.TEAMNAME }" readonly></span>
		</div>
		<div class="form_group">
			<span>담당부서</span> <span><input type="text" name="" value="${vo.CAPTAINNAME }"
				readonly></span>
		</div>
		<div class="form_group">
			<span>직책/직급</span> <span><input type="text" name=""
				value="${vo.PTB}" readonly></span>
		</div>
		<div class="form_group">
			<span>연락처</span> <span><input type="text" name="" value="${uvo.tel }"
				readonly></span>
		</div>
		<div class="form_group">
			<span>이메일</span> <span><input type="text" name="" value="${uvo.email }"
				readonly></span>
		</div>

		<div class="box">
			<div class="form_group">
				<c:set var="cnt" value="${fn:split(vo.CNT,',') }" />
				<span>인원</span> <span><input type="text" name="" value="성인 : ${cnt[0] }"
					readonly></span> <span><input type="text" name=""
					value="아동 : ${cnt[1] }" readonly></span>
			</div>
			<div class="form_group">
				<span>금액</span> <span><input type="text" name=""
					value="${vo.PRICE }" readonly></span>
			</div>
		</div>
		<div class="form_group">
			<input type="button" class="sbtn" value="승인완료"> <input
				type="button" class="sbtn" value="승인거절">
		</div>

	</div>

</section>