<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신 버전의 방식으로 HTML 보여주도록 설정.-->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<!--viewport : 화면에 보이는 영역을 제어하는 기술. width는 device-width로 설정. initial-scale는 초기비율-->
<!-- 모바일 웹 페이지 설정 -->
<title>행사관리시스템</title>
<!-- 모바일 웹 페이지 설정 끝 -->
<!--IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. http://code.google.com/-->
<!--[if lt IE 9]>
    	 	<script src="/resources/include/js/html5shiv.js"></script>
<![endif]-->

<link rel="stylesheet" href="/css/font-awesome.css">
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/jquery.bxslider.css">
<link rel="stylesheet" href="/css/sliderstyle.css">
<script src="/js/jquery-1.12.4.min.js"></script>

<script src="/js/chk.js"></script>


</head>
<body>
	<div id="main_wrap">
		<!--  Header 영역  -->
		<header>
			<tiles:insertAttribute name="header" />
		</header>
		<section>
			<tiles:insertAttribute name="body" />
		</section>
		<section>
			<tiles:insertAttribute name="footer" />
		</section>
		<div class="top_btn">
			<a>
				<img src="/img/common/topicon.png" alt="탑 버튼">
			</a>
		</div>
		<div id="popup" class="email_popup">
				<div class="popup_bg"></div>
				<div class="popup_body">
					<div class="popup_title">
					이메일무단수집거부
					<p class="close_btn" onClick="javascript:document.getElementById('popup').style.display='none';">
						<span></span>
						<span></span>
					</p>
					</div>
					<div class="popup_content">
						<div class="img_box">
							<img src="/img/common/email_icon.png" alt="이메일 아이콘">
						</div>
					<p>행사관리시스템 홈페이지에 게시된 이메일 주소가 전자우편 수집<br>
					프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하여<br>
					이를 위반 시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.</p>
					</div>
				</div>
			</div>
		</div>
		<div id="wrap_agree" class="wrap_agree_pop" style="display:none;">
			<div class="agree_bg"></div>
			<div class="agreePop">
			<div class="closeBtnDiv" onclick="javascript:document.getElementById('wrap_agree').style.display='none';">
				<div></div>
				<div></div>
			</div>
			<h3>개인정보 수집 및 이용 동의</h3>
			<p class="numbering">1.</p><p>수집항목 : [필수] 성명, 소속(학교), 직책(학년), 기타사항, 연락처, 이메일</p>
			<p class="numbering">2.</p><p>수집 및 이용목적 : 회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존</p>
			<p class="numbering">3.</p><p>보관기간<br>
				<span>- 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관</span>
				<span>- 단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등 관련 법령에 의하여 일정 기간 보관이 필요한 경우에는 해당 기간 동안 보관함</span>
			</p>
			<p class="numbering">4.</p><p>동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.</p>
			<p class="numbering">5.</p><p>사진 촬영에 대한 고지 : 본인(갑)은 행사주관기관(을)의 모든 사진 촬영에 대해 동의하며, 촬영된 사진(들)을 사용할 모든 권리를  행사주관기관에게 허가합니다.<br>
				이에 따라 갑은 촬영자나 촬영된 사진을 소유한 사진가 또는 단체에 어떤 매체(인터넷, 신문, 잡지  기타 매체 등)에 글, 그림 또는 전체나 일부로 사용되는 것과 같은, 사용 및 배포 방법이나 형태,
				 그리고 국적에 관계없이, 사진(들)을 사용할 권리(소유 및 저작, 판권 등을 포함한다.) 일체를 을에게 부여합니다.<br>
				본인(갑)은 또한 이 사진(들)의 판권 및 소유권을 주장하지 않는다는 점에 대해 동의하며 상기 조항에 의거, 모든 소유권 및 저작 및 판권 등이 행사 주관기관에게 있음을 인정합니다.<br>
				또한, 갑은 인화된 상태의 사진 또는 네거티브, 포지티브, 사진파일과 같은 기타 디지털 저장매체 등에 대해서도 을 또는 을이 속해 있는 개인 또는 단체, 기구의 재산 또는 인쇄매체 및 언론매체 등에 귀속될 수 있다는 점에 대해서도 동의합니	다.<br>
				갑은 위의 내용에 따라 추후 초상권과 관련하여, 행사주관기관(을) 또는 을이 속해 있는 단체, 기구 또는 인쇄매체 및 언론매체를 상대로 일체의 소송을 제기하지 않을 것이며 이에 대해서도 동의합니다.<br>
			</p>
			<h3>개인정보 제3자 제공 동의</h3>
				<p class="numbering">1.</p><p>개인정보를 제공받는 자 : 행사주관기관</p>
				<p class="numbering">2.</p><p>제공하는 개인정보 항목 : [필수] 성명, 소속(학교), 직책(학년), 기타사항, 연락처, 이메일</p>
				<p class="numbering">3.</p><p>개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 서비스 분석과 통계에 따른 혜택 및 맞춤 서비스 제공, 민원처리 등 고객상담, 고객관리, 서비스 이용에 따른 설문조사 및 혜택 제공, 분쟁조정을 위한 기록보존</p>
				<p class="numbering">4.</p><p>개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 회원탈퇴 시 또는 위 개인정보 이용목적 달성 시 까지 이용합니다.</p>
				<p class="numbering">5.</p><p>동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.</p>
		</div></div>
		<div id="rentPopWrap">
			<div class="content_Pop">
			<div class="rentPopcloseBtnDiv" onclick="javascript:document.getElementById('rentPopWrap').style.display='none';">
				<div></div>
				<div></div>
			</div>
				<h4>행사신청 안내 사항</h4><br>
				<p>1. 현재 진행중인 행사 화면에서 참가하려는 행사를 선택합니다.</p>
				<p>2. 행사에 참여하고자 하는 경우 참가신청 버튼을 클릭합니다.</p>
				<p>3. 참가비 결제 화면에서 결제관련 사항을 입력합니다.</p>
				<p>4. 결제 가능한 수단은 카드결제, 온라인계좌이체, 무통장입금 등입니다. </p>
				<p>5. 결제 도중 장애가 발생한 경우 안내된 연락처로 문의하시기 바랍니다. </p>
				<p>6. 결제 완료된 참가신청 건을 취소하는 경우 취소 수수료가 발생할 수 있으면 자세한 사항은 관련 약관을 참고하시기 바랍니다.</p>
				<div class="btn">
					<p class="reserv_btn reservBtn" data-num='${rentlist[i.index].BBS_ID }'>
										신청하기
					</p>
				</div>
			</div>
		</div>
		

<style>
	#rentPopWrap{position:fixed;width:100%;height:100%;background:rgba(0,0,0,0.5);top:0;left:0;z-index:999;display:none;}
	.content_Pop{position:absolute;background:#fff;width:50%;height:600px;overflow-y:auto;top:calc(35% - 200px);transform:translateX(-50%);left:50%;padding:1%;}
	.content_Pop h4{font-size:1.2em;font-weight:600;}
	p.reserv_btn.reservBtn{box-sizing: border-box; margin:50px auto 0; text-align: center; width: 300px; height: 60px; line-height: 58px; border: 1px solid #63b746; color: #63b746; font-size: 1.188rem; cursor: pointer;-webkit-transition: all .5s ease; -moz-transition: all .5s ease; -o-transition: all .5s ease; transition: all .5s ease;}
	p.reserv_btn.reservBtn:hover{background: #63b746; color: #fff; border-color: #63b746;}
	.rentPopcloseBtnDiv{width:30px;float:right;cursor:pointer;position:relative;}
	.rentPopcloseBtnDiv>div{width:3px;height:20px;background:#b3b3b3;transform:rotate(45deg);position:absolute;top:0;left:0;}
	.rentPopcloseBtnDiv>div:last-of-type{transform:rotate(-45deg);}

	@media (max-width: 1600px){
	.content_Pop{width:70%;height:430px;margin-top:100px;}
	}
	@media (max-width: 1300px){
	.content_Pop{width:80%;padding:20px;}
	}
	@media (max-width: 600px){
	p.reserv_btn.reservBtn{width:100%;}
	.rentPopcloseBtnDiv{margin-right:-4%;}
	#rentPopWrap p{font-size:14px;}
	}
	
</style>

<script>
		$(".reservBtn").click(function() {
		//if (1 != 1) 
		//alert('${loginVO.id}')
		var loginId = '${loginVO.id}'
		if (loginId == "") {
			location.href='/loginUsr.do';
		} else {
			location.href="bookinsert.do?NTT_ID=rent&BBS_ID="+$(this).attr("data-num");

		}
	
	});

</script>
</body>
</html>