<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Community.css">
<script>
	function goPage(pageNo){
	    location.href = "/board.do?pageNo="+pageNo+"&type=${NTT_ID}";
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
			<div class="community_table">
				<table>
					<colgroup>
						<col width="11%">
						<col width="63%">
						<col width="13%">
						<col width="13%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach begin="0" end="${list.size() }" varStatus="i">
							<c:if test="${not empty list[i.index]  }">
								<tr>
									<td>${list[i.index].indexNum }</td>
									<td class="txt_align_left"><a href="/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }">${list[i.index].TITLE}</a></td>
									<td>${list[i.index].PUSHDATE }</td>
									<c:if test="${list[i.index].CNT=='' || empty list[i.index].CNT}">
										<td>0</td>
									</c:if>
									<c:if test="${list[i.index].CNT!='' || not empty list[i.index].CNT}">
										<td>${list[i.index].CNT }</td>
									</c:if>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
		<jsp:include page="/WEB-INF/jsp/admin/board/paging.jsp" flush="true">
		    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
		    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
		    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
		    <jsp:param name="pageNo" value="${paging.pageNo}" />
		    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
		    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
		    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>
				<c:if test="${type=='자유게시판' }" >
					<div align="right"><a class="add_free"href="/freeboard.do?NTT_ID=freeboard">글쓰기</a></div>
				</c:if>

			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>
</body>