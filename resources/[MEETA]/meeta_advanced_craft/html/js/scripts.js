var mode;
var data;
var Current_Mode;
var Current_Slot;
var Items;

var Item_Slot1;
var Item_Slot2;
var Item_Slot3;
var Item_Slot4;
var Item_Slot5;
var Item_Slot6;
var Item_Slot7;
var Item_Slot8;

var Item_Count1;
var Item_Count2;
var Item_Count3;
var Item_Count4;
var Item_Count5;
var Item_Count6;
var Item_Count7;
var Item_Count8;

function ClearAll(){

    Item_Slot1 = null;
    Item_Slot2 = null;
    Item_Slot3 = null;
    Item_Slot4 = null;
    Item_Slot5 = null;
    Item_Slot6 = null;
    Item_Slot7 = null;
    Item_Slot8 = null;

    Item_Count1 = null;
    Item_Count2 = null;
    Item_Count3 = null;
    Item_Count4 = null;
    Item_Count5 = null;
    Item_Count6 = null;
    Item_Count7 = null;
    Item_Count8 = null;

    Current_Mode = null;
    Current_Slot = null;
    data = null;
    $('.count').text('');
    $('[data-slot] > .empty_item').html('');
    $('[data-slot] > .empty_item').removeClass('active');
    $('[data-action="mode"]').removeClass('blue').addClass('btn-flat');
}

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
        ClearAll();

        mode = event.data.mode;
        data = event.data.data;

        if(mode == "Weapon"){
            $("#text_header").text("คราฟอาวุธ");
        }else if(mode == "Normal"){
            $("#text_header").text("ทำอาหาร");
        }
        
        LoadMenu(data);

    }else if(event.data.action == "setItems") {
        Items = event.data.itemList;
        LoadItems(Items);
    }else if(event.data.action == "modal") {
        $("#progressbar").hide();
        $("#text_result").html(event.data.message);
        $("#text_result").show();

        if(event.data.closed == true){
            setTimeout(function(){
                closeHUD();  
            },500);
        }else{
            setTimeout(function(){
                $('#modal_carft').modal('close');
            }, 2000);
        }

        //ClearAll();
        $('[data-action="clear"]').trigger('click');
    }else if(event.data.action == "update") {
        $("#text_result").html(event.data.message);
    }else{
        $(".ui").fadeOut('fast');
    }

});

var Config = new Object();
Config.closeKeys = [113, 27, 90];

function LoadMenu(data){

    $(".menu").html("");

    $.each(data, function (index, item) {
        var button = '<a class="btn-flat white-text z-depth-0" data-action="mode" data-id="' + index + '" style="margin-right: 10px;">' + item.Name + '</a>';
        $(".menu").append(button);
    });
}

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
    
    
    $('body').on('click','[data-action="clear"]', function(){
        ClearAll();
        $.post("http://meeta_advanced_craft/ClearAll", JSON.stringify({mode:mode}));
    });
    //คราฟ 
    $('body').on('click','[data-action="carft"]', function(){

        if(Current_Mode){
            if(Item_Slot1 == null && Item_Slot2 == null && Item_Slot3 == null && Item_Slot4 == null && Item_Slot5 == null && Item_Slot6 == null && Item_Slot7 == null && Item_Slot8 == null){
                M.toast({html: 'กรุณาเลือกไอเทมของคุณ!'})
            }else{
                var URL;
                var Timer;
                if(mode == "Normal"){
                    URL = "CookingItem";
                    Timer = 5000;
                    $.post("http://meeta_advanced_craft/PlayAnimationCooking", JSON.stringify({
                        mode: Current_Mode,
                    }));
                }else{
                    URL = "CarftItem"
                    Timer = 5000;
                    $('#modal_carft').modal('open');
                }
                setTimeout(function(){
                   
                    $.post("http://meeta_advanced_craft/" + URL, JSON.stringify({
                        mode: Current_Mode,
                        item1: Item_Slot1,
                        item2: Item_Slot2,
                        item3: Item_Slot3,
                        item4: Item_Slot4,
                        item5: Item_Slot5,
                        item6: Item_Slot6,
                        item7: Item_Slot7,
                        item8: Item_Slot8,
                        count1: Item_Count1,
                        count2: Item_Count2,
                        count3: Item_Count3,
                        count4: Item_Count4,
                        count5: Item_Count5,
                        count6: Item_Count6,
                        count7: Item_Count7,
                        count8: Item_Count8
                    }));
                }, Timer);
            }
           
        }else{
            if(mode == "Normal"){
                M.toast({html: 'กรุณาเลือกโหมดที่เมนูอาหารด้วย!'})
            }else{
                M.toast({html: 'กรุณาเลือกโหมดที่คุณจะคราฟด้วย!'})
            }
            
        }
    });

    //เลือกโหมด
    $('body').on('click','[data-action="mode"]', function(){
        var id = $(this).attr('data-id');

        if(Current_Mode == id){
            $('[data-action="mode"][data-id="' + id + '"]').removeClass('indigo darken-3').addClass('btn-flat');
            Current_Mode = null;
        }else{
            $('[data-action="mode"]').removeClass('indigo darken-3').addClass('btn-flat');
            $('[data-action="mode"][data-id="' + id + '"]').removeClass('btn-flat').addClass('btn indigo darken-3');
            Current_Mode = id;
        }
    });

    //เลือกช่อง
    $('body').on('click','[data-slot]', function(){
        var id = $(this).attr('data-slot');

        // if(Current_Slot == id){
        //     $('[data-slot="' + id + '"] > .empty_item').removeClass('active');
        //     Current_Slot = null;
        // }else{

            $('[data-slot] > .empty_item').removeClass('active');

            if(Item_Slot1 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot2 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot3 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot4 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot5 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }
           
            if(Item_Slot6 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot7 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }

            if(Item_Slot8 == null){
                $('[data-slot="' + id + '"] > .empty_item').addClass('active');
                Current_Slot = id;
            }
            

       // }
    });
    // ใส่
    $('body').on('click','[data-action="use"]', function(){

        var index = $(this).attr('data-index');
        itemData = $('#item-' + index).data("item");

        if(Current_Slot) {
            for (var i in Items) {
                if(Items[i].name == itemData.name) {
                    if(Items[i].count > 0){

                        var Cando = false;

                        if(Current_Slot == 1){

                            if(Item_Slot1 == null){
                                Item_Slot1 = Items[i].name;
                                Cando = true;
                                Item_Count1 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count1);
                            }else{
                                Cando = false;
                            }
                            
                        }else if(Current_Slot == 2){
                        
                            if(Item_Slot2 == null){
                                Item_Slot2 = Items[i].name;
                                Cando = true;
                                Item_Count2 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count2);
                            }else{
                                Cando = false;
                            }

                        }else if(Current_Slot == 3){
                            
                            if(Item_Slot3 == null){
                                Item_Slot3 = Items[i].name;
                                Cando = true;
                                Item_Count3 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count3);
                            }else{
                                Cando = false;
                            }
                            
                        }else if(Current_Slot == 4){
                            
                            if(Item_Slot4 == null){
                                Item_Slot4 = Items[i].name;
                                Cando = true;
                                Item_Count4 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count4);
                            }else{
                                Cando = false;
                            }

                        }else if(Current_Slot == 5){
                            
                            if(Item_Slot5 == null){
                                Item_Slot5 = Items[i].name;
                                Cando = true;
                                Item_Count5 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count5);
                            }else{
                                Cando = false;
                            }

                        }else if(Current_Slot == 6){

                            if(Item_Slot6 == null){
                                Item_Slot6 = Items[i].name;
                                Cando = true;
                                Item_Count6 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count6);
                            }else{
                                Cando = false;
                            }

                        }else if(Current_Slot == 7){
                            
                            if(Item_Slot7 == null){
                                Item_Slot7 = Items[i].name;
                                Cando = true;
                                Item_Count7 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count7);
                            }else{
                                Cando = false;
                            }
                            
                        }else if(Current_Slot == 8){
                            
                            if(Item_Slot8 == null){
                                Item_Slot8 = Items[i].name;
                                Cando = true;
                                Item_Count8 = 1;
                                 $("#count_" + Current_Slot).text(Item_Count8);
                            }else{
                                Cando = false;
                            }

                        }

                        if(Cando){
                            Items[i].count = Items[i].count-1;
                            $('[data-slot="' + Current_Slot + '"] > .empty_item').html('<img class="faster" src="nui://esx_inventoryhud/html/img/items/' + Items[i].name + '.png" style="width: 100%;" />');
                            animateCSS('[data-slot="' + Current_Slot + '"] > .empty_item img', 'zoomIn');
                            LoadItems(Items, false);
    
                            //Current_Slot = null;
                            //$('[data-slot] > .empty_item').removeClass('active');
                        }else{
                            for (var i in Items) {
                                if(Items[i].name == itemData.name) {
                                    if(Current_Slot == 1){
                                        
                                        if(Item_Slot1 == itemData.name){
                                            if(Items[i].count > 0){

                                                if(mode == "Weapon"){
                                                    Item_Count1 = Item_Count1+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count1);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 2){
                                        if(Item_Slot2 == itemData.name){
                                            if(Items[i].count > 0){

                                                if(mode == "Weapon"){
                                                    Item_Count2 = Item_Count2+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count2);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 3){
                                        
                                        if(Item_Slot3 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count3 = Item_Count3+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count3);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 4){
                                        
                                        if(Item_Slot4 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count4 = Item_Count4+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count4);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 5){
                                        
                                        if(Item_Slot5 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count5 = Item_Count5+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count5);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 6){
                                        
                                        if(Item_Slot6 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count6 = Item_Count6+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count6);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 7){
                                        
                                        if(Item_Slot7 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count7 = Item_Count7+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count7);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }else if(Current_Slot == 8){
                                        
                                        if(Item_Slot8 == itemData.name){
                                            if(Items[i].count > 0){
                                                
                                                if(mode == "Weapon"){
                                                    Item_Count8 = Item_Count8+1;
                                                }

                                                $("#count_" + Current_Slot).text(Item_Count8);

                                                Items[i].count = Items[i].count-1;
                                                LoadItems(Items, false);

                                            }else{
                                                M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                                            }
                                        }

                                    }
                                    
                                }
                                //break;
                            }
                            //M.toast({html: 'ช่องนี้มีไอเทมอยู่แล้ว!'})
                        }

                       


                    }else{
                        M.toast({html: 'จำนวนไอเทมไม่เพียงพอ!'})
                    }
                    break;
                }
            }
        }else{
            M.toast({html: 'กรุณาเลือกช่องเพื่อใส่ไอเทม!'})
        }
        
    });
    
});

function closeHUD() {
    $('#modal_carft').modal('close');
    $.post("http://meeta_advanced_craft/NUIFocusOff", JSON.stringify({}));
}