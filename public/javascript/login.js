$.getScript( '/javascript/base.js');
$(document).ready( function() { 
  // return out of password
  $('input[type="password"]').blur( function() {
    $(this).parents('form').submit();
  });
});