/*
function add_click()
{
	$(".wrong", $(this).parent()).remove();
	var gift_code = $(this).prevAll("input[type='text']").val().trim();
	var add_button = $(this);
	
	var found = false;
	
	add_button.parent().prevAll().each(function(){
		if ($(".gift_code_field", $(this)).val() == gift_code)
		{
			if ($(this) == gift_code)
			{
				found = true;
				return;
			}
		}
	});
	
	
	if (!found)
	{
		if (gift_code.length > 0)
		{
			$.ajax({
		        url: '/add_gift_code/'+ $("#non_profit_id").val() + "/" + gift_code,
		        type: 'POST',
		        dataType: 'json',
		        success: function(data, textStatus, xhr) {
		        	if (data.valid)
		        	{
		        		if (data.remaining_value > 0)
		        		{
			        		add_button.parent().append($("<span />").attr('class', 'redeem').html('$' + data.remaining_value));
			        		
			        		var div_line = $('<div />').attr('class', 'gift_code_line');
				
							$('<label />').html(parseInt($(".gift_code").length + 1) + ":").appendTo(div_line);
							$('<input type="text" />', {name: 'gift_code'}).attr('class', 'gift_code gift_code_field').appendTo(div_line);
							
							
							var fields = $(".gift_code_fields");
							var del_gift = $(".del_gift_code", fields);
							var add_gift = $(".add_gift_code", fields);
							
							if (del_gift.length == 0)
							{
								del_gift = $('<img />', {src: "/assets/cross.png"}).attr("class", "del_gift_code");
								del_gift.click(del_click);
							}
							del_gift.appendTo(div_line);
					
							
							if ($(".gift_code").length < 5)
							{
								add_button.appendTo(div_line);
							}
							else
							{
								add_button.hide();
							}
							
							div_line.hide();
							$(".gift_code_fields").append(div_line);
							div_line.slideDown();
						}
						else
						{
							add_button.parent().append($("<span />").attr('class', 'wrong').html('The gift code has not remaining value'));
						}
		        	}
		        	else
		        	{
		        		add_button.parent().append($("<span />").attr('class', 'wrong').html('The gift code is not valid for this non-profit.'));
		        	}
		        }  
	        });
         }
         else
         {
         	$(this).parent().append($("<span />").attr('class', 'wrong').html('Please enter a valid gift code'));
         }
	}
	else
	{
		$(this).parent().append($("<span />").attr('class', 'wrong').html('Repeated gift codes are not allowed'));
	}
}
function del_click()
{
	var gift_line = $(this).parent();
	var previous_line = gift_line.prev();
	
	$(".redeem", previous_line).remove();
	
	if ($(".gift_code").length > 2)
	{
		previous_line.append($(this));
	}
	else
	{
		$(this).hide();
	}
	
	var add_gift_code = $(".add_gift_code");
	previous_line.append(add_gift_code);
	add_gift_code.show();
	gift_line.slideUp('normal', function(){
		$(this).remove();
	});
}
*/

$(document).ready(function() {
	
	if ($("input[name='gift_code_has']:checked").val() == 'No'){
		$(".gift_code_fields").hide();
	}
	
	//$(".edit_reservation_popup").hide();

	$("input[name='gift_code_has']").change(function(){
	    if ($("input[name='gift_code_has']:checked").val() == 'Yes'){
	    	$(".wrong", $(".gift_code_fields")).remove();
	    	$(".gift_code_fields").slideDown();
	    }
	    else
	    {
	    	
	    	$(".gift_code_fields").slideUp('normal', function()
	    	{
	    		$(".add_gift_code", $(this)).appendTo($(".gift_code_line"));
	    		$(".gift_code_fields").find(".gift_code_line:gt(0)").remove();
	    		$("input[type=text].gift_code", $(this)).val('');
	    		$(".redeem", $(this)).remove();
	    	});
	    }
	  });
	  
	$(".code_validate").click(function(){
		$(this).parent().find('.wrong').remove();
		var gift_code = $(this).prevAll("input[type='text']").val().trim();
		if (gift_code.length > 0)
		{
			validate_button = $(this);
			$.ajax({
		        url: '/add_gift_code/'+ $("#non_profit_id").val() + "/" + gift_code,
		        type: 'POST',
		        dataType: 'json',
		        success: function(data, textStatus, xhr) {
		        	if (data.valid)
		        	{	        			
						if (data.remaining_value <= 0)
		        		{
			        		validate_button.parent().append($("<span />").attr('class', 'wrong').html('The gift code has not remaining value'));
						}
						else
						{							
							if (data.code_is_empty == true)
							{
								validate_button.parent().append($("<span />").attr('class', 'wrong').html('This gift code in empty. Please enter a different code.'));
							}
							else
							{
							validate_button.parent().find('.wrong').remove();
							if (data.showInBlocks != "")
							{
								$(".code_value").html(data.showInBlocks);
								
								$(".option-container").each(function(index)
								{	
									$_option = $(this).find("input[name='option_id']");
									$price = $(this).find(".price")
									if ($_option.val() != data.option_id)
									{
										$(this).attr("class", "option-container-disabled");	
										//$(this).attr("style", "display:none");	
										$price.html("This block is not available");	
									}
								});
								
							}
							else
							{
								$(".code_value").html('$' + data.redeem_value);
							}
			        			
							}
							
						}							
						
		        	}
		        	else
		        	{		    
		      		    validate_button.parent().append($("<span />").attr('class', 'wrong').html('The gift code is not valid for this non-profit.'));
	
		        	}
		        }  
	        });
         }
         else
         {
         	$(this).parent().append($("<span />").attr('class', 'wrong').html('Please enter a valid gift code'));
         }
	});
	/*$(".add_gift_code").click(add_click);
	$(".del_gift_code").click(del_click);
	*/
	$(".option-container").click(function(){
		
		//var gift_codes = [];
		//$(".gift_code").each(function(index, value){
		//	if ($(this).val().trim().length > 0)
		//	{
		//		gift_codes.push($(this).val().trim());
		//	}
		//});

		make_reserve = function(option_container){

			option_id = $("[name='option_id']", option_container).val()
    		$("#manual_overlay").show();
			$("#manual_loading").show();
			if ($("[name='create_new']", option_container).val() == 'true') {
        		$.ajax(
        			{
        				url: '/confirm/new_reserve/'+option_id,
        				type: 'POST',
        				dataType: 'json',
        				success:function(data, textStatus, xhr) {
        					$("#manual_overlay").hide();
							$("#manual_loading").hide();
				        	if (data.success)
				        	{
				        		window.location.href = $("[name='redirect']", option_container).val() ;	
				        	}
				        	else
				        	{
					        	$.Zebra_Dialog('<strong>Reservation error</strong>, There was an error validating your reservation. Please try again later.', {
								    'type':     'error',
								    'title':    'Error'
								});
							}
        				}
        				
        			}
        		);
    		}
    		else if($("[name='create_new']", option_container).val() == 'false') 
    		{
    				$.ajax(
        			{
        				url: '/confirm/update_reserve/'+ option_id,
        				type: 'POST',
        				dataType: 'json',
        				success:function(data, textStatus, xhr) {
        					$("#manual_overlay").hide();
							$("#manual_loading").hide();
				        	if (data.success)
				        	{
				        		window.location.href = $("[name='redirect']", option_container).val() ;	
				        	}
				        	else
				        	{
					        	$.Zebra_Dialog('<strong>Reservation error</strong>, There was an error validating your reservation. Please try again later.', {
								    'type':     'error',
								    'title':    'Opps'
								});
							}
        				}
        				
        			}
        		);
    		}
		}

		$gcode = $(".gift_code").val();
        if ($gcode == ""){
        	make_reserve($(this));
        }
        else
        {
        	var option_container = $(this);
			$.ajax({																		// gift_codes.join(",")
		        url: '/validate_gift_codes/'+ $("#non_profit_id").val() + '?gift_codes='+ $gcode ,
		        type: 'POST',
		        dataType: 'json',
		        success: function(data, textStatus, xhr) {
		        	if (data.valid)
		        	{
			        	option_id = $("[name='option_id']", option_container).val()
			        	
			        	$.ajax({
					        url: '/validate_block_option/' + option_id + "/" + $("#non_profit_id").val() + "/" + $gcode,
					        type: 'POST',
					        dataType: 'json',
					        success: function(data, textStatus, xhr) {
			        			if (data.valid)
			        			{
		        					make_reserve(option_container);
			        			}
			        		}	
			        	});

		        	}
		        	else
		        	{
		        		$.Zebra_Dialog('Gift code invalid. Please re-enter your gift code.', {
						    'type':     'error',
						    'title':    'Opps'
						});
		        	}
		        }
	        });
        }
		
		
		
		
	});
	
	$(".checkout_btn").click(function(){
		var ap = $("#associate_producer_id").val();
		if (ap == ""){
			ap = 0
		}
		$.ajax(
			{
				url: '/reservation/'+ $("#reserve").val() + '/save_ap/' + ap,
				type: 'POST',
				dataType: 'json',
				success:function(data, textStatus, xhr) {
		        	if (data.success)
		        	{
		        		$(".build_another_overlay").show();
						$(".build_another_popup").fadeIn(200);
		        	}
		        	else
		        	{
			        	$.Zebra_Dialog('<strong>Reservation error</strong>, There was an error validating your reservation. Please try again later.', {
						    'type':     'error',
						    'title':    'Error'
						});
					}
				}
				
			}
		);	
		
	});


	$(".edit_reservation").click(function(){	
		$(".build_another_overlay").show();
		$(".edit_reservation_popup").fadeIn(200);
		
	});
	

	$(".PaypalSubmit").click(function(){	
		
		if ( $("#associate_producer_id").val() == "") {			
			$("#paypal_form").submit();
		} else{
			
			$.ajax(
				{
					
					url: '/reservation/'+ $("#invoice").val() + '/save_ap/' + $("#associate_producer_id").val(),
					type: 'POST',
					dataType: 'json',
					success:function(data, textStatus, xhr) {
			        	if (data.success)
			        	{
			        		$("#paypal_form").submit();
			        	}
			        	else
			        	{
				        	$.Zebra_Dialog('<strong>Reservation error</strong>, There was an error validating your reservation. Please try again later.', {
							    'type':     'error',
							    'title':    'Error'
							});
						}
					}
					
				}
			);	
		};			
		return false;
	});
	
	$(".GiftSubmit").click(function(){
		
		if ( $("#associate_producer_id").val() == "") {
			window.location.href = "/confirm_purchase"
			
		} else{
			
			$.ajax(
				{
					url: '/reservation/' + $("#reserve").val() +'/save_ap/'+ $("#associate_producer_id").val(),
					type: 'POST',
					dataType: 'json',
					success:function(data, textStatus, xhr) {
			        	if (data.success)
			        	{		        		
			        		window.location.href = "/confirm_purchase"
			        	}
			        	else
			        	{
				        	$.Zebra_Dialog('<strong>Reservation error</strong>, There was an error validating your reservation. Please try again later.', {
							    'type':     'error',
							    'title':    'Error'
							});
						}
					}
					
				}
			);
		};
		return false;	  
	});
	
	$("#add_entity_wrapper").find("#tabs").tabs();
	
	if ($("#existing_dog_type").length > 0)
	{
		if ($("#existing_dog_type").val() == 3)
		{
			$("#add_entity_wrapper").find("#tabs").tabs('select', 1);
		}
		else
		{
			if ($("#existing_dog_type").val() == 2)
			{
				$("#add_entity_wrapper").find("#tabs").tabs('select', 2);
			}
		}
		
		
	}
	
	var onMouseOutOpacity = 0.67;
	$('#thumbs ul.thumbs li').opacityrollover({
		mouseOutOpacity:   onMouseOutOpacity,
		mouseOverOpacity:  1.0,
		fadeSpeed:         'fast',
		exemptionSelector: '.selected'
	});
	
	// Initialize Advanced Galleriffic Gallery
	if ($('#tabs_wishihave #thumbs').length > 0)
	{
		var gallery = $('#tabs_wishihave #thumbs').galleriffic({
			delay:                     2500,
			numThumbs:                 10,
			preloadAhead:              10,
			enableTopPager:            false,
			enableBottomPager:         false,
			imageContainerSel:         '#slideshow',
			controlsContainerSel:      '#controls',
			captionContainerSel:       '#caption',
			loadingContainerSel:       '#loading',
			renderSSControls:          false,
			renderNavControls:         false,
			enableHistory:             false,
			autoStart:                 false,
			syncTransitions:           true,
			defaultTransitionDuration: 900,
			onSlideChange:             function(prevIndex, nextIndex) {
				// 'this' refers to the gallery, which is an extension of $('#thumbs')
				this.find('ul.thumbs').children()
					.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
					.eq(nextIndex).fadeTo('fast', 1.0);
			},
			onPageTransitionOut:       function(callback) {
				this.fadeTo('fast', 0.0, callback);
			},
			onPageTransitionIn:        function() {
				this.fadeTo('fast', 1.0);
			}
		});
		if ($("#existing_dog_id").val().length > 0 && $("#existing_dog_type").length > 0 && $("#existing_dog_type").val() == 2)
		{
			link = $("[data-dogid="+ $("#existing_dog_id").val() + "]", $("#thumbs")).find("a");
			if (link.length > 0)
			{
				$.galleriffic.gotoImage(link.attr('href').replace(/^.*#/, '').replace(/\?.*$/, '') );
			}
		}
		
	}
	
	
	$("#add_entity_wrapper #submit_entity").click(function()
	{
		var post_review = function(id)
		{
			$.post('/reserve/add_dog', {dog_id: id}, function(data) {
               if (data.success == true) {
                 window.location = '/reserve/review';
               }
               else
               {
               		$.Zebra_Dialog('<strong>An error ocurred creating the dog</strong>, Try again later.', {
					    'type':     'error',
					    'title':    'Error'
					});
               }
             });
		}
		
		if ($("#tabs_iknow").attr('aria-hidden') == 'false')	{
			$(".create_entity1").submit();	
   		
   		}
   		else 
   			if ($("#tabs_wishihave").attr('aria-hidden') == 'false'){
				var dog_id = $("ul.thumbs li.selected").attr("data-dogid");
				post_review(dog_id);
		}
		else 
			if ($("#tabs_memorial").attr('aria-hidden') == 'false'){
				$(".create_entity3").submit();	
		}		
		
	});
});


