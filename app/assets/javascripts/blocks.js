jQuery(document).ready(function() {
	$('#grid-content .dog a').qtip({
		content: 'Select any block as a starting point. You will have 20 minutes to build your block.',
		style: {
			classes: 'ui-tooltip-rounded ui-tooltip-shadow ui-tooltip-green'
		}
	});
	
	$('#grid-content .place').each(function()
	{
		$(this).qtip({													
		content: 'I&rsquo;m ' + $(this).attr("data-dog") + '! ' + 'Click Me!',			 	
		style: {
			classes: 'ui-tooltip-rounded ui-tooltip-blue'
		}
		});
	});
		
	$('#grid-content .reserve a').qtip({
		content: 'This block is Reserved!',
		style: {
			classes: 'ui-tooltip-rounded ui-tooltip-blue'
		}
	});
	
	
	$('#grid-content .place').click(function(e){
		
		e.preventDefault();
		var src = $(this).attr('href');
	
		$.ajax(
			{
							
			url: src,
			type: 'POST',
			dataType: 'json',
			
			success:function(data){
				var html_str = data.html;
				var newdiv = $('<div/>').html(html_str);
				
				$.modal(newdiv,{
					closeHTML:"<a href='#' title='Close' class='modal-close'></a>",
					containerCss:{
					backgroundColor:"#fff",
					borderColor:"#fff",
					padding:0,
					width:450
				},
					autoResize:true,
					close:true,
					onClose: function (dialog) {
						dialog.data.fadeOut('slow', function () {
							dialog.container.hide('slow', function () {
								dialog.overlay.slideUp('slow', function () {
									$.modal.close();
								});
							});
						});
					},
					onOpen: function (dialog) {
						dialog.overlay.fadeIn('slow', function () {
							dialog.data.hide();
							dialog.container.fadeIn('slow', function () {
								dialog.data.slideDown('slow');
							});
						});
					}										
				});				
			}		
		});
		
	});


	$('#preview').click(function(e){
		
		e.preventDefault();
		var src = $(this).attr('href');
	
		$.ajax(
			{
							
			url: src,
			type: 'POST',
			dataType: 'json',
			
			success:function(data){
				var html_str = data.html;
				var newdiv = $('<div/>').html(html_str);
				
				$.modal(newdiv,{
					closeHTML:"<a href='#' title='Close' class='modal-close'></a>",
					containerCss:{
					backgroundColor:"#fff",
					borderColor:"#fff",
					padding:0,
					width:450
				},
					autoResize:true,
					close:true,
					onClose: function (dialog) {
						dialog.data.fadeOut('slow', function () {
							dialog.container.hide('slow', function () {
								dialog.overlay.slideUp('slow', function () {
									$.modal.close();
								});
							});
						});
					},
					onOpen: function (dialog) {
						dialog.overlay.fadeIn('slow', function () {
							dialog.data.hide();
							dialog.container.fadeIn('slow', function () {
								dialog.data.slideDown('slow');
							});
						});
					}										
				});				
			}		
		});	
		
	});
	
	if ($(".rotator_block").length > 0){
		theRotator('rotator_block');
	}
	
	


});
