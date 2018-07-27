<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function() {
		$("#ibtn").click(function() {
			if (1 != 1) {

			} else {
				var chk = "";
				var chkbox = document.getElementsByName("day");
				for (var i = 0; i < chkbox.length; i++) {
					if (chkbox[i].checked) {
						chk = chk + "," + chkbox[i].value;
					}
				}

				$("#FDAY").val(chk);
				$("#FTIME").val($("#fhour").val() + ":" + $("#fmin").val());
				$("#STIME").val($("#shour").val() + ":" + $("#smin").val());
				$("#PRICE").val($("#big").val() + "," + $("#small").val());
				$("#frm").submit();
			}
		});
		$('.dateInput').datepicker({dateFormat:'yy-mm-dd'});
		
		$("#ebtn").click(function() {
			if (1 != 1) {

				
			} else {
				var chk = "";
				var chkbox = document.getElementsByName("day");
				for(var i = 0 ; i<chkbox.length;i++){
					if (chkbox[i].checked) {
						//chk = chk +"," +chkbox[i].value;
						chk = (chk.trim() =='') ? chkbox[i].value : chk +"," +chkbox[i].value;
					}	
				}

				$("#FDAY").val(chk);
				if($("#fhour").val()<10 && $("#fhour").val().length == 1){
					$("#fhour").val("0"+$("#fhour").val());
				}
				if($("#shour").val()<10 && $("#shour").val().length ==1 ){
					$("#shour").val("0"+$("#shour").val());
				} 
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
				$("#PRICE").val($("#big").val()+","+$("#small").val());
				$("#NTT_NO").val('${NTT_NO}');
				$("#NTT_ID").val('${NTT_ID}');
			    console.log('NTT_ID : ' + $("#NTT_NO").val());
			    console.log('NTT_NO : ' + $("#NTT_ID").val());
			    console.log('file : ' + $("#file").val());
				console.log('TITLE : ' + $("#TITLE").val());
				console.log('FDAY : ' + $("#FDAY").val());
				console.log('CNT : ' + $("#CNT").val());
				console.log('FTIME : ' + $("#FTIME").val());
				console.log('STIME : ' + $("#STIME").val());
				console.log('PRICE : ' + $("#PRICE").val());
				console.log('DETAIL : ' + $("#DETAIL").val());
				console.log('PTB : ' + $("#PTB").val()); 
				console.log('NTT_NO : ' + $("#NTT_NO").val()); 
		
				fnUpdate();	
			}
		});

		$("#dbtn").click(function() {
			if (1 != 1) {
			
				alert( $("#BBS_ID").val());
				return;
				
			} else {
				
		
				fnDelete();	
			}
		});
		
		
		function fnUpdate(){
			if(confirm("<spring:message code="common.update.msg" />")){
				document.frm.action = "<c:url value='/admin/updateData.do'/>";
				
			    document.frm.submit();
			}
		}
		
	});

	function fnDelete(){
		if(confirm("<spring:message code="common.delete.msg" />")){
			
			document.frm.action = "<c:url value='/admin/boardDelete.do'/>";
		    document.frm.submit();
		}
	}
</script>
<link rel="stylesheet" href="/css/rent2.css">
<div id="main_wrap" style="margin-top:85px;">
<form method="post" id="frm" name="frm" action="/admin/registData.do" enctype="multipart/form-data">
	<!--  Header 영역  -->
	<input type="hidden" name="NTT_ID" value="trip" />
	<input type="hidden" name="BBS_ID" value="${vo.BBS_ID }" />
	<input type="hidden" name="MBER_ID" value="${vo.MBER_ID }" />
	<input type="hidden" id="FTIME" name="FTIME" value="" />
	<input type="hidden" id="STIME" name="STIME" value="" />
	<div class="left_content">

		

		<div class="form_group">
			<p style="margin-bottom:10px;">소개이미지</p>
			<input type="file" id="" name="mfile" value="" style="width: 90px;margin-bottom:20px;"><span>${vo.IMAGE }</span>
			<p style="margin-bottom:10px;">상세이미지</p>
			<input type="file" id="" name="lfile" value="" style="width: 90px;margin-bottom:20px;"><span>${vo.LOGO }</span>
		</div>

	</div>

	<div class="right_content">

		<div class="form_group">
			<p class="p_title">제목</p>
			<input type="text"  id="" name="TITLE" value="${vo.TITLE }" >
		</div>

		<div class="form_group">
			<p class="p_title">요약</p>
			<input type="text"  id="" name="SIMPLECONTENT" value="${vo.SIMPLECONTENT }" >
		</div>
		<div class="form_group">
			<p class="p_title">설명</p>
			<textarea cols="30" rows="10"  id="" name="CONTENT">${vo.CONTENT }</textarea>
		</div>

		<div class="form_group">
			<span class="p_title">인원</span><input type="number" id="" name="CNT" value="${vo.CNT }" />
		</div>
		<div class="form_group">
			<span class="p_title">일자</span><input style="float:right;" type="text" class="dateInput" id="" name="FDATE" value="${vo.FDATE }" />
		</div>

		<div class="form_group">
			<small>시작</small>
							 
							<c:set value="${fn:split(vo.FTIME,':') }" var="FTIME"/>
							<c:if test="${empty vo}">
							<select id="fhour" >
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select> 
							<select id="fmin" >
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
							</c:if>
							<c:if test="${not empty vo }" >
								<input type="text" id="fhour" readonly="readonly" value="${FTIME[0] }"> : 
								<input type="text" id="fmin" readonly="readonly" value="${FTIME[1] }">
							
							</c:if>
			</div>
			<div class="form_group">
							<small>종료</small>
							<c:set value="${fn:split(vo.STIME,':') }" var="STIME"/>
							<c:if test="${empty vo}">
							
							<select id="shour" >
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select>
							 <select id="smin" >
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
							</c:if>
							<c:if test="${not empty vo }" >
								<input type="text" id="shour" readonly="readonly" value="${STIME[0] }"> : 
								<input type="text" id="smin"  readonly="readonly" value="${STIME[1] }">
							
							</c:if>
		</div>

		<div class="form_group">
			<c:set value="${fn:split(vo.PRICE,',') }" var="PRICE"/>
			<input type="hidden" id="PRICE" name="PRICE"/> 
		
				<!--<label for="s">개인</label><input type="radio" id="s" name="INTRO" value="s" <c:if test="${vo.INTRO == 's'}">checked</c:if> />
				<label for="t">단체</label><input type="radio" id="t" name="INTRO" value="t" <c:if test="${vo.INTRO == 't'}">checked</c:if> />-->
			
		</div>

		<div class="form_group" style="margin-top:50px;">
			<c:if test="${not empty vo }" >
				<input type="button" id="ebtn" value="수정하기" style="width: 120px;height:30px;line-height:1;font-size:14px;">
				<input type="button" id="dbtn" value="삭제" style=""></div>
			</c:if>
			<c:if test="${empty vo }" >
				<input type="button" id="ibtn" value="등록하기" style="width: 120px;height:30px;line-height:1;font-size:14px;">
			</c:if>
		</div>

	</div>
	</form>
	
</div>