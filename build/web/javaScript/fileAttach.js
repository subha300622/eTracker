/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var xmlhttp = createRequest();

function viewFileAttachForIssue(issueId) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/getFilesByIssueId.jsp?issueId=" + issueId + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackModuleAttach(issueId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callbackModuleAttach(issueId) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $("#IssuePopupFiles").html(xmlhttp.responseText);
            $(".popupHeading").html("View Attached Files ( " + issueId + " )");
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
function closeFileAttach() {
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


function createFileAttach() {

    var issueId = document.getElementById('issueId').value;
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
            formData.append('issueId', issueId);
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                // Add the file to the request.
                formData.append('photos[]', file, file.name);
            }
            if (files.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/eTracker/fileAttachIssue.jsp', true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        $("#mdaterrormsg").html($.trim(xhr.responseText));
                        document.getElementById('mdaterrormsg').style.display = 'block';
                        document.getElementById('file-mod-form').reset();
                        document.getElementById('mod-upload-button').value = "Upload Document";
                        document.getElementById('mod-upload-button').disabled = false;
                        getFilesCount(issueId);
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
    function getFilesCount(issueId) {
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/getFileCountByIssueId.jsp?issueId=" + issueId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
                callbackFileAttach();
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}

function updateFileAttach() {
    var issueId = document.getElementById('issueIda').value;
    var comments = CKEDITOR.instances.comments.getData();
    var editor = CKEDITOR.instances['comments'];
    var fileModSelect = document.getElementById('img-mod-select');
    if (document.getElementById("img-mod-select").value == '') {
        document.getElementById('imgerrormsg').style.display = 'block';
        document.getElementById('imgerrormsg').innerHTML = "Please select the file";
        return false;
    } else {
        var files = fileModSelect.files;
        if (xmlhttp !== null) {
            $('#progressbara').fadeIn('slow');
            document.getElementById('mod-update-button').value = "Processing";
            document.getElementById('mod-update-button').disabled = true;
            var formData = new FormData();
            formData.append('issueId', issueId);
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                formData.append('photos[]', file, file.name);
            }
            if (files.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/eTracker/fileAttachIssueComment.jsp', true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var text = $.trim(xhr.responseText);
                        var texta = text.substring(0, text.indexOf("@@@"));
                        document.getElementById('imgerrormsg').style.display = 'block';
                        document.getElementById('img-mod-form').reset();
                        document.getElementById('mod-update-button').value = "Add image(s) to comments";
                        document.getElementById('mod-update-button').disabled = false;
                        if (texta === "success") {
                            comments = comments + "<br/>" + text.substring(text.indexOf("@@@") + 3, text.length);
                            editor.setData(comments);
                            CKEDITOR.instances['comments'].on('change', function () {
                                CKEDITOR.instances['comments'].updateElement()
                            });
                            closeImgAttach();
                        } else {
                            $("#imgerrormsg").html(text);
                        }
                    }
                };
                xhr.send(formData);
            }
            $('#progressbara').fadeOut('slow');
        } else {
            alert('no ajax request');
        }
    }
}
function closeImgAttach() {
    document.getElementById("img-mod-select").value = '';
    document.getElementById('imgerrormsg').style.display = 'none';
    document.getElementById('uploadImg').disabled = false;
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSApopup').fadeOut('fast', 'swing');
    $('#progressbara').fadeOut('fast', 'swing');
}
function showImgAttach() {
    document.getElementById('imgerrormsg').style.display = 'none';
    document.getElementById('uploadImg').disabled = true;
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#TSApopup').fadeIn('fast', 'swing');
}
