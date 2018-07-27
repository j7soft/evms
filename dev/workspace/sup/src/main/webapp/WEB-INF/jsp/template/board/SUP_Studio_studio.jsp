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
		<article class="studio studio01">
			<div class="content_h3bx">
				<h3>${type }</h3>
				<ul class="route">
				<c:set value="${fn:split(root,',') }" var="ro"/>
	                <li>${ro[0] }</li>
	                <li>${ro[1] }</li>
		            <li>${ro[2] }</li>
	            </ul>
			</div>

			<div class="topBox clear">
				<div class="studioBox">
					<ul>
						<c:forEach begin="0" end="${list.size() }" varStatus="i">
							<c:if test="${not empty list[i.index]}">
								<li><a
									href="/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }">
										<c:if test="${NTT_ID=='move' }">										
											<p>${list[i.index].FTYPE}</p>
											<h4>${list[i.index].TEAMNAME }</h4>
											<div class="textBox">
												<p>품목 : ${list[i.index].ITEM_OBJECT }</p>
												<p>소재 : ${list[i.index].ITEM_SUBJECT }</p>
											</div>
										</c:if> 
										<c:if test="${NTT_ID=='story' }">
											<h4>${list[i.index].TITLE }</h4>
											<div class="textBox">
												<p>${list[i.index].SIMPLECONTENT }</p>
											</div>
										</c:if>
										<div class="imgBox">
										<!--	<img src="<c:if test='${not empty list[i.index].FFILE}'>/upload/${list[i.index].FFILE}</c:if><c:if test='${empty list[i.index].FFILE}'>/img/noimage.JPG</c:if>"  height="300" width="200">-->						
											<img src="/uploadStorage/file/${list[i.index].IMAGE }"
												alt="" height="300" width="200">
											<div class="hover">
												<img src="../img/studio/plus_icon.png" alt=""
													class="plusicon"> <span>SUP</span>
											</div>
										</div>
								</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>

		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<script src="/js/jquery.bxslider.min.js"></script>

<script src="/js/index.js"></script>