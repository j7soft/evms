<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script type="text/javascript">
	$(function() {
		$("#ibtn").click(function() {
			if (1 != 1) {
			
			} else {
				
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
				$("#PRICE").val($("#big").val()+","+$("#small").val());
				$("#NTT_ID").val('${NTT_ID}');
			  
				fnInsert();
			}
		});
		
		
		$("#ebtn").click(function() {
			if (1 != 1) {
			
			} else {
				/* var chk = "";
				var chkbox = document.getElementsByName("day");
				for(var i = 0 ; i<chkbox.length;i++){
					if (chkbox[i].checked) {
						//chk = chk +"," +chkbox[i].value;
						chk = (chk.trim() =='') ? chkbox[i].value : chk +"," +chkbox[i].value;
					}	
				} */

			/* 	$("#FDAY").val(chk);
				if($("#fhour").val()<10){
					$("#fhour").val("0"+$("#fhour"));
				}
				if($("#shour").val()<10){
					$("#shour").val("0"+$("#shour"));
				} */
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
				$("#PRICE").val($("#big").val()+","+$("#small").val());
				$("#NTT_NO").val('${NTT_NO}');
				$("#NTT_ID").val('${NTT_ID}');
		
				fnUpdate();	
			}
		});
		
		
	});
	function fnInsert(){
		if(confirm("<spring:message code="common.regist.msg" />")){
			document.supContentVO.action = "<c:url value='/admin/registData.do'/>";
			
		    document.supContentVO.submit();
		}
	}
	function fnUpdate(){
		if(confirm("<spring:message code="common.update.msg" />")){
			document.supContentVO.action = "<c:url value='/admin/updateData.do'/>";
			
		    document.supContentVO.submit();
		}
	}
</script>

<article class="backoffice2">
	<form id="supContentVO" name="supContentVO" method="post" enctype="multipart/form-data">
	<input type="hidden" name="NTT_ID" value="${vo.NTT_ID }" />
	<input type="hidden" name="BBS_ID" value="${vo.BBS_ID }" />
	<input type="hidden" name="NTT_NO" value="${vo.NTT_ID }" />
	<input type="hidden" name="" value="" />
	<div class="topBox clear">
		<div class="title_box">
			<h3>교육 등록</h3>
		</div>
		<div class="box01">
			<ul>
				<li><span>제목</span> <input type="text" id="" name="TITLE" value="${vo.TITLE }"></li>
				<li><span>요약설명</span> <input type="text"  id="" name="SIMPLECONTENT" value="${vo.SIMPLECONTENT }"></li>
				<li><span>일자</span> 
					<input type="date"  id="" name="FDATE" value="${vo.FDATE }">
				</li>
				<li><span>시간</span> 
							<small>시작</small>
							<input type="hidden" id="FTIME" name="FTIME" value="00:00" /> 
							<c:set value="${fn:split(FTIME,':') }" var="FTIME"/>
							<select id="fhour" value="${FTIME[0] }">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select> 
							<select id="fmin" value="${FTIME[1] }">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
							<small>종료</small>
							<c:set value="${fn:split(STIME,':') }" var="STIME"/>
							<input type="hidden" id="STIME" name="STIME" value="00:00" />
							<select id="shour" value="${STIME[0] }">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select>
							 <select id="smin" value="${STIME[1] }">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
						
				<li><span>인원</span>
					<input type="text" id="" name="CNT" value="${vo.CNT }" />
				</li>
				
				<li><span>이용료</span> 
					<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
					<input type="hidden" id="PRICE" name="PRICE" value="0" />
					성인 <input type="number" id="big" value="${pri[0] }">
					아동 <input type="number" id="small" value="${pri[1] }" >
				</li>
				<li><span>장소</span>
				<input type="text" id="" name="POSITION" value="${vo.POSITION }" />
				</li>
			</ul>
		</div>
		<div class="box02">
			<p>이미지 업로드</p>
			<input type="file" name="mfile" id="mfile" class="upload" value="${vo.IMAGE }">
			<c:if test="${not empty vo.IMAGE}" >
				<div>
					<span>등록된파일 : ${vo.IMAGE }</span>
					<img src="/uploadStorage/file/${vo.IMAGE }" width="200" height="200"/>
				</div>
			</c:if>
			<p>설명</p>
			<textarea rows="" cols="" id="" name="CONTENT">${vo.CONTENT }</textarea>
			<p>파일 업로드</p>
			<input type="file" name="file" class="file">
		</div>
		<div class="btn_area">
					<c:if test="${empty vo}">
						<button type="button" id="ibtn">등록</button>
					</c:if>
					<c:if test="${not empty vo }" >
						<input type="button" id="ebtn" value="수정하기">
						<input type="button" id="" value="삭제">
					</c:if>
				</div>
	</div>
	</form>
</article>
</section>