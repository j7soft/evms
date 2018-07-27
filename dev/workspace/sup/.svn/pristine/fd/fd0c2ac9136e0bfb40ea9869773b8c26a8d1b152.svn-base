<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Login.css">
<c:set var="ca1" value="카테고리1" />
<c:set var="ca2" value="카테고리2" />
<c:set var="ca3" value="카테고리3" />
<c:set var="ca4" value="카테고리4" />


<style type="text/css">
#section {
	overflow: -webkit-paged-y;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#qnabtn").click(function() {
			if (1 != 1) {

			} else {
				$(this).parents("#frm").attr({
					"method" : "post",
					"action" : "/boardinsert.do",
					"enctype": "multipart/form-data"
				});
				$(this).parents("#frm").submit();
			}

		});

	});
</script>

<div id="qna_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="mypage qna_faq">
		<div class="content_h3bx qa">
				<h3 class="tab tab1">나의질문</h3>
			</div>
		<div class="content_h3bx3">
				<form id="frm" name="frm">
					<div class="tab_box tab_box1">
						<div class="qnabx">
							<div class="qna_input1 clear">
								<p>제목</p>
								<!--<input type="text" name="TITLE" readonly>-->${vo.TITLE }
							</div>
							<input type="hidden" name="MBER_ID" value="${lvo.id }" />
							<input type="hidden" name="NTT_ID" value="qna" />

							<ul class="qna_input2 clear">
								<li>
									<p>성명</p> ${lvo.name }
								</li>
								<li>
									<p>연락처</p> ${lvo.tel }
								</li>
								<li>
									<p>이메일</p> ${lvo.email }
								</li>
							</ul>
							<div class="qna_input3 clear">
								<p>내용</p>
								<textarea name="CONTENT" cols="30" rows="10" readonly>${vo.CONTENT }</textarea>
							</div>
							<div class="qna_input3 clear">
								<p>답변내용</p>
								<textarea name="PTB" cols="30" rows="10" readonly>${vo.PTB }</textarea>
							</div>
							<!--<div class="qna_input4 clear">
								<p>첨부파일</p>
								<input type="text" class="fileName" readonly="readonly">
								 <label for="uploadBtn" class="btn_file">파일 찾기</label> <input
									type="file" id="uploadBtn" name="file" class="uploadBtn"> 
							</div>
							 <div align="center"> 
								<button type="button" id="qnabtn">등록하기</button>
							</div> -->
						</div>
					</div>
				</form>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>
<script>
	$(document).ready(
			function() {
				var cnt = 7;
				$('.tab_box1').show();
				$('.tab1').addClass('tabOn');

				$('.tab').each(function(index) {
					$(this).click(function() {
						$(".tab_box").hide();
						$(".tab_box:eq(" + index + ")").show();

						for (var i = 0; i <= cnt; i++) {
							$('.tab' + i).removeClass('tabOn');
						}
						$(this).addClass('tabOn');
					});
				});

				var cnt = 7;
				$('.tab_faqbx1').show();
				$('.tab_faq1').addClass('tab_on');

				$('.tab_faq').each(function(index) {
					$(this).click(function() {
						$(".tab_faqbx").hide();
						$(".tab_faqbx:eq(" + index + ")").show();

						for (var i = 0; i <= cnt; i++) {
							$('.tab_faq' + i).removeClass('tab_on');
						}
						$(this).addClass('tab_on');
					});
				});

				var uploadFile = $('.qna_input4 .uploadBtn');
				uploadFile.on('change', function() {
					if (window.FileReader) {
						var filename = $(this)[0].files[0].name;
					} else {
						var filename = $(this).val().split('/').pop().split(
								'\\').pop();
					}
					$(this).siblings('.fileName').val(filename);
				});
			});
</script>

<script src="/js/jquery-1.12.4.min.js"></script>
    <script src="/js/jquery.bxslider.min.js"></script>
    <script src="/js/common.js"></script>
