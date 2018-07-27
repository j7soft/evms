<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="/css/SUP_Login.css">
<script type="text/javaScript">
	function fnAgree() {
		var checkField = document.QustnrManageForm.checkField;
		if (checkField) {
			if (checkField.length > 1) {
				for (var i = 0; i < checkField.length; i++) {
					if (checkField[i].checked) {
					} else {
						alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원으로 가입할 수 없습니다.
						checkField[i].focus();
						return;
					}
				}
			} else {
				if (checkField.checked) {
				} else {
					alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원으로 가입할 수 없습니다.
					checkField[i].focus();
					return;
				}
			}
		}
		document.QustnrManageForm.submit();
	}

	function fnDisAgree() {
		alert("<spring:message code="comUssUmt.stplatCnfirmtValidate.disagreeStplatCnfirmt" />"); //약관에 동의하지 않으면 회원가입을 하실수 없습니다.
		return;
	}
</script>
<!--  Main section 영역  -->
<section id="section">
	<!-- <div class="sub_bg">
		<h3>서브메인 이미지</h3>
	</div>
	 -->
	<article class="login signup">
		<div class="content_h3bx">
			<h3>회원가입</h3>
		</div>
		<noscript class="noScriptTitle">
			<spring:message code="common.noScriptTitle.msg" />
		</noscript>

		<form name="QustnrManageForm"
			action="<c:url value='/uss/umt/EgovMberSbscrbView.do'/>" method="post">
			<div class="wTableFrm">
				<!-- 약관확인 -->
				<table class="wTable">
					<tr>
						<th>약관동의</th>
					</tr>

					<tr>
						<td><label for="useStplatCn"> <textarea
									id="useStplatCn" cols="120" rows="15">
"제1장 총칙"

제1조 (목적)

이 약관은 OOOOO행사관리 홈페이지가 제공하는 서비스(이하 "서비스"라 합니다)를 이용함에 있어 이용자와 OOOOO행사관리간의 권리, 의무 및 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
									
제2조 (약관의 효력 및 변경)

1. 이 약관은 서비스 화면에 게시하거나 기타의 방법으로 공지함으로써 이용자에게 공시하고, 이에 동의한 이용자가 서비스에 가입함으로써 효력이 발생합니다.
2. OOOOO행사관리는 필요하다고 인정되는 경우 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 서비스 화면에 공지함으로써 이용자가 직접 확인할 수 있도록 할 것입니다.
3. 이용자는 변경된 약관에 동의하지 않으실 경우 서비스 이용을 중단하고 본인의 회원등록을 취소할 수 있으며, 계속 사용하시는 경우에는 약관 변경에 동의한 것으로 간주되며 변경된 약관은 전항과 같은 방법으로 효력이 발생합니다.
4. 이용자가 이 약관의 내용에 동의하는 경우 OOOOO행사관리의 서비스 제공행위 및 이용자의 서비스 이용행위에는 이 약관이 우선적으로 적용될 것입니다. 이 약관에 명시되지 않은 사항에 대해서는 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 프로그램 보호법 등 기타 대한민국의 관련법령과 상관습에 의합니다.

제3조 (용어의 정의)

1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
	① 이용자 : 서비스에 접속하여 OOOOO행사관리가 제공하는 서비스를 받는 회원 및 비회원
	② 회원 : 서비스에 접속하여 이 약관에 동의하고, ID(고유번호)와 PASSWORD(비밀번호)를 발급 받아 실명확인 절차를 거친 자
	③ 비회원 : 회원가입을 하지 않고 OOOOO행사관리가 제공하는 서비스를 이용하는 자
	④ ID(고유번호) : 회원 식별과 회원의 서비스 이용을 위하여 이용자가 선정하고 OOOOO행사관리가 승인하는 영문자와 숫자의 조합( 본인 인증된 1인당 하나의 ID만 발급, 이용 가능합니다)
	⑤ PASSWORD(비밀번호) : 회원의 정보 보호를 위해 이용자 자신이 설정한 문자와 숫자의 조합
	⑥ 이용해지 : OOOOO행사관리 또는 회원이 서비스 이용 이후 그 이용계약을 종료시키는 의사표시
2. 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스별 안내에서 정하는 바에 의합니다.

"제2장 서비스 이용계약"

제4조 (이용계약의 성립)

이용계약은 이용자의 약관내용에 대한 동의와 이용자의 이용신청에 대한 OOOOO행사관리의 승낙으로 성립합니다.

제5조 (이용신청)

이용신청은 서비스의 회원정보 화면에서 이용자가 OOOOO행사관리에서 요구하는 가입신청 양식에 개인의 신상정보를 기록하는 방식으로 신청합니다.

제6조 (이용신청의 승낙)

1. OOOOO행사관리는 제5조에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙합니다.
2. OOOOO행사관리는 다음 각 호에 해당하는 경우에 대하여는 그 신청에 대한 제한 사유가 해소될 때까지 승낙을 유보 또는 일부 서비스 이용을 제한할 수 있습니다.
	① 내용이 허위(차명, 비실명, 주민등록번호 도용 등)인 것으로 판명되거나, 그러하다고 의심할만한 합리적인 사유가 발생할 경우
	② 기타 OOOOO행사관리가 필요하다고 인정되는 경우
3. OOOOO행사관리는 다음에 해당하는 경우에는 이용신청을 승낙하지 아니할 수 있습니다.
	① 본인의 실명으로 신청하지 않았을 때
	② 다른 사람의 명의를 사용하여 신청하였을 때
	③ 신청서의 내용을 허위로 기재하였을 때
	④ 사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때⑤ 기타 OOOOO행사관리가 정한 이용신청 요건이 미비 되었을 때

제7조 (계약사항의 변경)

회원은 회원정보관리를 통해 언제든지 자신의 정보를 열람하고 수정할 수 있습니다. 회원은 이용신청 시 기재한 사항이 변경되었을 때에는 수정을 하여야 하며, 수정하지 아니하여 발생하는 문제의 책임은 회원에게 있습니다.

"제3장 서비스제공 및 이용"

제8조 (서비스 이용)

1. OOOOO행사관리는 회원의 이용신청을 승낙한 때부터 서비스를 개시합니다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시합니다.
2. OOOOO행사관리의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공시하거나 회원에게 이를 통지합니다.
3. 서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 다만, OOOOO행사관리의 업무상 또는 기술상의 이유로 서비스가 일시 중지될 수 있고, 또한 정기점검 등 운영상의 목적으로 OOOOO행사관리가 정한 기간에는 서비스가 일시 중지될 수 있습니다. 이러한 경우 OOOOO행사관리는 사전 또는 사후에 이를 공지합니다.
4. 회원에 가입한 후라도 일부 서비스 이용 시 서비스 제공자의 요구에 따라 특정 회원에게만 서비스를 제공할 수도 있습니다.
5. OOOOO행사관리는 서비스를 일정범위로 분할하여 각 범위별로 이용가능 시간을 별도로 정할 수 있습니다. 이 경우 그 내용을 사전에 공지합니다.

제9조 (서비스의 변경, 중지 및 정보의 저장과 사용)

1. 회원은 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, OOOOO행사관리의 관리범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실에 대해 OOOOO행사관리가 아무런 책임을 지지 않음에 동의합니다.
2. OOOOO행사관리가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일전에 고지 후 서비스를 중지할 수 있으며, 이 기간동안 회원이 고지내용을 인지하지 못한데 대하여 OOOOO행사관리는 책임을 부담하지 아니합니다. 상당한 이유가 있을 경우 위 사전 고지기간은 감축되거나 생략될 수 있습니다.또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 OOOOO행사관리는 책임을 부담하지 아니합니다.
3. OOOOO행사관리의 사정으로 서비스를 영구적으로 중단하여야 할 경우 제2항을 준용합니다. 다만, 이 경우 사전 고지기간은 1개월로 합니다.
4. OOOOO행사관리는 사전 고지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 회원 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.
5. OOOOO행사관리는 회원이 이 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 중지할 수 있습니다. 이 경우 OOOOO행사관리는 회원의 접속을 금지할 수 있으며, 회원이 게시한 내용의 전부 또는 일부를 임의로 삭제할 수 있습니다.
6. 장기간 휴면 회원인 경우 안내 메일 또는 공지사항 발표 후 1주일간의 통지 기간을 거쳐 서비스 사용을 중지할 수 있습니다.

제10조 (정보의 제공 및 광고의 게재)

1. OOOOO행사관리는 회원이 서비스 이용 중 필요가 있다고 인정되는 다양한 정보 및 광고에 대해서는 전자우편이나 서신우편, SMS(휴대폰 문자메시지), DM, 메신저 등의 방법으로 회원에게 제공할 수 있으며, 만약 원치 않는 정보를 수신한 경우 회원은 이를 수신거부 할 수 있습니다.
2. OOOOO행사관리는 서비스의 운용과 관련하여 서비스화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있으며, OOOOO행사관리는 서비스를 이용하고자 하는 회원이 이 광고게재에 대하여 동의하는 것으로 간주합니다.
3. OOOOO행사관리는 서비스 상에 게재되어 있거나 서비스를 통한 광고주와의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.

제11조 (게시물 또는 내용물의 삭제)

1. OOOOO행사관리는 회원이 게시하거나 등록하는 서비스 내의 모든 내용물이 다음 각 호의 경우에 해당된다고 판단되는 경우 사전 통지 없이 삭제할 수 있으며, 이에 대해 OOOOO행사관리는 어떠한 책임도 지지 않습니다.
① OOOOO행사관리, 다른 회원 또는 제3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우② 공공질서 및 미풍양속에 위반되는 내용인 경우③ 범죄적 행위에 결부된다고 인정되는 내용일 경우④ 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우⑤ 서비스 성격에 부합하지 않는 정보의 경우⑥ 기타 관계 법령 및 OOOOO행사관리에서 정한 규정 등에 위배되는 경우
2. OOOOO행사관리는 서비스에 게시된 내용을 사전 통지된 지 3일 이후 편집, 이동, 삭제할 수 있는 권리를 보유하며, 게시된 내용이 이 약관에 위배되거나 상용 또는 비합법적, 불건전한 내용일 경우 및 해지 회원이 게시한 게시물은 사전통보 없이 삭제할 수 있습니다.
3. OOOOO행사관리는 게시된 내용이 일정기간 이상 경과되어, 게시물로써의 효력을 상실하여 그 존치 목적이 불분명한 경우 공지사항 발표 후 1주일간의 통지기간을 거쳐 해당 게시물을 삭제할 수 있습니다.

제12조 (게시물의 저작권)

1. 회원이 서비스 내에 게시한 게시물의 저작권은 회원에게 있으며, OOOOO행사관리는 다른 서비스에서의 개재 등 활용할 수 있습니다.
2. 회원의 게시물이 타인의 저작권, 프로그램 저작권 등을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 회원이 부담하여야 합니다.
3. 회원은 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.

제13조 (OOOOO행사관리의 소유권)

1. OOOOO행사관리가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타권리는 OOOOO행사관리에게 소유권이 있습니다.
2. 회원은 OOOOO행사관리가 명시적으로 승인한 경우를 제외하고는 제1항 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정행위, 상업적 이용행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.

"제4장 계약 당사자의 의무"

제14조 (회원의 의무 및 정보보안)

1. 회원은 서비스 이용을 위해 가입할 경우 현재의 사실과 일치하는 완전한 정보(이하 "가입정보"라 한다)를 제공하셔야 합니다. 또한 가입정보에 변경이 발생할 경우 즉시 갱신하셔야 합니다.
2. 회원이 서비스 사용을 위한 가입절차를 완료하시면 아이디와 비밀 번호를 받게 됩니다. 회원의 아이디, 비밀번호 관리를 위해
	① 회원의 승인 없이 비밀번호, 아이디가 사용되는 문제가 발생되면 즉시 OOOOO행사관리에 신고하셔야 하고
	② 매 접속 종료 시 확실히 로그아웃을 하셔야 합니다.
3. 회원은 서비스를 이용하면서 다음과 같은 행위를 하지 않기로 동의합니다.
	① 타인(소수를 포함)에게 위해를 가하는 행위
		㉮ 타인의 ID, PASSWORD, 개인정보의 도용 및 타인으로 가장하는 행위
		㉯ 타인과의 관계를 허위로 명시하는 행위
		㉰ 타인을 비방할 목적으로 사실 또는 허위의 사실을 적시하여 명예를 훼손하는 행위
		㉱ 자기 또는 타인에게 재산상의 이익을 주거나 타인에게 손해를 가할 목적으로 허위의 정보를 유통시키는 행위
		㉲ 수치심이나 혐오감 또는 공포심을 일으키는 말이나 음향, 글이나 화상 또는 영상을 계속하여 상대방에게 도달하게 하여 상대방의 일상적 생활을 방해하는 행위
		㉳ OOOOO행사관리의 사전 승낙 없이 서비스를 이용한 영리행위
		㉴ 타인의 정보통신서비스 이용명의를 도용하여 사용하는 행위
	② 불필요하거나 승인되지 않은 광고, 판촉물을 게재하거나, "정크 메일(junk mail)", "스팸(spam)", "행운의 편지(chain letters)", "도배글", "피라미드 조직" 등을 권유하거나 게시, 게재 또는 전자우편으로 보내는 행위
	③ 저속 또는 음란한 데이터, 텍스트, 소프트웨어, 음악, 사진, 그래픽, 비디오 메시지 등(이하 "컨텐츠")을 게시, 게재 또는 전자우편으로 보내는 행위
	④ 권리(지적재산권을 포함한 모든 권리)가 없는 컨텐츠를 게시, 게재 또는 전자우편으로 보내는 행위
	⑤ 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비를 파괴, 방해 또는 기능을 제한하기 위한 소프트웨어 바이러스를 게시, 게재 또는 전자우편으로 보내는 행위
	⑥ 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시, 게재, 전자우편으로 보내는 행위 등 다른 사용자의 개인정보를 수집 또는 저장하는 행위⑦ 재물을 걸고 도박하거나 사행행위를 하는 행위
	⑧ 윤락행위를 알선하거나 음행을 매개하는 내용의 정보를 유통시키는 행위
	⑨ 기타 불법적이거나 부당한 행위
4. 회원은 이 약관 및 관계법령에서 규정한 사항을 준수하여야 합니다.

제15조 (OOOOO행사관리의 의무)

1. OOOOO행사관리는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시일에 서비스를 이용할 수 있도록 합니다.
2. OOOOO행사관리는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.
3. OOOOO행사관리가 제공하는 서비스로 인하여 회원에게 손해가 발생한 경우 그러한 손해가 OOOOO행사관리의 고의나 중과실에 기해 발생한 경우에 한하여 OOOOO행사관리에서 책임을 부담하며, 그 책임의 범위는 통상손해에 한합니다.
4. OOOOO행사관리는 회원으로부터 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 신속히 처리하여야 합니다. 다만, 신속한 처리가 곤란한 경우에는 회원에게 그 사유와 처리일정을 통보하여야 합니다.
5. OOOOO행사관리는 관련법령이 정하는 바에 따라서 회원 등록정보를 포함한 회원의 개인정보를 보호하기 위하여 노력합니다. 회원의 개인정보보호에 관해서는 관련법령 및 제 16조에 제시된 내용을 지킵니다.

제16조 (개인정보보호정책)

1. OOOOO행사관리는 이용 신청 시 회원이 제공하는 정보를 통하여 회원에 관한 정보를 수집하며, 회원의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스제공을 위한 목적으로 이용합니다.
2. OOOOO행사관리는 서비스 제공과 관련하여 취득한 회원의 정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호의 경우에는 그러하지 아니합니다.
	① 관계 법령에 의하여 수사상의 목적으로 관계기관으로부터 요구가 있는 경우
	② 정보통신윤리위원회의 요청이 있는 경우
	③ 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우

"제5장 계약해지"

제17조 (계약해지 및 이용제한)

1. 회원이 이용계약을 해지하고자 하실 때에는 회원 본인이 직접 인터넷을 통해 당 사이트에 해지 신청을 하여야 합니다.
2. OOOOO행사관리는 보안 및 아이디 정책, 서비스의 원활한 제공 등과 같은 이유로 회원의 ID 및 PASSWORD 변경을 요구하거나 변경 할 수 있습니다.
3. OOOOO행사관리는 회원이 다음 각 호에 해당하는 행위를 하였을 경우 사전통지 없이 이용계약을 해지할 수 있습니다.
	① 비 실명가입, 개인정보의 도용 등 회원이 제공한 데이터가 허위임이 판명된 경우
	② 범죄적 행위에 관련되는 경우
	③ 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우 
	④ 타인의 서비스 아이디 및 비밀 번호를 도용한 경우
	⑤ 타인의 명예를 손상시키거나 불이익을 주는 경우
	⑥ 같은 사용자가 다른 아이디로 이중 등록을 한 경우
	⑦ 서비스에 위해를 가하는 등 서비스의 건전한 이용을 저해하는 경우
	⑧ 기타 관련법령이나 OOOOO행사관리가 정한 이용조건에 위배되는 경우

"제6장 기타"

제18조 (요금 및 유료정보)

서비스 이용은 기본적으로 무료입니다. 단, 서비스에서 정한 별도의 유료 정보와 유료서비스에 대해서는 그러하지 아니합니다.

제19조 (양도금지)

회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.

"제7장 손해배상 등"

제20조 (손해배상)

OOOOO행사관리는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동 손해가 OOOOO행사관리의 중대한 과실에 의한 경우를 제외하고 이에 대하여 책임을 부담하지 아니합니다.

제21조 (면책조항)

1. OOOOO행사관리는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
2. OOOOO행사관리는 회원의 귀책사유로 인한 서비스이용의 장애에 대하여 책임을 지지 않습니다.
3. OOOOO행사관리는 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.
4. OOOOO행사관리는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.

제22조 (관할법원)

1. 서비스 이용과 관련하여 OOOOO행사관리와 회원 사이에 분쟁이 발생한 경우, OOOOO행사관리와 회원은 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 하여야 합니다.
2. 제1항의 규정에도 불구하고 서비스 이용으로 발생한 분쟁에 대하여 소송이 제기될 경우 OOOOO행사관리 소재지를 관할하는 법원을 관할법원으로 합니다.

부칙

(시행일) 이 약관은 2018년 04월 30일부터 적용합니다.
									</textarea>
						</label></td>
					</tr>
					<tr>
						<td><label for="checkField"> <input name="checkField"
								type="checkbox" /> 동의함
						</label></td>
					</tr>
				</table>
				<!-- 정보동의내용 -->
				<table class="wTable">
					<tr>
						<th>정보동의내용</th>
					</tr>
					<tr>
						<td><label for="infoProvdAgeCn"> 
						<div id="infoProvdAgeCn" cols="120" rows="15" class="text_terms">
						<br>
						<p>여러분이 우리 OOOOO행사관리 홈페이지를 이용할 경우 다음 정보는 로그인 기록을 통하여 자동적으로 수집·저장됩니다.
<br><br>
<p>이용자 여러분의 인터넷서버 도메인과 우리 홈페이지를 방문할 때 거친 웹사이트의 주소 이용자의 브라우져 종류 및 OS 방문일시 등<br>
<p>위와 같이 자동 수집·저장되는 정보는 이용자 여러분에게 보다 나은 서비스 제공을 위해 홈페이지 개선과 보완에 이용될 것입니다. 홈페이지 보안을 위해 관리적·기술적 노력을 하고 있으나, 만약의 침해사고 시 문제가 될 수 있는 민감한 정보의 기재는 피하여 주시기 바랍니다.
<br><br>
<p>개인정보 수집 기관(부서 및 수집내용등 안내)
<p>OOOOO행사관리 홈페이지를 통하여 수집되는 개인정보는 해당부서에서 안전하게 관리하고 있으며, 그 현황은 아래와 같습니다.
<br><br>
<table class="text_agree">
<tr><td>개인정보 파일명</td><td>수집내용</td><td>수입목적</td><td>수집기관(부서)</td><td>연락처</td></tr>
<tr><td>홈페이지 회원</td><td>성명,전화번호,휴대폰번호,이메일 등</td><td>홈페이지 운영 및 관리</td><td>중소기업기술정보진흥원운영센터</td><td>02-9999-9999</td></tr>
<tr><td>고객문의</td><td>성명,이메일주소,휴대폰번호</td><td>홈페이지를 통한 민원서비스 제공 및 처리내역 보유	</td><td>중소기업기술정보진흥원운영센터</td><td>02-9999-9999</td></tr>
<tr><td>부조리 통합신고</td><td>이름, 생년월일, 주소, 휴대폰번호, 이메일주소, 전화번호</td><td>신고자 본인확인 및 신고사항 조치</td><td>감사팀</td><td>02-9999-9999</td></tr>
</table>
<br>
<p>홈페이지 운영 및 관리 : 중소기업기술정보진흥원운영센터 02-9999-9999
<br><br>
<p>서버담당 : 중소기업기술정보진흥원운영센터 02-9999-9999
<br><br>
<p>개인정보를 포함하여 수집된 모든 정보가 정확하고 완전하며 항상 최신의 상태로 유지되기 위하여, 이용자는 개인정보의 변경이 발생할 경우 즉시 갱신하여야 합니다.
<br><br>
<p>OOOOO행사관리는 여러분의 개인정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다. 개인정보를 보호하는데 있어 귀하께 고지한 사항들에 반하는 사고가 발생할 경우 개인정보관리책임관이 책임을 집니다.
<br><br>
<p>이용자 개인정보와 관련한 아이디(ID)의 비밀번호에 대한 보안유지책임은 해당 이용자 자신에게 있습니다. OOOOO행사관리는 비밀번호에 대해 어떠한 방법으로도 이용자에게 직접적으로 질문하는 경우는 없으므로 타인에게 비밀번호가 유출되지 않도록 각별히 주의하시기 바랍니다.
<br><br>
<p>이메일 및 웹 서식 등을 통한 수집정보
<p>이용자 여러분은 우편, 전화, 이메일 또는 온라인 전자서식 등을 통한 전자적 방법을 통해 의사를 표시할 수 있습니다. 이러한 방법의 선택에 있어 몇 가지 유의사항을 알려드립니다.
<br><br>
<p>여러분이 홈페이지에 기재한 사항은 다른 사람들이 조회 또는 열람할 수도 있습니다.<br>
<p>여러분이 기재한 사항은 관련 법규에 근거하여 필요한 다른 사람과 공유될 수 있으며,<br>
<p>관련법령의 시행과 정책개발의 자료로도 사용될 수 있습니다.<br>
<p>또한, 이러한 정보는 타 부서와 공유되거나, 필요에 의하여 제공될 수도 있습니다.<br>
<p>개인정보의 이용제한 및 제3자 공개의 거부<br>
<p>OOOOO행사관리는 수집취득한 모든 정보를 [개인정보보호법]의 제18조에 의거 본인의 승낙 없이 제3자에게 누설 또는 배포하지 않으며, 상업적 목적으로 사용하지 않습니다.<br>

<br><br>
<div>
<p>단 아래사항에 대하여는 예외로 합니다.<br>
<p>1. 관계 법령에 의하여 수사상 목적으로 관계기관으로부터 요구가 있는 경우
<p>2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우
<p>3 .기타 관계법령에서 정한 절차에 따라 요청한 경우
</div>
<div>
<p>홈페이지 접속 (쿠키사용)에 관한 사항
<p>이용자들에게 특화된 맞춤서비스를 제공하기 위해서 우리 OOOOO행사관리는 이용자들의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버(HTTP)가 이용자의 컴퓨터 브라우저에게 보내는 최소량의 정보이며 이용자들의 PC컴퓨터내의 하드디스크에 저장되기도 합니다.
<br>
<p>이용자들이 우리시 홈페이지에 접속한 후 로그인(Log-In)하여 회원서비스를 이용하기 위해서는 쿠키를 허용하셔야 합니다. 우리시는 이용자들에게 적합하고 보다 유용한 서비스를 제공하기 위해서 쿠키를 이용하여 아이디에 대한 정보를 찾아냅니다. 쿠키는 이용자의 컴퓨터는 식별하지만 이용자를 개인적으로 식별하지는 않습니다.
<br>
<p>이용자들은 쿠키에 대하여 사용여부를 선택할 수 있습니다. 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용할 수도 있고, 쿠키가 저장될 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수도 있습니다. 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 일부 서비스는 이용할 수 없습니다.
<br>
<p>수집된 개인정보의 사용 목적<br>
<p>OOOOO행사관리는 개인정보 수집 시 사용목적을 정확히 밝히고 있으며, 수집되는 개인정보는 아래와 같은 목적으로 사용합니다.<br>
<p>성명, 성별, 아이디, 비밀번호 등은 서비스 이용에 따른 본인식별 등의 서비스 제공에 사용되며, 이메일주소, 전화번호 등은 고지사항 전달, 본인의사 확인, 불만처리 등 원활한 의사소통 경로를 확보하기 위한 것이고, 그 외 기타의 자료들은 개인 맞춤서비스를 제공하기 위한 자료활용을 목적으로 하고 있습니다.
<br>
<p>홈페이지에서 운영하는 보안조치
<br>
<p>OOOOO행사관리 홈페이지를 안전하고 지속적으로 서비스하고자 보안패치 및 네트워크 유통량의 통제(Monitor)는 물론 불법적으로 접속, 정보를 변경하는 등의 시도를 방지하는 여러 가지 프로그램을 운영하고 있습니다.
<br>
<p>링크 사이트 웹 페이지
<br>
<p>OOOOO행사관리가 운영하는 여러 웹페이지에 포함된 링크 또는 배너를 클릭하여 다른 사이트 또는 웹페이지로 옮겨갈 경우 개인정보보호방침은 그 사이트 운영기관이 게시한 방침이 적용됨으로 새로 방문한 사이트의 개인정보보호방침을 확인하시기 바랍니다.
<br>
<p>웹사이트 이용중 다른 사람의 개인정보 취득
<br>
<p>OOOOO행사관리가 운영하는 웹사이트에서 이메일 주소 등 식별할 수 있는 개인정보를 취득하여서는 아니 됩니다.
<br>
</div>						
						</div>
						</label> <!-- <c:out value="${fn:replace(result.infoProvdAgeCn , crlf , '<br/>')}" escapeXml="false" /> -->
						</td>
					</tr>
					<tr>
						<td><label for="checkField"> <input name="checkField"
								type="checkbox" />동의함

						</label></td>
					</tr>
				</table>

				<div class="btn">
					<input type="submit" class="s_submit" onclick="fnAgree(); return false;" value="동의" />
				</div>
				<div style="clear: both;"></div>


			</div>
		</form>
	</article>
	<!-- content end -->
</section>
<!--  //Main section 영역  -->

