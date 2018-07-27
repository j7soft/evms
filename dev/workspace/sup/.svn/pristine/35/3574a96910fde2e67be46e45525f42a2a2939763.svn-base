<%@page import="javax.tools.JavaFileManager.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Community.css">
<script type="text/javascript">
	console.log(location.href);


	$(function() {
		$(".btn").click(function() {

		});

	});
	
    function share() {
      var url = encodeURI(encodeURIComponent(location.href));
      var title = encodeURI("${vo.TITLE}");
      var shareURL = "http://share.naver.com/web/shareView.nhn?url=" + url + "&title=" + title;
     // window.popup(shareURL,"width=500,height=500,toolbar=no,location=no,status=no,fullscreen=no,top=300,left=300,menubar=no");
      window.open(shareURL, 'popup01', 'width=500, height=500, toolbar=no, location=no, status=no, fullscreen=no, top=300,  left=300, menubar=no');
    
    }
  
  
</script>


<div id="community_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="community">
			<div class="content_h3bx">
				<h3>${type }</h3>
				<ul class="route">
				<c:set value="${fn:split(root,',') }" var="ro"/>
	                <li>${ro[0] }</li>
	                <li>${ro[1] }</li>
	                <li>${ro[2] }</li>
	            </ul>
			</div>
			<div class="community_view">
				<h4>${vo.TITLE }</h4>
				<ul class="view_info clear">
					<li><a href="javascript:history.go(-1)"><img
							src="../img/community/list_icon.png" alt="목록보기 아이콘"> 목록보기</a></li>
					<li><a href="/uploadStorage/file/${vo.FFILE }"> ${vo.FFILE } </a></li>
					<li>${vo.CNT }</li>
					<li>${vo.PUSHDATE }</li>
				</ul>
				<div class="viewbx">
					<div>${vo.CONTENT }</div>
				</div>
				<ul class="view_link">
					<!-- <li><a href="${vo.VIDEO }" >${vo.VIDEO }</a></li> -->
			 	</ul>
				<!-- 
				<c:set value="${fn:split(vo.ITEM_IMAGE,';') }" var="image"/>
				<c:if test="${image[0] != 'null' }">
					<img src="/uploadStorage/file/${image[0] }" alt="" height="300" width="200">
				</c:if>	
				<c:if test="${image[1] != 'null' }">
					<img src="/uploadStorage/file/${image[1] }" alt="" height="300" width="200">
				</c:if>	
				<c:if test="${image[2] != 'null' }">
					<img src="/uploadStorage/file/${image[2] }" alt="" height="300" width="200">
				</c:if>	
				<c:if test="${image[3] != 'null' }">
					<img src="/uploadStorage/file/${image[3] }" alt="" height="300" width="200">
				</c:if>	
				<c:if test="${image[4] != 'null' }">
					<img src="/uploadStorage/file/${image[4] }" alt="" height="300" width="200">
				</c:if>	
					 -->
			 <input type="button" value="공유하기" class="btn_share_naver" onclick="shareSns()"/>
			 <div class="shareBtn"> <a onclick="share()"><img src="../img/community/shareNaver.png" alt="네이버 공유하기" width="35px"></a>
			  <a href="javascript:sharefacebook()" target="_blank"><img src="../img/community/shareFacebook.png" alt="페이스북 공유하기" width="35px"></a> </div>
			</div>
		</article>
	</section>
	<!-- //Main section 영역   -->
		<script>
		/*facebook공유*/
		function sharefacebook() {
			var newURL = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname;
			window.open("http://www.facebook.com/sharer/sharer.php?u="+encodeURIComponent(window.location.href), 'popup02', 'width=500, height=500, toolbar=no, location=no, status=no, fullscreen=no, top=300,  left=300, menubar=no');
		}

		function shareSns(){
			$('.shareBtn').toggleClass('on');
		}
		</script>
		<style>
			/*공유하기Btn 20180515 추가*/
			.shareBtn{display:none;position:absolute;right:0;bottom:38px;padding:8px;border:1px solid #e1e1e1;background:#fff;border-radius:10px;}
			.shareBtn.on{display:block;}
		
		</style>
</div>
    <script src="/js/jquery.bxslider.min.js"></script>
	<script src="/js/common.js"></script>
	<script src="/js/index.js"></script>