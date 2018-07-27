<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Login.css">
<style type="text/css">
#section {
	overflow: -webkit-paged-y;
}

</style>
<style>
        #mypage_wrap .mypage .content_h3bx2 .tab_box1 ul li p{line-height:65px;}
        .mypage .content_h3bx2 .tab_box1 ul li input{padding:15px 0;border:1px solid #eee;margin:5px 0;padding-left:15px;}
        
		#lfrm button{position:relative;margin:35px auto;left:50%;margin-left:-25%;}
    	#lfrm button{left:25%;}
		#lfrm button:last-of-type{left:54%;}
		.mypage .content_h3bx2 .tab_box1{display:none;}
		.review_form{display:none;}
    .mypage .content_h3bx2 .tab_box1 ul li input#name{width:76%;}
    
    
		@media all and (max-width:768px){
		#lfrm button, #lfrm button:last-of-type{position:relative;margin-left:0;margin:0px auto;margin-top:30px;left:50%;transform:translateX(-50%);}
		#lfrm button:last-of-type{margin-top:10px;}
		}
		</style>
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var cnt = 7;
			$('.tab_box2').show();
			$('.tab2').addClass('tabOn');

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
		});
		
		$('.tab3').click(function(){
			$('.tab_box2.review_form').hide();
			$('.tab_box3').show();
		});
		$('.mypage .content_h3bx h3').click(function(){
			$(this).addClass('tabOn').siblings().removeClass('tabOn');
		});
		
		$('.reviewbtn').click(function(){
			var FDATE = $(this).attr("data-FDATE");
			var FTYPE = $(this).attr("data-FTYPE");
			var BBS_ID = $(this).attr("data-BBS_ID");
			var TITLE = $(this).attr("data-TITLE");
			$("#rFDATE").val(FDATE);
			$("#rFTYPE").val(FTYPE);
			$("#TITLE").val(TITLE);
			$(".TITLE").html(TITLE);
			
			$('.tab_box').hide();
			$('.review_form').show();
			
		});
		
		
		$("#rebtn").click(function(){
			$("#refrm").submit();
		});
		
		
		$("#infoOkBtn").attr("hidden", true);

		$("#infoChangeBtn").click(function() {
			var ck = "";
			$("#infoChangeBtn").attr("hidden", true);
			$("#infoOkBtn").attr("hidden", false);
			$(".re").attr("readonly", false);
			$(".rpa").focus(function() {
				$(this).val("");
			});
		});
		$("#infoOkBtn").click(function() {
			if (1 != 1) {

			}else if(!checkForm($("#t1"),"비밀번호를" )){
				return;
			}else if(!checkForm($("#t2"),"비밀번호 확인란을" )){
				return;
			}else if(!checkForm($("#t3"),"전화번호를" )){
				return;
			}else if(!checkForm($("#t4"),"이메일을" )){
				return;
			}else if($("#t1").val()!=$("#t2").val()){
				alert("비밀번호, 비밀번호 확인란의 비밀번호가 같지 않습니다.");
				return;
			} else {
				$("#infoChangeBtn").attr("hidden", false);
				$("#infoOkBtn").attr("hidden", true);
				$("#lfrm").attr({
					"method" : "post",
					"action" : "/loginUpdate.do"
				});
				$("#lfrm").submit();

			}

		});
		//회원탈퇴 클릭
		$('#infoSignoutBtn').click(function(){
			/*
			$("#infoChangeBtn").attr("hidden", false);
			$("#infoOkBtn").attr("hidden", true)
			;*/
			
			
			$("#lfrm").attr({
				"method" : "post",
				"action" : "/signout.do"
			});
			alert("회원 탈퇴 완료되었습니다.");
			$("#lfrm").submit();
		});

	});
</script>
<div id="mypage_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="mypage">
			<div class="content_h3bx my">
				<h3 class="tab tab2 tabOn">예약</h3>
				<h3 class="tab tab1">정보</h3>
				<h3 class="tab tab3">문의</h3>
			</div>
			<div class="content_h3bx2">
				<div class="tab_box tab_box2">
					<div class="mypage_table">
						<c:choose>
							<c:when test="${list.size()!=0 }">
								<table summary="예약내역">
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="45%">
										<col width="13%">
										<col width="10%">
										<col width="12%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">구분</th>
											<th scope="col">제목</th>
											<th scope="col">날짜</th>
											<th scope="col">시간</th>
											<th scope="col">상태</th>
											<!-- <th scope="col">후기</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach begin="0" end="${list.size() }" varStatus="i">
											<c:set value="${list[i.index].NTT_ID }" var="ntt" />
											<c:if test="${not empty list[i.index] and fn:indexOf(ntt,'reserv') != -1  }">
												<tr>
													<td>${list.size() - i.index  }</td>
													<td>
														<c:choose>
															<c:when test="${fn:indexOf(list[i.index].NTT_ID,'rent') != -1 }">대관예약</c:when>
															<c:when test="${fn:indexOf(list[i.index].NTT_ID,'bus') != -1 }">셔틀버스 예약</c:when>
															<c:when test="${fn:indexOf(list[i.index].NTT_ID,'edu') != -1 }">교육예약</c:when>
															<c:when test="${fn:indexOf(list[i.index].NTT_ID,'trip') != -1 }">현장학습 예약</c:when>										
														</c:choose>	
													</td>
													<td class="txt_align_left"><a
														href="/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID}">${list[i.index].TITLE }</a></td>
													<td>${list[i.index].FDATE }</td>
                                                    <td>${list[i.index].FTIME }</td>
													<td>
														<c:if test="${list[i.index].ONOFF=='' || empty list[i.index].ONOFF }" >
															<span>대기</span>
														</c:if>
														<c:if test="${list[i.index].ONOFF!='' || not empty list[i.index].ONOFF }" >
															<span class="color_ed1c24">${list[i.index].ONOFF }</span>
														</c:if>
														
													</td>
													<!-- <td>
													<fmt:parseDate value="${sysdate }" var="strPlanDate" pattern="yyyy-MM-dd"/>
													<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
													<fmt:parseDate value="${list[i.index].FDATE }" var="endPlanDate" pattern="yyyy-MM-dd"/>
													<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
												
													 	<c:if test="${strDate-endDate>=0}" >
															<button  class="reviewbtn" data-TITLE="${list[i.index].TITLE }" data-FTYPE="${list[i.index].NTT_ID }" data-BBS_ID="${list[i.index].BBS_ID }" data-FDATE="${list[i.index].FDATE }">작성하기</button>
														</c:if>
														<c:if test="${strDate-endDate<0}" >
															<button style="background-color:black;color:white;"  class="notbtn" type="button" onclick="alert('${strDate-endDate }일  후 작성가능합니다.')">${strDate-endDate }일  후 <br>작성가능</button>
														</c:if> 
													</td> -->
												</tr>


											</c:if>
										</c:forEach>

									</tbody>
								</table>
								<!--<div class="page_numbx">
									<ul class="page_num">
										<li><i class="fa fa-angle-double-left" aria-hidden="true"></i></li>
										<li>1</li>
										<li>2</li>
										<li>3</li>
										<li>4</li>
										<li>5</li>
										<li>&middot;&middot;&middot;</li>
										<li><i class="fa fa-angle-double-right"
											aria-hidden="true"></i></li>
									</ul>
								</div>-->
								<!-- //page_button -->
							</c:when>

							<c:otherwise>
							등록된 예약정보가 없습니다.
							</c:otherwise>
						</c:choose>

					</div>
				</div>
				<div class="tab_box tab_box1">
					<form id="lfrm" name="lfrm">
						<ul>
							<li class="clear"><p>아이디</p> <input type="text" id="id"
								name="id" value="${lvo.id }" readonly="no"></li>
							<li class="clear"><p>성명</p><input type="text"
								name="name" value="${lvo.name }" readonly="readonly"></li>
							<li class="clear"><p>비밀번호</p> <input type="password" id="t1"
								class="re rpa" name="password" value="${lvo.password }"
								readonly="readonly"></li>
							<li class="clear"><p>비밀번호 확인</p> <input type="password"
								id="t2" class="re rpa" name="" value="${lvo.password }"
								readonly="readonly"></li>
							<li class="clear"><p>전화번호</p> <input type="text" id="t3"
								class="re" name="tel" value="${lvo.tel }" readonly="readonly"></li>
							<li class="clear"><p>이메일</p> <input type="text" id="t4"
								class="re" name="email" value="${lvo.email }"
								readonly="readonly"></li>
						</ul>
						<button id="infoChangeBtn" type="button">변경</button>
						<button id="infoOkBtn" type="button">완료</button>
						<!-- 4.25 KJS 추가 ,CSS처리 해야함-->
						<button id="infoSignoutBtn" type="button">회원탈퇴</button>
					</form>
				</div>
				<div class="tab_box tab_box3">
					<div class="mypage_table">
						<c:choose>
							<c:when test="${list.size()!=0 }">

								<table summary="문의">
									<colgroup>
										<col width="10%">
										<col width="70%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">날짜</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin="0" end="${list.size() }" varStatus="i">
											<c:set value="${list[i.index].NTT_ID }" var="ntt" />
											<c:if test="${not empty list[i.index] and fn:indexOf(ntt,'qna') != -1  }">

												<tr>
													<th scope="col">${list.size() - i.index  }</th>
													<th scope="col"><a href="detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID}">${list[i.index].TITLE } </a></th>
													<th scope="col">${list[i.index].PUSHDATE }</th>
													<!-- <th scope="col">${list[i.index].ONOFF }</th> -->
													<th>
														<c:choose>
														    <c:when test="${not empty list[i.index].PTB }">
														        답변완료
														    </c:when>
														    <c:otherwise>
														    	답변대기
														    </c:otherwise>
														</c:choose>
													</th>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							<!-- 	<div class="page_numbx">
									<ul class="page_num">
										<li><i class="fa fa-angle-double-left" aria-hidden="true"></i></li>
										<li>1</li>
										<li>2</li>
										<li>3</li>
										<li>4</li>
										<li>5</li>
										<li>&middot;&middot;&middot;</li>
										<li><i class="fa fa-angle-double-right"
											aria-hidden="true"></i></li>
									</ul>
								</div> -->
								<!-- //page_button -->
							</c:when>
							<c:otherwise>
							등록하신 문의내용이 없습니다.
						</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="tab_box tab_box3 review_form">
					<form id="refrm" name="frm" method="post" action="/bookinsert2.do">
						<input type="hidden" name="NTT_ID" value="review"/>
						<input type="hidden" name="NAME" value="${lvo.name }"/>
						<input type="hidden" id="rFDATE" name="FDATE" />
						<input type="hidden" id="rFTYPE" name="FTYPE" />
						<input type="hidden" id="TITLE" name="TITLE" />
	                    <h4 class="TITLE"></h4>
	                    <div class="qnabx">
	                        <div class="qna_input3 clear">
	                          <p>후기</p>
	                          <textarea name="CONTENT" id="CONTENT" cols="30" rows="10"></textarea>
	                        </div>
	                        <div style="text-align:center;"><button type="button" id="rebtn" class="emdfhr">등록하기</button></div>
	                    </div>
	                </form>
                </div>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
	
</div>