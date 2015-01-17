$( document ).ready(function() {
	        console.log( "document loaded" );

	// fullscreener();
})


function fullscreener() {
	var total = $(document).height()-222;
	if ($(".section-inner").height() != total) {
		$(".section-inner").css({"height":total})
	}
}