$(document).ready(function(){
  // debugger
  console.log("ready!")
	
  $('input').focus()

  //hide the link when it is clicked
	$('.clickable').click(function(){
			console.log("hide!")
	    $(this).hide()
	})

	$('#help_toggle').click(function(){
		console.log("toggle!")
		$('#help_toggle_msg').toggle()
	})


	//AJAX time
	$('form').submit(function(e) {
		console.log("ajax!")
		e.preventDefault()
		$.ajax({
			url: "/ajax",
			method: "POST",
			data: $('form').serialize()
		}).done(function(response){
			console.log(response)
			
			var result = jQuery.parseJSON(response)

			if (result.alert_msg) {
				$('#alert_ajax').text(result.alert_msg)
				$('#alert_ajax').show()

			}
			else {
				
				console.log("save")

				display_result(result)
				update_table(result)
			}
		 
			console.log("end of ajax form submit")
		})
	})



	// **********************************************************
	// Keypress
	$('#input_url').keypress(function() {
		console.log("keypress")
		
		var url = $('#input_url').val()
		console.log(url)

		$.ajax({
			url: "/ajax_key",
			method: "POST",
			data: $('form').serialize()
		}).done(function(response){
			console.log(response)

			if (response) {
				var result = jQuery.parseJSON(response)
				
				console.log("save")
			
				display_result(result)
				update_table(result)
			}
		 
			console.log("end of ajax form submit")
		})



	})

	// ***********************************************************
	// Reusable functions
	// display result msg
	function display_result(result){
		$('#result_ajax').empty()
		$('#result_ajax').show()
		$('#result_ajax').append("<p> your new link is: </p>" 
			+ '<a href="' + result.short + '">' + result.short + '</a>')
	}

	// update table with the new inserted row
	function update_table(result) {
		$('#table_url').append('<tr class="clickable"><td>' + result.long + '</td>' + 
			'<td><a href="' + result.short + '">' + result.short + '</a></td>' +
			'<td>' + result.click_count + '</td></tr>')
	}



}) // end of document ready