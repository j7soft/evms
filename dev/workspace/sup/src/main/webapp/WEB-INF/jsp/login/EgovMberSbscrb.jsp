<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Login.css">
<style>
    span.aa{color:red;float:left;}
    .signup2 .form_box li input{width:65%;}
    
    
</style>
<script type="text/javaScript">
	var idck = 1;

	$(function() {
		$("#btn").click(function() {
			var form = document.mberManageVO;
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			var regPhone = /^((01[0|1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
			//var $email = document.mberEmailAdres;

			//  console.log(form.password);
			console.log("11111");
			if ($("#id").val() == null || $("#id").val() == '') {
				alert("아이디를 입력해 주세요.");		
			}else if(form.mberId.value.length < 4 || form.mberId.value.length > 12 ){
				alert("아이디는 최소 4글자 최대 12글자입니다.");
			}else if (idck == 1) {
				alert("아이디 중복확인을 해주세요.");
				return;
			}else if(form.password.value.length < 4 || form.password.value.length > 12){
				alert("비밀번호는 최소 4글자 최대 12글자입니다.");
				return false;
			}else if($('#password2').val() == ""){
				alert("비밀번호확인을 입력해주세요.");
				return false;
			}else if(form.password.value != form.password2.value){
				alert("비밀번호와 비밀번호 확인이 다릅니다.");
				return false;
			}else if(form.mberNm.value == ""){
				alert("이름을 입력해주세요.");
				return false;
			} else if(form.mberEmailAdres.value == ""){
				alert("이메일을 입력해주세요.");
				return false;
			}else if(!regEmail.test(form.mberEmailAdres.value)) {
	            alert('이메일 주소가 유효하지 않습니다');
			    return false;

			}else if(!regPhone.test(form.moblphonNo.value)) {
	            alert('입력하신 전화번호가 유효하지 않습니다');
			    return false;

			}else if (confirm("<spring:message code="common.regist.msg" />")) {			
				if (form.password.value != form.password2.value) {
					alert("<spring:message code="fail.user.passwordUpdate2" />");
					return;
				} else {
					form.submit();
				}
			}
			
			
			
			
		});
		$("#id").focus(function() {
			$("#id").val("");
			$("#span").html("");
			$("#span").css("color", "black");
			idck = 1;
		});
		
		
		$( "#password2" ).change(function() {
			var form = document.mberManageVO;
			if(form.password.value != form.password2.value){
			  alert( "비밀번호와 비밀번호 확인이 다릅니다." );}
			});

		
		 function chk(){
			var tmp = document.getElementById('id').value;
			var tmp2 = /[a-z]|[0-9]/gi; // 정규식 - 알파벳과 숫자만 지정
			tmp = tmp.replace(tmp2, ''); // 지정한 정규식에서 알파벳과 숫자만 공백으로 바꾼다
			if(tmp != ''){
				alert('영문과 숫자만 입력이 가능합니다.');
			 }
		}

		$("input[name=mberId]").keyup(function(event){ 
			chk();
		});

/*
		 function checkEmail(email) {
     //var regExp = /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;   // 이메일 체크 ( id1.id2@test.com 대응불가 )
      var regExp = /^[-!#$%&'*+./0-9=?A-Z^_a-z{|}~]+@[-!#$%&'*+/0-9=?A-Z^_a-z{|}~]+.[-!#$%&'*+./0-9=?A-Z^_a-z{|}~]+$/;
		 if(regExp.test(email)) { // test 는 정규 Methods 입니다. test는 변경없음
        return true;
      } else {
        return false;
      }
    }
		$("input[name='mberEmailAdres']").blur(function(){
			  var email = $(this).val();
		  // 이메일 유효성 검사
		   if(! checkEmail(email) ) {
				    alert('잘못된 형식의 이메일 주소입니다.');
					$(this).focus();
					return false;
					
			  }
		});
*/

		$("#btnMbrId").click(
				function() {
					if ($("#id").val() == null || $("#id").val() == '') {
						alert("아이디를 입력해 주세요.");
					} else if($("#id").val().length < 4 || $("#id").val().length > 12){
						alert("아이디는 4글자 이상 12글자 이하여야합니다.");
						return false;
					
					}else {
						$.ajax({
							type : "POST",
							url : "/uss/umt/EgovIdDplctCnfirmAjax.do",
							data : "id=" + $("#id").val(),
							success : function(result) {
								console.log(result);
								if (result == "ok") {
									$("#span").html("사용 가능한 아이디입니다.")
									idck = 0;
									$("#id").prop("readonly");
								} else {
									$("#span").html("사용 불가한 아이디입니다.").css(
											"color", "red");
									idck = 1;
								}
							}
						});
					}
				});
	});
</script>

<section id="section">
<article class="login signup2">
		<div class="content_h3bx">
			<h3>회원가입</h3>
		</div>

		<form action="/uss/umt/EgovMberSbscrb.do" name="mberManageVO"
			method="post">
			<div class="form_box">
				<ul>
					<!-- 회원구분 -->
					<li>
						<span class="aa">*</span><p>회원구분</p> 
			            <input type="radio" name="mberType" value="1" checked>개인
			            <input type="radio" name="mberType" value="2">회사
			        </li>						
					<li>
						<span class="aa">*</span><p>아이디</p><input id='id' type="text" name="mberId" placeholder="최소 4글자 최대12글자">
						<button type="button" id="btnMbrId" class="btn_s2">중복확인</button> <span id="span"></span>
					</li>
					<li>
						<span class="aa">*</span><p>비밀번호</p> <input type="password" name="password" placeholder="최소 4글자 최대12글자">
					</li>
					<li>
						<span class="aa">*</span><p>비밀번호 확인</p> <input type="password" id="password2" name="password2" placeholder="비밀번호를 확인해주세요">
					</li>
					<li>
						<span class="aa">*</span><p>이름</p> <input type="text" name="mberNm" placeholder="이름을 입력해주세요">
					</li>
					<li>
						<p style="margin-left:8px;">연락처</p> <input type="tel" name="moblphonNo" placeholder="ex) 01000000000">
					</li>
					<li>
						<span class="aa">*</span><p>이메일</p> <input type="email" name="mberEmailAdres" placeholder="이메일을 입력해주세요">
					</li>
				</ul>

				<div class="btn">
					<input type="button" id='btn' class="s_submit" value="가입" />
				</div>
			</div>
		</form>
	</article>
</section>
<!--  //Main section 영역  -->
