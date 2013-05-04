jQuery(document).ready(function() {

	$("#grid-content-readonly .place").click(function(){		
		
		$("#grid-content-readonly .place").removeClass('selected');		
		$(this).addClass('selected');				
		$("#grid-content-readonly .place_option").remove();
		
		var new_div = $("<div/>", {"class" : 'place_option'});	
		var left = parseInt($(this).css('left')) + parseInt($(this).css('width'));
		new_div.css('left', left + 'px' );
		new_div.css('top', $(this).css('top'));
				
		var button_del = $("<input />", {"class" : 'place_option_button', "type": "button","value": "Delete"});			
		var button_edit = $("<input />", {"class" : 'place_option_button', "type": "button","value": "Edit"});	
		var button_view = $("<input />", {"class" : 'place_option_button', "type": "button","value": "View"});
		var button_send = $("<input />", {"class" : 'place_option_button', "type": "button","value": "Send email to owner"});	
			
		$(this).parent().append(new_div);
		new_div.append(button_del);
		new_div.append(button_edit);
		new_div.append(button_view);
		new_div.append(button_send);
		
		var imgref = $(this);
		var room_id = imgref.attr("data-room_id")				
		var email = imgref.attr('data-user')
		
		$(button_del).click(function(){
			var res=confirm("Are you sure that you want to delete this block");
				if (res==true){				
					$.ajax({
				        url: '/remove_room/'+ room_id,
				        type: 'POST',
				        dataType: 'json',
				        success: function(data, textStatus, xhr) {
				        	if (data.valid){			        	
				        		imgref.remove();
				        		$("#grid-content-readonly .place_option").remove();
				        	}
				        	else{				        	
				        		$.Zebra_Dialog('<strong>Error</strong>, There was an error deleting the block.', {
								    'type':     'error',
								    'title':    'Error'
								});
				        	}
				        }
			        });
				}
				else{
					$("#grid-content-readonly .place_option").remove();
				}			 
		});
	
		$(button_edit).click(function(){
			window.location = "/admin/blocks/" + room_id + "/edit"
		});
		
		$(button_view).click(function(){
			window.location = "/admin/blocks/" + room_id
		});
		
		$(button_send).click(function(){						
			window.location = "/admin/send_mail/" + '?' + $.param({addresses: email});
			
		});
		
	});
	
	
	
});