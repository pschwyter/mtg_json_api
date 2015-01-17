$(document).on('ready page:load', function() {

	navigator.geolocation.getCurrentPosition(function(position) {
	  $.post(
	  		"/users/whereami", 
	  		{ lato: position.coords.latitude, longo: position.coords.longitude }
	  ).done(function(){
	  	console.log("I see you Majick Daddy! You are at" )
	  	console.log(position.coords.latitude, position.coords.longitude)

	  }).fail(function(){
	  	console.log("Your location is too hot for me Majick Daddy!")
	  });
	});

  // Kinda dumb bourbon mixin
  $('.accordion-tabs').each(function(index) {
    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
  });

  $('.accordion-tabs').on('click', 'li > a', function(event) {
    if (!$(this).hasClass('is-active')) {
      event.preventDefault();
      var accordionTabs = $(this).closest('.accordion-tabs');
      accordionTabs.find('.is-open').removeClass('is-open').hide();

      $(this).next().toggleClass('is-open').toggle();
      accordionTabs.find('.is-active').removeClass('is-active');
      $(this).addClass('is-active');
    } else {
      event.preventDefault();
    }
  });

  // Adding cards to search users by
  $('#add-card').ajaxForm(
    {url: '/return_first_search_result',
     type: 'post'
    }
  )
});
