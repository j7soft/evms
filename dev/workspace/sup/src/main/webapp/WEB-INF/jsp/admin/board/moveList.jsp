<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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


<link rel="stylesheet" href="/css/SUP_Backoffice.css">

	<div id="b_office_Rent">
		<div class="title_box">
			<h3>${type }</h3>
		</div>
		<div class="add_list" align="right"><a href="/admin/boardIpage.do?NTT_ID=${NTT_ID }">등록</a></div>
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
				<th>업체명</th>
				<th>대표</th>
				<th>분야</th>
				<th>호수</th>
				<th>관리</th>
			</tr>
			<c:forEach begin="0" end="${list.size() }" varStatus="i">
				<c:if test="${not empty list[i.index]}">
					<tr>
						<td>${i.index+1 }</td>
						<td>${list[i.index].TEAMNAME }</td>
						<td>${list[i.index].PTB }</td>
						<td>${list[i.index].FTYPE }</td>
						<td>${list[i.index].ROOM }</td>
						<%-- <td><input type="checkbox" data-BBS_ID="${list[i.index].BBS_ID }" class="onbtn" <c:if test="${list[i.index].ONOFF == 'ON' }" >checked</c:if>/></td> --%>
						
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
	
		
		