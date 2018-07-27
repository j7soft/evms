<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script type="text/javaScript" language="javascript" defer="defer">
function fnCmmRegPage(){
	//alert('333');
	//var $bbsid = 'rentDetail';
	//alert('${bbsid}'); 
	
	$(location).attr('href', '/admin/cont/registPage.do?bbsId=rentDetail' ); //  'book/rentDetail';
	
}

</script>

	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${title }</h3>
		</div>
	<!-- 	<select id="select" >
			<option value="all" selected="selected">전체</option>
			<option value="rent">대관예약</option>
			<option value="edu">교육예약</option>
			<option value="tra">현장예약</option>
			<option value="bus">셔틀예약</option>
		</select> -->
		
		<table>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="40%">
				<col width="12%">
				<col width="8%">
				<col width="10%">
				<col width="10%">
			</colgroup>

			<tr>
				<th>순2번</th>
				<th>상품명</th>
				<th>신청자</th>
				<th>인원</th>
				<th>기간</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td><a href="/admin/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID}">${list[i.index].TITLE }</a></td>
						<td>${list[i.index].TEAMNAME }</td>
						<td>${list[i.index].CNT }</td>
						<td>
							<p>${list[i.index].FDATE }</p>
							<p>${list[i.index].FTIME }-${list[i.index].STIME }</p>
						</td>
						<td>
							<p class="standby">
								${list[i.index].ONOFF}
							</p>
						</td>
						<td><a href="/admin/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID}">관리</a></td>
					</tr>
				</c:if>

			</c:forEach>

		</table>
		            <button id = 't' onclick = 'fnCmmRegPage()'> 등록</button>
	</div>
