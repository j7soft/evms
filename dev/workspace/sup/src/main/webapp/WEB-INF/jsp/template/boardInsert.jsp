<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<link rel="stylesheet" href="/css/SUP_Community.css">

<script type="text/javascript">
	$(function() {
		$("#freeboardbtn").click(function() {
			if (1 != 1) {

			} else if (!checkForm($("#t1"), "제목을")) {
				return;
			} else if (!checkForm($("#t2"), "내용을")) {
				return;
			} else {
				$("#frm").attr({
					"method" : "post",
					"action" : "/infoInsert.do"
				});
				$("#frm").submit();
			}

		});
	});
	
	
	
</script>


<section class="freeboard">
	<form id="frm" name="frm" enctype="multipart/form-data">
		<div id="b_office_notice">
			<div class="title_box">
				<h3>
					<!-- 공지사항,보도자료,교육자료  -->
				</h3>
			</div>
			<input type="hidden" id="" name="MBER_ID" value="${lvo.id }" /> <input
				type="hidden" id="" name="NTT_ID" value="${NTT_ID }" />
			<div>
				<h4>
					<input type="text" autocomplete="off" placeholder="제목을 입력해주세요." name="TITLE" id="t1" style="width:100%;text-align:center;font-weight:bold;">
				</h4>
			</div>
			<div class="form_group">
				<label for="f1">첨부파일</label> <input type="file" name="file" id="f1">
			</div>
			<div>
				<textarea name="CONTENT" id="t2" cols="30" rows="10"
					placeholder="내용을 입력하세요."></textarea>

			</div>
			<div class="form_group">
				<label for="g1">동영상 링크</label> <input type="text" name="VIDEO"
					id="g1" style="float:none;width:250px;height:21px;border:1px solid #ccc;">
			</div>

			<div class="form_group">
				<input type="button" id="freeboardbtn" value="등록하기">
			</div>
		</div>
	</form>
</section>
    <script src="/js/jquery.bxslider.min.js"></script>
	
	<script src="/js/index.js"></script>