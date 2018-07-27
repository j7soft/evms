<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	$(function() {
		$(".stbtn").click(
						function() {

							<c:if test = "${not empty vo.ONOFF}">
							    alert("이미 " +"${vo.ONOFF}" + "된 건은 수정할 수 없습니다" );
							return false;
							</c:if>
							
							var st =  $(this).val();

							
							if(confirm(st+" 하시겠습니까?")){
								
								if(st == "승인" ){
									st = 'Y'
								}else{
									st = 'N'
								}
								
								location.href="/admin/stupdate.do?NTT_ID=${vo.NTT_ID}&BBS_ID=${vo.BBS_ID}&ONOFF="+st+"&CNT=${vo.CNT }&NTT_NO=${vo.NTT_NO }";
							}
						}); 
		$("#stdbtn").click(function() {
			if (1 != 1) {
			
				alert( $("#BBS_ID").val());
				return;
				
			} else {
				
		
				fnDelete();	
			}
		});
	});
	
	
	function fnDelete(){
		if(confirm("<spring:message code="common.delete.msg" />")){
			
			document.supContentVO.action = "<c:url value='/admin/reservDelete.do'/>";
			
		    document.supContentVO.submit();
		}
	}

</script>


<section class="width625">
<form name="supContentVO">
	<div id="b_office_Learning3">
			<input type="hidden" id="NTT_ID" name="NTT_ID" value="${vo.NTT_ID }" /> 
			<input type="hidden" id="BBS_ID" name="BBS_ID" value="${vo.BBS_ID }" />
		<div class="title_box">
			<h3>현장학습 예약</h3>
		</div>
		<div class="head">
			<input type="text" name="" class="date" readonly
				value="${vo.FDATE } / ${vo.FTIME} ">
			<div></div>
		</div>

		<div class="form_group">
			<span>구분</span> <span><input type="text" name=""
				value="${vo.FTYPE }" readonly></span>
		</div>
		<div class="form_group">
			<span>단체명</span> <span><input type="text" name=""
				value="${vo.TEAMNAME }" readonly></span>
		</div>

		<div class="box">
			<div class="form_group">
				<span>신청자명</span> <span><input type="text" name=""
					value="${vo.NAME }" readonly></span>
			</div>
			<div class="form_group">
				<span>예약자소속</span> <span><input type="text" name=""
					value="${vo.PTB }" readonly></span>
			</div>
			<div class="form_group">
				<span>연락처</span> <span><input type="text" name=""
					value="${vo.CHARGE_TEL }" readonly></span>
			</div>
			<div class="form_group">
				<span>이메일</span> <span><input type="text" name=""
					value="${vo.EMAIL }" readonly></span>
			</div>
		</div>
		<div class="form_group">
			<span>상품명</span> <span><input type="text" name=""
				value="${vo.TITLE }" readonly></span>
		</div>
		
		
			<div class="form_group">
				<c:set var="cnt" value="${fn:split(vo.CNT,',') }" />
				<span>인원</span> <span style="width:35.5%;"><input type="text" name="" value="성인 : ${cnt[0] }"
					readonly></span> <span style="width:35.5%;"><input type="text" name=""
					value="아동 : ${cnt[1] }" readonly></span>
			</div>

		<div class="form_group">
			<span style="float: left;">요청사항</span> <span><textarea name=""
					id="" cols="30" rows="10"
					style="margin-left: 1%; width: 99%; border: 1px solid #ccc;">${vo.REQUEST }</textarea></span>
		</div>

		<div class="form_group">
			<input type="button" class="stbtn" value="승인">
			<input type="button" class="stbtn" value="거절">
			<input type="button" id="stdbtn" value="삭제">
		</div>

	</div>
</form>
</section>
