
<%
	/**
	 * @Class Name : EgovIdPasswordSearch.jsp
	 * @Description : 아이디/비밀번호 찾기 화면
	 * @Modification Information
	 * @
	 * @  수정일             수정자                   수정내용
	 * @ -------    --------    ---------------------------
	 * @ 2009.03.09    박지욱          최초 생성
	 *   2016.06.13   김연호              표준프레임워크 v3.6 개선
	 *  @author 공통서비스팀
	 *  @since 2009.03.09
	 *  @version 1.0
	 *  @see
	 *
	 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
	function fnCheckUsrId(userSe) {
	}

	function fnCheckUsrPassword(userSe) {
	}

	function fnSearchId() {
	}

	function fnSearchPassword() {
	}
</script>
<div class="login_wrap">
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
				<div class="leftBox">
					<div class="leftBox01">
						<h3>아이디 찾기</h3>
						<form name="idForm" action="<c:url value='/uat/uia/searchId.do'/>"
							method="post">
							<ul>
								<li class="name"><label for="name">이름</label> <input
									type="text" name="name" maxlength="20" placeholder="" /></li>
								<li class="e_mail"><label for="e-mail">이메일주소</label> <input
									type="text" name="email" maxlength="30" placeholder="" />
							</ul>

							<div class="btn">
								<button type="button">아이디 찾기</button>
							</div>
							<input name="userSe" type="hidden" value="GNR">
						</form>
					</div>
				</div>
				<div class="rightBox clear">
					<div class="rightBox01">
						<h3>비밀번호 찾기</h3>
						<form name="passwordForm"
							action="<c:url value='/uat/uia/searchPassword.do'/>"
							method="post">
							<ul>
								<li class="id"><label for="id">아이디</label><input
									type="text" name="id" maxlength="15" title="" placeholder="" /></li>
								<li class="name"><label for="name">이름</label> <input
									type="text" name="name" maxlength="20" title="" placeholder="" /></li>
								<li class="e_mail"><label for="e_mail">이메일주소</label><input
									type="text" name="email" maxlength="30" title="" placeholder="" /></li>
							</ul>
							<div class="btn">
								<input type="button" class="btn_login" onClick="fnSearchId();"
									value="" />
							</div>
							<input name="userSe" type="hidden" value="GNR">
						</form>
					</div>
				</div>
				</form>
			</div>
			<input name="userSe" type="hidden" value="GNR">
			</form>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>

