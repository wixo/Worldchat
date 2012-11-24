// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

var $geolocate = document.querySelector('a.geolocate');

if ( navigator.geolocation ) {
	navigator.geolocation.getCurrentPosition(function( p ) {
		$geolocate && ($geolocate.href = 'http://localhost:4000/chatrooms?lat='+p.coords.latitude+'&long='+p.coords.longitude);
	});
} else {
	error('not supported');
}