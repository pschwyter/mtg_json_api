$(document).ready(function(){

	// Updating comments partial
	var page_load_latest_message_id = $('.comment').last().data('id')
	var trade_id = $('#trade-comments').data('trade-id');
	if (trade_id != undefined) {
		setInterval(function(){
			$.ajax({
				type: 'GET',
				url: '/trades/' + trade_id + '/comments'
			});
			var latest_message_id = $('.comment').last().data('id');
			if ($('.js-menu').hasClass('is-visible')) {
					page_load_latest_message_id = latest_message_id;
					$('.message-badge').html('0');
				}
			if (latest_message_id > page_load_latest_message_id && $('.js-menu').hasClass('is-visible') == false ) {
					$('.message-badge').html('new!');
				}

		}, 2000)
	}

	// Updating nav-bar trade notification
	setInterval(function(){
		$.ajax({
				type: 'GET',
				url: '/update_nav_bar_unaccepted_trades_count'
			})
	}, 2000)
});