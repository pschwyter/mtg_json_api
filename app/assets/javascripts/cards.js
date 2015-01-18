// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	var cards = new Bloodhound({
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('card'),
	  queryTokenizer: Bloodhound.tokenizers.whitespace,
	  remote: {
	  	url: 'https://api.deckbrew.com/mtg/cards/typeahead?q=%QUERY',
	  }
	});
	// initialize the bloodhound suggestion engine
	cards.initialize();

	// instantiate the typeahead UI
	$('.custom-templates .typeahead').typeahead(null, {
	  name: 'cards',
	  displayKey: 'card',
	  source: cards.ttAdapter(),
	  templates: {
	    empty: [
	      '<div class="empty-message">',
	      'unable to find any Cards',
	      '</div>'
	    ].join('\n'),
	    suggestion: function(card){
        return  '<div id="user-selection">' +
                '<p><strong>' + card.name + '</strong></p>' +
                '<p>' + card.editions[0].set + '</p>' +
                '</div>' ;
      }
	  }
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
	var cardsets = gon.cardsets;
	 
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
	var cardtypes = gon.cardtypes;
	 
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
	var cardsubtypes = gon.cardsubtypes;
	 
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