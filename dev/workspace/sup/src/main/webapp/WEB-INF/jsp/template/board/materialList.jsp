<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Community.css">
<link rel="stylesheet" href="/css/SUP_Materials.css">


    <div id="materials_wrap">
    <section id="section">
        <article class="materials">
            <div class="content_h3bx">
                <h3>소재자료실</h3>
                <ul class="route">
                    <li>홈</li>
                    <li>소재정보</li>
                    <li>소재자료실</li>
                </ul>
            </div>
            <div class="text_meterials" style="color:#333;">
			<p style="text-align:center; margin-bottom:30px;font-size: 20px; font-weight: 600;">보유하신 소재의 판매(또는 무상기증) 의뢰 또는 필요하신 소재의 구매 의뢰는 아래 담당자에게 메일로 신청해 주시기 바랍니다. <br>※ 메일에 포함될 내용 :  구매 또는 판매 구분, 소재명, 소재량, 소재 요건, 거래조건, 담당자 연락처, 기타 남기실 말씀 등 </p>
			<p style="font-size:16px;"><span>*</span>소재 구매.판매 문의는 ( 담당자 연락처 정보 등 )으로 연락주시기 바랍니다.<br>
			<span>*</span>서울새활용플라자 소재은행 담당 : 02-2153-0426, ezra@seouldesign.or.kr</p>
</div>
            <div class="community_table">
                <table>
                    <colgroup>
                      <col width="11%">
                      <col width="63%">
                      <col width="13%">
                      <col width="13%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">순서</th>
                            <th scope="col">제목</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                      <c:forEach begin="0" items="${list }" varStatus="i">
		           
                        <tr onclick="location.href='/detail.do?NTT_ID=${list[i.index].NTT_ID }&BBS_ID=${list[i.index].BBS_ID }'">
                            <td>${i.index+1 }</td>
                            <td class="txt_align_left">${list[i.index].TITLE }</a></td>
                            <td>${list[i.index].PUSHDATE }</td>
                            <c:if test="${list[i.index].CNT=='' || empty list[i.index].CNT}">
										<td>0</td>
									</c:if>
									<c:if test="${list[i.index].CNT!='' || not empty list[i.index].CNT}">
										<td>${list[i.index].CNT }</td>
									</c:if>
                        </tr>
                       </c:forEach>
                    </tbody>
                </table>

              
              
              
              
              
            </div>
        </article>
    </section>
    
    </div>
    <script src="/js/jquery.bxslider.min.js"></script>

	<script src="/js/index.js"></script>