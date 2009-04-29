$(document).ready( function() {
  $("input[type='file']").keypress( function(e) { return false; });
  $('div.panel').hover( function() {
    $(this).css({ border: '1px solid #333'});
    $(this).find('h2, h3').css({color: '#333' });
  }, function() {
    $(this).find('h2, h3').css({color: '#999' });
    $(this).css({ border: '1px solid #999'});
  });
});
