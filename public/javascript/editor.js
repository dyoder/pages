$(document).ready( function() {
  $('a.delete').click( function() {
    var href = $(this).attr('href');
    $(this).hide();
    $(this).after(
     "<div class='confirmation'>Delete: are you sure? " +
     "<a class='yes'>Yes</a> " +
     "<a class='no'>No</a></div>"
    );
    $('a.yes').click( function() {
      var el = this;
      $.blockUI("Okay, just a second ...", 
        { 'font-weight': 'bold', border: 'none' });
      $.ajax({ 
        type: 'delete', 
        url: href, 
        success: function() { 
          window.location = '/admin';
        },
        error: function() {
          $.unblockUI();
          $(el).parent().hide().after("<div class='confirmation'>Delete failed.</div>")
        }
      });
    });
    $('a.no').click( function() {
      $(this).parent().hide();
      $('a.delete').show();
    });
    return false;
  });
  $('input.date').change( function(e) {
    var date = Date.parse( $(this).val() );
    if ( date === null ) { date = Date.today(); }
    $(this).val( date.toString('yyyy-MM-dd'));
  });
  
}); 
