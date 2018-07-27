<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/jquery.form.min.js"></script>
<link rel="stylesheet" href="/css/SUP_Backoffice.css">

<script type="text/javascript">
	$(function() {
		var code = "${code}";
		if (code == 1) {
			alert("등록에 성공하였습니다.");
		} else if (code == 2) {
			alert("등록에 실패하였습니다.");
		}
		$(document).on( "click", ".radio", function() {
					var ck = "0";
					if ($(this).val() == "0") {
						ck = "0";
					} else {
						ck = "1";
					}
					location.href = "/state.do?NTT_NO=popup&BANNER_NM="
							+ $(this).parents("form").find("#BANNER_NM").val()
							+ "&REFLCT_AT=" + ck;
				});

		$(document).on("click", "#btnpop", function() {
			var from = $(this).parents("form");
			if (1 != 1) {

			} else {
				$(this).parents("form").ajaxForm({ //파일과 함께 보낼때는 ajaxForm을 사용
					url : "/admin/ContentInsert.do?NTT_NO=popup",
					type : "post",
					enctype : "multipart/form-data", //대용량 파일 전송을 위해 enctype을 꼭 써야함
					dataType : "text",
					error : function() {
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success : function(data) {
						alert("입력이 완료 됐습니다.");
						location.reload();
					}
				});
			}

		});

	});
</script>
	<div class="title_box">
		<h3>팝업 관리</h3>
	</div>
<c:forEach begin="0" end="5" varStatus="i">
	<fieldset style="margin-bottom:100px;" class="con_popup">
		<legend id="lg">컨텐츠 관리 - 팝업${i.index+1 }</legend>
		<form id="frm" name="frm" class="frm">
			<input type="hidden" id="BANNER_NM" name="BANNER_NM"
				value='popup${i.index+1}' /> <input type="hidden" name="RANK"
				value='${i.index+1}' />
			<c:if test="${not empty list[i.index].BANNER_NM }">
				<div>
					<label>사용여부</label> <label for="yes${i.index }"> <input
						type="radio" id="yes${i.index }" class="radio" name="REFLCT_AT"
						value="0"
						<c:if test="${list[i.index].REFLCT_AT==0 }">checked="checked"</c:if> />사용
					</label> <label for="no${i.index }"> <input type="radio"
						id="no${i.index }" class="radio" name="REFLCT_AT" value="1"
						<c:if test="${list[i.index].REFLCT_AT==1 }">checked="checked"</c:if> />사용
						안함
					</label>
				</div>
			</c:if>
			<div>
				<label for="image">이미지</label> <input type="file" name="file"
					id="image" /> <img alt="사진" class="img"
					<c:if test="${not empty list[i.index].BANNER_IMAGE_FILE }">src="/uploadStorage/file/${list[i.index].BANNER_IMAGE_FILE }"</c:if>
					height="100" width="100" /> <input type="hidden" name="b_file"
					value='${list[i.index].BANNER_IMAGE_FILE}' />
			</div>
			<div>
				<label for="link">링크</label><input type="text" name="LINK_URL"
					value='${list[i.index].LINK_URL }' />
			</div>
			<div>
				<label for="position">좌표</label><input type="text" name="POSITION"
					value='${list[i.index].POSITION}' />
			</div>
			<div>
				<label>기간</label> <input type="date" maxlength="10" class="fdate"
					name="FDATE" placeholder="시작일을 선택해주세요"
					value='${list[i.index].FDATE }' /> <input type="date"
					maxlength="10" class="sdate" name="SDATE" placeholder="종료일을 선택해주세요"
					value='${list[i.index].SDATE }' />
				</label>
			</div>
			<div>
				<button type="submit" value="등록" id="btnpop" class='btnpop' style="width:100px;height:25px;font-size:14px;font-weight:bold;">등록</button>
			</div>
		</form>
	</fieldset>
</c:forEach>