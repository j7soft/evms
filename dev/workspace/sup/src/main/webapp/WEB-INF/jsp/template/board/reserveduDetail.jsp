<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<div id="b_office_Education3">

		<div class="title_box">
			<h3>교육 예약</h3>
		</div>
		<div class="head">
			 
			 <!-- 교육예약 마감일 value값 - ${vo.SDATE} -->
			<input type="text" name="" class="date" readonly value="${vo.FDATE }"> 
			  <input type="text" name="" class="time" readonly value="${vo.FTIME} - ${vo.STIME}">
			<div>
				<input type="text" name="" class="place" readonly value="${vo.TITLE }">
			</div>
		</div>

		<div class="form_group">
			<span>신청자명</span> <span><input type="text" name="" value="${lvo.name }"
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
		<%-- <div class="form_group">
			<span>기관/단체/회사명</span> <span><input type="text" name="" value="${vo.PTB}" readonly></span>
		</div> --%>
		<div class="form_group">
			<span>연락처</span> <span><input type="text" name="" value="${lvo.tel }"
				readonly></span>
		</div>
		<div class="form_group">
			<span>이메일</span> <span><input type="text" name="" value="${lvo.email }"
				readonly></span>
		</div>

		<div class="box">
			<div class="form_group">
				<c:set var="cnt" value="${fn:split(vo.CNT,',') }" />
				<span>인원</span> <span style="width:35.5%;"><input type="text" name="" value="성인 : ${cnt[0] }"
					readonly></span> <span style="width:35.5%;"><input type="text" name=""
					value="아동 : ${cnt[1] }" readonly></span>
			</div>

		</div>
			<!--<div class="form_group">
				<c:set var="price" value="${fn:split(pvo.PRICE,',') }" />
				<span>금액</span> <span style="width:35.5%;"><input type="text" name="" value="성인 : ${price[0] }"
					readonly></span> <span style="width:35.5%;"><input type="text" name=""
					value="아동 : ${price[1] }" readonly></span></span>
			</div>
			<div class="form_group">
				<span>합계</span>  <span><input type="text" name=""
					value="${(price[0]*cnt[0]) + (price[1]*cnt[1]) }" readonly></span>
			</div>-->
	<!-- 	<div class="form_group">
			<input type="button" class="stbtn" value="승인"> 
			<input type="button" class="stbtn" value="거절">
		</div> -->

	</div>

</section>

<style>
	section.width625{display:block;margin:100px auto; float:none;}
	#b_office_Education3 > .form_group:last-of-type{text-align:left;margin-top:0;}
	.title_box{margin-bottom:40px;}
	
</style>
