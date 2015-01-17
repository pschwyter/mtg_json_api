// Loads inventory list by default on visiting user page

$('.users.show').ready(function(){
	var user_id = $("#user").data("id");
	$(user_id).css("background-color","#F7977A");
	$.ajax({
	      type: "GET",
	      dataType: "script",
	      url: "/fetch_inventory/" + user_id
	  }); 	
})