<%@page import="java.io.Console"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/sliderstyle.css">
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<script type="text/javascript">
	$(function() {
		$(".reserv_btn").click(function() {
			if (1 != 1) {

			} else {
				location.href="bookinsert.do?BBS_ID="+$(this).attr("data-num")+"&type=${type}";

			}
		
		});
		console.log("${list[0].IMAGE}");
		console.log("${list[1].IMAGE}");
		console.log("${list[2].IMAGE}");
		console.log("${list[3].IMAGE}");
		console.log("${list[4].IMAGE}");
		console.log("${list[5].IMAGE}");

	});
</script>
<div id="main_wrap">
	<!--  Header 영역  -->

	<!--  //Header 영역  -->
	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation office">
			<div class="content_h3bx">
				<h3>대관</h3>
				<div class="h3_icon">
					<img src="../img/reservation/edu_icon.png" " alt="">
				</div>
			</div>

			<div class="tep_list_box">
				<ul class="tep_list clear">
					<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
						<c:if test="${i.index == 0 }">
							<li class="active"><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
						<c:if test="${i.index != 0 }">
							<li><span>${rentlist[i.index].TITLE }</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>

			<div class="tep_wrap">
				<c:forEach begin="0" end="${rentlist.size() }" varStatus="i">
					<c:if test="${not empty rentlist[i.index].BBS_ID}" >
					<div class="tep_box tep_box${i.index }">
						<c:set value="${fn:split(rentlist[i.index].IMAGE,';') }" var="im" />
						<section class="sub_slider slider${i.index }">
							<c:forEach begin="0" end="${fn:length(im) }" varStatus="y">
								<c:if test="${y.index == 0 }" >
									<img class="center" src="/uploadStorage/file/${im[y.index] }" />
								</c:if>
								<c:if test="${y.index != 0 && im[y.index]!=''}" >
									<img src="/uploadStorage/file/${im[y.index] }" />
								</c:if>
								
							</c:forEach>
						</section>

						<div class="info_box">
							<ul class="info_list clear">
								<li>
									<h3>${rentlist[i.index].TITLE }</h3>
								</li>
								<li>
									<h4>운영시간</h4>
									<p>${rentlist[i.index].FDAY}<br>${rentlist[i.index].FTIME}
										~ ${rentlist[i.index].STIME}
									</p>
								</li>
								<li>
									<h4>사용 가능 인원</h4>
									<p>${rentlist[i.index].CNT }</p>
								</li>

								<li>
									<h4>이용료</h4> <c:set var="big"
										value="${fn:split(rentlist[i.index].PRICE,',')}" />
									<p>
										성인 : ${big[0] }<br>아동 : ${big[1] }
									</p>
								</li>
								<li>
									<h4>특이사항</h4>
									<p>${rentlist[i.index].CONTENT }</p>
								</li>
								<li>
									<h4>담당자</h4>
									<p>${rentlist[i.index].PTB }</p>
								</li>
							</ul>
							<div class="btn">
								<p class="reserv_btn" data-num='${rentlist[i.index].BBS_ID }'>
									예약하기 <img src="/img/reservation/right_icon.png" alt="">
								</p>
							</div>
						</div>
					</div>
					</c:if>
				</c:forEach>

			</div>

		</article>
	</section>
</div>
<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/slider.jquery.js"></script>

<script>
	$('.tep_list li').click(function() {

		$(this).addClass('active').siblings().removeClass('active');
		var tep = $(this).index();

		// alert('.tep_box' + tep);
		$('.tep_box').hide();
		$('.tep_box' + tep).show();

	});

	// $('.tep_list li:nth-of-type(1)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box1').show();

	// });

	// $('.tep_list li:nth-of-type(2)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box2').show();

	// });

	// $('.tep_list li:nth-of-type(3)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box3').show();

	// });

	// $('.tep_list li:nth-of-type(4)').click(function(){

	//   $('.tep_box').hide();
	//   $('.tep_box4').show();

	// });
</script>