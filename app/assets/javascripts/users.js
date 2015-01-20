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
  // Typeahead for card names
  var cardnames = new Bloodhound({
    datumTokenizer: function (card){
      return Bloodhound.tokenizers.obj.whitespace(card.name)
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: 'https://api.deckbrew.com/mtg/cards/typeahead?q=%QUERY',
    }
  });
  // initialize the bloodhound suggestion engine
  cardnames.initialize();

  // instantiate the typeahead UI
  $('.card_name_users .cardname_users_typeahead').typeahead(null, {
    name: 'cardnames',
    displayKey: 'name',
    source: cardnames.ttAdapter()
  });

  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substrRegex;
   
      // an array that will be populated with substring matches
      matches = [];
   
      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i');
   
      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          // the typeahead jQuery plugin expects suggestions to a
          // JavaScript object, refer to typeahead docs for more info
          matches.push({ value: str });
        }
      });
   
      cb(matches);
    };
  };

  if (typeof window.gon !== 'undefined') {
    var cardsets_users = gon.cardsets_users;
  }  
   
  $('#cardset_users .cardset_users_typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'cardsets',
    displayKey: 'value',
    source: substringMatcher(cardsets_users)
  });
});
