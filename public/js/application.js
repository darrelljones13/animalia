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
    	minLength: 3
  	});
	};

	var hideAllOverlays = function() {
		$(".overlay").hide();
	};

	//search link, shows modal

	$('#search-link').on('click', function() {
		hideAllOverlays();
		$("#search.overlay").show();
	});	

	//random animal link, shows modal

	$('#random-animal-link').on('click', function() {
		hideAllOverlays();
		$.get('/species/random', function(data) {
			$("#species-card.overlay").html(data);
			$("#species-card.overlay").show();
		});
	});

	//animal modal

  $('.card').on('click', function(event) {
    event.preventDefault();
    hideAllOverlays();
    $("#species-card.overlay").show();
  });
  
  $('.overlay').on('click', '.exit',  hideAllOverlays);

  //relative links for animal modal
	
	$(document).on('click', '.relative.card', function(event) {
		event.preventDefault();
		hideAllOverlays();
		var animalId = $(this).attr('id')
		$.get('/card', {animal_id: animalId}, function(data) {
			$("#species-card.overlay").html(data);
			$("#species-card.overlay").show();
		});
	});

	//search modal

	$('#species-search-input-submit').on('click', function(event) {
		event.preventDefault();
		hideAllOverlays();
		var searchInput = $('#species-search-input').val();
		$.post('/species/search', {animal: searchInput}, function(data) {
			$("#species-card.overlay").html(data);
			$("#species-card.overlay").show();
		});
	});
		
   //probably not finished
  $("#add-card-button").on("click", function(event) {
  	event.preventDefault();
  	event.stopPropagation();
  	var specId = parseInt($('#current-species-id').html());
  	$.post('/add_to_collection', {species_id: specId}, function(message) {
		console.log(message);
	});	
  });
  
  // my collection card modal

  $(document).on('click', '.card', function(event) {
    event.preventDefault();
    event.stopPropagation();
    hideAllOverlays();
    var animalId = $(this).attr('id')
    $.get('/card', {animal_id: animalId}, function(data) {
      $("#species-card.overlay").html(data);
      $("#species-card.overlay").show();
    });
  });

    $('.overlay').on('click', '.exit',  hideAllOverlays);

	//search for species in database
	// $('#species-search').on('submit', function(event){
	// 	event.preventDefault();
	// 	var species = $('input').val();
	// 	$.post('/species', {species: species}, function(foundSpecies){
	// 		console.log(foundSpecies)
	// 	});
	// });

});

//end doc ready
