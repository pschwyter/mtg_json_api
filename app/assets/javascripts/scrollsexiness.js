
var header = true;

function show_header() {
	// console.log("show header");
	$(".nav").removeClass("evilnav");
	$(".header").show();
	header = true;
}

function hide_header() {
	// console.log("hide header");
	$(".nav").addClass("evilnav");
	$(".header").hide();
	header = false;
}

function scroll_callback() {
    var y_scroll_pos = window.pageYOffset;
    var header_hide_boundary = 180; 
    // console.log(y_scroll_pos);            

    if (y_scroll_pos >= header_hide_boundary && header === true)  { 
		hide_header();
	} else if (y_scroll_pos < header_hide_boundary && header === false) {
		show_header();
	}
}

$(window).on('scroll', scroll_callback);

// .css("position", "fixed") 
// .switchClass( "nav", "evilnav")