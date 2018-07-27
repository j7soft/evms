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

	<div id="b_office_Learning3">

		<div class="title_box">
			<h3>현장학습 예약</h3>
		</div>
		<div class="head">
			<input type="text" name="" class="date" readonly
				value="${vo.FDATE } / ${vo.FTIME}  ${vo.STIME}">
			<div></div>
		</div>

		<div class="form_group">
			<span>구분1</span> <span><input type="text" name=""  value="${vo.FTYPE }" 
				readonly></span>
		</div>
		<div class="form_group">
			<span>단체명</span> <span><input type="text" name="" value="${vo.TEAMNAME }" 
				readonly></span>
		</div>

		<div class="box">
			<% //if(${lvo.name }.equals'이지혜') { %>
			<% 
			//out.println( aaa ); 
			%>
			<div class="form_group">
				<span>신청자명</span> <span><input type="text" name="" value="${lvo.name }" 
					readonly></span>
			</div>
			<%// } %>
			<div class="form_group">
				<span>예약자소속</span> <span><input type="text" name="" value="${vo.PTB }"
					readonly></span>
			</div>
			<div class="form_group">
				<span>연락처</span> <span><input type="text" name="" value="${lvo.tel }"
					readonly></span>
			</div>
			<div class="form_group">
				<span>이메일</span> <span><input type="text" name=""
					value="${lvo.email }" readonly></span>
			</div>
		</div>
		<div class="form_group">
			<span>상품명</span> <span><input type="text" name=""
				value="${vo.TITLE }" readonly></span>
		</div>
		<div class="form_group">
				<span>인원</span> <span> <input type="text" name="" value="${vo.CNT }"
					readonly> 
				</span>

			</div>

		
		<div class="box2">
		<div class="form_group">
			<span>요청사항</span>
			<textarea name="" id="" cols="30" rows="10">${vo.REQUEST }</textarea>
		</div>
		
			
			<!-- <div class="form_group">
				<span>금액</span> <span><input type="text" name=""
					value="${vo.PRICE }" readonly></span>
			</div> -->
		</div>

		<!-- <div class="form_group">
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