<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/SUP_Reservation.css">
    <div id="reserve_wrap">
   
    <!--  Main section 영역  -->
    <section id="section">
        <article class="reservation Rent_3">
            <div class="content_h3bx">
                <h3>대관</h3>
                <ul class="route">
                    <li>홈</li>
                    <li>대관 및  예약</li>
                    <li>대관</li>
                </ul>
            </div>
                
                <div class="topBox clear">
                    <div class="Box1">
                        <p>2017.12.22</p>
                        <p>대관 장소</p>
                        <label for="" id="radio1">
                            <p><input type="radio" id="radio1" name="radio">미디어룸 (1층/ 81㎡ / 20명) 시간당 8,000원 (기본 3시간 24,000원)</p>
                        </label>
                        <label for="" id="radio2">
                            <p><input type="radio" id="radio2" name="radio">교육실 A (4층/ 142㎡ / 40명) 시간당 10,000원 (기본 3시간 30,000원)</p>
                        </label>
                        <label for="" id="radio3">
                            <p><input type="radio" id="radio3" name="radio">교육실 B (5층/ 205㎡ / 50~60명) 시간당 15,000원 (기본 3시간 45,000원)</p>
                        </label>
                    </div>
                    <div class="box2">
                        <ul>
                            <li><span>인원</span> <input type="text" placeholder="숫자를 기입해주세요."></li>
                            <li><span>일자</span> <input type="date"> <input type="date">
                                <span class="span"><lable><input type="checkbox" id="" class="checkbox"></lable>당일</span></li>
                            <li><span>시간</span> <input type="time"><input type="time"> <small>평일 및 공휴일 09~19시 사이</small></li>
                            <li><span>단체명</span> <input type="text" placeholder="신청하려는 대표 단체명을 기입해주세요."></li>
                            <li><span>사업자등록번호</span> <span class="span"><label for=""><input type="checkbox" class="checkbox"></label>없음</span></li>
                            <li><span>단체소개</span> <input type="text" placeholder="대관 심의시 참고합니다."></li>
                            <li><span>주소</span> <input type="text"></li>
                        </ul>
                    </div>
                    <div class="box3">
                        <p>서울새활용플라자관련 민간협력기관, 입주기업, 협력사 해당 여부 <span>대관시 대관료 할인 여부 판단용입니다</span></p>
                        <ul>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 정부 및 산하기관</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 서울시</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 서울시 산하기관 등 공공기관</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 서울새활용플라자 입주기업</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 서울새활용플라자 민간협력기관</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 서울새활용플라자 협력사</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 기타</p></label></li>
                            <li><label for="" id=""><p><input type="checkbox" id=""> 해당사항 없음</p></label></li>
                        </ul>
                    </div>
                    <div class="box4">
                        <ul>
                            <li><span>신청자명</span> <input type="text" placeholder="신청명을 기입해주세요."></li>
                            <li><span>직위</span> <input type="text" placeholder="직위를 기입해주세요."></li>
                            <li><span>연락처</span> <select name="" id="" class="phone_select">
                                <option value="010">010</option>
                                <option value="010">010</option>
                                <option value="010">010</option>
                            </select> - 
                            <input type="text" class="phone"> - <input type="text" class="phone">
                            </li>
                            <li><span>이메일</span> <input type="text" class="email"> @ <input type="text" class="email">
                                <select name="" id="" class="email_select">
                                    <option value="직접입력">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                </select>
                            </li>
                        </ul>
                    </div>
                    <div class="box5">
                        <ul>
                            <li><p>대관 행사명 <input type="text"></p> <small>* 교육, 회의, 워크샵 용도 외의 대관은 받지 않으며 교육시 상품, 유료 서비스의 홍보와 계약 유도, 판매를 주된 목적으로 하는 사용은 불가합니다. (새활용관련 유료 교육 프로그램은 가능)</small></li>
                            <li><p>행사 참가 대상 <input type="text"></p></li>
                            <li><p>행사참가비 유/무 여부 <label for=""><input type="radio" id=""></label> <span>유료</span> <label for=""><input type="radio" id=""></label> <span>무료</span> <label for=""><input type="radio" id=""></label> <span>무료이나 기타조건이 필요</span></p></li>
                            <li class="inputli"><input type="text"></li>
                            <li><p>시설물(현수막,배너) 설치 및 물품 반입 계획 및 여부 <label for=""><input type="radio" id=""></label> <span>있음</span> <label for=""><input type="radio" id=""></label> <span>없음</span> </p> <small>* 설물 설치 및 변경(현수막, 안내물, 가설물 등), 물품 반입 등의 사항이 있을 시 계획서를 작성하여 사용 전 미리 협의하여 주시기 바랍니다. (케이터링 등 음식반입은 불가합니다.) -현재 내, 외부 현수막 설치는 불가합니다.</small></li>
                        </ul>
                    </div>
                    <div class="box6">
                        <p>개인정보 수집 및 이용 동의 <label for=""><input type="radio" id="" name="radio0"></label> <span>동의</span> <label for=""><input type="radio" id="" name="radio0"></label> <span>동의하지 않음</span></p>
                            <small>* 서울새활용플라자 대관 시설 이용객의 편의/예약 신청/사용 등과 관련된 내용 이외엔 개인정보를 사용하지 않습니다</small>
                        <p>승인 여부 안내 <label for=""><input type="radio" id="" name="radio01"></label> <span>동의</span> <label for=""><input type="radio" id="" name="radio01"></label> <span>동의하지않음</span></p>
                            <small>* 대관 신청이 승인되면, 담당자 메일로 대관 신청서 및 대관 운영 계획, 대관 계약서, 대관 입금안내서 등을 보내드립니다.
기 확정된 대관이 있거나 미승인시에는 대관 불가 안내 문자를 보내드리니 참고바랍니다.</small>
                    </div>
                    <div class="btn"><button type="button">신청</button></div>
                </div>
            
        </article>
    </section>
    <!--  //Main section 영역  -->

	<script src="/js/jquery.bxslider.min.js"></script>

	<script src="/js/index.js"></script>
  
