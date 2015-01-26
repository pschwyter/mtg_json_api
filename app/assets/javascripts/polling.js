$(document).ready(function(){

	var page_load_latest_message_id = $('.comment').last().data('id')
	var trade_id = $('#trade-comments').data('trade-id');
	if (trade_id != undefined) {
		var interval = setInterval(function(){
			if ($('.js-menu').hasClass('is-active')) {
				var last_comment_id = $('#comments-container .comment').last().data('id');
			} else {
				var last_comment_id = 0;
			};
			$.ajax({
				type: 'GET',
				data: { 'last_comment_id': last_comment_id},
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
			// clear interval if left page
			if ($('.js-menu').length == 0) {
				clearInterval(interval);
			}
		}, 1000)
	}

	// Updating nav-bar trade notification
	setInterval(function(){
		$.ajax({
				type: 'GET',
				url: '/update_nav_bar_unaccepted_trades_count'
			});
	}, 1000)
});