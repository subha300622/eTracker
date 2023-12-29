$(function() {
    "use strict";

    var header = $('#header');
    var content = $('#content');
    var input = $('#input');
    var myName = false;
    var issueId = $('#issueId').val();
    var socket = atmosphere;
    var subSocket;
    var transport = 'websocket';
    // We are now ready to cut the request
    var request = {url: '/eTracker/check',
        contentType: "application/json",
        logLevel: 'debug',
        transport: transport,
        trackMessageLength: true,
        reconnectInterval: 5000};


    request.onOpen = function(response) {
        content.html($('<p>', {text: 'Atmosphere connected using ' + response.transport}));
        transport = response.transport;

        // Carry the UUID. This is required if you want to call subscribe(request) again.
        request.uuid = response.request.uuid;
    };

    request.onClientTimeout = function(r) {
        content.html($('<p>', {text: 'Client closed the connection after a timeout. Reconnecting in ' + request.reconnectInterval}));
        subSocket.push(atmosphere.util.stringifyJSON({issueId: issueId, assignedTo: 'is inactive and closed the connection. Will reconnect in ' + request.reconnectInterval}));
        input.attr('disabled', 'disabled');
        setTimeout(function() {
            subSocket = socket.subscribe(request);
        }, request.reconnectInterval);
    };

    request.onReopen = function(response) {
        content.html($('<p>', {text: 'Atmosphere re-connected using ' + response.transport}));
    };

    // For demonstration of how you can customize the fallbackTransport using the onTransportFailure function
    request.onTransportFailure = function(errorMsg, request) {
        atmosphere.util.info(errorMsg);
        request.fallbackTransport = "long-polling";
        header.html($('<h3>', {text: 'Atmosphere Chat. Default transport is WebSocket, fallback is ' + request.fallbackTransport}));
    };

    request.onMessage = function(response) {

        var responseContent = response.responseBody;
        try {
            var json = atmosphere.util.parseJSON(responseContent);
            var currentId = getCurrentUserId();
            if (json.assignedTo === undefined) {

            } else {
                alert(currentId + ", " + json.assignedTo);
                if (currentId === json.assignedTo) {
                    var notification = new Notification(json.issueId, {
                        icon: 'http://www.eminentlabs.com/eTracker/eminentech%20support%20files/Eminentlabs_logo.gif',
                        body: json.subject,
                    });
                    notification.onclick = function() {
                        window.open("../viewIssueDetails.jsp?issueid=" + json.issueId);
                    };
                }
            }
        } catch (e) {
            console.log('This doesn\'t look like a valid JSON: ', responseContent);
            return;
        }
    };

    request.onClose = function(response) {
        content.html($('<p>', {text: 'Server closed the connection after a timeout'}));
        if (subSocket) {
            subSocket.push(atmosphere.util.stringifyJSON({issueId: issueId, assignedTo: 'disconnecting'}));
        }
        input.attr('disabled', 'disabled');
    };

    request.onError = function(response) {
        content.html($('<p>', {text: 'Sorry, but there\'s some problem with your '
                    + 'socket or the server is down'}));
    };

    request.onReconnect = function(request, response) {
        content.html($('<p>', {text: 'Connection lost, trying to reconnect. Trying to reconnect ' + request.reconnectInterval}));
        input.attr('disabled', 'disabled');
    };

    subSocket = socket.subscribe(request);

    $(document).on('click', '#submit', function() {
        if (issueId.length === 12) {
            var assignedTo = $("#assignedto").val();

            if (getCurrentUserId() === assignedTo) {

            } else {
                alert(assignedTo);
                subSocket.push(atmosphere.util.stringifyJSON({issueId: issueId, assignedTo: assignedTo}));
            }
        }
    });


});

function getCurrentUserId() {
    $.ajax({
        url: '/eTracker/getCurrentUserId.jsp',
        async: true,
        type: 'POST',
        success: function(data) {
            return data;
        }
    });

}

