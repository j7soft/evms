<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	$(function() {
		$("#btn").click(function() {
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

				console.log($("#file").val())
				console.log($("#TITLE").val())
				console.log($("#FDAY").val())
				console.log($("#FTIME").val())
				console.log($("#STIME").val())
				console.log($("#PRICE").val())
				console.log($("#DETAIL").val())
				console.log($("#PTB").val())
			}
		});
	});
</script>
<link rel="stylesheet" href="/css/rent2.css">
<div id="main_wrap">
	<!--  Header 영역  -->

	<div class="left_content">

		<div class="img_box">
			<img src="" alt="">
		</div>

		<div class="form_group">
			<input type="file">
			<input type="file">
			<input type="file">
			<input type="file">
			<input type="file">
			<button>+</button>
		</div>

	</div>

	<div class="right_content">

		<div class="form_group">
			<p class="p_title">제목</p>
			<input type="text" name="">
		</div>

		<div class="form_group">
			<p class="p_title">요약</p>
			<input type="text" name="">
		</div>
		<div class="form_group">
			<p class="p_title">설명</p>
			<textarea name="" cols="30" rows="10"></textarea>
		</div>

		<p class="p_title">연령</p>
		<div class="form_group">
			<span class="p_title">일자</span><select name=""></select>
		</div>

		<div class="form_group">
			<span class="p_title">시간</span> <input type="number" step="1" min="0"
				max="20"> <input type="number" step="1" min="0" max="20">
			<span class="m_bar"> - </span> <input type="number" step="1" min="0"
				max="20"> <input type="number" step="1" min="0" max="20">
		</div>

		<div class="form_group">
			<span class="p_title"> 금액 </span> <span class="right"> <input
				type="checkbox" name=""> <label for="">무료</label>
			</span> <span class="right text">10,000</span>
		</div>

		<div class="form_group">
			<input type="submit" value="예약 신청하기">
		</div>

	</div>
</div>