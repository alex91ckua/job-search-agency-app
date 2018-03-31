"use strict";

var $j = jQuery.noConflict();

var searchJobsItems;
var showedBlogPost = 9;

var file_api = ( window.File && window.FileReader && window.FileList && window.Blob ) ? true : false;


// Parallax function for hero section
function parallaxIt(e, target, movement){
  var $this = $j('.hero');
  var relX = e.pageX - $this.offset().left;
  var relY = e.pageY - $this.offset().top;

  TweenMax.to(target, 1, {
    x: (relX - $this.width()/2) / $this.width() * movement,
    y: (relY - $this.height()/2) / $this.height() * movement
  })
};


// Carousel that shows only on mobile resolution
function owlCarouselMobileOnly(item) {
  var owl = $j(item),
    owlOptions = {
      loop: true,
      items: 1,
      nav: true,
      dots: true
    };

  if ($j(window).outerWidth() < 768) {
    var owlActive = owl.owlCarousel(owlOptions);
  } else {
    owl.addClass('off');
  }

  $j(window).resize(function() {
    if ($j(window).outerWidth() < 768) {
      if ($j('.owl-carousel').hasClass('off')) {
        var owlActive = owl.owlCarousel(owlOptions);
        owl.removeClass('off');
      }
    } else {
      if (!$j('.owl-carousel').hasClass('off')) {
        owl.addClass('off').trigger('destroy.owl.carousel');
        owl.find('.owl-stage-outer').children(':eq(0)').unwrap();
      }
    }
  });
};


// Direction Aware Hover
function directionAwareHover(item) {

  for (var i = 0; i < item.length; i++) {

    item[i].onmouseenter = function(e) {
      var x = e.pageX - getCoords(this).left;
      var y = e.pageY - getCoords(this).top;
      var edge = closestEdge(x, y, this.clientWidth, this.clientHeight);
      var overlay = $j(this).find(".vacancy__descr");

      switch (edge) {
        case "left":
          //tween overlay from the left
          $j(overlay).css("top", "0%");
          $j(overlay).css("left", "-100%");
          TweenMax.to(overlay, .5, {
            left: '0%'
          });
          break;
        case "right":
          $j(overlay).css("top", "0%");
          $j(overlay).css("left", "100%");
          //tween overlay from the right
          TweenMax.to(overlay, .5, {
            left: '0%'
          });
          break;
        case "top":
          $j(overlay).css("top", "-100%");
          $j(overlay).css("left", "0%");
          //tween overlay from the right
          TweenMax.to(overlay, .5, {
            top: '0%'
          });
          break;
        case "bottom":
          $j(overlay).css("top", "100%");
          $j(overlay).css("left", "0%");
          //tween overlay from the right
          TweenMax.to(overlay, .5, {
            top: '0%'
          });
          break;
      }
    };

    item[i].onmouseleave = function(e) {
      var x = e.pageX - getCoords(this).left;
      var y = e.pageY - getCoords(this).top;
      var edge = closestEdge(x, y, this.clientWidth, this.clientHeight);
      var overlay = $j(this).find(".vacancy__descr");

      switch (edge) {
        case "left":
          TweenMax.to(overlay, .5, {
            left: '-100%'
          });
          break;
        case "right":
          TweenMax.to(overlay, .5, {
            left: '100%'
          });
          break;
        case "top":
          TweenMax.to(overlay, .5, {
            top: '-100%'
          });
          break;
        case "bottom":
          TweenMax.to(overlay, .5, {
            top: '100%'
          });
          break;
      }
    };
  }
};


// Detect Closest Edge for "Direction Aware Hover"
function closestEdge(x, y, w, h) {
  var topEdgeDist = distMetric(x, y, w / 2, 0);
  var bottomEdgeDist = distMetric(x, y, w / 2, h);
  var leftEdgeDist = distMetric(x, y, 0, h / 2);
  var rightEdgeDist = distMetric(x, y, w, h / 2);
  var min = Math.min(topEdgeDist, bottomEdgeDist, leftEdgeDist, rightEdgeDist);
  switch (min) {
    case leftEdgeDist:
      return "left";
    case rightEdgeDist:
      return "right";
    case topEdgeDist:
      return "top";
    case bottomEdgeDist:
      return "bottom";
  }
};

// Distance Formula for "Direction Aware Hover"
function distMetric(x, y, x2, y2) {
  var xDiff = x - x2;
  var yDiff = y - y2;
  return (xDiff * xDiff) + (yDiff * yDiff);
};

// Get coordinates of element
function getCoords(elem) { // кроме IE8-
  var box = elem.getBoundingClientRect();

  return {
    top: box.top + pageYOffset,
    left: box.left + pageXOffset
  };
};


// Map handler
function contcatsMapHandler() {
  var initUrl = $j(".nav-desktop__item:first").data("map");
  setMap(initUrl);

  // Handler for mobile links
  $j(".location__nav-mobile").on("click", function() {
    setMap($j(this).data("map"));
  });

  // Handler for desktop links
  $j(".nav-desktop__item").on("click", function() {
    setMap($j(this).data("map"));
  });
};


// Set map function
function setMap(url) {
  if (url == undefined) { return };
  $j(".contacts__map").css('background-image', 'url("' + url + '")');
};


$j( document ).on('turbolinks:load', function() {

    $j(document).ready(function() {

      $j('#search_job_submit_btn').on('click',function (e) {
        $j(this).val('Searching...');
      });

      // Smooth scrolling to internal links
      $j('a[href^="#"]').on('click',function (e) {
          e.preventDefault();
        if ($j(this).hasClass("carousel-control-prev")  || $j(this).hasClass("carousel-control-next")) { return };
          var target = this.hash;
          var $target = $j(target);

        $j('html, body').stop().animate({
          'scrollTop': $target.offset().top
        }, 900, 'swing');
      });


      // Nav toggle
      $j("#headerNavToggle").on("click", function(e) {
        e.preventDefault();
        $j("#header").toggleClass("header--open");
      });


      // Initialize Select2
      $j('.js-select2').each(function() {
        var placeholder = $j(this).data('placeholder');

        $j(this).select2({
          minimumResultsForSearch: -1,
          placeholder: placeholder
        });
      });


      // Initialize parallax
      $j('.homepage .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -40);
        parallaxIt(e, '.hero__orb--2', 10);
        parallaxIt(e, '.hero__orb--3', -20);
      });

      $j('.current-jobs .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -10);
      });

      $j('.client-services .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -10);
      });

      $j('.contact-us .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -10);
      });

      $j('.about-us .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -10);
      });

      $j('.blog-page .hero').mousemove(function(e){
        parallaxIt(e, '.hero__orb--1', -10);
      });


      // Initialize quotes owlCarousel
      $j(".quotes .owl-carousel").owlCarousel({
        items: 1,
        loop: true,
        nav: true,
        dots: true,
        autoplay: true,
        autoplayTimeout: 10000
      });


      // Initialize current-jobs owlCarousel
      owlCarouselMobileOnly('.charter__items');
      owlCarouselMobileOnly('.our-team .owl-carousel');


      // Initialize Stats owlCarousel
      $j(".stats__slider").owlCarousel({
        items: 1,
        loop: true,
        nav: true,
        dots: true,
        autoplay: true,
        autoplayTimeout: 10000
      });


      // Initialize Direction Aware Hover
      searchJobsItems = document.querySelectorAll(".search-current-jobs  .result__vacancy");
      directionAwareHover(searchJobsItems);


      // File input handler
      $j('.form__file').change(function() {
        var fullPath = $j(this).find("input").val();
        if (fullPath) {
          var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
          var fileName = fullPath.substring(startIndex);
          if (fileName.indexOf('\\') === 0 || fileName.indexOf('/') === 0) {
              fileName = fileName.substring(1);
          }
          $j(this).find(".file__info").html("Attached: " + fileName);
          $j(this).find(".file__btn").addClass("file__btn--added-file");
        }
      });

      // Our team - "load more" handler
      $j(".members__show-all-btn").on("click", function(e) {
        e.preventDefault();
        if ($j(window).outerWidth() < 992) {
          $j(".our-team__member:not(:nth-child(-n+2))").slideToggle();
        } else {
          $j(".our-team__member:not(:nth-child(-n+3))").slideToggle();
        }
        $j(".our-team__members--hide").removeClass("our-team__members--hide");
        $j(".members__join-our-team-btn").slideToggle();
        $j(".members__show-all-btn").slideToggle();
      });


      // Init map handler
      contcatsMapHandler();


      // Blog page - load more btn Handler
      $j(".blog-posts__load-more-btn  button").on("click", function(e) {
        e.preventDefault();
        $j(".blog-posts__item:not(:nth-child(-n+9))").slideToggle('medium', function() {
          if ($j(this).is(':visible'))
              $j(this).css('display','block');
        });

        $j(".blog-posts__load-more-btn").slideToggle();
      });

        // Bootstrap accordion fix
        $j("#accordion").children().click(function (e) {
            if ($j(e.currentTarget).siblings().children(".collapsing").length > 0 ) {
                return false;
            }
        })

    });
});