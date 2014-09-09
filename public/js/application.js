$(document).ready(function() {

	//get species data from database
	$.post('/speciesnames', function(species){
		autocomplete("#species-input", species);
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

	$('#instructions-link').on('click', function() {
		hideAllOverlays();
		$("#instructions.overlay").show();
	});

	$('#search-link').on('click', function() {
		hideAllOverlays();
		$("#search.overlay").show();

	});
	
	$('.overlay .exit').on('click', hideAllOverlays)

  // _____________________________
  // This is the card modal

  $('.card').on('click', function(event) {
    event.preventDefault();
    hideAllOverlays();
    $(".species-card.overlay").show();

  });
  
  $('.overlay .exit').on('click', hideAllOverlays)
  // ______________________________

 $(document).ready(function(){
    
    $(".container").on("click", ".row", function(event) {
        $(".row").removeClass("selected");
        $(this).addClass("selected");
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
