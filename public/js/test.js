$(document).ready(function(){
    resizeIcons();
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
    $(".bar").on("click", ".icons", function(event) {
        $('.icons').css("height", "");
        var level = $(this).parent().attr("id");
        var next = (parseInt(level) + 1);
        if(next === 8) {
            request = $.get("/ajax/" + $(this).children('.hidden-id').text() + "/"+ next,function(data,status){
                $(".description").html(data['description']);
                $(".detail h3").text(data['name']);
                $(".red_list_status").text(data['status']);
                $(".population_trend").text(data['trend']);
                $(".hierarchy .kingdom").html(data['taxonomy']['kingdom']);
                $(".hierarchy .phylum").html(data['taxonomy']['phylum']);
                $(".hierarchy .class").html(data['taxonomy']['class']);
                $(".hierarchy .order").html(data['taxonomy']['order']);
                $(".hierarchy .family").html(data['taxonomy']['family']);
                $(".hierarchy .genus").html(data['taxonomy']['genus']);
                $(".hierarchy .species").html(data['taxonomy']['species']);
            });
            request.done(function() {
                resizeIcons();
            });
            // headed to species detail
            $(".bar.species").addClass(".active");

            $(".detail img").attr("src", $(this).children("img").attr("src"));

        }else{
            request = $.get("/ajax/" + $(this).children('.hidden-id').text() + "/"+ next,function(data,status){
                data.forEach( function(object) {
                    $("#" + next).append('<div class="icons"><img src="' + object['image'] + '" /><h4>' + object['name'] + '</h4><span class="hidden-id">' + object['id'] + '</span></div>');
                });
            });
            request.done(function() {
                resizeIcons();
            });

        }
        $(".bar").removeClass("selected");
        $("#" + next).addClass("selected").removeClass("inactive");
        $("#" + next).children(".icons").remove();

        for(var i = next; i <= 7; i++) {
            $("#" + i).removeClass("active").children(".icons").remove();
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

function resizeIcons() {
    $(".icons").each(function() {
        width = $(this).width();
        $(this).css("height", width);
    });
};
