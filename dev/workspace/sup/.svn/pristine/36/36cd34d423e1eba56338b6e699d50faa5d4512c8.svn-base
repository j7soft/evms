<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script type="text/javascript" >
	$(function(){
		$(".qbtn").click(function(){
			if(1!=1){
				
			}else if(!checkForm($("#t1"),"답변 내용을" )){
				return;
			}
			else{
				if(confirm("답변 이메일을 보내시겠습니다.?")){
					$("#frm").submit();	
				}else{
					return;
				}
			}
		});
		$(".dbtn").click(function(){
			if(1!=1){
				
			}else {
				if(confirm("정말로 삭제하시겠습니까?")){
					location.href="/admin/boardDelete.do?NTT_ID=${NTT_ID}&BBS_ID=${vo.BBS_ID}";			
				}else{
					return;
				}
			}			
		});
	});
</script>
<section>
	<div id="b_office_qna">
		<form id="frm" name="frm" action="/admin/qndUpdate.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="BBS_ID" value="${vo.BBS_ID }" />
			<input type="hidden" name="NTT_ID" value="${vo.NTT_ID }" />
			<div class="title_box">
				<h3>${type }</h3>
			</div>
			<div class="form_group">
				<span>제목</span> <span><input style="" type="text" name=""
					value="${vo.TITLE }" readonly></span>
			</div>
			<div class="form_group">
				<span>회원 이름</span> <span><input type="text" name=""
					value="${lvo.name }" readonly></span>
			</div>
			<div class="form_group">
				<span>연락처</span> <span><input type="text" name=""
					value="${lvo.tel }" readonly></span>
			</div>
			<div class="form_group">
				<span>이메일</span> <span><input type="text" name=""
					value="${lvo.email }" readonly></span>
			</div>
			<div class="form_group">
				<span>첨부파일</span> <span><input type="file" name=""
					readonly>${vo.FFILE }</span>
			</div>
			<div class="form_group">
				<span style="vertical-align: top;">내용</span>
				<textarea name="CONTENT" id="" cols="30" rows="10"
					style="width: 50%;" readonly>${vo.CONTENT }</textarea>
			</div>
			<div class="form_group">
				<span style="vertical-align: top;">답변</span>
				<textarea name="PTB" id="t1" cols="30" rows="10" style="width: 50%;">${vo.PTB }</textarea>
			</div>
			<input type="text" style="text-align: center;"  >
			<div class="form_group">
				<input type="button" class="qbtn" value="답변">
				<input type="button" class="dbtn" value="삭제">
			</div>
		</form>
	</div>
</section>