$(document).ready(function(){
    // BAR CLICKS **********************************
    $(".container").on("click", ".bar.active", function(event) {
        var level = $(this).attr("id");
        var next = parseInt(level) + 1;
        console.log("hey")

        $(".bar").removeClass("selected");
        $(this).addClass("selected");

        setTimeout(function() {
            for(var x = 1; x < level; x++) {
                $("#" + x).addClass("active");
            }
        }, 300);

    });

    // CARD CLICKS **********************************
    $(".bar").on("click", ".cards", function(event) {
        var level = $(this).parent().attr("id");
        var next = (parseInt(level) + 1);
        $(".bar").removeClass("selected");
        $("#" + next).addClass("selected").removeClass("inactive");
        $("#" + next).children(".cards").remove();

        $.get("/ajax/" + $(this).children('.hidden-id').text() + "/"+ next,function(data,status){
            data.forEach( function(object) {
                $("#" + next).append('<div class="cards"><h4>' + object['name'] + '</h4><span class="hidden-id">' + object['id'] + '</span></div>');
            });
        });

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
