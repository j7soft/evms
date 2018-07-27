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
				$("#stdbtn").click(function() {
					if (1 != 1) {
					
						alert( $("#BBS_ID").val());
						return;
					}
				});
				
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
	<div id="b_office_Reservation3">
			<input type="hidden" id="NTT_ID" name="NTT_ID" value="${vo.NTT_ID }" /> 
			<input type="hidden" id="BBS_ID" name="BBS_ID" value="${vo.BBS_ID }" />
		<div class="title_box">
			<h3>대관 예약</h3>
		</div>
		<div class="head">
			<input type="text" name="" class="date" readonly value="${vo.FDATE }"> /&nbsp;&nbsp;&nbsp;
			  <input type="text" name="" class="time" readonly value="${vo.FTIME }~${vo.STIME }">
			<div>
				<input type="text" name="" class="place" readonly value="${vo.TITLE }"> 
			</div>
		</div>

		<div class="form_group">
			<span>인원</span> <span><input type="text" name="" readonly value="${vo.CNT }"></span>
		</div>
		<div class="form_group">
			<span>단체명</span> <span><input type="text" name="" readonly value="${vo.TEAMNAME }"></span>
		</div>
		<div class="form_group">
				<span>직위</span> <span><input type="text" name="" readonly value="${vo.CAPTAINNAME }"></span>
		</div>	
		<div class="form_group">
			<span>사업자등록번호</span> <span><input type="text" name="" readonly value="${vo.CRNUM }"></span>
		</div>
		<div class="form_group">
			<span>단체소개</span> <span><input type="text" name="" readonly value="${vo.TEAMCONTENT }"></span>
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
				<span>신청자</span> <span><input type="text" name="" readonly value="${vo.NAME }"></span>
			</div>
			
			<div class="form_group">
				<span>연락처</span> <span><input type="text" name="" readonly value="${vo.CHARGE_TEL }"></span>
			</div>
			<div class="form_group">
				<span>이메일</span> <span><input type="text" name="" readonly value="${vo.EMAIL }"></span>
			</div>
		</div>

		<div class="box2">
			<div class="form_group">
				<span>대관 행사명</span> <span><input type="text" name="" readonly value="${vo.EVENTNAME }"></span>
			</div>
			<div class="form_group">
				<span>용도</span> <span><input type="text" name=""
					value="${vo.USAGE }" readonly></span>
			</div>
			<div class="form_group">
				<span>행사 참가 대상</span> <span><input type="text" name="" value="${vo.TARGET }"
					readonly></span>
			</div>
			<div class="form_group">
				<span>행사 참가비 유/무 여부</span> <span><input type="text" name="" value="${vo.ENTRYFEE }"
					readonly></span>
			</div>
			<div class="form_group">
				<span>시설물(현수막,배너) 설치 및 물품 반입 계획 및 여부</span> <span><input
					type="text" name="" readonly value="${vo.ITEM }"></span>
			</div>
		</div>
		<p>* 시설물 설치 및 변경(현수막, 안내물, 가설물 등), 물품 반입 등의 사항이 있을 시 계획서를 작성하여 사용
			전 미리 협의하여 주시기 바랍니다.</p>
		<p>(케이터링 등 음식반입은 불가합니다.) - 현재 내, 외부 현수막 설치는 불가합니다.</p>

		<div class="form_group">
			<input type="button" class="stbtn" value="승인"> 
			<input type="button" class="stbtn" value="거절">
			<input type="button" id="stdbtn" value="삭제">
		</div>
	</div>
</form>
</section>