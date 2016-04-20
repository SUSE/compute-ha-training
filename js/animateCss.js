// From https://github.com/daneden/animate.css
jQuery.fn.extend({
    animateCss: function (animationName) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        $(this).addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
        });
    }
});

Reveal.addEventListener('ready', function () {
    //var arrow = document.querySelector('#evacuate-architecture img.arrow');
    Reveal.addEventListener('fragmentshown', function (event) {
        var fragment = jQuery(event.fragment);
        if (fragment.is("#evacuate-architecture img.arrow")) {
            fragment.animateCss('slideInRight');
        }
    });
});
