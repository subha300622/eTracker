
var xmlhttp = createRequest();
function createRequest() {
    var reqObj = null;
    try {
        reqObj = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (err) {
        try {
            reqObj = new ActiveXObject("Microsoft.XMLHTTP");
        }
        catch (err2) {
            try {
                reqObj = new XMLHttpRequest();
            }
            catch (err3) {
                reqObj = null;
            }
        }
    }
    return reqObj;
}



function callfunc(clickb) {
    var value;
     var issueid=document.getElementById("issueId").value;
    var project=document.getElementById("project").value;
    var priority=document.getElementById('priority').value;
    var status=document.getElementById('status').value;
    var version=document.getElementById('fversion').value;
    var sorton=document.getElementById('sorton').value;
    var sort_method=document.getElementById('sort_method').value;
    var userin=document.getElementById('userin').value;
   
    if (sorton.length == 0 || sorton == "null" || sorton == "undefined") {

        xmlhttp = createRequest();
        if (xmlhttp !== null) {

            xmlhttp.open("GET", "/eTracker/admin/project/withoutSort.jsp?issueid=" + issueid + "&clickb=" + clickb + "&userin=" + userin + "&project=" + project + "&version=" + version + "&priority=" + priority + "&status=" + status + "&rand=" + Math.random(1, 10), false);

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        value = comp.replace(/\s/g, "");
                      

                    }

                }

            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }

    } else {
        xmlhttp = createRequest();
        if (xmlhttp !== null) {

            xmlhttp.open("GET", "/eTracker/admin/project/sorting_on.jsp?issueid=" + issueid + "&sorton=" + sorton + "&sort_method=" + sort_method + "&clickb=" + clickb + "&project=" + project + "&version=" + version + "&userin=" + userin + "&priority=" + priority + "&status=" + status + "&rand=" + Math.random(1, 10), false);

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        value = comp.replace(/\s/g, "");
                      

                    }

                }
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }

    }
    return value;
}
function callpos() {
    var position;
      var issueid=document.getElementById("issueId").value;
    var project=document.getElementById("project").value;
    var priority=document.getElementById('priority').value;
    var status=document.getElementById('status').value;
    var version=document.getElementById('fversion').value;
    var sorton=document.getElementById('sorton').value;
    var sort_method=document.getElementById('sort_method').value;
    var userin=document.getElementById('userin').value;
     //console.log("values in pos vali in prevnext is:"+version+project+priority+sorton+sort_method+status+userin+issueid);
    if (sorton.length == 0 || sorton == "null" || sorton == "undefined") {

        xmlhttp = createRequest();
        if (xmlhttp !== null) {

            xmlhttp.open("GET", "/eTracker/admin/project/withoutSortPosition.jsp?issueid=" + issueid  + "&userin=" + userin + "&project=" + project + "&version=" + version + "&priority=" + priority + "&status=" + status + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        position = comp.replace(/\s/g, "");
                       

                    }

                }

            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }

    } else {
        xmlhttp = createRequest();
        if (xmlhttp !== null) {

            xmlhttp.open("GET", "/eTracker/admin/project/sorting_onPosition.jsp?issueid=" + issueid + "&sorton=" + sorton + "&project=" + project + "&version=" + version + "&sort_method=" + sort_method + "&userin=" + userin + "&priority=" + priority + "&status=" + status  + "&rand=" + Math.random(1, 10), false);

            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200) {
                        var comp = xmlhttp.responseText;
                        position = comp.replace(/\s/g, "");
                      

                    }

                }
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }

    }
    return position;
}