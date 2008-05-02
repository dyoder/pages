$(document).ready( function() {
  // replace submit buttons with links
  $('input[type="submit"]').each( function() {
    $(this).replaceWith("<a class='submit' href='#'>"+$(this).val()+"</a>");
  });
  // click handlers for submit buttons
  // also check for required values
  $('a.submit').click( function() {
    var form = $(this).parents('form');
    var failed = form.find('.required')
      .filter( function() { return $(this).val() == '' ; } )
      .addClass('error')
      .after("<p class='error'>Required field.</p>");
    if ( failed.size() == 0 ) { form.submit(); }
    return false;
  });
  
  
});
