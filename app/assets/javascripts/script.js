"use strict";

var $j = jQuery.noConflict();

var searchJobsItems;
var showedBlogPost = 9;

var AOS;
var isNeeded;

var file_api = ( window.File && window.FileReader && window.FileList && window.Blob ) ? true : false;

// Random number function
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
};


// Parallax function
function parallaxIt(target, movement){

    // var $this = $j('.hero');
    // var timeout = getRandomInt(3500, 5000);
    //
    // TweenMax.to(target, (timeout/1000), {
    //     x: getRandomInt(-30,30),
    //     y: getRandomInt(-30,30)
    // });
    //
    // setInterval(function() {
    //     TweenMax.to(target, (timeout/1000), {
    //         x: getRandomInt(-50,40),
    //         y: getRandomInt(-50,40)
    //     });
    // }, (timeout/2));

    // $j($this).mousemove(function(e) {
    //     var relX = e.pageX - $this.offset().left;
    //     var relY = e.pageY - $this.offset().top;
    //
    //     TweenMax.to(target, 1, {
    //         x: (relX - $this.width()/2) / $this.width() * movement,
    //         y: (relY - $this.height()/2) / $this.height() * movement
    //     });
    // });

    $j(document).on("scroll", function() {

        TweenMax.to(target, 0, {
            y: ($j(window).scrollTop()) / movement * (-10),
            rotation: ($j(window).scrollTop())  / movement * 2
        });
    });

};

// Check if element is viewed in broswer window
function isScrolledIntoView(elem) {
    var docViewTop = $j(window).scrollTop();
    var docViewBottom = docViewTop + $j(window).height();

    var elemTop = $j(elem).offset().top;
    var elemBottom = elemTop + $j(elem).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
};

function orbAppearanceAnimation(target, direction) {

    switch (direction) {

        case 'topToBottom':
            TweenMax.to(target, 0, { y: -1000 });
            $j(target).css('opacity', 1);
            TweenMax.to(target, 2.5, { y: 0, ease: Expo.easeOut, delay: 0.5 });
            break;

        case 'leftToRight':
            TweenMax.to(target, 0, { x: -500 });
            $j(target).css('opacity', 1);
            TweenMax.to(target, 2.5, { x: 0, ease: Expo.easeOut, delay: 0.5 });
            break;

        case 'rightToLeft':
            TweenMax.to(target, 0, { x: 500 });
            $j(target).css('opacity', 1);
            TweenMax.to(target, 2.5, { x: 0, ease: Expo.easeOut, delay: 0.5 });
            break;
    };
}

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

$j(document).on("turbolinks:before-cache", function() {
    $j('.hero__orb--1, .hero__orb--2, .hero__orb--3').css('opacity', 0);

    $j("#header").removeClass("header--open");
})

var is_safari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);

$j( document ).on('turbolinks:load', function() {

    // Safari fix
    // remove empty [file] before submit
    $j('form').bind('submit', function() {

        if (is_safari) {

            $j(this).find("input[type=file]").each(function(index, field){
                if ( !$j(field).val() ) {
                    $j(field).remove();
                }
            });
        }

    });

    // Add/remove background to header on scroll
    $j(window).on("scroll", function() {
        var heroBg = $j('.hero').css('background-color');
        if ($j(window).scrollTop() > 50) {
            $j('.header').css('background-color', heroBg);
            $j('.header').addClass('header--scroll');
        } else {
            $j('.header').css('background-color', 'rgba(255,255,255,0)');
            $j('.header').removeClass('header--scroll');
        }
    });

    // Hero dropdown scroll to content on click
    $j('.hero__dropdown').on('shown.bs.collapse', function (e) {
        var $panel = $j(this).find('.show');
        var headerHeight = $j('.header').height();
        $j('html,body').animate({
            scrollTop: $panel.offset().top - headerHeight + 2
        }, 1000);
    });

    // Initialize orbAppearanceAnimation
    orbAppearanceAnimation('.hero__orb--1', 'topToBottom');
    orbAppearanceAnimation('.hero__orb--2', 'leftToRight');
    orbAppearanceAnimation('.hero__orb--3', 'rightToLeft');

    // Initialize parallax
    parallaxIt('.hero__orb--1', 10);
    parallaxIt('.hero__orb--2', 20);
    parallaxIt('.hero__orb--3', 15);


    // Nav toggle
    $j("#headerNavToggle").on("click", function (e) {
        e.preventDefault();
        $j("#header").toggleClass("header--open");
    });

    $j('#search_job_submit_btn').on('click', function (e) {
        $j(this).val('Searching...');
    });

    // Smooth scrolling to internal links
    $j('body').on('click', 'a[href^="#"]', function (e) {
        e.preventDefault();
        if ($j(this).hasClass("carousel-control-prev") || $j(this).hasClass("carousel-control-next")) {
            return
        }
        ;
        var target = this.hash;
        var $target = $j(target);

        $j('html, body').stop().animate({
            'scrollTop': $target.offset().top
        }, 900, 'swing');
    });

    // Remove empty value attribute
    $j(this).find('option').filter(function() {
        return !this.value || $j.trim(this.value).length == 0;
    }).removeAttr('value');

    // Initialize Select2
    $j('.js-select2').each(function () {
        $j(this).prepend('<option></option>');
        var placeholder = $j(this).data('placeholder');
        $j(this).select2({
            minimumResultsForSearch: -1,
            placeholder: placeholder,
            allowClear: true
        });
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
    $j('.form__file').change(function () {
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
    $j(".members__show-all-btn").on("click", function (e) {
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
    $j(".blog-posts__load-more-btn").on("click", "button", function (e) {
        e.preventDefault();
        $j(".blog-posts__item:not(:nth-child(-n+9))").slideToggle('medium', function () {
            if ($j(this).is(':visible'))
                $j(this).css('display', 'block');
        });

        $j(".blog-posts__load-more-btn").slideToggle();
    });

    // Bootstrap accordion fix
    $j("#accordion").children().click(function (e) {
        if ($j(e.currentTarget).siblings().children(".collapsing").length > 0) {
            return false;
        }
    })


    // Initialize AOS
    if (AOS) {
        AOS.init({
            once: true,
            offset: -300
        });
    };

    isNeeded = vhCheck('ios-gap');
});

document.addEventListener("turbolinks:before-cache", function() {
    // destroy select2 elements
    $j('.js-select2').each(function () {
        $j(this).select2('destroy');
    });

    // clean blue hover effect
    searchJobsItems = document.querySelectorAll(".search-current-jobs  .result__vacancy");
    for (var i = 0; i < searchJobsItems.length; i++) {

        var overlay = $j(this).find(".vacancy__descr");
        overlay.css({ 'left' : '', 'top': '' });
    }
});