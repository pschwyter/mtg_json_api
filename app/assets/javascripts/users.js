$(document).on('ready page:load', function() {

	navigator.geolocation.getCurrentPosition(function(position) {
	  $.post(
	  		"/users/whereami", 
	  		{ lato: position.coords.latitude, longo: position.coords.longitude }
	  ).done(function(){
	  	console.log("I see you Majick Daddy!")
	  }).fail(function(){
	  	console.log("Your location is too hot for me Majick Daddy!")
	  });
	});
})