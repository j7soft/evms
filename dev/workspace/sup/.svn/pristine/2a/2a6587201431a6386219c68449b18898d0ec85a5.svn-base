<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	$(function(){
		$(".stbtn").click(function(){
			var st =  $(this).val();
			if(confirm(st+" 하시겠습니까?")){
				location.href="/admin/stupdate.do?NTT_ID=${vo.NTT_ID}&BBS_ID=${vo.BBS_ID}&ONOFF="+st;
			}
		});
		
	});



</script>
<section class="width625">

	<div id="b_office_Bus3">

		<div class="title_box">
			<h3>셔틀버스 예약</h3>
		</div>
		<div class="form_group">
			<span>신청자</span> <span><input type="text" name="" value="${vo.NAME }" readonly></span>
		</div>
		<div class="form_group">
			<span>이메일</span> <span><input type="text" name="" value="${vo.EMAIL }" readonly /></span>
		</div>
		<div class="form_group">
			<span>연락처</span> <span><input type="text" name="" value="${vo.CHARGE_TEL }" readonly /></span>
		</div>
		<div class="form_group">
			<span>비상연락처</span> <span><input type="text" name="" value="${vo.TEL_SEC }" readonly /></span>
		</div>
		<div class="form_group">
			<span>일시</span> <span><input type="text" name="" value="${vo.FDATE } / ${vo.FTIME}" readonly /></span>
		</div>
		<div class="form_group">
			<span>이용목적</span> <span><input type="text" name="" value="${vo.FOBJECT }"
				readonly></span>
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

		<!--<div class="form_group">
			<input type="button" class="stbtn" value="승인"> 
			<input type="button" class="stbtn" value="거절">
		</div>-->

	</div>

</section>

<style>
	section.width625{display:block;margin:100px auto; float:none;}
	#b_office_Education3 > .form_group:last-of-type{text-align:left;margin-top:0;}
	.title_box{margin-bottom:40px;}
	
</style>
