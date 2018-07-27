<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	$(function(){
		$(".stbtn").click(function(){
			var st =  $(this).val();
			if(confirm(st+" 하시겠습니까?")){
				location.href="/admin/stupdate.do?NTT_ID=${vo.NTT_ID}&BBS_ID=${vo.BBS_ID}&ONOFF="+st;
			}
		});
		$(".onbtn").change(function(){
			var on = "";
			var BBS_ID = $(this).attr("data-BBS_ID");
			if($(this).prop("checked")){
				on="ON";
			}else{
				on="OFF";
			}
			location.href="/admin/atonUpdate.do?NTT_ID=${NTT_ID}&BBS_ID="+BBS_ID+"&type=ONOFF&value="+on;
		});
	});
	
	function goPage(pageNo){
        location.href = "/admin/getBoardList.do?pageNo="+pageNo+"&NTT_ID=${NTT_ID}";
	}
	
	function protectAdmin(){
		var url = window.location.href;
		if(url.includes('/admin')){
			alert('1');
			var loginId = '${loginVO.id}'
				if (loginId == "") {
					location.href='/loginUsr.do';
				}
		}
	};
	protectAdmin()
</script>

<section>

	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${type }</h3>
		</div>
		
		<div class="add_list" align="right">
			<c:if test="${NTT_ID != 'freeboard' }" >
				<a href="/admin/boardIpage.do?NTT_ID=${NTT_ID }">등록</a>
			</c:if>
		</div>
		<table>
			<colgroup>
				<col width="10%">
				<col width="50%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<%--<col width="10%">
				<col width="10%">--%>
			</colgroup>

			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<!--<th>상단표시</th>
				<th>공개여부</th>-->
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${list[i.index].indexNum }</td>
						<td>${list[i.index].TITLE }</td>
						<td>${list[i.index].MBER_ID }</td>
						<td>${list[i.index].PUSHDATE }</td>
						<!--<td><input type="checkbox" class="USE_AT" name="USE_AT" <c:if test="${list[i.index].USE_AT == 0}" >checked</c:if> /></td>
						<td><input type="checkbox" data-BBS_ID="${list[i.index].BBS_ID }" class="onbtn" <c:if test="${list[i.index].ONOFF == 'ON' }" >checked</c:if>/></td>-->
						<td><a href="boardDetail.do?NTT_ID=${NTT_ID }&BBS_ID=${list[i.index].BBS_ID }">관리</a></td>
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

</section>