<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Backoffice.css">
<script>
	jQuery(function(){
		
		
		
		
		jQuery(".btn").click(function(){
			if(1!=1){
				
			}else if(!checkForm(jQuery("#t1"),"제목을" )){
				return;
			}
			else{

			    oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
				jQuery("#frm").submit();
			}
		});
		jQuery(".dbtn").click(function(){
			if(1!=1){
				
			}else {
				if(confirm("정말로 삭제하시겠습니까?")){
					location.href="/admin/boardDelete.do?NTT_ID=${NTT_ID}&BBS_ID=${vo.BBS_ID}";			
				}else{
					return;
				}
			}			
		});

		
		
	});


</script>


	<!--  Main section 영역  -->
	<section id="section">
	
		
	<div id="b_office_notice">
		<div class="title_box">
			<h3>
				${type }
			</h3>
		</div>
		
		
		
<form id="frm" name="frm" action="<c:if test='${empty vo}'>/admin/boardInsert.do</c:if><c:if test='${not empty vo}'>/admin/boardUpdate.do</c:if>" method="post" enctype="multipart/form-data">
		
			<input type="hidden" name="NTT_ID" value="${NTT_ID }"/>
			<input type="hidden" name="NTT_NO" value="${type }"/>
			<input type="hidden" name="MBER_ID" value="${lvo.id }"/>
			<input type="hidden" name="BBS_ID" value="${vo.BBS_ID }"/>
			
			<div class="notice_title">
				<h4>
					<input type="text" placeholder="제목을 입력해주세요." value="${vo.TITLE }" name="TITLE" id="t1">
				</h4>
			</div>
			<div class="form_group">
				<label for="f1">첨부파일</label> <input type="file"  name="file" id="f1">${vo.FFILE }
				<label for="f1">메인이미지</label> <input type="file"  name="mfile" id="f1">${vo.IMAGE }
			</div>
			<div>
			 		
				

			<textarea style="width: 100%" rows="10" name="CONTENT" id="textAreaContent" cols="80">${vo.CONTENT }</textarea>
				
			<%-- <textarea name="CONTENT" id="t2" cols="30" rows="10" placeholder="내용을 입력하세요.">${vo.CONTENT }</textarea> --%>
			</div>
			<div class="form_group">
				<label for="g1">동영상 링크</label> <input type="text" name="VIDEO" value="${vo.VIDEO }"
					id="g1" style="float:none;width:250px;height:21px;border:1px solid #ccc;">
			</div>
	
			<div class="form_group">
				<c:if test='${empty vo}'>
					<input type="button" id="btnInsert" class="btn" value="등록하기">
				</c:if>
				<c:if test='${not empty vo}'>
					<input type="button" id="btnUpdate" class="btn" value="수정하기" >
					<input type="button" id="btnDelete" class="dbtn" value="삭제하기">
					<span >
					</span>
				</c:if>
			</div>
		</form>	
		
			</div>
		
	</section>
	<!--  //Main section 영역  -->


<!-- editor 영역  -->
<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/se2/js/jindo.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/se2/js/jindo_component.js" charset="utf-8"></script>
<script type="text/javascript" src="/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
	 
	 
	<!-- Smart Editor -->
	<script type="text/javascript">
	 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "textAreaContent",
	    sSkinURI: "/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});

	 
	// textArea에 이미지 첨부
	function pasteHTML(filepath){
	    var sHTML = '<img src="<%=request.getContextPath()%>/upload/'+filepath+'">';
	    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
	}
	 
</script>


<style>
	#b_office_notice div.form_group:nth-of-type(3), #b_office_notice div.form_group:nth-of-type(5){display:block;}
</style>