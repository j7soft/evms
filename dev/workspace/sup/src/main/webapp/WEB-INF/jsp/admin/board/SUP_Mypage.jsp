<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Login.css">
<link rel="stylesheet" href="/css/SUP_Backoffice.css">
</style>
<script type="text/javascript">
	$(function() {
		$("#infoOkBtn").attr("hidden", true);

		$("#infoChangeBtn").click(function() {
			var ck = "";
			$("#infoChangeBtn").attr("hidden", true);
			$("#infoOkBtn").attr("hidden", false);
			$(".re").attr("readonly", false);
			$(".rpa").focus(function() {
				$(this).val("");
			});
		});
		$("#infoOkBtn").click(function() {
			if (1 != 1) {

			}else if(!checkForm($("#t1"),"비밀번호를" )){
				return;
			}else if(!checkForm($("#t2"),"비밀번호 확인란을" )){
				return;
			}else if(!checkForm($("#t3"),"전화번호를" )){
				return;
			}else if(!checkForm($("#t4"),"이메일을" )){
				return;
			}else if($("#t1").val()!=$("#t2").val()){
				alert("비밀번호, 비밀번호 확인란의 비밀번호가 같지 않습니다.");
				return;
			}else {
				$("#infoChangeBtn").attr("hidden", false);
				$("#infoOkBtn").attr("hidden", true);
				$("#lfrm").attr({
					"method" : "post",
					"action" : "/amdin/infoUpdate.do"
				});
				$("#lfrm").submit();

			}

		});

	});
</script>
<div id="mypage_wrap">
	<!--  Main section 영역  -->
	<section class="width625">
		<article class="mypage">
			<div class="title_box">
				<h3>회원 정보</h3>
			</div>
			<div class="content_h3bx2">
				
				<div class="tab_box tab_box1">

					<form id="lfrm" name="lfrm">
						<ul>
							<li class="clear"><p>아이디</p> <input type="text" 
								name="id" value="${lvo.id }" readonly="no"></li>
							<li class="clear"><p>성명</p> <input type="text" 
								name="name" value="${lvo.name }" readonly="readonly"></li>
							<li class="clear"><p>비밀번호</p> <input type="password" id="t1"
								class="re rpa" name="password" value="${lvo.password }"
								readonly="readonly"></li>
							<li class="clear"><p>비밀번호 확인</p> <input type="password"
								id="t2" class="re rpa" name="" value="${lvo.password }"
								readonly="readonly"></li>
							<li class="clear"><p>전화번호</p> <input type="text" id="t3"
								class="re" name="tel" value="${lvo.tel }" readonly="readonly"></li>
							<li class="clear"><p>이메일</p> <input type="text" id="t4"
								class="re" name="email" value="${lvo.email }"
								readonly="readonly"></li>
							<li class="clear"><p>가입일시</p> <input type="text" id="t5"
								class="re" name="RDATE" value="${lvo.RDATE }"
								readonly="readonly"></li>
						</ul>
						<!-- <button id="infoChangeBtn" type="button">변경</button>
						<button id="infoOkBtn" type="button">완료</button> -->
					</form>
				</div>
			</div>
		</article>
	</section>
	<!--  //Main section 영역  -->
</div>
<script>
	$(document).ready(function() {
		var cnt = 7;
		$('.tab_box1').show();
		$('.tab1').addClass('tabOn');

		$('.tab').each(function(index) {
			$(this).click(function() {
				$(".tab_box").hide();
				$(".tab_box:eq(" + index + ")").show();

				for (var i = 0; i <= cnt; i++) {
					$('.tab' + i).removeClass('tabOn');
				}
				$(this).addClass('tabOn');
			});
		});
	});
</script>