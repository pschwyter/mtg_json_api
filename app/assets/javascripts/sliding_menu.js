$(document).ready(function(){

	var sliding_menu_height = $(window).height();

	$(window).resize(function(){
		var sliding_menu_height = $(window).height();
		$('.sliding-menu-content').height(sliding_menu_height);
	});
})