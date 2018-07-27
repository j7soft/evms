<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set value="${fn:split(vo.PRICE,',') }" var="price"/>
<c:set value="${vo.CNT - vo.RDCNT}" var="pbCnt"/>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
<link rel="stylesheet" href="/css/sliderstyle.css">
<style>
	.request_area .edu_explain{border:none;height:250px;}
</style>
<script type="text/javascript" >
	$(function(){
		/* console.log("${vo.FTIME}");
		console.log("${vo.STIME}");
		console.log("${vo.FDATE}"); */
$("#btn_h").click(function(){
			var loginId = '${loginVO.id}'
			if(loginId == ""){
				location.href='/loginUsr.do';
				return false;
			}else if($('#TEAMNAME').val() == ""){
				alert("기관명을 입력해주세요.")
				return false;
			}else if($('#CAPTAINNAME').val() == ""){
				alert("담당부서를 입력해주세요.");
				return false;
			}else if($("#bb").val() == "" || $("#ss").val() == ""){
				alert("인원을 입력해주세요.")
				return false;
			}else if(!$("#da").prop("checked")){
				alert("동의가 필요합니다.");
				return false;
			}else{
				var rcnt = parseInt($("#bb").val()) + parseInt($("#ss").val());
				if (rcnt == "" ){
					alert("인원을 입력해주세요");
					return false;
				}else if(rcnt > "${pbCnt}"){
					alert("인원을 초과하였습니다.\n"
					     +"현재접수인원 :${vo.RDCNT}\n"
					     +"접수가능인원 :${pbCnt}");
					return false;
				}
				
				console.log($("#NAME").val());
				console.log($("#CHARGE_TEL").val());
				console.log($("#EMAIL").val());
				console.log($("#TEAMNAME").val());
				console.log($("#CAPTAINNAME").val());
				$("#CNT").val($("#bb").val()+","+$("#ss").val());
				$("#PRICE").val((parseInt("${price[0]}")*$("#bb").val())+","+(parseInt("${price[1]}")*$("#ss").val()));
				$("#frm").attr({
					"method":"post",
					"action":"/bookinsert2.do"
				});
				
				$("#frm").submit();
				
			}
			
			
		});


	/*	$("#btn_h").click(function(){
		var loginId = '${loginVO.id}'
			if(loginId == ""){
				location.href='/loginUsr.do';
				return false;
			}else if($('#bb').val() == 0 && $('#ss').val() == 0){
				alert('인원을 선택해 주세요.');
				return false;
			
			}else if(!$("#da").prop("checked")){
				alert("동의가 필요합니다.");
				return false;
			}else{
				console.log($("#NAME").val());
				console.log($("#CHARGE_TEL").val());
				console.log($("#EMAIL").val());
				console.log($("#TEAMNAME").val());
				console.log($("#CAPTAINNAME").val());
				$("#CNT").val($("#bb").val()+","+$("#ss").val());
				$("#PRICE").val((parseInt("${price[0]}")*$("#bb").val())+","+(parseInt("${price[1]}")*$("#ss").val()));
				$("#frm").attr({
					"method":"post",
					"action":"/bookinsert2.do"
				});
				
				$("#frm").submit();
				
			}
			
			
		});
		*/
		$("#bb").change(function(){
			changePrice();
		});

		$("#ss").change(function(){
			changePrice();
		});
		function changePrice(){
			$("#PRICEBB").val(parseInt("${price[0]}")*$("#bb").val());
			$("#PRICESS").val(parseInt("${price[1]}")*$("#ss").val());
			//$("#PRICE").val((parseInt("${price[0]}")*$("#bb").val())+(parseInt("${price[1]}")*$("#ss").val())); 합계
		}
		
	});
</script>
<style>
#map {
	height: 400px;
	width: 100%;
}
</style>
 <div id="reserve_wrap">
  <form id="frm" name="frm"  >
    <!--  Main section 영역  -->
    <section id="section">
        <article class="reservation education">
            <div class="content_h3bx">
                <h3>${type }</h3>
                <ul class="route">
	                <li>홈</li>
	                <li>대관  및  예약</li>
	                <li>교육 예약</li>
	            </ul>
            </div>
            <input type="hidden" id="NTT_ID" name="NTT_ID" value="${vo.NTT_ID }" />
            <input type="hidden" id="NTT_NO" name="NTT_NO" value="${vo.BBS_ID }" />
            <input type="hidden" id="FDATE" name="FDATE" value="${vo.FDATE }" />
            <input type="hidden" id="FTIME" name="FTIME" value="${vo.FTIME }" />
            <input type="hidden" id="STIME"  name="STIME" value="${vo.STIME }" />
            <input type="hidden" id="TITLE"  name="TITLE" value="${vo.TITLE }" />
            <input type="hidden" id = "MBER_ID"  name="MBER_ID" value="${lvo.id }" />
            <input type="hidden" id = "CNT"  name="CNT" value="" />
            <input type="hidden" id = "PRICE"  name="PRICE" value="" />
            <div class="request_area">
                <h4>${vo.TITLE }</h4>
                <p class="edu_summary">${vo.SIMPLECONTENT }</p>
                <ul class="edu_date">
                  <li>${vo.FDATE }</li>
                  <li>${vo.FTIME } ~ ${vo.STIME }</li>
                  <li>${vo.POSITION}</li>
                  <!--<li>성인 ${price[0] }원 / 아동 ${price[1] }원</li>-->
                </ul>
                <!-- <div class="edu_explain">${vo.CONTENT }</div> -->
                <textarea rows="" cols="" id="" name="CONTENT" class="edu_explain" readonly style="width:100%;">${vo.CONTENT }</textarea>
                <div class="edu_location clear">
                
                    <div class="edu_map_explain">
                    	<h3>서울새활용플라자 위치</h3>
                    	<p>주소 : 서울특별시 성동구 용답동 249-35<br>
                     	 도로명 : 서울특별시 성동구 자동차시장길 49</p>
                    </div>
                </div>
                <div class="">
                    <div class="topBox clear">
					<h1 style="font-size:2.125rem">신청하기</h1>
					<span class="h1_css"></span>
					<div class="input_hr input_hr_2">
							<ul>
								<li>
									<h2>성명</h2>
									<div>
										<input type="text" name="NAME" id="NAME" value="${lvo.name }" placeholder="">
									</div>
								</li>
								<li>
									<h2>연락처</h2>
									<div>
										<input type="text" name="CHARGE_TEL" id="CHARGE_TEL" value="${lvo.tel }" placeholder="">
									</div>
								</li>
								<li> 
									<h2>이메일</h2>
									<div>
										<input type="text" name="EMAIL" id="EMAIL" value="${lvo.email }" placeholder="">
									</div>
								</li>
								<li>
									<h2>기관</h2>
									<div>
										<input type="text" name="TEAMNAME" id="TEAMNAME" placeholder="기관/단체/회사명, 개인은 신청자명">
									</div>
								</li>
								<li>
									<h2>담당부서</h2>
									<div>
										<input type="text" name="CAPTAINNAME" id="CAPTAINNAME" placeholder="">
									</div>
								</li>
								<li>
									<h2>인원</h2>
									<div>
										<input type="number" name="bb" id="bb" placeholder="성인인원을 입력하세요.">
										<input type="number" name="ss" id="ss" placeholder="아동인원을 입력하세요." style="margin-top: 10px;">
									</div>
								</li>
							<!--	<li>
									<h2>금액</h2>
									<div>
										<input type="text" name="PRICEBB" id="PRICEBB" placeholder="" readonly >
										<input type="text" name="PRICESS" id="PRICESS" placeholder="" readonly >
									</div>
								</li>-->
								<li class="radio_box_hr">
									<ul>
										<li>
											<input type="checkbox" name="da" id="da">
											<label for="da">개인정보 이용동의 <a><strong onclick="javascript:document.getElementById('wrap_agree').style.display='block';" style="cursor:pointer;">개인정보 이용약관</strong></a></label>
										</li>
									</ul>     
								</li>						
							</ul>
	
					</div>
					<div id = "btn_h"class="btn_h">
				        <button>신청하기</button>
			        </div>
				</div>

            </div>
        </article>
    </section>	
	 <!--  //Main section 영역  -->
    
        </form>
    </div>

	<script src="/js/jquery.bxslider.min.js"></script>
	<script src="/js/index.js"></script>