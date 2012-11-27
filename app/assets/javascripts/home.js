// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

!!window.CW ? 
	CW.bu = $('body').data('url') : 
	(function() {
		CW    = {};
		CW.bu = $('body').data('url');
	})();


var $geolocate = $('a.geolocate'),
    $alert     = $('div.alert'),
    $cookLat   = $.cookie('worldchat_lat'),
    $cookLong  = $.cookie('worldchat_long');

if( !!$cookLat && !!$cookLong ) {

	CW.lat || (CW.lat = $cookLat);
	CW.lng || (CW.lng = $cookLong);
	$alert.length && $alert.hide();
	$geolocate.attr('href','/chatrooms?lat='+CW.lat+'&long='+CW.lng);
	$geolocate.slideDown();

} else {

	if( navigator.geolocation ) {
		navigator.geolocation.getCurrentPosition(function( p ) {
			$geolocate.length && 
				(function(){
					$.cookie('worldchat_lat',p.coords.latitude);
					$.cookie('worldchat_long',p.coords.longitude);

					$alert.length && $alert.fadeOut();

					$geolocate.attr('href','/chatrooms?lat='+p.coords.latitude+'&long='+p.coords.longitude);
					$geolocate.slideDown();
				})();
		});
	} else {
		error('not supported');
	}

}