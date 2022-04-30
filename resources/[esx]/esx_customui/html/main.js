window.addEventListener('message', function(event) {
    var data = event.data;
    var f =  event.data.position * 0.5;

    if(!data.show){
        $(".container").css("display", "block");
    }else{
        $(".container").css("display", "none");
    }
    
    $("#health .determinate").css("width",data.health + "%");
    $("#stamina .determinate").css("width", data.stamina + "%");
    $("#armor .determinate").css("width", data.armor + "%");

    // $(".container").css({
    //     'top' : event.data.position.top_y + 'px',
    //     'left' : event.data.position.right_x + 'px',
    // })

    var top = window.screen.height * f;
    var right = window.screen.width * f;
    var width = Math.ceil(window.screen.width * (data.width * 1));

    $(".container").css({
        'width' : width + 'px',
        'margin-bottom' : (top) + 'px',
        'margin-right' : right + 'px',
    });
    

    if (event.data.action == "updateStatus") {
        updateStatus(event.data.st);
    }
})


function updateStatus(status){
    $('#hunger .determinate').css('width', status[0].percent+'%')
    $('#water .determinate').css('width', status[1].percent+'%')
}