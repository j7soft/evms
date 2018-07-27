<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%-- 
	<div><input type="text" id="NTT_NO" name="NTT_NO" value="${vo.NTT_NO }"></div><!-- 공통코드  -->
	<div><input type="text" id="TITLE" name="TITLE" value="${vo.TITLE }"></div><!-- 제목 -->
	<div><input type="text" id="SIMPLECONTENT" name="SIMPLECONTENT" value="${vo.SIMPLECONTENT }"></div><!-- 요약설명 -->
	<div><input type="text" id="FDATE" name="FDATE" value="${vo.FDATE }"></div><!-- 일시 -->
	<div><input type="text" id="FTIME" name="FTIME" value="${vo.FTIME }"></div><!-- 시작 -->
	<div><input type="text" id="STIME" name="STIME" value="${vo.STIME }"></div><!-- 종료 -->
	<div><input type="text" id="TARGET" name="TARGET" value="${vo.TARGET }"></div><!-- 대상 -->
	<div><input type="text" id="PRICE" name="PRICE" value="${vo.PRICE }"></div><!-- 금액 -->
	<div><input type="text" id="PLACE" name="PLACE" value="${vo.PLACE }"></div><!-- 장소 -->
	<div><input type="text" id="IMAGE" name="IMAGE" value="${vo.IMAGE }"></div><!-- 이미지 파일 -->
	<div><input type="text" id="DETAIL" name="DETAIL" value="${vo.DETAIL }"></div><!-- 설명 -->
	<div><input type="text" id="EMAIL" name="EMAIL" value="${vo.EMAIL }"></div><!-- 이메일 --> --%>

<section id="section">
	<article class="backoffice2">

		<div class="topBox clear">
			<h4>교육등록</h4>
			<div class="box01">
				<ul>
					<li><span>제목</span> <input type="text"></li>
					<li><span>요약설명</span> <input type="text"></li>
					<li class="li"><span>시작</span><span class="span"><input
							type="checkbox">당일</span> <span class="span02">종료</span></li>
					<li><span>일시</span> <input type="date"><input
						type="date"></li>
					<li><span>시작</span> <input type="time"><input
						type="time"></li>
					<li><span>대상</span> <select name="" id="">
							<option value="성인">성인</option>
					</select> <select name="" id="">
							<option value="어린이">어린이</option>
					</select></li>
					<li><span>금액</span> <select name="" id="">
							<option value="성인">성인</option>
					</select> <select name="" id="">
							<option value="어린이">어린이</option>
					</select> <input type="checkbox" class="check"><span class="span">무료</span>
					</li>
					<li><span>장소</span> <select name="" id="">
							<option value=""></option>
					</select></li>
				</ul>
			</div>
			<div class="box02">
				<p>이미지 업로드</p>
				<input type="file" name="" class="file">
				<button>+</button>
				<p>설명</p>
				<div class="textBox"></div>
				<p>파일 업로드</p>
				<input type="file" name="" class="file">
			</div>
			<div class="btn">
				<button type="button">등록</button>
			</div>
		</div>

	</article>
</section>