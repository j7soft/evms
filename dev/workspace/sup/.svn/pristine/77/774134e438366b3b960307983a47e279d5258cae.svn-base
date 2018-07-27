<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<style>
    nav{display:inline-block;float:left;}
    section{width:calc(100% - 500px); float:left;margin-top:130px;margin-left:;}
</style>
    



<div id="b_office_Rent">
	<div class="title_box">
		<h3>${BBS_NM }예약</h3>
	</div>
	<c:if test="${NTT_ID == 'reservrent' or NTT_ID == 'reservedu' and not empty title}">
		<div class="select_box">
			<select class="select1">
				<option value="all" selected="selected">전체</option>
				<c:forEach begin="0" items="${title }" varStatus="i">
					<option value="${title[i.index].TITLE }">${title[i.index].TITLE }</option>
				</c:forEach>
			</select>
		</div>
	</c:if>
	<c:if test="${NTT_ID == 'reservtrip'}">
		<div class="select_box">
			<select class="select1">
				<option value="all" selected="selected">전체</option>
				<option value="s">개인</option>
				<option value="t">단체</option>
			</select>
			<select class="select2">
				<option value="all" selected="selected">전체</option>
				<option value="am">오전</option>
				<option value="pm">오후</option>
				
			</select>
		</div>
	</c:if>
	<table>
		<c:if test="${NTT_ID == 'reservrent' or NTT_ID == 'reservedu' }">
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="25%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
			</colgroup>
					<tr>
				<th>순번</th>
				<th>구분</th>
				<th>신청자</th>
				<th>예약일</th>
				<th>인원</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" items="${list}" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${list[i.index].TITLE}</td>
					<td>${list[i.index].lname }</td>
					<td>
						<p>${list[i.index].FDATE }</p>
						<p>${list[i.index].FTIME }-${list[i.index].STIME }</p>
					</td>
					<td>${list[i.index].CNT}</td>
					<td>
						<p class="standby"><c:if test="${list[i.index].ONOFF!='' || not empty list[i.index].ONOFF}">${list[i.index].ONOFF}</c:if><c:if test="${list[i.index].ONOFF=='' || empty list[i.index].ONOFF}">대기</c:if></p>
					</td>
					<td><a href="/admin/cont/detailPage.do?BBS_ID=${list[i.index].BBS_ID}&NTT_ID=${NTT_ID}">관리</a></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${NTT_ID == 'reservtrip' }">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>구분</th>
				<th>구분2</th>
				<th>신청자</th>
				<th>예약일</th>
				<th>인원(성인/아동)</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" items="${list}" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${list[i.index].TITLE}</td>
					<td>
						<c:if test="${list[i.index].NTT_NO=='s'}">개인</c:if>
						<c:if test="${list[i.index].NTT_NO=='t'}">단체</c:if>
					</td>
					<td>
						<c:if test="${list[i.index].NTT_NO=='s'}">
							<c:set var="type2" value="${fn:substring(list[i.index].FTIME,0,2) }" />
							
							<c:if test="${type2 < 12 }" >
								오전학습
							</c:if>
							<c:if test="${type2 >= 12 }" >
								오후학습
							</c:if>
						</c:if>
						<c:if test="${list[i.index].NTT_NO=='t'}">
							${list[i.index].FTYPE }
						</c:if>
					</td>
					<td>${list[i.index].lname }</td>
					<td>
						<p>${list[i.index].FDATE }</p>
						<p>${list[i.index].FTIME }</p>
					</td>
					<c:set value="${fn:split(list[i.index].CNT,',') }" var="scnt" />
					<td>${scnt[0] }/${scnt[1] }</td>
					<td>
						<p class="standby"><c:if test="${list[i.index].ONOFF!='' || not empty list[i.index].ONOFF}">${list[i.index].ONOFF}</c:if><c:if test="${list[i.index].ONOFF=='' || empty list[i.index].ONOFF}">대기</c:if></p>
					</td>
					<td><a href="/admin/cont/detailPage.do?BBS_ID=${list[i.index].BBS_ID}&NTT_ID=${NTT_ID}">관리</a></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${NTT_ID == 'reservbus' }">
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="25%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>순번</th>
				<th>신청자</th>
				<th>연락처</th>
				<th>예약시간</th>
				<th>인원</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" items="${list}" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${list[i.index].lname}</td>
					<td>${list[i.index].tel}</td>
					<td>
						<p>${list[i.index].FDATE }</p>
						<p>${list[i.index].FTIME }</p>
					</td>
					<td>${list[i.index].CNT }</td>
					<td>
						<p class="standby"><c:if test="${list[i.index].ONOFF!='' || not empty list[i.index].ONOFF}">${list[i.index].ONOFF}</c:if><c:if test="${list[i.index].ONOFF=='' || empty list[i.index].ONOFF}">대기</c:if></p>
					</td>
					<td><a href="/admin/cont/detailPage.do?BBS_ID=${list[i.index].BBS_ID}&NTT_ID=${NTT_ID}">관리</a></td>
				</tr>
			</c:forEach>
		</c:if>
		
		<c:if test="${empty list }">
			<tr><td colspan="10">등록된 정보가 없습니다.</td></tr>
		</c:if>
	</table>
	<!--<c:if test="${not empty list }">
		<div class="pagenation" align="center">
			<button>&lt;&lt;</button>
			&nbsp;&nbsp;
			<button>&lt;</button>
			&nbsp;
			<button class="on">1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			&nbsp;
			<button>&gt;</button>
			&nbsp;&nbsp;
			<button>&gt;&gt;</button>
		</div>
	</c:if>-->
</div>
