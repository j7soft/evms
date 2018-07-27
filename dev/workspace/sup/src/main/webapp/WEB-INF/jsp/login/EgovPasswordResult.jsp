<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/jquery.bxslider.css">
<link rel="stylesheet" href="/css/SUP_Login.css">
<script type="text/javascript">
	$(function(){
		$("#pw").click(function(){
			location.href="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>"; 
		});
		$("#login").click(function(){
			location.href='/loginUsr.do'; 
		});
	})
</script>
<!--  Main section 영역  -->
    <section id="section">
        <div class="sub_bg"><h3>서브메인 이미지</h3></div>
        <article class="login fint_pw">
            <div class="content_h3bx">
                <h3>비밀번호 찾기</h3>
            </div>
            <div class="find_result">
                <div class="result_pw clear">
					<div style="text-align: center;">${resultInfo}</div>              
                </div>
                <div class="result_btn">
                    <button id="login">로그인</button>
                </div>
            </div>
        </article>
    </section>
    <!--  //Main section 영역  -->
   