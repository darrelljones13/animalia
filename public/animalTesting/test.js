$(document).ready(function(){
    resizeCards();
    // BAR CLICKS **********************************
    // $(".container").on("click", ".bar.active", function(event) {
    //     var level = $(this).attr("id");
    //     var next = parseInt(level) + 1;
    //     console.log("hey")

    //     $(".bar").removeClass("selected");
    //     $(this).addClass("selected");

    //     setTimeout(function() {
    //         for(var x = 1; x < level; x++) {
    //             $("#" + x).addClass("active");
    //         }
    //     }, 300);

    // });

    // CARD CLICKS **********************************
    $(".bar").on("click", ".cards", function(event) {
        $('.cards').css("height", "");
        var level = $(this).parent().attr("id");
        var next = (parseInt(level) + 1);
        if(next === 8) {
            request = $.get("/ajax/" + $(this).children('.hidden-id').text() + "/"+ next,function(data,status){
                $(".description").html(data['description']);
                $(".detail h3").text(data['name']);
                $(".red_list_status").text(data['status']);
                $(".population_trend").text(data['trend']);
                $(".taxonomy .kingdom").html(data['taxonomy']['kingdom']);
                $(".taxonomy .phylum").html(data['taxonomy']['phylum']);
                $(".taxonomy .class").html(data['taxonomy']['class']);
                $(".taxonomy .order").html(data['taxonomy']['order']);
                $(".taxonomy .family").html(data['taxonomy']['family']);
                $(".taxonomy .genus").html(data['taxonomy']['genus']);
                $(".taxonomy .species").html(data['taxonomy']['species']);
            });
            request.done(function() {
                resizeCards();
            });
            // headed to species detail
            $(".bar.species").addClass(".active");

            $(".detail img").attr("src", $(this).children("img").attr("src"));

        }else{
            request = $.get("/ajax/" + $(this).children('.hidden-id').text() + "/"+ next,function(data,status){
                data.forEach( function(object) {
                    $("#" + next).append('<div class="cards"><img src="' + object['image'] + '" /><h4>' + object['name'] + '</h4><span class="hidden-id">' + object['id'] + '</span></div>');
                });
            });
            request.done(function() {
                resizeCards();
            });

        }
        $(".bar").removeClass("selected");
        $("#" + next).addClass("selected").removeClass("inactive");
        $("#" + next).children(".cards").remove();

        for(var i = next; i <= 7; i++) {
            $("#" + i).removeClass("active").children(".cards").remove();
        };
        $(this).siblings().removeClass("breadcrumb")
        $(this).addClass("breadcrumb");


    });


//
//    $(".bar.class").on("click", ".cards", function(event) {
//        $(".bar").removeClass("selected");
//        $(".bar.order").addClass("selected");
//        $(".cards").remove();
//        for(var i = 0; i < 20; i++) {
//            $(".bar.order").append('<div class=cards>NAME</div>')
//            $(".bar.order").append('<div class="cards odd">NAME</div>')
//        }
//
//    });

});

function resizeCards() {
    $(".cards").each(function() {
        width = $(this).width();
        $(this).css("height", width);
    });
};
