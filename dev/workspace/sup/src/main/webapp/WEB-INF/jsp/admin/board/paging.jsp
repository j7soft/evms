<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pagenation" align="center">
    <a href="javascript:goPage(${param.firstPageNo})" class="first">&lt;</a>
    <a href="javascript:goPage(${param.prevPageNo})" class="prev">&lt;&lt;</a>
    <span>
        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="javascript:goPage(${i})" class="choice">${i}</a></c:when>
                <c:otherwise><a href="javascript:goPage(${i})">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <a href="javascript:goPage(${param.nextPageNo})" class="next">&gt;</a>
    <a href="javascript:goPage(${param.finalPageNo})" class="last">&gt;&gt;</a>
</div>