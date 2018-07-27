<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	/**
	 * @Class Name : EgovLoginUsr.jsp
	 * @Description : Login 인증 화면
	 * @Modification Information
	 * @
	 * @  수정일         수정자                   수정내용
	 * @ -------    --------    ---------------------------
	 * @ 2009.03.03    박지욱          최초 생성
	 *   2011.09.25    서준식          사용자 관리 패키지가 미포함 되었을때에 회원가입 오류 메시지 표시
	 *   2011.10.27    서준식          사용자 입력 탭 순서 변경
	 *  @author 공통서비스 개발팀 박지욱
	 *  @since 2009.03.03
	 *  @version 1.0
	 *  @see
	 *
	 *  Copyright (C) 2009 by MOPAS  All right reserved.
	 */
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><spring:message code="comUatUia.title" /></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/SUP_Login.css">
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>"></script>
<script type="text/javaScript" language="javascript">
	$(function() {
		if ("${message}" != "") {
			alert("${message}");
		}
	});

	function actionLogin() {
		if (document.loginForm.id.value == "") {
			alert("<spring:message code="comUatUia.validate.idCheck" />");
<%-- 아이디를 입력하세요 --%>
	} else if (document.loginForm.password.value == "") {
			alert("<spring:message code="comUatUia.validate.passCheck" />");
<%-- 비밀번호를 입력하세요 --%>
	} else {
			saveid(document.loginForm);
			document.loginForm.action = "<c:url value='/uat/uia/actionLogin.do'/>";
			//document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
			//document.loginForm.action="<c:url value='/j_spring_security_check'/>";
			document.loginForm.submit();
		}
	}

	/* function actionCrtfctLogin() {
	 document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
	 document.defaultForm.submit();
	 }
	 */
	function goFindId() {
		document.defaultForm.action = "<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
		document.defaultForm.submit();
	}

	function goRegiUsr() {
		var userSe = document.loginForm.userSe.value;
		document.loginForm.action = "<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
		document.loginForm.submit();

	}

	function setCookie(name, value, expires) {
		document.cookie = name + "=" + escape(value) + "; path=/; expires="
				+ expires.toGMTString();
	}

	function getCookie(Name) {
		var search = Name + "=";
		if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
			offset = document.cookie.indexOf(search);
			if (offset != -1) { // 쿠키가 존재하면
				offset += search.length;
				// set index of beginning of value
				end = document.cookie.indexOf(";", offset);
				// 쿠키 값의 마지막 위치 인덱스 번호 설정
				if (end == -1)
					end = document.cookie.length;
				return unescape(document.cookie.substring(offset, end));
			}
		}
		return "";
	}

	function saveid(form) {
		var expdate = new Date();
		// 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
		if (form.checkId.checked) {
			expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
		} else {
			expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
		}
		setCookie("saveid", form.id.value, expdate);
	}

	function getid(form) {
		form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
	}

	function fnInit() {
		/* if (document.getElementById('loginForm').message.value != null) {
		    var message = document.getElementById('loginForm').message.value;
		} */
		/* if (${message} != "") {
		    alert(${message});
		} */

		/* *************************
		document.loginForm.rdoSlctUsr[0].checked = false;
		document.loginForm.rdoSlctUsr[1].checked = false;
		document.loginForm.rdoSlctUsr[2].checked = true;
		document.loginForm.userSe.value = "USR";
		document.loginForm.id.value="TEST1";
		document.loginForm.password.value="rhdxhd12";
		 **************************** */

		//getid(document.loginForm);
		// 포커스
		//document.loginForm.rdoSlctUsr.focus();
		getid(document.loginForm);

		document.loginForm.userSe.value = "GNR";
	}
</script>
</head>
<body onLoad="fnInit();">

	<!-- javascript warning tag  -->
	<noscript class="noScriptTitle">
		<spring:message code="common.noScriptTitle.msg" />
	</noscript>

	<div id="login_wrap">
		<!--  Main section 영역  -->
		<section id="section">
			<div class="sub_bg">
				<h3>서브메인 이미지</h3>
			</div>
			<article id="targ" name="targ" class="login">
				<div class="content_h3bx">
					<h3>로그인</h3>
				</div>

				<!-- login영역 -->
				<form name="loginForm" id="loginForm"
					action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
					<input type="hidden" id="message" name="message"
						value="<c:out value='${message}'/>">

					<fieldset class="login_form">


						<div class="login_input">
							<ul>
								<!-- 아이디 -->
								<!--<c:set var="title">아이디</c:set>-->
								<li class="loginbx_id"><label for="id">아이디</label> <input
									value="webmaster" type="text" name="id" id="id" maxlength="10"
									title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
								</li>
								<!-- 비밀번호 -->
								<c:set var="title">
									<spring:message code="comUatUia.loginForm.pw" />
								</c:set>
								<li class="loginbx_pw"><label for="password">비밀번호</label> <input
									type="password" name="password" id="password" maxlength="12"
									title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
								</li>
								<!-- 아이디 저장 -->
								<!--			<c:set var="title">아이디 저장</c:set>-->
								<li class="chk"><input type="checkbox" name="checkId"
									class="check2" onClick="javascript:saveid(document.loginForm);"
									id="checkId">아이디 저장</li>
								<li class="loginbx_link">
									<ul class="btn_idpw clear">
										<li><a href="#" onClick="goFindId(); return false;">아이디/비밀번호
												찾기</a></li>
										<!-- 아이디/비밀번호 찾기 -->
										<li><a href="#" onClick="goRegiUsr(); return false;">회원가입</a></li>
										<!-- 회원가입  -->
									</ul>
								</li>
								<li><input type="button" class="btn_login" value="로그인"
									onClick="actionLogin()"> <!-- 로그인  --></li>
							</ul>
						</div>

					</fieldset>

					<input name="userSe" type="hidden" value="GNR" /> <input
						name="j_username" type="hidden" />
				</form>

			</article>
		</section>
		<!--  //Main section 영역  -->
	</div>


	<!-- 팝업 폼 -->
	<form name="defaultForm" action="" method="post" target="_blank">
		<div style="visibility: hidden; display: none;">
			<input name="iptSubmit3" type="submit"
				value="<spring:message code="comUatUia.loginForm.submit"/>"
				title="<spring:message code="comUatUia.loginForm.submit"/>">
		</div>
	</form>
	<!-- login영역 //-->


	<script src="../js/jquery-1.12.4.min.js"></script>
	<script src="../js/jquery.bxslider.min.js"></script>
	<script src="../js/common.js"></script>

</body>
</html>
