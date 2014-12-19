function fullscreener() {
	var total = $(document).height()-222;
	if ($(".section-inner").height() != total) {
		$(".section-inner").css({"height":total*2})
}
}


$(document).on('ready page:load', function() {

fullscreener()
})


