<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">

<section>
	<in
	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${title }</h3>
			<ul class="route">
				<c:set value="${fn:split(root,',') }" var="ro"/>
	                <li>${ro[0] }</li>
	                <li>${ro[1] }</li>
	                <li>${ro[2] }</li>
            </ul>
		</div>
		<div><button>글쓰기</button></div>
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
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>상단표시</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].TITLE }</td>
						<td>${list[i.index].NAME }</td>
						<td>${list[i.index].PUSHDATE }</td>
						<td><input type="checkbox" name="ONOFF" value="${list[i.index].ONOFF}"</td>
						<td><button type="button" name="${list[i.index].BBS_ID }">관리</button></td>
					</tr>
				</c:if>

			</c:forEach>

		</table>
		<div align="center">
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

</section>



