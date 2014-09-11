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

//     $.post('/speciesnames', function(species) {
//         autocomplete('#species-input-instructions', species);
//     });

//     var autocomplete = function(selector, species) {
//         $(selector).autocomplete({
//             source: species,
//             minLength: 3
//         });
//     };

//     var hideAllOverlays = function() {
//         $(".overlay").hide();
//     };

//     //search link, shows modal

//     $('#search-link').on('click', function() {
//         hideAllOverlays();
//         $("#search.overlay").show();
//     });

//     //random animal link, shows modal

//     $('#random-animal-link').on('click', function() {
//         hideAllOverlays();
//         $.get('/species/random', function(data) {
//             $("#species-card.overlay").html(data);
//             $("#species-card.overlay").show();
//         });
//     });

//     //animal modal

//     $('.card').on('click', function(event) {
//         event.preventDefault();
//         hideAllOverlays();
//         $("#species-card.overlay").show();
//     });

//     $('.overlay').on('click', '.exit', hideAllOverlays);

//     //relative links for animal modal

//     $(document).on('click', '.relative.card', function(event) {
//         event.preventDefault();
//         hideAllOverlays();
//         var animalId = $(this).attr('id')
//         $.get('/card', {
//             animal_id: animalId
//         }, function(data) {
//             $("#species-card.overlay").html(data);
//             $("#species-card.overlay").show();
//         });
//     });

//     //search modal

//     $('#species-search-input-submit').on('click', function(event) {
//         event.preventDefault();
//         hideAllOverlays();
//         var searchInput = $('#species-search-input').val();
//         $.post('/species/search', {
//             animal: searchInput
//         }, function(data) {
//             $("#species-card.overlay").html(data);
//             $("#species-card.overlay").show();
//         });
//     });

    //add card to collection
    $("body").on("submit", ".add-card-button", function(event) {
        console.log(this);
        event.preventDefault();
        event.stopPropagation();
        var specId = parseInt($(this).find('.current-species-id').text());
        console.log(specId);
        var data = {
            species_id: specId
        };
        console.log(data);
        $.post('/add_to_collection', data, function(message) {
            console.log(message);
        });
    });

//     // my collection card modal

//     $(document).on('click', '.card', function(event) {
//         event.preventDefault();
//         event.stopPropagation();
//         hideAllOverlays();
//         var animalId = $(this).attr('id')
//         $.get('/card', {
//             animal_id: animalId
//         }, function(data) {
//             $("#species-card.overlay").html(data);
//             $("#species-card.overlay").show();
//         });
//     });

//     $('.overlay').on('click', '.exit', hideAllOverlays);

//     //search for species in database
//     // $('#species-search').on('submit', function(event){
//     // 	event.preventDefault();
//     // 	var species = $('input').val();
//     // 	$.post('/species', {species: species}, function(foundSpecies){
//     // 		console.log(foundSpecies)
//     // 	});
  });

 });

//end doc ready
