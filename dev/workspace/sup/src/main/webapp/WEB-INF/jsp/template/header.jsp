<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="shortcuticon" href="../img/common/sup.png" type="image/x-icon">
<link rel="icon" href="../img/common/sup.png" type="image/x-icon">

<!--  Header 영역  -->
<script src="/js/common.js"></script>

<header class="header">
	<div class="login_area clear">
		<div class="header_home">
			<ul>
			
			</ul>
		</div>
		<div class="header_login">
		<!--	<ul>
				<li><a href="/">홈</a></li>
				<c:if test="${empty loginVO.id }">
					<li><a href="/loginUsr.do">로그인</a></li>
					<li><a href="/uss/umt/EgovStplatCnfirmMber.do">회원가입</a></li>
				</c:if>
				<c:if test="${not empty loginVO.id }">
					<li><a href="/actionLogout.do">로그아웃</a></li>
					<c:if test="${loginVO.userSe != 'USR' }" >
						<li><a href="/mypage.do">마이페이지</a></li>
					</c:if>
					<c:if test="${loginVO.userSe == 'USR' }" >
						<li><a href="/admin/selectcal.do?NTT_ID=reservrent">관리자<a></li>		
					</c:if>
				</c:if>
			</ul>-->
             <ul>
				<li><a href="/">홈</a></li>
				<c:if test="${empty loginVO.id }">
					<li><a href="/loginUsr.do">로그인</a></li>
					<li><a href="/uss/umt/EgovStplatCnfirmMber.do">회원가입</a></li>
				</c:if>
				<c:if test="${not empty loginVO.id }">
					<li><a href="/actionLogout.do">로그아웃</a></li>
					<c:if test="${loginVO.userSe != 'USR' }" >
						<li><a href="/mypage.do">마이페이지</a></li>
					</c:if>
					<c:if test="${loginVO.userSe == 'USR' }" >
						<li><a href="/admin/selectcal.do?NTT_ID=reservrent">관리자<a></li>		
					</c:if>
				</c:if>
			</ul>
		</div>
	</div>
	<div class="gnb_area">
		<h1>
			<a href="/"><img src="/img/common/logo.jpg" alt="중소기업기술정보진흥원"></a>
		</h1>
		<nav class="nav">
			<ul class="gnb clear">
				<li><span onclick="location.href='/introduce.do?type=Introduction'">소개 및 안내</span></li>
				<li><span onclick="location.href='/boardList.do?type=move'">행사캘린더</span></li>
				<li><span onclick="location.href='/display.do?type=SUP_Display'">진행중인행사</span></li>
				<li><span onclick="location.href='/book.do?type=rent'">카테고리별행사</span></li>
				<!-- <li><span onclick="location.href='/introduce.do?type=MaterialsI'">소재정보</span></li> -->
				<li><span onclick="location.href='/board.do?type=notice'">커뮤니티</span></li>
			</ul>
		</nav>
		<div style="display:none;">
			<input type="submit" class="search_btn" value=""> <input
				type="search" name="" id="search">
		</div>
		<!-- <a class="designLogo" href="http://www.seouldesign.or.kr" target="_blank"><img src="/img/common/SeoulDeisgnLogo.svg" width="120" alt="서울디자인로고"></a> -->
	</div>
	<div class="gnb_dropdown">
		<div>
			<ul class="gnb_list clear">
				<li>
					<ul class="dropdown_list">
						<li><a href="/introduce.do?type=Introduction">행사관리시스템 개요</a></li>
						<li><a href="/introduce.do?type=Business">시스템 구성</a></li>
						<li><a href="/introduce.do?type=Message">기능</a></li>
						<li><a href="/introduce.do?type=Organization">참가비 결제 안내</a></li>
						<li><a href="/introduce.do?type=Location">운영기관</a></li>
					</ul>
				</li>
				<li>
					<ul class="dropdown_list">
						<li><a href="/studio.do?type=Studio_Education">행사 캘린더</a></li>
						<li><a href="/boardList.do?type=move">기간별 행사조회</a></li>
						<li><a href="/studio.do?type=Studio_Display">장소별 행사조회</a></li>
					</ul>
				</li>
				<li>
					<ul class="dropdown_list">
						<li><a href="/display.do?type=Display_Studio">오늘의행사</a></li>
						<li><a href="/display.do?type=SUP_Display">금주의행사</a></li>
						<li><a href="/display.do?type=Display_Education">이달의 행사</a></li>
					</ul>
				</li>
				<li>
					<ul class="dropdown_list">
						<li><a href="/book.do?type=mkt">판로마케팅</a></li>
						<li><a href="/book.do?type=hrm">인사·조직관리</a></li> 
						<li><a href="/book.do?type=fund">정책자금</a></li>
						<li><a href="/book.do?type=loc">입지</a></li>
						<li><a href="/book.do?type=rnd">R&D</a></li>
						<li><a href="/book.do?type=prz">표창</a></li> 
						<li><a href="/book.do?type=invst">투자</a></li> 
					</ul>
				</li>

				<li>
					<ul class="dropdown_list">
						<li><a href="/board.do?type=notice">공지사항</a></li>
						<li><a href="/board.do?type=news">설문조사</a></li>
						<li><a href="/board.do?type=reference">자료실</a></li>
						<!-- <li><a href="/boardList.do?type=story">스토리</a></li>-->
						<li><a href="/board.do?type=freeboard">묻고답하기</a></li>
						<li><a href="/board.do?type=faq">FAQ</a></li> 
					</ul>
				</li>
			</ul>
			
			
		</div>
	</div>
</header>

<header class="mobile_header">

	<div class="mobile_nav_btn">
		모바일 네비게이션 버튼
	</div>
	<h1 class="mobile_logo">
		<a href="/">행사관리시스템 로고</a>
	</h1>
	
	<nav class="">
		<div>
			<ul class="mobile_top_menu">
				<li><a href="/">홈</a></li>
				<c:if test="${empty loginVO.id }">
					<li><a href="/loginUsr.do">로그인</a></li>
					<li><a href="/uss/umt/EgovStplatCnfirmMber.do">회원가입</a></li>
				</c:if>
				<c:if test="${not empty loginVO.id }">
					<li><a href="/actionLogout.do">로그아웃</a></li>
					<c:if test="${loginVO.userSe != 'USR' }" >
						<li><a href="/mypage.do">마이페이지</a></li>
					</c:if>
					<c:if test="${loginVO.userSe == 'USR' }" >
						<li><a href="/admin/selectcal.do?NTT_ID=reservrent">관리자<a></li>		
					</c:if>
				</c:if>
				<!--<li><a href="/customer.do">Q&A</a></li>-->
			</ul>
		</div>
		<!-- <div class="form_group">
			<input type="submit" name="" value="">
			<input type="text" name="" id="" placeholder="Search">
		</div> -->
		<div class="mobile_sub_menu clear">
			<div class="menu_title">
				<h2>소개 및 안내</h2>
			</div>
			<div class="menu_list">
				<ul>
					<li><a href="/introduce.do?type=Introduction">행사관리시스템 개요</a></li>
					<li><a href="/introduce.do?type=Business">시스템 구성</a></li>
					<li><a href="/introduce.do?type=Message">기능</a></li>
					<li><a href="/introduce.do?type=Organization">참가비 결제 안내</a></li>
					<li><a href="/introduce.do?type=Location">운영기관</a></li>
				</ul>
			</div>
		</div>
		<div class="mobile_sub_menu clear">
			<div class="menu_title">
				<h2>행사캘린더</h2>
			</div>
			<div class="menu_list">
				<ul>
					<li><a href="/studio.do?type=Studio_Education">행사 캘린더</a></li>
					<li><a href="/board.do?type=move">기간별 행사조회</a></li>
					<li><a href="/studio.do?type=Studio_Display">장소별 행사조회</a></li>
				</ul>
			</div>
		</div>
		<div class="mobile_sub_menu clear">
			<div class="menu_title">
				<h2>진행중인행사</h2>
			</div>
			<div class="menu_list">
				<ul>
					<li><a href="/display.do?type=Display_Studio">오늘의행사</a></li>
					<li><a href="/display.do?type=SUP_Display">금주의행사</a></li>
					<li><a href="/display.do?type=Display_Education">이달의 행사</a></li>
				</ul>
			</div>
		</div>
		<div class="mobile_sub_menu clear">
			<div class="menu_title">
				<h2>카테고리별행사</h2>
			</div>
			<div class="menu_list">
				<ul>
					<li><a href="/book.do?type=mkt">판로마케팅</a></li>
					<li><a href="/book.do?type=hrm">인사·조직관리</a></li> 
					<li><a href="/book.do?type=fund">정책자금</a></li>
					<li><a href="/book.do?type=loc">입지</a></li>
					<li><a href="/book.do?type=rnd">R&D</a></li>
					<li><a href="/book.do?type=prz">표창</a></li> 
					<li><a href="/book.do?type=invst">투자</a></li> 				
				</ul>
			</div>
		</div>

		<div class="mobile_sub_menu clear">
			<div class="menu_title">
				<h2>커뮤니티</h2>
			</div>
			<div class="menu_list">
				<ul>
					<li><a href="/board.do?type=notice">공지사항</a></li>
					<li><a href="/board.do?type=news">설문조사</a></li>
					<li><a href="/board.do?type=reference">자료실</a></li>
					<!-- <li><a href="/board.do?type=story">스토리</a></li>-->
					<li><a href="/board.do?type=freeboard">묻고답하기</a></li>
					<li><a href="/board.do?type=faq">FAQ</a></li> 
				</ul>
			</div>
		</div>
	</nav>
</header>
<script>
	$(".busBtn").click(function() {
			var loginId = '${loginVO.id}'
			if (loginId == "") {
				location.href='/loginUsr.do';
			} else{
				location.href="/bookinsert.do?NTT_ID=bus&BBS_ID=";
			}
			
		});
</script>
<style>
.designLogo{display:block;width:120px;float:right;margin-right:49px;}



@media all and (max-width:1281px) {
	.designLogo{width:82px;}
}
</style>
<!--  //Header 영역  -->
