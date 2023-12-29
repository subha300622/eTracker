/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var xmlhttp = createRequest();
function trim(str)
{
    while (str.charAt(str.length - 1) === " ")
        str = str.substring(0, str.length - 1);
    while (str.charAt(0) === " ")
        str = str.substring(1, str.length);
    return str;
}
function isPositiveInteger(str) {
    var pattern = "1234567890";
    var i = 0;
    do {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) === pattern.charAt(j)) {
                pos = 1;
                break;
            }
        i++;
    } while (pos === 1 && i < str.length)
    if (pos === 0)
        return false;
    return true;
}
var crids;
function isAlphaNumeric(str) {
    var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    var i = 0;
    do {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) === pattern.charAt(j)) {
                pos = 1;
                break;
            }
        i++;
    } while (pos === 1 && i < str.length)
    if (pos === 0)
        return false;
    return true;
}
function showcrid() {
    $("#errormsg").css({"display": "none"});
    $('#tablecrid tr:gt(1)').remove();
    $('#addissue').css({"display": "block"});
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#cridpopup').fadeIn('fast', 'swing');
}
;

function closecrid() {

    $('#overlay').fadeOut('fast', 'swing');
    $('#cridpopup').fadeOut('fast', 'swing');


}

function createcrid(pid) {

    var crDescriptions = document.getElementsByName('crDescription');
    var issueId = document.getElementById('issueIdForCr').value;
    var status = document.getElementById('statusForCR').value;
    getCRs(issueId);
    var addedCrIds = "";
    var addedCrDescriptions = "";
    var totalcrIds = document.getElementsByName('crId');
    getAllTrFormatsByPid(pid);
    var trPattren = alltrFormats.split(",");
    var notExist = "";
    var notAllowForNext = true;
    var isExist = false;
    var crIDs = crids.split(",");

    for (var i = 0; i < totalcrIds.length; i++) {
        if ((totalcrIds[i].value === "NA") || (totalcrIds[i].value === "na") || (totalcrIds[i].value === "Na") || (totalcrIds[i].value === "nA") && crIDs.length <= 1) {
            break;
        } else {
            for (var k = 0; k < totalcrIds.length; k++) {
                isExist = false;
                for (var m = 0; m < trPattren.length; m++) {
                    if (trim(trPattren[m].substring(0, 4)) === trim(totalcrIds[k].value.substring(0, 4))) {
                        isExist = true;
                        break;
                    }
                }
                if (isExist === false)
                {
                    notExist = notExist + " " + totalcrIds[k].value;
                    notAllowForNext = false;
                }
            }

            if (notAllowForNext === false)
            {
                document.getElementById('errormsg').innerHTML = 'Invalid CR ID    ' + notExist;
                document.getElementById('errormsg').style.display = 'block';
                document.getElementById('errormsg').focus();
                return false;
            }
        }
    }
    for (var i = 0; i < totalcrIds.length; i++) {

        if (trim(totalcrIds[i].value) === '')
        {
            document.getElementById('errormsg').innerHTML = 'Please enter correct CR ID ';
            document.getElementById('errormsg').style.display = 'block';
            totalcrIds[i].focus();
            return false;
        }

        for (var j = 0; j < totalcrIds.length; j++) {
            if (i !== j) {
                if (trim(totalcrIds[i].value.toUpperCase()) === trim(totalcrIds[j].value.toUpperCase())) {
                    document.getElementById('errormsg').style.display = 'block';
                    document.getElementById('errormsg').innerHTML = totalcrIds[i].value + " is exists.";
                    totalcrIds[j].value = '';
                    totalcrIds[j].focus();
                    return false;
                }
            }
        }
        if (crids != undefined) {
            var eachcrid = crids.split(",");
            for (var k = 0; k < eachcrid.length; k++) {
                if (trim(eachcrid[k].toUpperCase()) === trim(totalcrIds[i].value.toUpperCase())) {
                    document.getElementById('errormsg').style.display = 'block';
                    document.getElementById('errormsg').innerHTML = totalcrIds[i].value + " is already exists.";
                    totalcrIds[i].value = '';
                    totalcrIds[i].focus();
                    return false;
                }
            }
        }
        addedCrIds = addedCrIds + trim(totalcrIds[i].value) + ",";
        addedCrDescriptions = addedCrDescriptions + trim(crDescriptions[i].value) + ",";
    }
    if (addedCrIds.length > 2) {
        addedCrIds = addedCrIds.substring(0, addedCrIds.length - 1);
        addedCrDescriptions = addedCrDescriptions.substring(0, addedCrDescriptions.length - 1);
    }
    for (var i = 0; i < totalcrIds.length; i++) {
        var crId = totalcrIds[i].value;
        var crDescription = crDescriptions[i].value;
        if (crids !== '') {
            if (trim(crId) === '')
            {
                document.getElementById('errormsg').innerHTML = 'Please enter correct CR ID';
                document.getElementById('errormsg').style.display = 'block';
                totalcrIds[i].focus();
                return false;
            }
            if (crId.length === 10) {
                var charValid = crId.substring(0, 4);
                var numValid = crId.substring(4);

                for (var m = 0; m < trPattren.length; m++) {
                    if (trim(trPattren[m].substring(0, 4)) === trim(totalcrIds[i].value.substring(0, 4))) {
                        if (trPattren[m].split("-")[1] === "0" && !isPositiveInteger(trim(numValid))) {
                            document.getElementById('errormsg').innerHTML = 'CR ID last 6 characters are numeric';
                            document.getElementById('errormsg').style.display = 'block';
                            totalcrIds[i].focus();
                            return false;
                        }
                    }
                }
                if (!isAlphaNumeric(trim(charValid))) {
                    document.getElementById('errormsg').innerHTML = 'Please enter correct CR ID';
                    document.getElementById('errormsg').style.display = 'block';
                    totalcrIds[i].focus();
                    return false;
                }

            } else {

                document.getElementById('errormsg').innerHTML = 'CR ID length must be 10 alpha numeric characters';
                document.getElementById('errormsg').style.display = 'block';
                totalcrIds[i].focus();
                return false;
            }
            var tottalcrid = trim(crids).split(",");
            for (var k = 0; k < tottalcrid.length; k++) {

                if (crId === tottalcrid[k]) {
                    document.getElementById('errormsg').innerHTML = crId + ' Already exists';
                    document.getElementById('errormsg').style.display = 'block';
                    totalcrIds[i].value = '';
                    totalcrIds[i].focus();
                    return false;
                }
            }
            if (trim(crDescription) === '')
            {
                document.getElementById('errormsg').innerHTML = 'Please enter correct CR Description';
                document.getElementById('errormsg').style.display = 'block';
                crDescriptions[i].focus();
                return false;
            }
        } else {
            if (trim(crId) === '')
            {
                document.getElementById('errormsg').innerHTML = 'Please enter correct CR ID';
                document.getElementById('errormsg').style.display = 'block';
                totalcrIds[i].focus();
                return false;
            }
            if (!(crId === "NA" || crId === "na" || crId === "Na" || crId === "nA") && (crId.length < 10)) {
                document.getElementById('errormsg').innerHTML = "Please enter the valid CR ID or 'NA' if Not Applicable-->";
                totalcrIds[i].value = '';
                totalcrIds[i].focus();
                return false;
            }
            if (crId.length === 10) {
                var charValid = crId.substring(0, 4);
                var numValid = crId.substring(4);

                if (!isAlphaNumeric(trim(charValid))) {
                    document.getElementById('errormsg').innerHTML = 'Please enter correct CR ID';
                    document.getElementById('errormsg').style.display = 'block';
                    totalcrIds[i].focus();
                    return false;
                }
                for (var m = 0; m < trPattren.length; m++) {
                    if (trim(trPattren[m].substring(0, 4)) === trim(totalcrIds[i].value.substring(0, 4))) {
                        if (trPattren[m].split("-")[1] === "0" && !isPositiveInteger(trim(numValid))) {
                            document.getElementById('errormsg').innerHTML = 'CR ID last 6 characters are numeric';
                            document.getElementById('errormsg').style.display = 'block';
                            totalcrIds[i].focus();
                            return false;
                        }
                    }
                }
            }
            if (crDescription === "") {
                document.getElementById('errormsg').innerHTML = "Please enter the valid CR ID Description or 'NA' if Not Applicable";
                document.getElementById('crDescription').value = '';
                crDescriptions[i].focus();
                return false;
            }
            if (!(crDescription === "NA" || crDescription === "na" || crDescription === "Na" || crDescription === "nA") && (crDescription.length < 5)) {
                document.getElementById('errormsg').innerHTML = "Please enter the valid CR ID Description or 'NA' if Not Applicable";
                crDescriptions[i].value = '';
                crDescriptions[i].focus();
                return false;
            }
        }
    }
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/addCrId.jsp?crId=" + encodeURIComponent(addedCrIds) + "&crDescription=" + encodeURIComponent(addedCrDescriptions) + "&issueIdForCr=" + issueId + "&crstatus=" + status + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackcrid();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
var alltrFormats = "";
function getAllTrFormatsByPid(pid) {

    xmlhttp = createRequest();
    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/admin/project/retrieveAlltrFormats.jsp?TrformatpId=" + pid + "&action=retrieve&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var trFormats = xmlhttp.responseText;
                    alltrFormats = trFormats;
                }

            }

        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}


function callbackcrid() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#cridpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#crrow').html("");
            $('.credit').html("");
            $('#crrow').replaceWith(comp);
            openNormal();
            document.getElementById('crId').value = '';
            document.getElementById('crDescription').value = '';
        }

    }
}
function editcrid(sno, editcrid, description) {
    document.getElementById('oldcrId').value = editcrid;
    document.getElementById('sno').value = sno;
    document.getElementById('editcrId').value = editcrid;
    document.getElementById('editcrDescription').value = description;
    document.getElementById('editcrerrormsg').innerHTML = '';
    document.getElementById('editcrerrormsg').style.display = 'none';
    $('#overlay').fadeIn('fast', 'swing');
    $('#crEditpopup').fadeIn('fast', 'swing');
}
function closeeditcrid() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#crEditpopup').fadeOut('fast', 'swing');
}
function updatecrid(pid) {

    var crId = document.getElementById('editcrId').value;
    var oldcrid = document.getElementById('oldcrId').value;
    var issueId = document.getElementById('issueIdForCr').value;
    var crDescription = document.getElementById('editcrDescription').value;
    var sno = document.getElementById('sno').value;
    getCRs(issueId);
    var tottalcrid = trim(crids).split(",");
    getAllTrFormatsByPid(pid);
    var trPattren = alltrFormats.split(",");
    var notExist = "";
    var notAllowForNext = true;
    var isExist = false;

    if (tottalcrid.length > 2) {
//      
//        
        var checkValidation = check(pid);

        if (checkValidation == 0) {

        } else {
            return false;
        }

        if (trim(crId) === '')
        {
            document.getElementById('editcrerrormsg').innerHTML = 'Please enter correct CR ID';
            document.getElementById('editcrerrormsg').style.display = 'block';
            document.getElementById('editcrId').focus();
            return false;
        }
        if (crId.length === 10) {
            var charValid = crId.substring(0, 4);
            var numValid = crId.substring(4);

            for (var m = 0; m < trPattren.length; m++) {
                if (trim(trPattren[m].substring(0, 4)) === trim(crId.substring(0, 4))) {
                    if (trPattren[m].split("-")[1] === "0" && !isPositiveInteger(trim(numValid))) {
                        document.getElementById('editcrerrormsg').innerHTML = 'CR ID last 6 characters are numeric';
                        document.getElementById('editcrerrormsg').style.display = 'block';
                        document.getElementById('editcrId').focus();
                        return false;
                    }
                }
            }
            if (!isAlphaNumeric(trim(charValid))) {
                document.getElementById('editcrerrormsg').innerHTML = 'Please enter correct CR ID';
                document.getElementById('editcrerrormsg').style.display = 'block';
                document.getElementById('editcrId').focus();
                return false;
            }

        } else {
            document.getElementById('editcrerrormsg').innerHTML = 'CR ID length must be 10 alpha numeric characters';
            document.getElementById('editcrerrormsg').style.display = 'block';
            document.getElementById('editcrId').focus();
            return false;
        }
    }

    for (var k = 0; k < tottalcrid.length; k++) {

        if (oldcrid !== tottalcrid[k]) {
            if (crId === tottalcrid[k]) {
                document.getElementById('editcrerrormsg').innerHTML = crId + ' Already exists';
                document.getElementById('editcrerrormsg').style.display = 'block';
                document.getElementById('editcrId').value = '';
                document.getElementById('editcrId').focus();
                return false;
            }
        }
    }
    if (trim(crDescription) === '')
    {
        document.getElementById('editcrerrormsg').innerHTML = 'Please enter correct CR Description';
        document.getElementById('editcrerrormsg').style.display = 'block';
        document.getElementById('editcrDescription').focus();
        return false;
    } else {
        if (trim(crId) === '')
        {
            document.getElementById('editcrerrormsg').innerHTML = 'Please enter correct CR ID';
            document.getElementById('editcrerrormsg').style.display = 'block';
            document.getElementById('editcrId').focus();
            return false;
        }
        if (!(crId === "NA" || crId === "na" || crId === "Na" || crId === "nA") && (crId.length < 10)) {
            alert("Please enter the valid CR ID or 'NA' if Not Applicable-->");
            document.getElementById('editcrId').value = '';
            document.getElementById('editcrId').focus();
            return false;
        }
        if (crDescription === "" || crDescription === "Enter SAP CR ID Description or 'NA' if Not Applicable") {
            document.getElementById('errormsg').innerHTML = "Please enter the valid CR ID Description or 'NA' if Not Applicable";
            document.getElementById('editcrDescription').value = '';
            document.getElementById('editcrDescription').focus();
            return false;
        }
        if (!(crDescription === "NA" || crDescription === "na" || crDescription === "Na" || crDescription === "nA") && (crDescription.length < 5)) {
            document.getElementById('errormsg').innerHTML = "Please enter the valid CR ID Description or 'NA' if Not Applicable";
            document.getElementById('editcrDescription').value = '';
            document.getElementById('editcrDescription').focus();
            return false;
        }
        if (crId.length === 10) {
            var charValid = crId.substring(0, 4);
            var numValid = crId.substring(4);
            if (!isAlphaNumeric(trim(charValid))) {
                document.getElementById('editcrerrormsg').innerHTML = 'Please enter correct CR ID';
                document.getElementById('editcrerrormsg').style.display = 'block';
                document.getElementById('editcrId').focus();
                return false;
            }
            for (var m = 0; m < trPattren.length; m++) {
                if (trim(trPattren[m].substring(0, 4)) === trim(crId.substring(0, 4))) {
                    if (trPattren[m].split("-")[1] === "0" && !isPositiveInteger(trim(numValid))) {
                        document.getElementById('editcrerrormsg').innerHTML = 'CR ID last 6 characters are numeric';
                        document.getElementById('editcrerrormsg').style.display = 'block';
                        document.getElementById('editcrId').focus();
                        return false;
                    }
                }
            }
//            for (var n = 0; n < trPattren.length; n++) {
//
//                if (trim(trPattren[n].substring(0, 4)) === trim(crId.substring(0, 4))) {
//                    var existvalue = crId;
//                    isExist = true;
//                    break;
//                }
//            }
//            if (isExist === false)
//            {
//                notExist = notExist + " " + crId;
//                notAllowForNext = false;
//            }
//
//            if (notAllowForNext === false)
//            {
//                document.getElementById('editcrerrormsg').innerHTML = 'Invalid CR ID    ' + notExist;
//                document.getElementById('editcrerrormsg').style.display = 'block';
//                 document.getElementById('editcrId').focus();
//                return false;
//            }
            var checkValidation = check(pid);

            if (checkValidation == 0) {

            } else {
                return false;
            }

        }
    }
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/editCrId.jsp?crId=" + encodeURIComponent(crId) + "&crDescription=" + encodeURIComponent(crDescription) + "&sno=" + sno + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackeditcrid();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}

function callbackeditcrid() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#crEditpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var crId = document.getElementById('editcrId').value;
            var crDescription = document.getElementById('editcrDescription').value;
            var sno = document.getElementById('sno').value;
//                    location.reload();
////                    var comp = xmlhttp.responseText;
            $('.desc' + sno).html(crDescription);
            $('.key' + sno).html('<img src=\'/eTracker/images/edit.png\'  onclick=\'editcrid("' + sno + '","' + crId + '","' + crDescription + '")\' style=\'cursor: pointer;\'/>' + crId);
////                    alert(closer.html);
////                                 closer.innerHTML=crId;
////                    alert($("#"+idgen).innerHTML);
////                    alert(document.getElementsByClassName(sno+"key").value);
////                    document.getElementsByClassName(sno+'key').value=crId;
////                    document.getElementsByClassName(sno+'desc').value=crDescription;
////                    document.getElementById('editcrId').value='';
////                    document.getElementById('editcrDescription').value='';

        }

    }
}

function getCRs(issueid) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/crIdByIssue.jsp?issueid=" + encodeURIComponent(issueid) + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackgetcrid();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callbackgetcrid() {
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            crids = comp;
        }
    }
}
function check(pid) {
    var counter = 0;
    getAllTrFormatsByPid(pid);
    var trPattren = alltrFormats.split(",");
    var crId = document.getElementById('editcrId').value;
    var notExist = "";
    var notAllowForNext = true;
    var isExist = false;

    for (var n = 0; n < trPattren.length; n++) {

        if (trim(trPattren[n].substring(0, 4)) === trim(crId.substring(0, 4))) {
            var existvalue = crId;
            isExist = true;
            break;
        }
    }
    if (isExist === false)
    {
        notExist = notExist + " " + crId;
        notAllowForNext = false;
    }

    if (notAllowForNext === false)
    {
        document.getElementById('editcrerrormsg').innerHTML = 'Invalid CR ID    ' + notExist;
        document.getElementById('editcrerrormsg').style.display = 'block';
        document.getElementById('editcrId').focus();
        counter = 1;
    }
    return counter;
}
