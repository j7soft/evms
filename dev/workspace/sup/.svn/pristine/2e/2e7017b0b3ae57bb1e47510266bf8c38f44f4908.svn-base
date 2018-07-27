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
<style>
	.content_h3bx, .content_h3bx_mypage{margin-bottom:0;}
	.mypage .content_h3bx{margin-bottom:0;}
	.mypage>div:first-of-type{width:100%;border-bottom:1px solid #eee;margin-bottom:65px;}
	.qnabx .qna_input4 .btn_file{cursor:pointer;}

	/*.mypage .content_h3bx h3:after{content:"";display:block;position:absolute;left:0;bottom:-20px;width:100%;height:4px;background:#63b746;}*/
</style>
<div id="qna_wrap">
<div class="content_h3bx">
                <h3>고객센터</h3>
                <ul class="route">
                    <li>홈</li>
                    <li>고객센터</li>
                </ul>
            </div>
	<!--  Main section 영역  -->
	<section id="section">
		<article class="mypage qna_faq">
		<div>
			<div class="content_h3bx qa">
				<h3 class="tab tab1">FAQ</h3>
				<h3 class="tab tab2">Q&amp;A</h3>
			</div></div>
			<div class="content_h3bx3">
				<div class="tab_box tab_box1">
					<h4 class="tab_faq tab_faq1">${ca1 }</h4>
					<h4 class="tab_faq tab_faq2">${ca2 }</h4>
					<h4 class="tab_faq tab_faq3">${ca3 }</h4>
					<h4 class="tab_faq tab_faq4">${ca4 }</h4>
					<div class="tab_faqbx tab_faqbx1">
						<ul>
							<c:forEach begin="0" end="${list.size() }" varStatus="i">
								<c:if test="${ca1 == list[i.index].FTYPE }">
									<li>
										<div class="q_area">
											<p class="qna_txt">Q</p>
											<p>${list[i.index].TITLE }</p>
										</div>
										<div class="a_area">
											<p class="qna_txt">A</p>
											<p>${list[i.index].CONTENT }</p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="tab_faqbx tab_faqbx2">
						<ul>
							<c:forEach begin="0" end="${list.size() }" varStatus="i">
								<c:if test="${ca2 == list[i.index].FTYPE }">
									<li>
										<div class="q_area">
											<p class="qna_txt">Q</p>
											<p>${list[i.index].TITLE }</p>
										</div>
										<div class="a_area">
											<p class="qna_txt">A</p>
											<p>${list[i.index].CONTENT }</p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="tab_faqbx tab_faqbx3">
						<ul>
							<c:forEach begin="0" end="${list.size() }" varStatus="i">
								<c:if test="${ca3 == list[i.index].FTYPE }">
									<li>
										<div class="q_area">
											<p class="qna_txt">Q</p>
											<p>${list[i.index].TITLE }</p>
										</div>
										<div class="a_area">
											<p class="qna_txt">A</p>
											<p>${list[i.index].CONTENT }</p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="tab_faqbx tab_faqbx4">
						<ul>
							<c:forEach begin="0" end="${list.size() }" varStatus="i">
								<c:if test="${ca4 == list[i.index].FTYPE }">
									<li>
										<div class="q_area">
											<p class="qna_txt">Q</p>
											<p>${list[i.index].TITLE }</p>
										</div>
										<div class="a_area">
											<p class="qna_txt">A</p>
											<p>${list[i.index].CONTENT }</p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					


					
				</div>
				<form id="frm" name="frm">
					<div class="tab_box tab_box2">
						<div class="qnabx">
							<div class="qna_input1 clear">
								<p>제목</p>
								<input type="text" name="TITLE" >
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
								<textarea name="CONTENT" cols="30" rows="10"></textarea>
							</div>
							<!--<div class="qna_input4 clear">
								<p>첨부파일</p>
								<input type="text" class="fileName" readonly="readonly">
								<label for="uploadBtn" class="btn_file">파일 찾기</label> <input
									type="file" id="uploadBtn" name="file" class="uploadBtn">
							</div>-->
							<div align="center">
								<button type="button" id="qnabtn">등록하기</button>
							</div>
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
<script>
	$(".tab2").click(function() {
			var loginId = '${loginVO.id}'
			if (loginId == "") {
				location.href='/loginUsr.do';
			} 
			
		});
</script>
<style>
	.qna_faq .tab_box1 .tab_faqbx ul{padding:0;}
	.qna_faq .tab_box1 .tab_faqbx ul li{height:auto;padding:0;}
	#qnabtn{margin-top:35px;}
	.a_area{height:auto;overflow:hidden;}
</style>
<script src="/js/jquery-1.12.4.min.js"></script>
    <script src="/js/jquery.bxslider.min.js"></script>
  