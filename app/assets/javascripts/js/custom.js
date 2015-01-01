/* -------------------- Placeholder for IE --------------------- */

jQuery(document).ready(function() {

	// Invoke the plugin
    $('input, textarea').placeholder();
    // That’s it, really.
    // Now display a message if the browser supports placeholder natively
    var html;
    
});

/* -------------------- Twitter --------------------- */

jQuery(document).ready(function($){
	
	$.getJSON('http://api.twitter.com/1/statuses/user_timeline/lukaszholeczek.json?count=3&callback=?', function(tweets){
		$("#twitter").html(tz_format_twitter(tweets));
	}); 

});

jQuery(document).ready(function($){
	
	/* ------------------- Fancybox --------------------- */

	(function() {

		$('[rel=image]').fancybox({
			type        : 'image',
			openEffect  : 'fade',
			closeEffect	: 'fade',
			nextEffect  : 'fade',
			prevEffect  : 'fade',
			helpers     : {
				title   : {
					type : 'inside'
				}
			}
		});

		$('[rel=image-gallery]').fancybox({
			nextEffect  : 'fade',
			prevEffect  : 'fade',
			helpers     : {
				title   : {
					type : 'inside'
				},
				buttons  : {},
				media    : {}
			}
		});


	})();
	
	
	/* ------------------- Client Carousel --------------------- */

	$('.clients-carousel').flexslider({
	    animation: "slide",
		easing: "swing",
	    animationLoop: true,
	    itemWidth: 200,
	    itemMargin: 1,
	    minItems: 1,
	    maxItems: 8,
		controlNav: false,
		directionNav: false,
		move: 2
      });


	/* ------------------ Back To Top ------------------- */

	jQuery('#under-footer-back-to-top a').click(function(){
		jQuery('html, body').animate({scrollTop:0}, 300); 
		return false; 
	});
	

	/* --------------------- Tabs ------------------------ */	

		(function() {

			var $tabsNav    = $('.tabs-nav'),
				$tabsNavLis = $tabsNav.children('li'),
				$tabContent = $('.tab-content');

			$tabsNav.each(function() {
				var $this = $(this);

				$this.next().children('.tab-content').stop(true,true).hide()
													 .first().show();

				$this.children('li').first().addClass('active').stop(true,true).show();
			});

			$tabsNavLis.on('click', function(e) {
				var $this = $(this);

				$this.siblings().removeClass('active').end()
					 .addClass('active');

				$this.parent().next().children('.tab-content').stop(true,true).hide()
															  .siblings( $this.find('a').attr('href') ).fadeIn();

				e.preventDefault();
			});

		})();
		
			
});

/* ------------------ Tooltips ----------------- */

jQuery(document).ready(function() {

    $('.tooltips').tooltip({
      selector: "a[rel=tooltip]"
    })

});

/* ------------------ Progress Bar ------------------- */	

jQuery(document).ready(function($){
	
	$(".meter > span").each(function() {
		$(this)
		.data("origWidth", $(this).width())
		.width(0)
		.animate({
			width: $(this).data("origWidth")
		}, 1200);
	});
});

/* ------------------- Parallax --------------------- */

jQuery(document).ready(function($){
	
	$('#da-slider').cslider({
		autoplay	: true,
		bgincrement	: 0
	});

});

/* ------------------ Image Overlay ----------------- */

jQuery(document).ready(function () {
	
	$('.picture').hover(function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link').stop().fadeTo(150, 1);
	},function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link').stop().fadeTo(150, 0);
	});
	
});

/* -------------------- Isotope --------------------- */

jQuery(document).ready(function () {
	
	$('#portfolio-wrapper').imagesLoaded(function() {
		
		var $container = $('#portfolio-wrapper');
			$select = $('#filters select');

		// initialize Isotope
		$container.isotope({
		// options...
		resizable: false, // disable normal resizing
		// set columnWidth to a percentage of container width
	  	masonry: { columnWidth: $container.width() / 12 }
		});

		// update columnWidth on window resize
		$(window).smartresize(function(){
		
			$container.isotope({
			// update columnWidth to a percentage of container width
			masonry: { columnWidth: $container.width() / 12 }
			});
		});


		$container.isotope({
			itemSelector : '.portfolio-item'
		});

		$select.change(function() {
			
			var filters = $(this).val();

				$container.isotope({
					filter: filters
				});
			
			});

			var $optionSets = $('#filters .option-set'),
		  	$optionLinks = $optionSets.find('a');

		  	$optionLinks.click(function(){
			
				var $this = $(this);
				// don't proceed if already selected
				if ( $this.hasClass('selected') ) {
			  		return false;
				}
			var $optionSet = $this.parents('.option-set');
			$optionSet.find('.selected').removeClass('selected');
			$this.addClass('selected');

			// make option object dynamically, i.e. { filter: '.my-filter-class' }
			var options = {},
				key = $optionSet.attr('data-option-key'),
				value = $this.attr('data-option-value');
			// parse 'false' as false boolean
			value = value === 'false' ? false : value;
			options[ key ] = value;
			if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
			  // changes in layout modes need extra logic
			  changeLayoutMode( $this, options )
			} else {
			  // otherwise, apply new options
			  $container.isotope( options );
			}

			return false;
			
		  });
		
	});
	
});

/* ------------------ Icon Box Hover Effect ----------------- */

jQuery(document).ready(function () {
	
	$('.icons-box').hover(function () {
		
		firstClassName = $(this).find('i').attr('class').split(' ')[0];
		
		className = $(this).find('i').attr('class');
		
		$(this).find('i').removeClass(className);
		
		$(this).find('i').addClass(firstClassName).addClass('ico-white circle-white big-red');
		
		
	},function () {
		
		$(this).find('i').removeClass('ico-white circle-white big-red');
		
		$(this).find('i').addClass(className);
		
	});
	
});