$(document).ready(function() {


	$('#species-search').on('submit', function(event){
		event.preventDefault();
		var species = $('input').val();
		$.post('/species', {species: species}, function(foundSpecies){
			console.log(foundSpecies)


		});
	});


});//end doc ready
