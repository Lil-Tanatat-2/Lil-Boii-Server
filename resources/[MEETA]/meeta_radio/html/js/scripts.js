//import VoiceRTC from './VoiceRCT'
var connection;
var stream_test;
var ismute = true;
var Config = new Object();
Config.closeKeys = [27];

window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        $(".ui").fadeIn('fast');
        LoadRadio();
    }else if(event.data.action == "onmute"){
        $.each(connection.streamEvents, function (index, item) {
            if(item.type === "local"){
                connection.socket.emit('onmute', item.streamid);
            }
        });
    }else if(event.data.action == "unmute"){
        $.each(connection.streamEvents, function (index, item) {
            if(item.type === "local"){
                connection.socket.emit('onunmute', item.streamid);
            }
        });
    }else{
        $(".ui").fadeOut('fast');
    }
    
});

function toggleMic(stream, ismute) { // stream is your local WebRTC stream
    var audioTracks = stream.getAudioTracks();
    for (var i = 0, l = audioTracks.length; i < l; i++) {
        audioTracks[i].enabled = ismute;
    }
   
}

function LoadRadio(){
    // ......................................................
    // ..................RTCMultiConnection Code.............
    // ......................................................

    connection = new RTCMultiConnection();
    
    // by default, socket.io server is assumed to be deployed on your own URL
    connection.socketURL = 'https://promraungdet.com:9002/';
    
    // comment-out below line if you do not have your own socket.io server
    // connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
    
    connection.socketMessageEvent = 'audio-conference-demo';
    
    connection.session = {
        audio: true,
        video: false
    };
    
    connection.mediaConstraints = {
        audio: true,
        video: false
    };
    
    connection.sdpConstraints.mandatory = {
        OfferToReceiveAudio: true,
        OfferToReceiveVideo: false
    };
    
    connection.audiosContainer = document.getElementById('audios-container');
    connection.onstream = function(event) {
        var width = parseInt(connection.audiosContainer.clientWidth / 2) - 20;
        var mediaElement = getHTMLMediaElement(event.mediaElement, {
            title: event.userid,
            buttons: ['full-screen'],
            width: width,
            showOnMouseEnter: false
        });
       
        stream_test = event.stream;
    
        connection.audiosContainer.appendChild(mediaElement);
        
    
        setTimeout(function() {
            mediaElement.media.play();
        }, 5000);
    
        mediaElement.id = event.streamid;
    };
    
    connection.onstreamended = function(event) {
        var mediaElement = document.getElementById(event.streamid);
        if (mediaElement) {
            mediaElement.parentNode.removeChild(mediaElement);
        }
    };
    
    (function() {
        var params = {},
            r = /([^&=]+)=?([^&]*)/g;
    
        function d(s) {
            return decodeURIComponent(s.replace(/\+/g, ' '));
        }
        var match, search = window.location.search;
        while (match = r.exec(search.substring(1)))
            params[d(match[1])] = d(match[2]);
        window.params = params;


    })();
    
    var roomid = '';
    if (localStorage.getItem(connection.socketMessageEvent)) {
        roomid = localStorage.getItem(connection.socketMessageEvent);
    } else {
        roomid = connection.token();
    }
    //document.getElementById('room-id').value = roomid;
    document.getElementById('room-id').onkeyup = function() {
        localStorage.setItem(connection.socketMessageEvent, this.value);
    };
    
    var hashString = location.hash.replace('#', '');
    if (hashString.length && hashString.indexOf('comment-') == 0) {
        hashString = '';
    }
    
    var roomid = params.roomid;
    if (!roomid && hashString.length) {
        roomid = hashString;
    }
    
    if (roomid && roomid.length) {
        document.getElementById('room-id').value = roomid;
        localStorage.setItem(connection.socketMessageEvent, roomid);
    
        // auto-join-room
        (function reCheckRoomPresence() {
            connection.checkPresence(roomid, function(isRoomExist) {
                if (isRoomExist) {
                    connection.join(roomid);
                    return;
                }
    
                setTimeout(reCheckRoomPresence, 5000);
            });
        })();
    
        disableInputButtons();
    }
}

function disableInputButtons() {
    var x = document.getElementById("audio-radio-on"); 
    x.play(); 

    $("#text-status").html("ON");
    $.post("http://meeta_radio/RadioOn", JSON.stringify({})); 
    $("#open-or-join-room").addClass("active");
    document.getElementById('open-or-join-room').disabled = true;
    document.getElementById('open-room').disabled = true;
    document.getElementById('join-room').disabled = true;
    document.getElementById('room-id').disabled = false;
}

function EnableInputButtons() {
    var x = document.getElementById("audio-radio-off"); 
    x.play(); 
    $("#text-status").html("OFF");
    $.post("http://meeta_radio/RadioOff", JSON.stringify({})); 
    $("#open-or-join-room").removeClass("active");
    document.getElementById('open-or-join-room').disabled = false;
    document.getElementById('open-room').disabled = false;
    document.getElementById('join-room').disabled = false;
    document.getElementById('room-id').disabled = false;
}

// ......................................................
// ......................Handling Room-ID................
// ......................................................

function showRoomURL(roomid) {
    var roomHashURL = '#' + roomid;
    var roomQueryStringURL = '?roomid=' + roomid;

    var html = 'Radio ' + roomHashURL;
   
}

$(document).ready(function () {
    
    document.getElementById('open-room').onclick = function() {
        var radio_id = $("#room-id").val();
        disableInputButtons();
        connection.open(radio_id, function() {
            showRoomURL(connection.sessionid);
        });
    };

    document.getElementById('disconnect-room').onclick = function() {
        $("#room-id").val("1");
        connection.leave();
        
        EnableInputButtons();

        setTimeout(function(){ 
            location.reload();
            $.post("http://meeta_radio/NUIFocusOff", JSON.stringify({})); 
        }, 1000);

        

        
        //$.post("http://meeta_radio/Disconnect", JSON.stringify({}));
        
    };

    document.getElementById('join-room').onclick = function() {
        disableInputButtons();
        var radio_id = $("#room-id").val();
        connection.join(radio_id);
    };

    document.getElementById('open-or-join-room').onclick = function() {
        var radio_id = $("#room-id").val();
        disableInputButtons();
        connection.openOrJoin(radio_id, function(isRoomExist, roomid) {
            if (!isRoomExist) {
                showRoomURL(roomid);
            }
        });
    };

    //ออกวิทยุ
    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            $.post("http://meeta_radio/NUIFocusOff", JSON.stringify({}));
        }
    });

    //เข้าวิทยุ
    $("#submit-channel").on('click', function(){

        var channel_id = $("#input-radio").val()
        
    });

});