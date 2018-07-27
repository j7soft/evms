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
<meta name="robots" content="index,nofollow"/>
<!--viewport : 화면에 보이는 영역을 제어하는 기술. width는 device-width로 설정. initial-scale는 초기비율-->
<!-- 모바일 웹 페이지 설정 -->
<script>
	function protectAdmin(){
		var url = window.location.href;
		if(url.indexOf('/admin')){
			//alert('1');
			var loginId = '${loginVO.id}'
				if (loginId == "") {
					location.href='/loginUsr.do';
				}
		}
	};
	protectAdmin()
</script>
<title>서울 새활용 플라자 관리자</title>
<!-- 모바일 웹 페이지 설정 끝 -->
<!--IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. http://code.google.com/-->
<!--[if lt IE 9]>
    	 	<script src="/resources/include/js/html5shiv.js"></script>
		<![endif]-->

<script src="/js/chk.js"></script>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>"></script>
<style>
    html, body{height:100%;}
    .adminNav{float:left;display:inline-block;height:100%;position:fixed;/*overflow-y:scroll*/;}
    .adminNav>nav{height:100%;}
    section.adminSection{width:1200px; float:left;margin-top:75px;margin-left:500px;padding-bottom:150px;}
</style>
</head>
<body>
<div style="overflow:hidden;overflow-x:auto;">
	<nav class="adminNav">
		<tiles:insertAttribute name="nav" />
	</nav>
	<section class="adminSection">
		<tiles:insertAttribute name="body" />
	</section>
	<style>
        #lnb ul li{font-size:14px;}
        #lnb ul{margin-bottom:10px;}
        .pagenation button{width:auto;}
        .pagenation button:hover{color:#63b746;}
    
    </style>
</div>
</body>
</html>