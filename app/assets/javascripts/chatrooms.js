// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(function() {

	var $chatroom     = $('ul.chatroom'),
	    $times        = $('time.timeago'),
	    $messageInput = $('div.message-input > input');

	$times.length && $('time.timeago').timeago();
	$chatroom.length && ($chatroom[0].scrollTop = $chatroom[0].scrollHeight);

	$chatroom.length && (function() {
		

		// Enable pusher logging - don't include this in production
		Pusher.log = function(message) {
		  if (window.console && window.console.log) window.console.log(message);
		};

		// Flash fallback logging - don't include this in production
		WEB_SOCKET_DEBUG = true;

		var pusher = new Pusher('97fede60c81562795cb1');
		var channel = pusher.subscribe('worldchat');

		channel.bind('wc:create:'+$chatroom.data('venue'), function(data) {
		  console.log(data)
		  $message = $('<li>').attr('class','message');
		  $('<div>').attr('class','author chatroom-part part').html(data.user_name).appendTo($message);
		  $('<div>').attr('class','content chatroom-part part').html(data.content+' ').appendTo($message);
		  $('<time>').attr('class','date-time chatroom-part part timeago').attr('datetime',data.created_at).timeago().appendTo($message);

		  $chatroom.length && $message.appendTo($chatroom);

		  $chatroom[0].scrollTop = $chatroom[0].scrollHeight;

		  $messageInput.val('').focus();
		});
	})();

})