<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>






<script type="text/javascript">
	IMP.request_pay({
		amount : 1000,
		buyer_name : '홍길동',
		name : '결제테스트'
	}, function(response) {
		//결제 후 호출되는 callback함수
		if (response.success) { //결제 성공
			console.log(response);
		} else {
			alert('결제실패 : ' + response.error_msg);
		}
	})
</script>





<link rel="stylesheet" href="/css/SUP_Backoffice.css" />
<form name="pgForm">
	<input type="hidden" name="Amt" value="1000">
	<input type="hidden" name="BuyerName" value="홍길동">
	<input type="hidden" name="OrderName" value="결제테스트">
</form>
<section class="width625">

	<div id="b_office_Bus3">

		<div class="title_box">
			<h3>셔틀버스 예약 ${vo.lname}</h3>
		</div>
		<div class="form_group">
			<span>신청자</span> <span><input type="text" name=""
				value="${uvo.name }" readonly></span>
		</div>
		<div class="form_group">
			<span>이메일</span> <span><input type="text" name=""
				value="${uvo.email }" readonly /></span>
		</div>
		<div class="form_group">
			<span>연락처</span> <span><input type="text" name=""
				value="${uvo.tel }" readonly /></span>
		</div>
		<div class="form_group">
			<span>비상연락처</span> <span><input type="text" name=""
				value="${vo.TEL_SEC }" readonly /></span>
		</div>
		<div class="form_group">
			<span>일시</span> <span><input type="text" name=""
				value="${vo.FDATE } / ${vo.FTIME}" readonly /></span>
		</div>
		<div class="form_group">
			<span>이용목적</span> <span><input type="text" name=""
				value="${vo.FOBJECT }" readonly></span>
		</div>
		<div class="form_group">
			<span>출발지</span> <span><input type="text" name=""
				value="${vo.STARTING }" readonly></span>
		</div>

		<div class="form_group">
			<span>인원</span> <span><input type="text" name=""
				value="${vo.CNT }" readonly></span>
		</div>

		<div class="form_group">
			<span>기타 요청사항</span>
			<textarea name="" id="" cols="30" rows="10" readonly="readonly">${vo.REQUEST }</textarea>
		</div>

		<div class="form_group">
			<input type="button" class="sbtn" value="승인완료"> <input
				type="button" class="sbtn" value="승인거절">
		</div>

	</div>

</section>