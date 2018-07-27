<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
	$(function(){
		document.idForm.userSe.value = "GNR";
	});
	function fnSearchId() {
		if (document.idForm.name.value == "") {
			alert("<spring:message code="comUatUia.idPw.validate.name" />");
		} else if (document.idForm.email.value == "") {
			alert("<spring:message code="comUatUia.idPw.validate.email" />");
		} else {
			document.idForm.submit();
		}
	}

	function fnSearchPassword() {
		if (document.passwordForm.id.value == "") {
			alert("<spring:message code="comUatUia.idPw.validate.id" />");
		} else if (document.passwordForm.name.value == "") {
			alert("<spring:message code="comUatUia.idPw.validate.name" />");
		} else if (document.passwordForm.email.value == "") {
			alert("<spring:message code="comUatUia.idPw.validate.email" />");
		}else {
			document.passwordForm.submit();
		}
	} 

</script>
<link rel="stylesheet" href="/css/SUP_Login.css">
<div id="login_wrap">
	<!--  Main section 영역  -->
	<section id="section">
		<div class="sub_bg">
			<h3>서브메인 이미지</h3>
		</div>
		<article class="login id_pw">
			<div class="content_h3bx">
				<h3>아이디 찾기/비밀번호 찾기</h3>
			</div>
			<div class="IdPassword clear">
				<form name="idForm" action="<c:url value='/uat/uia/searchId.do'/>"
					method="post">
					<div class="leftBox">
						<div class="leftBox01">
							<h3>아이디 찾기</h3>
							<ul>
								<li class="name"><label for="name">이름</label> <input
									id='name' type="text" name="name" maxlength="20"
									placeholder="이름을 입력해주세요."></li>

								<li class="e_mail"><label for="email">이메일주소</label> <input
									id='email' type="text" name="email" maxlength="30"
									placeholder="이메일 주소를 입력해주세요."></li>
							</ul>
							<div class="btn">
								<input type="button" class="btn_login" onClick="fnSearchId();"
									value="아이디 찾기" /> <input name="userSe" type="hidden"
									value="GNR">
							</div>
						</div>
					</div>
				</form>
				<form name="passwordForm"
					action="<c:url value='/uat/uia/searchPassword.do'/>" method="post">
					<div class="rightBox clear">
						<div class="rightBox01">
							<h3>비밀번호 찾기</h3>
							<ul>
								<li class="id"><label for="id1">아이디</label><input id='id1'
									type="text" name="id" maxlength="15" title=""
									placeholder="아이디를 입력해주세요." /></li>
								<li class="name"><label for="name1">이름</label> <input
									id='name1' type="text" name="name" maxlength="20" title=""
									placeholder="이름을 입력해주세요." /></li>
								<li class="e_mail"><label for="e_mail1">이메일주소</label><input
									id='e_mail1' type="text" name="email" maxlength="30" title=""
									placeholder="이메일을 입력해주세요." /></li>
							</ul>
							<div class="btn">
								<input type="button" class="btn_login"
									onClick="fnSearchPassword();" value="비밀번호 찾기"> <input
									name="userSe" type="hidden" value="GNR">
							</div>
						</div>
					</div>
				</form>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

