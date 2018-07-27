<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page trimDirectiveWhitespaces="true"%>
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
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />
<!-- 모바일 웹 페이지 설정 끝 -->
<!--IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다. http://code.google.com/-->
<!--[if lt IE 9]>
    	 	<script src="/resources/include/js/html5shiv.js"></script>
		<![endif]-->
<link rel="stylesheet" href="/resources/include/css/info.css">
<!-- 없어도 되는듯 -->
<title><tiles:getAsString name="title" /></title>
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="/resources/include/js/bootstrap.min.js"></script>
	
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<style type="text/css">
html, body {
	height: 100%;
	min-height: 100%;
	width: 100%;
}

body {
	background-color: #ecf0f1;
	color: #666;
	font-family: 'Lato', sans-serif;
	font-size: 16px;
	line-height: 1.5;
	min-height: 100%;
	position: relative;
}

.header {
	position: relative;
	/*  height: 100%; */
}

.blank {
	min-height: 50px;
}

.second_sec {
	background-color: #212121;
	color: #f0f0f0;
}

#checkInNow {
	margin-left: 152%;
	background-color: #c21616;
}
</style>



</head>
<body data-spy="scroll">
	<header class="header" id="header">
		<tiles:insertAttribute name="header" />
	</header>

	<section>
		<tiles:insertAttribute name="body" />
	</section>


</body>
</html>