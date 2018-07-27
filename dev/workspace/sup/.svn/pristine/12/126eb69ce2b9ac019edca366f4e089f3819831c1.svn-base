<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">

	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${type } 등록</h3>
		</div>
		<div class="add_list" align="right"><a href="/admin/bookIpage.do?NTT_ID=${NTT_ID }">등록</a></div>
		<table>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="30%">
				<%-- <col width="30%"> --%>
				<col width="12%">
				<col width="8%">
				<col width="10%">
				<col width="10%">
			</colgroup>

			<tr>
				<th>순번</th>
				<th>등록명</th>
				<th>인원</th>
				<th>일자</th>
				<!--<th>가격</th>-->
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].TITLE }</td>
						<td>${list[i.index].CNT }</td>
						<td>${list[i.index].FDATE }</td>
						<!--<td>${list[i.index].PRICE }</td>-->
						<td><a href="/admin/cont/detailPage.do?BBS_ID=${list[i.index].BBS_ID}&NTT_ID=${NTT_ID}">관리</a></td>
					</tr>
				</c:if>

			</c:forEach>

		</table>
		<div class="pagenation" align="center">
			<button>&lt;&lt;</button>
			&nbsp;&nbsp;
			<button>&lt;</button>
			&nbsp;
			<button>1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			&nbsp;
			<button>&gt;</button>
			&nbsp;&nbsp;
			<button>&gt;&gt;</button>
		</div>
		            
	</div>
	
		
		