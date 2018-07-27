<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	$(function() {
		$("#btn").click(function() {
			if (1 != 1) {
			
			} else {
				var chk = "";
				var chkbox = document.getElementsByName("day");
				for(var i = 0 ; i<chkbox.length;i++){
					if (chkbox[i].checked) {
						chk = chk +"," +chkbox[i].value;
					}	
				}
				
				$("#FDAY").val(chk);
				$("#FTIME").val($("#fhour").val()+":"+$("#fmin").val());
				$("#STIME").val($("#shour").val()+":"+$("#smin").val());
				$("#PRICE").val($("#big").val()+","+$("#small").val());

				console.log($("#file").val())
				console.log($("#TITLE").val())
				console.log($("#FDAY").val())
				console.log($("#FTIME").val())
				console.log($("#STIME").val())
				console.log($("#PRICE").val())
				console.log($("#DETAIL").val())
				console.log($("#PTB").val())
			}
		});
	});
</script>
<!--  Main section 영역  -->
<section id="section">
	<article class="contents">
		<div class="img_area">
			<div>
				<input type="file" name="file1" id="IMAGE1" class="upload">
				<button>+</button>
			</div>
		</div>

		<form id="frm" name="frm">
			<div class="input_area">
				<input type="hidden" id="NTT_ID" name="NTT_ID" value="" /> <input
					type="hidden" id="" name="" value="" /> <input type="hidden" id=""
					name="" value="" /> <input type="hidden" id="" name="" value="" />
				<input type="hidden" id="" name="" value="" />
				<ul class="clear">
					<li>
						<h4>대관명</h4> <textarea name="TITLE" id="TITLE" cols="30" rows="10"></textarea>
					</li>
					<li>
						<h4>운영시간</h4>
						<div>
							<input type="hidden" id="FDAY" name="FDAY" value="요일" /> <input
								type="checkbox" class="day" id="day" name="day" value="월">월
							<input type="checkbox" class="day" id="day" name="day" value="화">화
							<input type="checkbox" class="day" id="day" name="day" value="수">수
							<input type="checkbox" class="day" id="day" name="day" value="목">목
							<input type="checkbox" class="day" id="day" name="day" value="금">금
							<input type="checkbox" class="day" id="day" name="day" value="토">토
							<input type="checkbox" class="day" id="day" name="day" value="일">일
						</div>
						<div>
							<input type="hidden" id="FTIME" name="FTIME" value="00:00" /> 
								<select id="fhour">
								<c:forEach begin="0" end="23" varStatus="i">
									<option class="hourbtn" value="${i.index }">${i.index }</option>
								</c:forEach>
							</select> <select id="fmin">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
						</div>
						<div>
							<input type="hidden" id="STIME" name="STIME" value="00:00" />
								<select id="shour">
								<c:forEach begin="0" end="23" varStatus="i">
									<option class="hourbtn" value="${i.index }">${i.index }</option>
								</c:forEach>
							</select> <select id="smin">
								<option class="minbtn" value="00">00</option>
								<option class="minbtn" value="30">30</option>
							</select>
						</div>
					</li>
					<li>
						<h4>사용가능인원</h4> 
						<div><input width="50" type="number" id="CNT" name="CNT"></div>
					</li>
					<li>
						<h4>이용료</h4> 
						<input type="hidden" id="PRICE" name="PRICE" value="0" />
						<div>성인 <input type="number" id="big" ></div>
						<div>아동 <input type="number" id="small" ></div>
					</li>
					<li>
						<h4>상세설명</h4> <textarea name="DETAIL" id="DETAIL" cols="30" rows="10"></textarea>
					</li>
					<li>
						<h4>담당자</h4> <textarea name="PTB" id="PTB" cols="30" rows="10"></textarea>
					</li>
				</ul>
				
				<div class="btn_area">
					<button type="button" id="btn">등록</button>
				</div>


			</div>
		</form>

	</article>
</section>
<!--  //Main section 영역  -->