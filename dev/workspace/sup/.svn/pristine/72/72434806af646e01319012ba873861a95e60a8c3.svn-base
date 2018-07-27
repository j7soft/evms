<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<c:set var="ca1" value="카테고리1" />
<c:set var="ca2" value="카테고리2" />
<c:set var="ca3" value="카테고리3" />
<c:set var="ca4" value="카테고리4" />

<script type="text/javascript" >
	$(function(){
		$(".faqbtn").click(function(){
			if(1!=1){
				
			}else{
				$(this).parents("#frm").attr({
					"method":"post",
					"action":"/admin/boardInsert.do"
				});
				$(this).parents("#frm").submit();
			}
			
			
		});
		
		
	});

</script>
<section>

	<div id="b_office_faq">

		<div class="title_box">
			<h3>${type }</h3>
		</div>

		<article class="mypage qna_faq">
			<div class="content_h3bx2">
				<div class="tab_box tab_box1">
					<h4 class="tab_faq tab_faq1">${ca1 }</h4>
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
										<div class="delete">
											<a href="/admin/boardDelete.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }" >삭제</a>
										</div>
									</li>
									 
								</c:if>
							</c:forEach>
							<li>
								<form id="frm" name="frm">
									<input type="hidden" name="FTYPE" value=${ca1 } />
									<input type="hidden" name="NTT_ID" value=${NTT_ID } />
									<input type="hidden" name="MBER_ID" value=${lvo.id } />
				                    <div class="q_area">
				                        <p class="qna_txt">Q</p>
				                        <p><input type="text" name="TITLE"> <input type="button" class="faqbtn" value="등록"></p>
				                    </div>
				                    <div class="a_area clear">
					                    <p class="qna_txt">A</p>
					                    <p><textarea name="CONTENT" cols="30" rows="10"></textarea></p>
				                    </div>
								</form>
			               </li>
						</ul>
					</div>
					<h4 class="tab_faq tab_faq2">${ca2 }</h4>
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
										<div class="delete">
											<a href="/admin/boardDelete.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }" >삭제</a>
											</div>
									</li>
								</c:if>
							</c:forEach>
							<li>
								<form id="frm" name="frm">
									<input type="hidden" name="FTYPE" value=${ca2 } />
									<input type="hidden" name="NTT_ID" value=${NTT_ID } />
									<input type="hidden" name="MBER_ID" value=${lvo.id } />
				                    <div class="q_area">
				                        <p class="qna_txt">Q</p>
				                        <p><input type="text" name="TITLE"> <input type="button" class="faqbtn" value="등록"></p>
				                    </div>
				                    <div class="a_area clear">
					                    <p class="qna_txt">A</p>
					                    <p><textarea name="CONTENT" cols="30" rows="10"></textarea></p>
				                    </div>
								</form>
			               </li>
						</ul>
					</div>
					<h4 class="tab_faq tab_faq3">${ca3 }</h4>
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
										<div class="delete">
											<a href="/admin/boardDelete.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }" >삭제</a>
										</div>
									</li>
								</c:if>
							</c:forEach>
							<li>
								<form id="frm" name="frm">
									<input type="hidden" name="FTYPE" value=${ca3 } />
									<input type="hidden" name="NTT_ID" value=${NTT_ID } />
									<input type="hidden" name="MBER_ID" value=${lvo.id } />
				                    <div class="q_area">
				                        <p class="qna_txt">Q</p>
				                        <p><input type="text" name="TITLE"> <input type="button" class="faqbtn" value="등록"></p>
				                    </div>
				                    <div class="a_area clear">
					                    <p class="qna_txt">A</p>
					                    <p><textarea name="CONTENT" cols="30" rows="10"></textarea></p>
				                    </div>
								</form>
			               </li>
						</ul>
					</div>
					<h4 class="tab_faq tab_faq4">${ca4 }</h4>
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
										<div class="delete">
											<a href="/admin/boardDelete.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }" >삭제</a>
										</div>
									</li>
								</c:if>
							</c:forEach>
							<li>
								<form id="frm" name="frm">
									<input type="hidden" name="FTYPE" value=${ca4 } />
									<input type="hidden" name="NTT_ID" value=${NTT_ID } />
									<input type="hidden" name="MBER_ID" value=${lvo.id } />
				                    <div class="q_area">
				                        <p class="qna_txt">Q</p>
				                        <p><input type="text" name="TITLE"> <input type="button" class="faqbtn" value="등록"></p>
				                    </div>
				                    <div class="a_area clear">
					                    <p class="qna_txt">A</p>
					                    <p><textarea name="CONTENT" cols="30" rows="10"></textarea></p>
				                    </div>
								</form>
			               </li>
						</ul>
					</div>
					
					
					
					
					
				</div>
			</div>
		</article>
	</div>

</section>

<script src="../js/jquery-1.12.4.min.js"></script>

<script>
	$(function() {

		$('.tab_faq').click(function() {

			$('.tab_faqbx').hide();
			$(this).next('.tab_faqbx').show().siblings().removeClass('tab_on');
			$(this).addClass('tab_on');

		});

	});
</script>

<style>
.qna_faq .tab_box1 .tab_faqbx ul li, .a_area{height:auto;overflow:hidden;}
.a_area p{width:80%;white-space:pre-line;}
.tab_faqbx{padding-top:30px;}
.tab_faqbx .delete{top:25px;}
.q_area p .faqbtn{top:0;}
</style>
