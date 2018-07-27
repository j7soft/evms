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
		<div class="add_list" align="right"><a href="/admin/boardIpage.do?NTT_ID=${NTT_ID }">등록</a></div>
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
						<td>${list[i.index].TITLE }</td>
						<td>${list[i.index].lname }</td>
						<td>${list[i.index].CNT }</td>
						<td>
							<p>${list[i.index].FDATE }</p>
							<p>${list[i.index].FTIME }-${list[i.index].STIME }</p>
						</td>
						<td>
							<input type="checkbox" data-BBS_ID="${list[i.index].BBS_ID }" class="onbtn" <c:if test="${list[i.index].ONOFF == 'ON' }" >checked</c:if>/>
						</td>
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