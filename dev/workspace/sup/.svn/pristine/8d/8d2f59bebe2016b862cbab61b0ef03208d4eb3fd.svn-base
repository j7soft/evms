<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script type="text/javascript">
	$(function() {
		$("#btn_store").click(function() {
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
				$("#NTT_NO").val('${NTT_ID}');
				$("#NTT_ID").val('${NTT_ID}');
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
				
				if($(this).id=='ebtn'){
					alert("?");
				}else{
					fnInsert();				
				}
			}
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
<!--  Main section 영역  -->
<section id="section">
	<article class="contents">
	<form id="frm" name="supContentVO" method="post" commandName="supContentVO" enctype="multipart/form-data">
		<div class="img_area">
			<div>
				<c:set value="${fn:split(vo.ITEM_IMAGE,';') }" var="image" />
				<input type="file" name="file1" id="IMAGE1" class="upload" ><span>등록된파일 : ${image[0] }</span>
				<input type="file" name="file2" id="IMAGE2" class="upload" ><span>등록된파일 : ${image[1] }</span>
				<input type="file" name="file3" id="IMAGE3" class="upload" ><span>등록된파일 : ${image[2] }</span>
				<input type="file" name="file4" id="IMAGE4" class="upload" ><span>등록된파일 : ${image[3] }</span>
				<input type="file" name="file5" id="IMAGE5" class="upload" ><span>등록된파일 : ${image[4] }</span>
			</div>
		</div>

		
			<div class="input_area">
				<input type="hidden" id="NTT_ID" name="NTT_ID" value="${vo.NTT_ID }" /> 
				<input type="hidden" id="BBS_ID" name="BBS_ID" value="${vo.BBS_ID }" />
				<ul class="clear">
					<li>
						<h4>대관명</h4> <input type="text" name="TITLE" id="TITLE" value="${vo.TITLE }" />
					</li>
					<li>
						<h4>운영시간</h4>
						<c:if test="${empty vo }" >
						<div>
							<input type="hidden" id="FDAY" name="FDAY" value="요일" /> 
							<input type="checkbox" class="day" id="day" name="day" value="월">월
							<input type="checkbox" class="day" id="day" name="day" value="화">화
							<input type="checkbox" class="day" id="day" name="day" value="수">수
							<input type="checkbox" class="day" id="day" name="day" value="목">목
							<input type="checkbox" class="day" id="day" name="day" value="금">금
							<input type="checkbox" class="day" id="day" name="day" value="토">토
							<input type="checkbox" class="day" id="day" name="day" value="일">일
						</div>
						<div>
							<input type="hidden" id="FTIME" name="FTIME" value="00:00" /> 
								<select id="fhour">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select> <select id="fmin">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
						</div>
						
						
						<div>
							<input type="hidden" id="STIME" name="STIME" value="00:00" />
								<select id="shour">
								<c:forEach begin="9" end="19" varStatus="i">
									<option class="hourbtn" value="<c:if test="${i.index<10 }">0${i.index }</c:if><c:if test="${i.index>=10 }">${i.index }</c:if>">${i.index }</option>
								</c:forEach>
							</select>
							 <select id="smin">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
						</div>
						</c:if>
						<c:if test="${ not empty vo }" >
						<div>
							<input type="text" id="" name="" value="${vo.FDAY }" /> 
						</div>
						<div>
							<input type="text" id="" name="" value="${vo.FTIME }" /> 
						</div>
						<div>	
							<input type="text" id="" name="" value="${vo.STIME }" /> 
						</div>
				
						
						</c:if>
					</li>
					<li>
						<h4>사용가능인원</h4> 
						<div><input width="50" type="number" id="CNT" name="CNT" min="1" max="50" value="${vo.CNT }"></div>
					</li>
					<li>
						<c:set value="${fn:split(vo.PRICE,',') }" var="pri" />
						<h4>이용료</h4> 
						<input type="hidden" id="PRICE" name="PRICE" value="0" />
						<div>성인 <input type="number" id="big" value="${pri[0] }"></div>
						<div>아동 <input type="number" id="small" value="${pri[1] }" ></div>
					</li>
					<li>
						<h4>상세설명</h4> <textarea name="CONTENT" id="DETAIL" cols="30" rows="10">${vo.CONTENT }</textarea>
					</li>
					<li>
						<h4>담당자</h4> <textarea name="PTB" id="PTB" cols="30" rows="10">${vo.PTB }</textarea>
					</li>
				</ul>
				
				<div class="btn_area">
					<c:if test="${empty vo}">
						<button type="button" id="btn_store">등록</button>
					</c:if>
					<c:if test="${not empty vo }" >
						<input type="button" id="ebtn" value="수정하기">
					</c:if>
				</div>
	
			</div>
		</form>

	</article>
</section>
<!--  //Main section 영역  -->