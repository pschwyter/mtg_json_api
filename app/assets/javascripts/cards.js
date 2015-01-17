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
});