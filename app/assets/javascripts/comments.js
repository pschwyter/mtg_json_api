// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	var trade_id = $('#trade-comments').data('trade-id');
	if (trade_id != undefined) {
		setInterval(function(){
			$.ajax({
				type: 'GET',
				url: '/trades/' + trade_id + '/comments'
			});
		}, 1000)
	}
});