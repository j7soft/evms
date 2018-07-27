<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Community.css">
<style>
	.page_num li{font-size:1em;}
</style>
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
            <div class="gallery_area">
                <ul class="list_gallery clear">
	                 <c:forEach begin="0" items="${list }" varStatus="i">
		                 <li onclick="location.href='/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }'">
		                      <div class="box_gallery" ><img src="<c:if test='${not empty list[i.index].FFILE}'>/uploadStorage/file/${list[i.index].FFILE}</c:if><c:if test='${empty list[i.index].FFILE}'>/img/noimage.JPG</c:if>" /></div>
		                      <p class="title_gallery">${list[i.index].TITLE }</p>
		                  </li>
	                 
	                 </c:forEach>
                  
                </ul>
                <div class="page_numbx">                          
                    <ul class="page_num">
                        <li><i class="fa fa-angle-double-left" aria-hidden="true"></i></li>
                        <li>1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                        <li>&middot;&middot;&middot;</li>
                        <li><i class="fa fa-angle-double-right" aria-hidden="true"></i></li>
                    </ul>
                </div> <!-- //page_button -->
              
              
              
              
              
            </div>
        </article>
    </section>
    <!--  //Main section 영역  -->
    </div>
    <script src="/js/jquery.bxslider.min.js"></script>
	<script src="/js/index.js"></script>
