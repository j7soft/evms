<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	$(function(){
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

</script>

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
				<col width="8%">
				<col width="10%">
				<col width="10%">
			</colgroup>

			<tr>
				<th>순번</th>
				<th>작성자</th>
				<th>종류</th>
				<th>내용</th>
				<th>표시</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].NAME }</td>
						<td>		
						<c:choose>
							<c:when test="${fn:indexOf(list[i.index].FTYPE,'rent') != -1 }">대관 예약</c:when>
							<c:when test="${fn:indexOf(list[i.index].FTYPE,'bus') != -1 }">셔틀버스 예약</c:when>
							<c:when test="${fn:indexOf(list[i.index].FTYPE,'edu') != -1 }">교육 예약</c:when>
							<c:when test="${fn:indexOf(list[i.index].FTYPE,'trip') != -1 }">현장학습 예약</c:when>										
						</c:choose>	
						</td>
						<td>${list[i.index].CONTENT }</td>
						<td><input type="checkbox" data-BBS_ID="${list[i.index].BBS_ID }" class="onbtn" <c:if test="${list[i.index].ONOFF == 'ON' }" >checked</c:if>/></td>
						<td><a href="boardDetail.do?NTT_ID=${NTT_ID }&BBS_ID=${list[i.index].BBS_ID }">관리</a></td>
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