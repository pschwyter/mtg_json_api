// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	var width = $('#artist').css('width');
	$('.name-input').css({'width': width});

	$(window).resize(function(){
		var width = $('#artist').css('width');
		$('.name-input').css({'width': width});	
	})

	$('.add-inventory').on('ajax:success', function(data){
		var card_name = $(this).data('card-name');
		$('#confirmation-message').html(
			'<div class="added-inventory-notice" id="card-notice">' +
				'<p>' + card_name +' added to Inventory</p>' +
			'</div>'
			);
		setTimeout(function() {
	    $('#card-notice').fadeOut('slow');
		}, 700);
	});

	$('.add-tradeable').on('ajax:success', function(){
		var card_name = $(this).data('card-name');
		$('#confirmation-message').html(
			'<div class="added-tradeable-notice" id="card-notice">' +
				'<p>'+ card_name+ ' added to Trade List</p>' +
			'</div>'
			);
		setTimeout(function() {
	    $('#card-notice').fadeOut('slow');
		}, 700);
	});

	$('.add-wanted').on('ajax:success', function(){
		var card_name = $(this).data('card-name');
		$('#confirmation-message').html(
			'<div class="added-wanted-notice" id="card-notice">' +
				'<p>'+ card_name + ' added to Wish List</p>' +
			'</div>'
			);
		setTimeout(function() {
	    $('#card-notice').fadeOut('slow');
		}, 700);
	});

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
	$('.custom-templates .typeahead').typeahead(null, {
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

	// Card SET - TYPEAHEAD
	if (typeof window.gon !== 'undefined') {
		var cardsets = gon.cardsets;
	}	 
	 
	$('#cardset .cardset_typeahead').typeahead({
	  hint: true,
	  highlight: true,
	  minLength: 1
	},
	{
	  name: 'cardsets',
	  displayKey: 'value',
	  source: substringMatcher(cardsets)
	});


	// CARD TYPE - TYPEAHEAD
	if (typeof window.gon !== 'undefined') {
		var cardtypes = gon.cardtypes;
	}

	$('#cardtype .cardtype_typeahead').typeahead({
	  hint: true,
	  highlight: true,
	  minLength: 1
	},
	{
	  name: 'cardtypes',
	  displayKey: 'value',
	  source: substringMatcher(cardtypes)
	});

	// CARD SUBTYPE - TYPEAHEAD
	if (typeof window.gon !== 'undefined') {
		var cardsubtypes = gon.cardsubtypes;
	}
	 
	$('#cardsubtype .cardsubtype_typeahead').typeahead({
	  hint: true,
	  highlight: true,
	  minLength: 1
	},
	{
	  name: 'cardsubtypes',
	  displayKey: 'value',
	  source: substringMatcher(cardsubtypes)
	});	

});