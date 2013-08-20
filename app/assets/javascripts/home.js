function theRotator(rotator_class) {
  //Set the opacity of all images to 0
  $('div.' + rotator_class+ ' ul li').css({opacity: 0.0});
  
  //Get the first image and display it (gets set to full opacity)
  $('div.' + rotator_class+ ' ul li:first').css({opacity: 1.0});
  
  //Call the rotator function to run the slideshow, 6000 = change to next image after 6 seconds
  
  $('div.' + rotator_class+ ' ul li.show').removeClass('show');
  $('div.' + rotator_class+ ' ul li:first').addClass('show');
  
  setInterval(function(){rotate(rotator_class);},5000);
  
}

function rotate(rotator_class) { 
  //Get the first image
  var current = ($('div.' + rotator_class+ ' ul li.show')?  $('div.' + rotator_class+ ' ul li.show') : $('div.' + rotator_class+ ' ul li:first'));

    if ( current.length == 0 ) current = $('div.' + rotator_class+ ' ul li:first');

  //Get next image, when it reaches the end, rotate it back to the first image
  var next = ((current.next().length) ? ((current.next().hasClass('show')) ? $('div.' + rotator_class+ ' ul li:first') :current.next()) : $('div.' + rotator_class+ ' ul li:first'));
  
  //Un-comment the 3 lines below to get the images in random order
  
  //var sibs = current.siblings();
        //var rndNum = Math.floor(Math.random() * sibs.length );
        //var next = $( sibs[ rndNum ] );
      

  //Set the fade in effect for the next image, the show class has higher z-index
  next.css({opacity: 0.0})
  .addClass('show')
  .animate({opacity: 1.0}, 400);

  //Hide the current image
  current.animate({opacity: 0.0}, 400)
  .removeClass('show');
  
};

$(document).ready(function() {    
  //Load the slideshow
  
  theRotator('rotator');
  $('div.rotator').fadeIn(1000);
    $('div.rotator ul li').fadeIn(1000); // tweek for IE
   
   
  //Get Started - select Non Profit, login, sign up
  $(".select_div").hide();
  $('#partial_login').hide();
  $('#partial_signup').hide();
  
    
  $('.duplicate').click(function(){  	
	  	var $id_room = '';
		if ($('.select_div').show()){
		  $(".select_div").hide();
		}
	
		//$('#dog_id').val($(".dog_id", $(this).parent()).val());		
		
		var $id_room = $(this).attr('id_room');	
		var $dog_id	= $(".dog_id", $(this).parent()).val();	
			
		params = {dog_id:$dog_id, id:$id_room}
		$.post("/home/getstarted_form",params, function(data) {
	
			if(data['status'] == 'success') {
				id = data['id'];
				$("#select_" + id).html(data['html']);
				$('#select_' + id).slideToggle("slow");
				$('#select_non').focus();
			}
					
		});  
  return false;
    
 });			
 
  $('.new').click(function(){  
	  	var $id_room = '';
		if ($('.select_div').show()){
			$(".select_div").hide();
	  	}	  	
		
		var $id_room = $(this).attr('id_room');
		var $dog_id = '';
		
		params = {dog_id:$dog_id, id:$id_room}
		$.post("/home/getstarted_form",params, function(data) {
	
			if(data['status'] == 'success') {
				id = data['id'];
				$("#select_" + id).html(data['html']);
				$('#select_' + id).slideToggle("slow");
				$('#select_non').focus();
			}
					
		}); 
	  
	return false;
  	  
  }); 
  

  $('#log_button').click(function(){ 
  
   if ($('#partial_signup').show()){
  	 $('#partial_signup').hide();
  	}
  	
  	if ($('#partial_login').hide()){
  		 $('#partial_login').show();
  	}else{		
  		 $('#partial_login').hide();
  	}

	return false;
  });
  
  $('#sign_button').click(function(){ 
	
	if ($('#partial_login').show()){
  		 $('#partial_login').hide();
  	}
 
	if ($('#partial_signup').hide()){
  		 $('#partial_signup').show();
  	}else{		
  		 $('#partial_signup').hide();
  	}
  	
 
	
	return false;
  });
  
  $("#sign_up_next").click(function(){
  	// $(".sign_up_confirm").show();
  	// $(".select_np_signup").show();
  	// console.log('test');
  	// $.ajax({
  		// type:"post",
  		// url: "/search-near",
  		// data: {'address':$('#address').val(), 'location_radius':$('#user_location_radius')},
  		// dataType:'html',
  		// success:function(response) {
  			// console.log('ajax success');
  			// $('#step2').html(response);
  		// },
  		// error:function() {
  			// console.log("error");
  		// }
  	// });
  	$('#new_user').submit();
  	//$(this).hide();
  });
  
  
  $("#getstarted_gonp").click(function(){
  	window.location.href = '/nonprofit/' + $("select", $(this).parent()).val();
  	return false;
  });
    
    
    
});

  

