$(document).ready( function(){
  
  // center a slide in the slideshow ... NOT for use otherwise ...
  var centerSlide = function() {
    // this is triggered off the CONTENT of the slide, not the slide itself,
    // so we first must get the slide and then the frame ...
    var slide = $(this).parent(); var frame = slide.parent();
    
    // next, make it possible to get the width/height of the slide ...
    slide.css({visibility:'hidden',display:'block',position:'absolute'});
    
    // we can use jQuery for the frame because it was displayed to begin with
    // but for some reason I get weird values using CSS height/width for the slide
    // so we will just use the offset* functions
    var top = Math.round(( frame.height() - slide[0].offsetHeight ) / 2);
    var left = Math.round(( frame.width() - slide[0].offsetWidth ) / 2);
    
    // set the padding, and restore the slide to display: none ... and we're done
    slide.css({ 
      'padding-top': top + 'px', 'padding-left': left+'px',
      visibility:'visible', display:'none'
    });
  };

  // first, go ahead and center non-images - 
  // use of first-child ensures that we don't call it multiple times
  $('div.slide > *:first-child:not(img)').each( centerSlide ); 
  
  // do the same thing for images on the load event to ensure that the
  // browser has the image actually loaded ...
  $('div.slide > img:first-child').load( centerSlide );
  
  // whent the img for the loading slide is itself loaded, go ahead
  // and show it while we wait for the rest of the images to load
  $('div.slide.loading img').load( function() { $(this).parent().show();  } );
  
  // once the first few images have loaded (or all of them if there are
  // fewer than 3), go ahead and get rid of the loading slide and start
  // the slideshow, using the cycle plug-in ... note there must be at least
  // one image in the slideshow, which is okay, because it is for a gallery
  var images = $('div.slide img'); var size = images.size();
  images.eq( ( size > 3 )? 3 : size ).load( function() { 
    $('div.slide.loading').fadeOut(4000, function() { 
      $(this).remove();
      $('div.slide:first-child').fadeIn(4000, function() {
        $('div.gallery div.frame').cycle({
          fx:'fade', timeout: 5000, speed:2000
        });
      });
    });
  });
});