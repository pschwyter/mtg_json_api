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

  // Trying to get card search auto-complete to work!
  var cards = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: 'http://api.mtgdb.info/search/'
  });

  // initialize the bloodhound suggestion engine
  cards.initialize();

  // instantiate the typeahead UI
  $('.typeahead').typeahead(null, {
    displayKey: 'value',
    source: cards.ttAdapter()
  });

  // Adding cards to search users by
  $('#add-card').ajaxForm(
    {url: '/return_first_search_result',
     type: 'post',
     success: function() {
      console.log($('#card-id').data("id"));
      var card_id = $('#card-id').data("id")
      $.ajax({
        type: "POST",
        dataType: "script",
        url: "/find_users_by/" + card_id
      }); 

     }
    }
  )

});




