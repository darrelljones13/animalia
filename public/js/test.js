$(document).ready(function(){
    $(window).resize(function(){
      resizeIcons();
    });
    resizeIcons();
    preloadIconImages(1, 3) // order images
    // CARD CLICKS **********************************
    $(".bar").on("click", ".icons", function(event) {
        $(this).parent().scrollTop($(this).position());
        $('.icons').css("height", "");
        var level = $(this).parent().attr("class").split(' ')[0];
        var next = (parseInt(level) + 1);
        moveTaxonomyForward(this, next);
        resizeIcons();
        if(next === 8) {
            // prepare species detail
            clearSpeciesDetail();
            populateSpeciesDetail(this, next);
            // move view to species detail
            $(".bar.species").addClass("active");
        }else{
            populateCards(this, next);
        }
    });
});

function resizeIcons() {
    $(".icon-fake").each(function() {
        width = $(this).width();
        $(this).css("height", width);
    });
    $(".icons").each(function() {
        width = $(".icon-fake").width();
        $(this).css("height", width);
    });
    $(".bar.selected .icons").each(function() {
        width = $(this).width();
        $(this).css("height", width);
    });
};

function moveTaxonomyForward(clicked, next) {
    $(".selected").removeClass("selected");
    $("." + next).addClass("selected").removeClass("inactive");
    $("." + next).children(".icons").remove();

    for(var i = next; i <= 7; i++) {
        $("." + i).removeClass("active").children(".icons").remove();
    };
    $(clicked).siblings().removeClass("breadcrumb")
    $(clicked).addClass("breadcrumb");

}

function populateCards(clicked, next) {
    var id = $(clicked).children('.hidden-id').text()
    request = $.get("/ajax/" + id + "/"+ next,
        function(data,status) {
            data.forEach( function(object) {
                $(".bar." + next).append('<div class="icons"><img src="' + object['image'] + '" /><h4>' + object['name'] + '</h4><span class="hidden-id">' + object['id'] + '</span></div>');
        });
    });
    request.done(function() {
        resizeIcons();
        preloadIconImages(id, next);
    });
}

function preloadIconImages(clicked, next) {
    $('.preload-image-container').empty();
    request = $.get("/preload/" + clicked + "/"+ next,
        function(data) {
            data.forEach( function(object) {
                $('.preload-image-container').append('<img src="' + object['image'] + '" />');
        });
    });
}

function populateSpeciesDetail(clicked, next) {
    var request = $.get("/ajax/" + $(clicked).children('.hidden-id').text() + "/"+ next, function(data,status){
        $(".description").html(data['description']);
        $(".range").text(data['range']);
        $(".habitat").text(data['habitat']);
        $(".major_threats").text(data['major_threats']);
        $(".card-container h3").text(data['name']);
        $(".red_list_status").text(data['status']);
        $(".population_trend").text(data['trend']);
        $(".bar .hierarchy .kingdom").html(data['taxonomy']['kingdom']);
        $(".bar .hierarchy .phylum").html(data['taxonomy']['phylum']);
        $(".bar .hierarchy .class").html(data['taxonomy']['class']);
        $(".bar .hierarchy .order").html(data['taxonomy']['order']);
        $(".bar .hierarchy .family").html(data['taxonomy']['family']);
        $(".bar .hierarchy .genus").html(data['taxonomy']['genus']);
        $(".bar .hierarchy .species").html(data['taxonomy']['species']);
        $(".detail img").attr("src", $(clicked).children("img").attr("src"));
    });
    request.done(function() {
        resizeIcons();
    });
}

function clearSpeciesDetail() {
    $(".description").html("");
    $(".detail h3").text("");
    $(".red_list_status").text("");
    $(".population_trend").text("");
    $(".bar .hierarchy .kingdom").html("");
    $(".bar .hierarchy .phylum").html("");
    $(".bar .hierarchy .class").html("");
    $(".bar .hierarchy .order").html("");
    $(".bar .hierarchy .family").html("");
    $(".bar .hierarchy .genus").html("");
    $(".bar .hierarchy .species").html("");
    $(".detail img").attr("src", "");
}


