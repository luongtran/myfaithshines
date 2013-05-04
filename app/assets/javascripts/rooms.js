$(document).ready(function() {

    if ($('#counter1').length > 0)
    {
	    $($('#counter1').get(0)).countdown({
	              image: '/assets/digits.png',
	              startTime: minutes + ":"+ seconds,
	              timerEnd: function(){ 
	                    $('#counter_wrapper').remove();
	              },
	              format: 'mm:ss',
	    });
	}
});


