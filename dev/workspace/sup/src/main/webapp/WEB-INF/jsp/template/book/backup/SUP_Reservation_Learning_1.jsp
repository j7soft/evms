<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Reservation.css">
<style>
#map {
	height: 400px;
	width: 100%;
}
</style>
<script type="text/javascript" >
	$(function(){
		$("#tbook_btn").click(function(){
			location.href="/bookinsert.do?BBS_ID=${vo.BBS_ID}";
		});
		$("#sbook_btn").click(function(){
			location.href="/bookinsert.do?BBS_ID=${vo.BBS_ID}";
		});
		
		
		
		
	});
	
</script>
<div id="reserve_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="reservation Learning">
			<div class="content_h3bx">
				<h3>현장학습</h3>
				<div class="h3_icon">
					<img src="/img/reservation/edu_icon.png" alt="노트와 펜 아이콘 이미지">
				</div>
			</div>

			<div class="topBox clear">
				<div class="leftBox">
					<img src="" alt="컨텐츠이미지">
				</div>
				<div class="rightBox">
					<h3>${vo.TITLE }TITLE</h3>
					<textarea rows="20" cols="70">${vo.SIMPLECONTENT }SCONTENT</textarea>
					<div class="btn clear">
						<button id="sbook_btn">예약하기</button>
						<button id="tbook_btn">단체예약</button>
					</div>
				</div>
				<p class="small">* 20명 이상 30명 이하는 단체로 예약해주시기 바랍니다</p>
				
				<div class="contentBox clear">
					<table border="1">
						<c:forEach begin="0" end="${reviewlist.size() }" varStatus="i">
							<tr>
								<th>${i.index+1 }</th>
								<th>${reviewlist[i.index].NAME }</th>
								<th>${reviewlist[i.index].CONTENT }</th>
								<th>${reviewlist[i.index].PUSHDATE }</th>
							</tr>
						</c:forEach>
						
					</table>


				</div>
				<div class="contentBox3 clear">
					<div class="mapBox">
						<div id="map"></div>
						<script>
							function initMap() {
								var uluru = {
									lat : 37.558577, 
									lng : 127.058236
								};
								var map = new google.maps.Map(document
										.getElementById('map'), {
									zoom : 16,
									center : uluru
								});
								var marker = new google.maps.Marker({
									position : uluru,
									map : map
									
								});
							}
						</script>
						<script async defer
							src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIb4yJMkcoQCHF-luIoXjHZ1KwS5d85qw&callback=initMap">
							
						</script>
					</div>
					<div class="addreBox">위치설명</div>
				</div>
			</div>

		</article>
	</section>
	<!--  //Main section 영역  -->
</div>