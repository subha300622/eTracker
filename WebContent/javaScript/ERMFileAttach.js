/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var xmlhttp = createRequest();

function viewFileAttachForApplicant(applicantId) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/getFilesByApplicantId.jsp?applicantId=" + applicantId + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackModuleAttach(applicantId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callbackModuleAttach(applicantId) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $("#IssuePopupFiles").html(xmlhttp.responseText);
            $(".popupHeading").html("View Attached Files ( " + applicantId + " )");
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#MDAVpopup').fadeIn('fast', 'swing');
        }
    }
}

function closeIssuePopup() {
    $("#IssuePopupFiles").html("");
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');

}


function showFileAttach() {
    document.getElementById('mdaterrormsg').style.display = 'none';
    document.getElementById('submit').disabled = true;
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#MDApopup').fadeIn('fast', 'swing');

}
function cloFileAttach() {
    document.getElementById("file-mod-select").value ='';
    document.getElementById('mdaterrormsg').style.display = 'none';
    document.getElementById('submit').disabled = false;
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDApopup').fadeOut('fast', 'swing');
    $('#progressbar').fadeOut('fast', 'swing');
}

function callbackFileAttach() {
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#filesIssue').html("");
            $('#filesIssue').replaceWith(comp);
            $('#overlay').fadeIn('fast', 'swing');
        }
    }
}


function uploadFileAttach() {

    var applicantId = document.getElementById('applicantId').value;
    var uploadButton = document.getElementById('upload-button');

    if (document.getElementById("file-mod-select").value == '') {
        document.getElementById('mdaterrormsg').style.display = 'block';
        document.getElementById('mdaterrormsg').innerHTML = "Please select the file";
        var formmod = document.getElementById('file-mod-form');
        return false;
    }
    else {
        if (xmlhttp !== null) {
            $('#progressbar').fadeIn('slow');
            var formmod = document.getElementById('file-mod-form');
            var fileModSelect = document.getElementById('file-mod-select');
            document.getElementById('mod-upload-button').value = "Processing";
            document.getElementById('mod-upload-button').disabled = true;


            var files = fileModSelect.files;
            var formData = new FormData();
            formData.append('applicantId', applicantId);
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                // Add the file to the request.
                formData.append('photos[]', file, file.name);
            }
            if (files.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/eTracker/ERMFileAttachCandidate.jsp', true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        $("#mdaterrormsg").html($.trim(xhr.responseText));
                        document.getElementById('mdaterrormsg').style.display = 'block';
                        document.getElementById('file-mod-form').reset();
                        document.getElementById('mod-upload-button').value = "Upload Document";
                        document.getElementById('mod-upload-button').disabled = false;
                        getFilesCount(applicantId);
                    } else {
                        //        alert('An error occurred!');
                    }
                };
                xhr.send(formData);

            }
            //file upload end

            $('#progressbar').fadeOut('slow');
        } else {
            alert('no ajax request');
        }

    }
    function getFilesCount(applicantId) {
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/getFileCountByApplicantId.jsp?applicantId=" + applicantId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
                callbackFileAttach();
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}



function viewResume(applicantId) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/getResumeByApplicantId.jsp?applicantId=" + applicantId + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackResume(applicantId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callbackResume(applicantId) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $("#IssuePopupFiles").html(xmlhttp.responseText);
            $(".popupHeading").html("View Resume For " + applicantId + " ");
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
          $('#MDAVpopup').fadeIn('fast', 'swing');
        }
    }
}