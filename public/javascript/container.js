$(document).ready( function() {
  if ( $.fn.draggable ) {
    $("#gallery-editor a.submit, #blog-editor a.submit").click( function(){
      var list = $('ul.container:first').find('a').map( function() {
        return $(this).attr('href').split('#')[1];
      }).get().join(', ');
      $("#gallery-editor input[name='selected'], #blog-editor input[name='selected']")
        .val( '[' + list + ']' );
    });
    $('ul.container:first').css({clear: 'both'})
    $('ul.container li').draggable({helper:'clone'});
    $('ul.container').droppable({
     accept: 'li', tolerance: 'touch', 
     drop: function(ev,ui) { $(this).append( ui.draggable.element ); }
    });
  }
});