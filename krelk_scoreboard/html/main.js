let onScreen = false;
let isLoaading = false;
let autoHide = false;
let timeToHide = 0;
let actualTimeOut = undefined;
let serverNameEnabled = false;
window.addEventListener('message', (event) => {
    var action = event.data.action;
    if (action == 'toggleScoreBoard') {
        if (!onScreen) {
            fetch(`https://${GetParentResourceName()}/getOnlinePlayers`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                }
            }).then(resp => resp.json()).then(resp => {
                if (resp && !isLoaading) {
                    if (resp == "notok") {
                        $("#scoreboard").fadeIn(330);
                        $("#scoreboard").css("display", "grid");
                        setTimeout(() => {
                            onScreen = true;
                            isLoaading = false;
                        }, "330");
                        autoHideFunction();
                        if (serverNameEnabled) { $("#servername").fadeIn(330); }
                        return;
                    }
                    isLoaading=true;
                    //Admins Count
                    if (resp[0] > 0) {
                        
                        $("#adminsonline .fa-shield-halved").attr("style", "color: greenyellow;");
                        $("#admins_status").text('Online');
                    } else {
                        $("#adminsonline .fa-shield-halved").attr("style", "color: red;");
                        $("#admins_status").text('Offline');
                    }

                    //Police Count
                    $("#policecount").text(resp[1]);

                    //Ems Count
                    $("#emscount").text(resp[2]);

                    //Mechanic Count
                    $("#mechaniccount").text(resp[3]);

                    //Taxi Count
                    $("#taxicount").text(resp[4]);

                    //Players Count
                    $("#playercount_number").text(resp[5]);

                    //Max Players Online Count
                    $("#playerscount_maxplayers").text(resp[6]);


                    $("#scoreboard").fadeIn(330);
                    $("#scoreboard").css("display", "grid");
                    setTimeout(() => {
                        onScreen = true;
                        isLoaading = false;
                    }, "330");
                    autoHideFunction();
                    if (serverNameEnabled) { $("#servername").fadeIn(330); }
                }
            });
        } else {
            $("#scoreboard").fadeOut(330);
            setTimeout(() => {
                onScreen = false;
                isLoaading = false;
            }, "330");
            if (actualTimeOut) { clearTimeout(actualTimeOut); actualTimeOut = undefined; }
            if (serverNameEnabled) { $("#servername").fadeOut(230); }
        }
    } else if (action == 'enableAdminsOnline') {
        $("#adminsonline").css("display", "block");
        $("#scoreboard").css("grid-template-columns", "repeat(6, 16.66%)");
    } else if (action == 'updatePlayersData') {
        if (onScreen && !isLoaading) {
            let playersData = event.data.data;
            //Admins Count
            if (playersData[0] > 0) {
                $("#adminsonline .fa-shield-halved").attr("style", "color: greenyellow;");
                $("#admins_status").text('Online');
            } else {
                $("#adminsonline .fa-shield-halved").attr("style", "color: red;");
                $("#admins_status").text('Offline');
            }

            //Police Count
            $("#policecount").text(playersData[1]);

            //Ems Count
            $("#emscount").text(playersData[2]);

            //Mechanic Count
            $("#mechaniccount").text(playersData[3]);

            //Taxi Count
            $("#taxicount").text(playersData[4]);

            //Players Count
            $("#playercount_number").text(playersData[5]);

            //Max Players Online Count
            $("#playerscount_maxplayers").text(playersData[6]);
        }
    } else if (action == 'setupHudColor') {
        let colors = event.data.colors
        $("#scoreboard").css("background", "linear-gradient(0deg, rgba("+colors.r+","+colors.g+","+colors.b+",0.6601015406162465) 0%, rgba(0,0,0,0.6516981792717087) 100%)");
        $("#scoreboard").css("box-shadow", "0px 0px 20px 0px rgba("+colors.r+","+colors.g+","+colors.b+",1)");

        $("#servername").css("background", "linear-gradient(0deg, rgba("+colors.r+","+colors.g+","+colors.b+",0.6601015406162465) 0%, rgba("+colors.r+","+colors.g+","+colors.b+",0.6601015406162465) 90%, rgba(0,0,0,0.15) 100%)");
        $("#servername").css("box-shadow", "0px 0px 10px 0px rgba("+colors.r+","+colors.g+","+colors.b+",1)");
    } else if (action == 'setupAutoHide') {
        autoHide = true;
        timeToHide = event.data.seconds;
    } else if (action == 'enableServerName') {
        let serverName = event.data.name;
        let serverNameColor = event.data.color;
        $("#servername h3").text(serverName);
        $("#servername h3").css("color", serverNameColor);
        serverNameEnabled = true;
    }
});

function autoHideFunction() {
    if (autoHide) {
        if (actualTimeOut) { clearTimeout(actualTimeOut); }
        actualTimeOut = setTimeout(() => {
            $("#scoreboard").fadeOut(330);
            setTimeout(() => {
                onScreen = false;
                isLoaading = false;
            }, "330");
            clearTimeout(actualTimeOut);
            actualTimeOut = undefined;
            if (serverNameEnabled) { $("#servername").fadeOut(330); }
        }, timeToHide*1000);
    }
}