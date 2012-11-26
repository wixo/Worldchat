// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

!!window.CW ? 
	CW.bu = $('body').data('url') : 
	(function() {
		CW    = {};
		CW.bu = $('body').data('url');
	})();


var $geolocate = $('a.geolocate');

if ( navigator.geolocation ) {
	navigator.geolocation.getCurrentPosition(function( p ) {
		$geolocate.length && 
			(function(){
				$geolocate.slideDown();
				$geolocate.attr('href','/chatrooms?lat='+p.coords.latitude+'&long='+p.coords.longitude);
			})();
	});
} else {
	error('not supported');
}