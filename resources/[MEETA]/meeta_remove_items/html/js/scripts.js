function animateCSS(element, animationName, callback) {
    const node = document.querySelector(element)
    node.classList.add('animated', animationName)

    function handleAnimationEnd() {
        node.classList.remove('animated', animationName)
        node.removeEventListener('animationend', handleAnimationEnd)

        if (typeof callback === 'function') callback()
    }

    node.addEventListener('animationend', handleAnimationEnd)
}

window.addEventListener("message", function (event) {

    if (event.data.action == "display") {
        $(".ui").fadeIn('fast');
        mode = event.data.mode;
        data = event.data.data;

    }else if(event.data.action == "setItems") {
        Items = event.data.itemList;
        LoadItems(Items);
    }else{
        $(".ui").fadeOut('fast');
    }

});

var Config = new Object();
Config.closeKeys = [113, 27, 90];


function LoadItems(items, animate = true){
    $("#ItemResult").html("");
    $.each(items, function (index, item) {
        if(item.count > 0){
            if(item.name == "key" || item.name == "keyhouse"){
                
            }else{
                var html_items = '<div id="item-' + index + '" class="col slot-1 faster" style="padding: 0px;width:20%;" data-action="use" data-item="'+ item.name +'" data-index="'+ index +'">' + 
                                            '<div class="card slot z-depth-0">' +
                                                '<div class="card-image" align="center" style="padding: 15px;">' +
                                                    '<img src="nui://esx_inventoryhud/html/img/items/' + item.name + '.png" style="width: 110px;height:110px;">' + 
                                                '</div>' + 
                                                '<div class="card-content" align="center" style="padding: 0;">'+ item.label + '</div>' + 
                                                '<div class="card-content" align="center" style="padding: 5px 0 15px 0;">' + 
                                                '<span id="item-price-' + index +'">' + item.count + '</span>' + 
                                                '</div>' + 
                                            '</div>' + 
                                        '</div>';
                $("#ItemResult").append(html_items);

                if(animate){
                    animateCSS('#item-' + index, 'zoomIn');
                }

                $('#item-' + index).data('item', item);
                $('#item-' + index).data('inventory', "main");
            }
        }
    });
}

$(document).ready(function () {

    //ออก
    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeHUD();  
        }
    });

    $('body').on('click','[data-action="use"]', function(){

        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");

        $('#modal_count').modal('open');
        $('#item-submit').attr('data-action','drop');
        $('#item-submit').attr('data-index', index);
        
    });

    $('body').on('click','#item-submit[data-action="drop"]', function(){
        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");
        var count = parseInt($('#txt_count').val());
        if(count > 0){
            if (itemData.canRemove) {
                $.post("http://meeta_remove_items/RemoveItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($('#txt_count').val())
                }));
                setTimeout(function() { $("#txt_count").focus(); }, 100);
            }
            $("#modal_count").modal('close');
        }else{
            $("#text_result").text("กรุณาใส่จำนวน").show();
            return false;
        }
    });
    
});

function closeHUD() {
    $('#modal_count').modal('close');
    $.post("http://meeta_remove_items/NUIFocusOff", JSON.stringify({}));
}