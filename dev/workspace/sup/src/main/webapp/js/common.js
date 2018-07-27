// GNB

$(document).ready(function(){


$(".gnb, .gnb_dropdown, .dropdown_list").mouseenter(function() {
  $(".gnb_dropdown").stop().slideDown("slow");
});
$(".gnb, .gnb_dropdown").mouseleave(function() {
  $(".gnb_dropdown").stop().slideUp("slow");
});


/* $('.gnb_area div .search_btn').hover(function(){
	$('.gnb_area div input[type="search"]').show();
});
$('.gnb_area div input[type="search"]').focusout(function(){
	$(this).hide();
}); */

$('.mobile_nav_btn').click(function(){
	$('body').toggleClass('on');
	$('.mobile_header nav').toggleClass('on');
});

$('.list_delete').click(function(){

	function button_event(){
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
		    $(this).hide();
		    console.log(this);
		}else{   //취소
		    return;
		}
	}
		button_event();

});

$('.top_btn').click(function(){
	$(window).scrollTop(0, 0);
});


$('.email_btn').click(function(){
	$('.email_popup').fadeIn();
});

$('.email_popup .popup_bg, .popup_title .close_btn').click(function(){
	$('.email_popup').fadeOut();
});




});
