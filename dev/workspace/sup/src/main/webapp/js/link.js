	// ¸µÅ©(½Ã¿¬)

	// ¸ÞÀÎÆäÀÌÁö
	$('.header_home ul li:first-of-type, h1 img, h2 img').click(function(){
		$(location).attr('href','./index.php');
	});

	// ·Î±×ÀÎ
	$('.header_login ul li:first-of-type, .result_btn button:last-of-type').click(function(){
		$(location).attr('href','./login.php');
	});

	// ¾ÆÀÌµð/ºñ¹Ð¹øÈ£ Ã£±â
	$('.result_btn button:first-of-type').click(function(){
		$(location).attr('href','./login_find.php');
	});

	// ¾ÆÀÌµð Ã£±â °á°ú
	$('.IdPassword .leftBox .btn button').click(function(){
		$(location).attr('href','./login_id.php');
	});

	// ºñ¹Ð¹øÈ£ Ã£±â °á°ú
	$('.IdPassword .rightBox .btn button').click(function(){
		$(location).attr('href','./login_pw.php');
	});

	// È¸¿ø°¡ÀÔ
	$('.header_login ul li:nth-of-type(2)').click(function(){
		$(location).attr('href','./login_agree.php');
	});
	$('.link_join').click(function(){
		$(location).attr('href','./login_join.php');
	});

	// ¸¶ÀÌÆäÀÌÁö Á¤º¸
	$('.btn_login, .header_login ul li:nth-of-type(3)').click(function(){
		$(location).attr('href','./SUP_Mypage.php');
	});

	// ¸¶ÀÌÆäÀÌÁö ¿¹¾à
	$('.Rent_3 .btn, .learning3 .edu_agree button, .education .edu_agree button, .bus .edu_agree button').click(function(){
		$(location).attr('href','./SUP_Mypage2.php');
	});

	// ¸¶ÀÌÆäÀÌÁö ¿¹¾à 2
	$('.mypage_review_form .qnabx button').click(function(){
		$(location).attr('href','./SUP_Mypage_review.php');
	});

	// ¸¶ÀÌÆäÀÌÁö ¹®ÀÇ
	$('.qna_faq .qnabx button').click(function(){
		$(location).attr('href','./SUP_Mypage3.php');
	});

	// ÈÄ±â¾²±â
	$('.review_btn1').click(function(){
		$(location).attr('href','./SUP_Mypage_review_form.php');
	});

	$('.review_btn2').click(function(){
		$(location).attr('href','./SUP_Mypage_review_form2.php');
	});

	// ½ºÆ©µð¿À »ó¼¼ÆäÀÌÁö
	$('.imgBox').click(function(){
		$(location).attr('href','./SUP_Studio_studio2.php');
	});

	// ´ë°ü ¿¹¾à µ¿ÀÇ ÆäÀÌÁö
	$('.reserv_btn').click(function(){
		$(location).attr('href','./SUP_Studio_Rent_3.php');
	});

	// ´ë°ü ¿¹¾à ÀÔ·Â ÆäÀÌÁö
	$('.rent2_btn').click(function(){
		$(location).attr('href','./SUP_Studio_Rent_3.php');
	});

	// ÇöÀåÇÐ½À ¿¹¾à ÆäÀÌÁö 2
	// $('.Learning .btn button:first-of-type').click(function(){
	// 	$(location).attr('href','./SUP_Reservation_Learning_2.php');
	// });

	// ÇöÀåÇÐ½À ¿¹¾à ÆäÀÌÁö 3
	$('.Learning .btn button:last-of-type, .Learning_02 .btn button').click(function(){
		$(location).attr('href','./SUP_Reservation_Learning_3.php');
	});

	// ÇöÀåÇÐ½À ¿¹¾à ÆäÀÌÁö 3
	$('.header_home ul li:last-of-type').click(function(){
		$(location).attr('href','./SUP_Introduction.php');
	});

	$('.ekscp').click(function(){
		$(location).attr('href', './SUP_Reservation_Learning_4.php');
	});

	$('.tkdals1').click(function(){
		$(location).attr('href', './SUP_Mypage2.php');
	});

	$('.office_btn').click(function(){
		$(location).attr('href', './SUP_Reservation_Office.php');
	});

	$('.edu_btn').click(function(){
		$(location).attr('href', './SUP_Reservation_Education.php');
	});

	$('.lear_btn1').click(function(){
		$(location).attr('href', './SUP_Reservation_Learning_1.php');
	});


	$('.lear_btn2').click(function(){
		$(location).attr('href', './SUP_Reservation_Learning_4.php');
	});


















    // ¾Ë¸²Ã¢

// È¸¿ø°¡ÀÔ ¿Ï·á
$(".signup2 .btn input").click(function(){
  $(location).attr('href','./SUP_Mypage.html');
    alert("회원가입이 완료되었습니다.");
});

// ¸¶ÀÌÆäÀÌÁö Á¤º¸¼öÁ¤ ¿Ï·á
$(".mypage .tab_box1 button").click(function(){
    alert("정보 수정이 완료되었습니다.");
});

// ¸¶ÀÌÆäÀÌÁö ÈÄ±â »èÁ¦
$(".emdfhr").click(function(){
    alert("등록이 완료되었습니다.");
});