<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	function goPage(pageNo){
	    location.href = "/admin/getBoardList.do?pageNo="+pageNo+"&NTT_ID=${NTT_ID}";
	}
</script>
	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${type }</h3>
		</div>
		<table>
			<colgroup>
				<col width="10%">
				<col width="38%">
				<col width="10%">
				<col width="22%">
				<%-- <col width="30%"> --%>
				<col width="10%">
				<col width="10%">
				<%--<col width="10%">
				<col width="10%">--%>
			</colgroup>

			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>회원ID</th>
				<th>내용</th>
				<th>답변상황</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].TITLE }</td>
						<td>${list[i.index].MBER_ID }</td>
						<td>${list[i.index].CONTENT }</td>
						<c:if test="${empty list[i.index].PTB }" ><td>답변대기</td></c:if>
 						<c:if test="${not empty list[i.index].PTB }" ><td>답변완료</td></c:if>
						<td><a href="/admin/boardDetail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }">관리</a></td>
					</tr>
				</c:if>

			</c:forEach>

		</table>
		<jsp:include page="paging.jsp" flush="true">
		    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
		    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
		    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
		    <jsp:param name="pageNo" value="${paging.pageNo}" />
		    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
		    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
		    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>
		            
	</div>
	
		
		