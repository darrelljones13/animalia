$(document).ready(function() {

	//get species data from database
	$.post('/speciesnames', function(species){
		$( "#species-input" ).autocomplete({
			source: species,
    	minLength: 3,
  	});	
	});



// Triggered when focus is moved to an item (not selecting). The default action is to replace the text field's value with the value of the focused item, though only if the event was triggered by a keyboard interaction.


	//search for species in database
	$('#species-search').on('submit', function(event){
		event.preventDefault();
		var species = $('input').val();
		$.post('/species', {species: species}, function(foundSpecies){
			console.log(foundSpecies)
		});
	});

});//end doc ready
