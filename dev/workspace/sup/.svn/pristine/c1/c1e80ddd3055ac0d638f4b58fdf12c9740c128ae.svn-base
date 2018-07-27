<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_studio.css">
<div id="reserve_wrap">

	<!--  Main section 영역  -->
	<section id="section">
		<article class="studio studio02">
			<div class="content_h3bx">
				<h3>입주시설임대</h3>
				<%--<h3>${type }</h3>--%>
				<ul class="route">
				<c:set value="${fn:split(root,',') }" var="ro"/>
	                <li>${ro[0] }</li>
	                <li>${ro[1] }</li>
	                <li>입주시설임대</li>
	               <%-- <li>${ro[2] }</li>--%>
	            </ul>
			</div>

			<div class="back">
				<a href="javascript:history.go(-1)"><img src="../img/studio/back_bar.png" alt="">
					목록보기</a>
			</div>

			<div class="info clear">

				<div class="left">
					<h4>
						${vo.TEAMNAME }
					</h4>
					<ul>
						<li><span>대 표</span><span>:</span><span>${vo.PTB }</span></li>
						<li><span>분 야</span><span>:</span><span>${vo.FTYPE }</span></li>
						<li><span>품 목</span><span>:</span><span>${vo.ITEM_OBJECT }</span></li>
						<li><span>소 재</span><span>:</span><span>${vo.ITEM_SUBJECT }</span></li>
						<li><span>위치</span><span>:</span><span>${vo.ROOM }</span></li>
					</ul>
				</div>
				<div class="right">
					<div class="logo_img">
						<img src="/uploadStorage/file/${vo.LOGO }" alt="로고이미지">
					</div>

					<p>
						${vo.INTRO }
					</p>
					<p>자세한 내용은 홈페이지를 참고해주세요</p>
					<a href="${vo.HOMEPAGE }">${vo.HOMEPAGE }</a>
				</div>
			</div>
			<c:if test="${not empty vo.VIDEO}" >
				<iframe src="${vo.VIDEO }" frameborder="0" class="video"></iframe>
			</c:if>
			<c:set value="${fn:split(vo.ITEM_IMAGE,';') }" var="image"/>
			<div class="grid_box clear">
				<c:forEach begin="0" end="11" varStatus="i">
					
					
						<%-- <c:if test="${image[i.index] =='null' }" >
							<img src="/img/noimage.JPG" alt="">
						</c:if> --%>
						<c:if test="${ (image[i.index] !='null') and (not empty image[i.index]) }" >
							<div class="grid">
								<img src="/uploadStorage/file/${image[i.index] }" alt="">
							</div>
						</c:if>
						
					
				</c:forEach>
			</div>

		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<script src="/js/jquery.bxslider.min.js"></script>
<script src="/js/index.js"></script>