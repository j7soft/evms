<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Community.css">

    <div id="community_wrap">
     <!--  Main section 영역  -->
    <section id="section">
        <article class="community gallery">
            <div class="content_h3bx">
                <h3>갤러리</h3>
                <ul class="route">
                    <li>홈</li>
                    <li>커뮤니티</li>
                    <li>갤러리</li>
                </ul>
            </div>
            <div class="community_view">
                <ul class="view_info clear">
                    <li class="link_list"><a href="javascript:history.back(-1)"><img src="../img/community/list_icon.png" alt="목록보기 아이콘"> 목록보기</a></li>
                    <li class="title_view">${vo.TITLE }</li>
                    <li>${vo.CNT }</li>
                    <li>${vo.PUSHDATE }</li>
                </ul>
                <div class="viewbx"><div><p>${vo.CONTENT }</p>
					<img height="165" width="300" src="<c:if test='${not empty vo.FFILE}'>/uploadStorage/file/${vo.FFILE}</c:if>
						<c:if test='${empty vo.FFILE}'>/img/noimage.JPG</c:if>" />

                </div></div>
            </div>
        </article>
    </section>
    </div>
    <script src="/js/jquery.bxslider.min.js"></script>
	
	<script src="/js/index.js"></script>