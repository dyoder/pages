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
    if ( failed.size() == 0 ) {
		if ($("ul.selected h3").length == 1) {
	 		var tag = "";
			if($('ul.selected h3')[0].textContent == "Gallery")
				tag = "gallery.images";
				else
				tag = "blog.entries";
	    		$('ul.selected li').each( function() {
		    		$(this).replaceWith("<input type=hidden name="+tag+" value="+$(this)[0].id+">");
				});
		}
		form.submit(); 
	}
    return false;
  });
  
  
});
