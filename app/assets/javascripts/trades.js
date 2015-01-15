// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  
  // Kinda dumb bourbon mixin
  $('.accordion-tabs').each(function(index) {
    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
  });

  $('.accordion-tabs').on('click', 'li > a', function(event) {
    if (!$(this).hasClass('is-active')) {
      event.preventDefault();
      var accordionTabs = $(this).closest('.accordion-tabs');
      accordionTabs.find('.is-open').removeClass('is-open').hide().addClass('is-closed');

      $(this).next().toggleClass('is-open').toggle().toggleClass('is-closed');
      accordionTabs.find('.is-active').removeClass('is-active');
      $(this).addClass('is-active');
      
      $('.is-closed.toggle-select select ').each(function(){
        $(this).attr('disabled','disabled');
      });
      $('.is-open.toggle-select select').each(function(){
        $(this).removeAttr('disabled');
      });

    } else {
      event.preventDefault();
    }
  });

  $('.initiator-qty').change(function(){
    $('#card-total-initiator').html(function(){
      var total = 0;
      $(".initiator-qty").each(function(){
        total += (parseInt($(this).val()) * $(this).data("price"));
      });
      return "$" + total
    });

  });

  $('.receiver-qty').change(function(){
    $('#card-total-receiver').html(function(){
      var total = 0;
      $(".receiver-qty").each(function(){
        total += (parseInt($(this).val()) * $(this).data("price"));
      });
      return "$" + total
    });

  });

  $('#card-total-initiator').html(function(){
      var total = 0;
      $(".initiator-qty").each(function(){
        total += (parseInt($(this).val()) * $(this).data("price"));
      });
      return "$" + total
    });

  $('#card-total-receiver').html(function(){
      var total = 0;
      $(".receiver-qty").each(function(){
        total += (parseInt($(this).val()) * $(this).data("price"));
      });
      return "$" + total
    });

});
