$(document).ready( function() { 
  $('div.quick_add a.open').click( function() {
    $(this).hide(); $(this).next().slideDown();
  });
  $('div.quick_add a.close').click( function() {
    var form = $(this).parent();
    form.slideUp('normal', function() {
      $(this).prev().show();
    });
  });
  
});