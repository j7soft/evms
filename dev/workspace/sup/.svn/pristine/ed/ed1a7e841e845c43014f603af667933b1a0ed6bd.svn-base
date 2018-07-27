<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<script type="text/javascript" >
	$(function(){
		$("#btn").click(function(){
			if(!$("#check").prop("checked")){
				alert("동의를 하셔야 다음페이지로 이동됩니다.")
			}else{
				//location.href="bookinsert.do?BBS_ID=${vo.BBS_ID}&type=${type}1";
				location.href="bookinsert.do?BBS_ID=1&type=${type}1";
			}
		});
	});
</script>

<div id="reserve_wrap">

	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation Rent">
			<div class="content_h3bx">
				<h3>대관</h3>
				<div class="h3_icon">
					<img src="../img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
				</div>
			</div>

			<div class="topBox clear">
				<div></div>
				<div class="textBox">
					<p>대관규정 및 개인정보 동의</p>
					<label for="check">
						<p>
							<input type="checkbox" id="check"> 동의
						</p>
					</label>
				</div>
				<div class="btn">
					<button type="button" id="btn">확인</button>
				</div>
			</div>

		</article>
	</section>
	<!--  //Main section 영역  -->

</div>