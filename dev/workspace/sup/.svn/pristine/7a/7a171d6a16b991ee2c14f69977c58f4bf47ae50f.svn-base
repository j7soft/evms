	// $('.slider').bxSlider({
	// 	pager:false,
	// 	  slideWidth: 320,
	// 	  maxSlides: 5,
	// 	  //minSlides: 4,
	// 	 moveSlides:1,
	// 	 pause:2000, //쉬는 시간
	// 	slideMargin: 33,
	// 	 auto:false,
	// 	 // speed: 20000,
	// 	 autoHover:true,
 //         infiniteLoop:true,
 //         touchEnabled :false,
	// });

    $('.visual_slider').bxSlider({
        //pager:false,
        //  minSlides: 4,
          //moveSlides:1,
          auto:true,
          //touchEnabled :false,
        controls: true,
        captions: true
    });

    $('.notice_slider').bxSlider({
        mode: 'vertical',
        auto: true,
        autoHover: true,
    });

    $('.slide').mouseenter(function(){

        $(this).siblings('.slide').removeClass('active');
        $(this).addClass('active');

    });



$(document).ready(function(){
    var cnt=7;
    $('.main_tab .tab_box1').show();
    $('.main_tab .tab1').addClass('tabOn');
  
    $('.main_tab .tab').each(function (index) {
        $(this).click(function(){
            $(".main_tab .tab_box").hide();
            $(".main_tab .tab_box:eq("+index+")").show();

            for(var i=0;i<=cnt;i++){
                $('.tab'+i).removeClass('tabOn');
            }
            $(this).addClass('tabOn');
        });
    });
});

//대관예약 셀렉트 js
$(document).ready(function(){
	
    $('.select_title').click(function(){
		$(this).next('.tep_list').slideToggle('fast');
		$(this).toggleClass('select_up')
	});


	$('.tep_list li').click(function(){
		var text = $(this).html();
		//alert('111');
		$(this).parent('ul').siblings('p').html(text);
		$(this).parent(".tep_list").slideUp('fast');
		$('.select_title').removeClass('select_up');
	});

/*	$('.select_depth1 span').click(function(){
		$(this).next('ul').slideToggle('fast');
		$(this).toggleClass('minus_up')
	});*/

	
});

