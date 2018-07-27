var date = getDateFormat(new Date());
function getDateFormat(dateValue){
	var year = dateValue.getFullYear();
	var month = dateValue.getMonth()+1;
	month = (month<10) ? "0"+month : month;
	var day = dateValue.getDate();
	day = (day<10)? "0"+day : day;
	var result = year+"-"+month+"-"+day;
	return result;
}
	
	

function checkForm(item, msg){
	var message = "";
	if(item.val().replace(/\s/g,"")==""){
		message = msg+" 입력해 주세요";
		alert(message);
		item.val("");
		item.focus();
		return false;
	}else{
		return true;
	}
}
function checkBox(item, msg){
	var message = "";
	if(item.val().replace(/\s/g,"")==""){
		message = msg+" 선택해 주세요";
		alert(message);
		item.val("");
		item.focus();
		return false;
	}else{
		return true;
	}
}

/* (?=pattern) or 연산으로 정의된 패턴과 일치하는 문자열 */
var pattern = [
	"((?=.*[a-zA-Z]).{1,15})",
	"((?=.*[a-zA-Z])(?=.*[0-9]).{1,15})",
	"((?=.*[a-zA-Z])(?=.*[0-9@#$%]).{8,12})",
	"^\\d{3}-\\d{3,4}-\\d{4}$", //핸드폰 번호 유효성 체크(-포함)
	"^\\d{4}-\\d{4}-\\d{4}-\\d{4}$",//카드 번호 유효성 체크(-포함)
	"^\\d{2}$",
	"^\\d{3}$",
	"^\\d{4}$",
	/*"\d{3}-\d{3,4}-\d{4}"*/
	/*"^[가-힣]*$"*/
];

function inputVerify(index, item){
	var data_regExp = new RegExp(pattern[index]);
	var match = data_regExp.exec(item.val());
	if(match==null){
		item.val("");
		alert("입력값이 형식에 맞지 않습니다.");
		item.attr("placeholder","입력값이 형식에 맞지 않습니다.");
		item.focus();
		return false;
	}else {
		return true;
	}
}








