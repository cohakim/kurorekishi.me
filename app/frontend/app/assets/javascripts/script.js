/**
*
* Detect Mobile Touch Support
*
**/

var touchSupport = false;
var eventClick = 'click';
var eventHover = 'mouseover mouseout';

(function(){
  if ('ontouchstart' in document.documentElement) {
    $('html').addClass('touch');
    touchSupport = true;
    eventClick = 'touchon touchend';
    eventHover = 'touchstart touchend';
  } else {
    $('html').addClass('no-touch');
  }
})();


/**
*
* Hides Adress Bar
*
**/

function hideAddressBar() {
  if(!window.location.hash) {
    if(document.documentElement.scrollHeight < window.outerHeight) {

      /* Expands Page Height if it's smaller than window */

      document.body.style.minHeight = (window.outerHeight + 60) + 'px';
      document.getElementById('container').style.minHeight = (window.outerHeight + 60) + 'px';
      document.getElementById('content-container').style.minHeight = (window.outerHeight + 60) + 'px';
    }

    setTimeout( function(){ window.scrollTo(0, 1); }, 0 );
  }
}

window.addEventListener('load', function(){ if(!window.pageYOffset){ hideAddressBar(); } } );


jQuery(document).ready(function($) {
  $('#sidemenu-container').toggleClass('active');
  $('#sidemenu-container').toggleClass('active');

  /**
  *
  * Touch Gestures
  *        &
  * Hover and Animation Triggers
  *
  **/

  /* Hover Effects */

  $('.portfolio-grid article a, .button, button, input[type="submit"], input[type="reset"], input[type="button"], #header a, .header-button, #nav-container a, .nav-child-container, .gallery-container a, #ps-custom-back').bind(eventHover, function(event) {
    $(this).toggleClass('hover');
  });

  /* Sidebar multi-level menu */

  $('.nav-child-container').bind(eventClick, function(event) {
    event.preventDefault();
    var $this = $(this);
    var ul = $this.next('ul');
    var ulChildrenHeight = ul.children().length * 46;

    if(!$this.hasClass('active')){
      $this.toggleClass('active');
      ul.toggleClass('active');
      ul.height(ulChildrenHeight + 'px');
    }else{
      $this.toggleClass('active');
      ul.toggleClass('active');
      ul.height(0);
    }
  });

  /* Sidebar Functionality */

  var opened = false;
  $('#menu-trigger').bind(eventClick, function(event) {
    $('#content-container').toggleClass('active');
    $('#sidemenu').toggleClass('active');
    if(opened){
      opened = false;
      setTimeout(function() {
        $('#sidemenu-container').removeClass('active');
      }, 500);
    } else {
      $('#sidemenu-container').addClass('active');
      opened = true;
    }
  });

  $('.nav a').bind('click', function(event) {
    event.preventDefault();
    var path = $(this).attr('href');
    $('#content-container').toggleClass('active');
    $('#sidemenu').toggleClass('active');
    setTimeout(function() {
      window.location = path;
    }, 500);
  });


  /**
  *
  * Flexslider
  *
  **/

  var $flexsliderContainer = $('.flexslider');

  if($flexsliderContainer.length > 0){
    $flexsliderContainer.flexslider({
      controlsContainer: ".flexslider-controls",
      prevText: '<span class="icon-left-open-big"></span>',
      nextText: '<span class="icon-right-open-big"></span>',
      slideshowSpeed: 5000,
      animationSpeed: 600,
      slideshow: true,
      smoothHeight: false,
      animationLoop: true,
    });
  }

});
