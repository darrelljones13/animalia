$(document).ready(function() {

	//get species data from database
	$.post('/speciesnames', function(species){
		autocomplete("#species-search-input", species);
	});

	$.post('/speciesnames', function(species) {
		autocomplete('#species-input-instructions', species);
	});

	var autocomplete = function(selector, species) {
		$(selector).autocomplete({
			source: species,
    	minLength: 3,
  	});
	}

	var hideAllOverlays = function() {
		$(".overlay").hide();
	};

	$('#search-link').on('click', function() {
		hideAllOverlays();
		$("#search.overlay").show();

	});	

	$('#random-animal-link').on('click', function() {
		hideAllOverlays();
		$("#species-card.overlay").show();

	});
	
	$('.overlay .exit').on('click', hideAllOverlays)


  // _____________________________
  // This is the card modal

  $('.card').on('click', function(event) {
    event.preventDefault();
    hideAllOverlays();
    $("#species-card.overlay").show();

  });
  
  $('.overlay .exit').on('click', hideAllOverlays)
  // ______________________________

    
 

    //probably not finished
    $("#add-card-button").on("click", function(event) {
    	event.preventDefault();
    	event.stopPropagation();
    	var specId = parseInt($('#current-species-id').html());
    	$.post('/add_to_collection', {species_id: specId}, function(message) {
			console.log(message);
		}); 
    });
    
	//search for species in database
	// $('#species-search').on('submit', function(event){
	// 	event.preventDefault();
	// 	var species = $('input').val();
	// 	$.post('/species', {species: species}, function(foundSpecies){
	// 		console.log(foundSpecies)
	// 	});
	// });

});//end doc ready
