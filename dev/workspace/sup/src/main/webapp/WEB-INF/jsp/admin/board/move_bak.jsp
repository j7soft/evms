<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<script type="text/javascript" >
	$(function(){
		$("#ibtn").click(function(){
			if(1!=1){
				
			}else{
				
				$("#frm").attr({
					"method":"post",
					"action":"/admin/boardInsert.do",
					"enctype":"multipart/form-data"
				});
				$("#frm").submit();
				
			}
			
		})
		$("#plus").click(function(){
			
		});
		
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
				if($("#fhour").val()<10){
					$("#fhour").val("0"+$("#fhour"));
				}
				if($("#shour").val()<10){
					$("#shour").val("0"+$("#shour"));
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
		
		function fnUpdate(){
			if(confirm("<spring:message code="common.update.msg" />")){
				document.frm.action = "<c:url value='/admin/updateData.do'/>";
				
			    document.frm.submit();
			}
		}
		
		
		
		
	});


</script>

	<link rel="stylesheet" href="/css/SUP_Backoffice.css">
	
	<section class="width625">
	<form id="frm" name="frm">
		<div id="b_office_business">
			<input type="hidden" name="NTT_ID" value="${NTT_ID }" />
			<input type="hidden" name="MBER_ID" value="${lvo.id }" />
			<input type="hidden" name="BBS_ID" value="${vo.BBS_ID }" />
			<input type="hidden" name="" value="" />
			<div class="title_box">
				<h3>입주 업체 관리</h3>
			</div>
			
			<div class="form_group">
				<span>업체명</span>
				<span><input type="text" name="TEAMNAME" value="${vo.TEAMNAME }" ></span>
			</div>
			<div class="form_group">
				<span>대표</span>
				<span><input type="text" name="PTB" value="${vo.PTB }" ></span>
			</div>
			<div class="form_group">
				<span>분야</span>
				<span><input type="text" name="FTYPE" value="${vo.FTYPE }" ></span>
			</div>
			<div class="form_group">
				<span>설립년도</span>
				<span><input type="text" name="MAKEYEAR" value="${vo.MAKEYEAR }" ></span>
			</div>
			<div class="form_group">
				<span>사업자등록번호</span>
				<span><input type="text" name="CRNUM" value="${vo.CRNUM }" ></span>
			</div>
			<div class="form_group">
				<span>호수</span>
				<span><input type="text" name="ROOM" value="${vo.ROOM }" ></span>
			</div>
			<div class="form_group">
				<span>입주일</span>
				<span><input type="date" name="MOVEDATE" value="${vo.MOVEDATE }" ></span>
			</div>
			<div class="form_group">
				<span>입주기간</span>
				<span><input type="date" name="MOVEPLAN" value="${vo.MOVEPLAN }" ></span>
			</div>
			<div class="form_group">
				<span>품목</span>
				<span><input type="text" name="ITEM_OBJECT" value="${vo.ITEM_OBJECT }" ></span>
			</div>
			<div class="form_group">
				<span>소재</span>
				<span><input type="text" name="ITEM_SUBJECT" value="${vo.ITEM_SUBJECT }" ></span>
			</div>
			<div class="form_group">
				<span>담당자 연락처</span>
				<span><input type="text" name="CHARGE_TEL" value="${vo.CHARGE_TEL }" ></span>
			</div>
			<div class="form_group">
				<span>사무실 연락처</span>
				<span><input type="text" name="OFFICE_TEL" value="${vo.OFFICE_TEL }" ></span>
			</div>
			<div class="form_group">
				<span>이메일</span>
				<span><input type="text" name="EMAIL" value="${vo.EMAIL }" ></span>
			</div>
			<div class="form_group">
				<span>홈페이지</span>
				<span><input type="text" name="HOMEPAGE" value="${vo.HOMEPAGE }" ></span>
			</div>
			<div class="form_group">
				<span>주소</span>
				<span><input type="text" name="ADDRESS" value="${vo.ADDRESS }" ></span>
			</div>
			<div class="form_group">
				<span>업체소개</span>
				<textarea name="INTRO" id="INTRO" cols="30" rows="10" style="width: 100%;" >${vo.INTRO }</textarea>
			</div>

			<div class="form_group">
				<span>동영상 링크</span>
				<span><input type="text" id = "VIDEO" name="VIDEO" value="${vo.VIDEO }"></span>
			</div>
			<div class="form_group">
				<span>메인 이미지 업로드</span>
				<span><input type="file" id ="IMAGE"  name="IMAGE" >${vo.IMAGE }</span>
			</div>
			<div class="form_group">
				<span>로고</span>
				<span><input type="file" id = "LOGO" name="LOGO" >${vo.LOGO }</span>
			</div>

			<!-- <div class="form_group">
				<span style="vertical-align: top;">이미지 업로드</span><br/>
				<span><br/>
					<input type="file" name="file1" >
					<input type="file" name="file2" >
					<input type="file" name="file3" >
					<input type="file" name="file4" >
					<input type="file" name="file5" >
					<input type="file" name="file6" >
					<input type="file" name="file7" >
					<input type="file" name="file8" >
					<input type="file" name="file9" >
					<input type="file" name="file10" >
					<input type="file" name="file11" >
					<input type="file" name="file12" >
				</span>
			</div> -->

			<div class="form_group">
			<c:if test="${not empty vo }" >
				<input type="button" id="ebtn" value="수정하기">
			</c:if>
			<c:if test="${empty vo }" >
				<input type="button" id="ibtn" value="등록하기">
			</c:if>
		</div>
		</div>
	</form>
	</section>