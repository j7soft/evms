<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

 <script type="text/javascript" charset="utf-8" src="/js/jquery.cookie.js"></script>
 <script type="text/javascript" charset="utf-8" src="/js/naverLogin.js"></script>
<script type="text/javascript">
$(function(){
	getid(document.loginForm);
	
	if("${message}"!=""){
		alert("${message}");
	}
});



var state = "";
function getNaverUserInfo(){
	   naver.api(URL, tokenInfo.access_token, function(data) {
	       var response = data._response.responseJSON;
	       console.log("success to get user info", response);
	       alert(response.response.email);
	   });
	}
    function generateState() {
        // CSRF 방지를 위한 state token 생성 코드
        // state token은 추후 검증을 위해 세션에 저장 되어야 합니다.
        var oDate = new Date();
        return oDate.getTime();
    }
    function saveState(state) {
        $.removeCookie("state_token");
        $.cookie("state_token", state);
    }
    var naver = NaverAuthorize({
        client_id : "nK74XgYvuNWrOdiP4VaI",
        client_secret : "4Qz4xemPcA",
        redirect_uri : "http://www.seoulup.or.kr"
    }); 


     function loginNaver() {
        var state = generateState();
        saveState(state);
        naver.login(state);
        state = "ok";
    }

    $("#NaverIdLoginBTN").click( function () {
        var state = generateState();
        saveState(state);
        naver.login(state);
    });
    window.onload=function(){
 // callback이 오면 checkLoginState()함수를 호출한다.
        checkLoginState();
    }
    var tokenInfo = { access_token:"" , refresh_token:"" };
    function checkLoginState() {
    var state = $.cookie("state_token");
    if(naver.checkAuthorizeState(state) === "connected") {
        //정상적으로 Callback정보가 전달되었을 경우 Access Token발급 요청 수행
        naver.getAccessToken(function(data) {

            var response = data._response.responseJSON;
            if(response.error === "fail") {
                //access token 생성 요청이 실패하였을 경우에 대한 처리
                return ;
            }
            tokenInfo.access_token = response.access_token;
            tokenInfo.refresh_token = response.refresh_token;

            //sonsole.log에 나온다.
            console.log("success to get access token", response);
        });
    } else {
        //Callback으로 전달된 데이터가 정상적이지 않을 경우에 대한 처리
        return ;
    }
}
	$(function() {
		if(state=='ok'){
			console.log("성");
		}else{
			/* if ("${message}" != "") {
				alert("${message}");
			} */
		}
		
	});

	function actionLogin() {
		if (document.loginForm.id.value == "") {
			alert("<spring:message code="comUatUia.validate.idCheck" />");

	} else if (document.loginForm.password.value == "") {
			alert("<spring:message code="comUatUia.validate.passCheck" />");

	} else {
			//var prevUrl = document.referrer;
			//alert(prevUrl);
			saveid(document.loginForm);
			document.loginForm.action = "<c:url value='/uat/uia/actionLogin.do'/>";
			//document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
			//document.loginForm.action="<c:url value='/j_spring_security_check'/>";
			document.loginForm.submit();
		//	window.location = prevUrl;
			
		}
	}
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
		getid(document.loginForm);
		document.loginForm.userSe.value = "GNR";
	}


	function enterkey() {
        if (window.event.keyCode == 13) { 
             actionLogin();
        }
}

</script>
<link rel="stylesheet" href="/css/SUP_Login.css">

<div id="login_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<article class="login">
			<div class="content_h3bx">
				<h3>로그인</h3>
			</div>

			<!-- login영역 -->
			<form name="loginForm" id="loginForm"
				action="<c:url value='/uat/uia/actionLogin.do'/>" method="post" onkeyup="enterkey();">
				<input type="hidden" id="message" name="message"
					value="<c:out value='${message}'/>">

				<fieldset class="login_form">


					<div class="login_input">
						<ul>
							<!-- 아이디 -->
							<!--<c:set var="title">아이디</c:set>-->
							<li class="loginbx_id"><label for="id">아이디</label> <input
								type="text" name="id" id="id" maxlength="12"
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
									<li><a
										href="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>">아이디/비밀번호
											찾기</a></li>
									<!-- 아이디/비밀번호 찾기 -->

									<li><a
										href="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>">회원가입</a></li>
									<!-- 회원가입  -->
								</ul>
							</li>
							<li><input type="button" class="btn_login" value="로그인"
								onClick="actionLogin()"> <!-- 로그인  --></li>
						</ul>
						
 
					<%-- <div style="text-align:center;background:#2db400;padding:10px 0;margin-top:17px;">
						    <a href="${url}" style="color:#fff;">네이버로 로그인하기</a>
						    <div style="text-align:center">${result}</div> --%>
						</div>
					</div>

				</fieldset>

				<input name="userSe" type="hidden" value="GNR" /> <input name="j_username" type="hidden" />
				<input name="reurl" type="hidden" value="${reurl}" />
			</form>

		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

<!-- login영역 //-->

