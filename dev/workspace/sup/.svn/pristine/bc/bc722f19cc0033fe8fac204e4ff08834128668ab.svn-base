<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">


<section>

	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${type }</h3>
		</div>
		<table>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="40%">
				<col width="12%">
				<col width="12%">
			</colgroup>

			<tr>
				<th>순번</th>
				<th>이름</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>확인</th>
			</tr>
			
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].name }</td>
						<td>${list[i.index].tel }</td>
						<td>${list[i.index].email }</td>
						<td><a href="/amdin/infoSelect.do?MBER_ID=${list[i.index].id }">확인</a></td>
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

</section>