var xmlhttp = createRequest();
function trim(str)
{
    while (str.charAt(str.length - 1) === " ") {
        str = str.substring(0, str.length - 1);
    }
    while (str.charAt(0) === " ") {
        str = str.substring(1, str.length);
    }
    return str;
}

function isPositiveInteger(str)
{
    var pattern = "abcdefghijklmnopqrstuvwxyz,'.-_ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890><";
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) === pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos === 1 && i < str.length)
    if (pos === 0)
        return false;
    return true;
}
function isPositiveInteger1(str)
{
    var pattern = "()#!@$%abcdefghijklmnopqrstuvwxyz,'.-_ \ ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890></&;:?{}[]=";
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) === pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos === 1 && i < str.length)
    if (pos === 0)
        return false;
    return true;
}
var showPopUp = function (popup) {
    $('#overlay').fadeIn('fast', 'swing');
    popup.fadeIn('fast', 'swing');
};
var closePopUp = function (popup) {
    popup.fadeOut('fast', 'swing');
    $('#overlay').fadeOut('fast', 'swing');
};
var submitProfileChangesForm = function () {




};
function showCompany() {

    document.getElementById('pId').value = document.getElementById('pid').value;
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#comppopup').fadeIn('fast', 'swing');


}
;

function createCompany() {

    var companyName = document.getElementById('comp').value;
    var pid = document.getElementById('pId').value;
    var srcCompany = document.getElementById('srcCompany').value;
    document.getElementById('comp').value = '';
    document.getElementById('srcCompany').value = '';
    if (trim(companyName) === '')
    {
        document.getElementById('errormsg').style.display = 'block';
        document.getElementById('comp').focus();
        return false;
    }

//            if (!isPositiveInteger(trim(companyName)))
//            {
//   		document.getElementById('errormsg').style.display='block';
//               document.getElementById('comp').focus();
//                return false;
//            }

    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createCompany.jsp?company=" + encodeURIComponent(companyName) + "&pid=" + pid + "&srcCompany=" + srcCompany + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackCompany();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function callbackCompany() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#comppopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#client ul li.lastcompany').before(comp);
            var count = document.getElementById('ccount').innerHTML;
            count = (count * 1) + 1;
            document.getElementById('ccount').innerHTML = count;

        }

    }
}
function closeCompany() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#comppopup').fadeOut('fast', 'swing');
    document.getElementById('errormsg').style.display = 'none';

}
function viewCompany(pid) {

    $('#client div').toggleClass('treeExpand');
    if ($('#client').has("ul").length === 0) {
        if (xmlhttp !== null) {
            var client = document.getElementById('pid').value;

            xmlhttp.open("GET", "/eTracker/UserBPM/viewCompany.jsp?client=" + client + "&pid=" + pid + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
                callbackViewCompany();
            };
            xmlhttp.send(null);
        }
    } else {
        $('#client ul').toggle('slow');
    }

}
function callbackViewCompany() {
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#client').append(comp);

        }

    }

}
function editc(editcid) {
    document.getElementById('editcid').value = editcid;
    var cname = document.getElementById('cvalue' + editcid).value;
    document.getElementById('editcname').value = cname;
    $('#overlay').fadeIn('fast', 'swing');
    $('#compEditpopup').fadeIn('fast', 'swing');
}
function updateCompany() {

    var cId = document.getElementById('editcid').value;
    var cName = document.getElementById('editcname').value;
    document.getElementById('cspan' + cId).innerHTML = cName;
    document.getElementById('cvalue' + cId).value = cName;
    if (trim(cName) === '')
    {
        document.getElementById('editcerrormsg').style.display = 'block';
        document.getElementById('editcname').focus();
        return false;
    }

//            if (!isPositiveInteger(trim(cName)))
//            {
//                document.getElementById('editcerrormsg').innerHTML='Please enter the valid characters in Company Name';
//   		document.getElementById('editcerrormsg').style.display='block';
//                
//                document.getElementById('editcname').focus();
//                return false;
//            }
    closeEditCompany();
    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateCompany.jsp?cId=" + cId + "&cName=" + encodeURIComponent(cName) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditCompany() {
    document.getElementById('editcid').value = '';
    document.getElementById('editcname').value = '';
    $('#overlay').fadeOut('fast', 'swing');
    $('#compEditpopup').fadeOut('fast', 'swing');

}
function deleteCompany(cId) {
    if (confirm("Do you want to delete Company?"))
    {
        $('#c' + cId).remove();
        var count = document.getElementById('ccount').innerHTML;
        count = (count * 1) - 1;
        document.getElementById('ccount').innerHTML = count;
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteCompany.jsp?cId=" + cId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }

}
function showBP(compId) {
    document.getElementById('compid').value = compId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#BPpopup').fadeIn('fast', 'swing');

}
function closeBP() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#BPpopup').fadeOut('fast', 'swing');
}

function viewBP(company) {
    $('#c' + company + ' div').toggleClass('treeExpand');
    if ($('#c' + company).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {


                xmlhttp.open("GET", "/eTracker/UserBPM/viewBP.jsp?company=" + company + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackviewBP(company);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#c' + company + ' ul').toggle('slow');
    }

}
function callbackviewBP(company) {
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#c' + company).append(comp);

        }

    }

}
function createBP() {

    var companyId = document.getElementById('compid').value;

    var bpName = document.getElementById('bp').value;

    var createBpType;
    if (document.getElementById('createBpType') !== null) {
        createBpType = document.getElementById('createBpType').value;
    }

    if (trim(bpName) === '')
    {
        document.getElementById('createbptypeerrormsg').style.display = 'none';
        document.getElementById('bperrormsg').style.display = 'block';
        document.getElementById('bp').focus();
        return false;
    }

//            if (!isPositiveInteger(trim(bpName)))
//            {
//   		document.getElementById('bperrormsg').style.display='block';
//               document.getElementById('bp').focus();
//                return false;
//            }
    if (document.getElementById('createBpType') !== null) {
        if (trim(createBpType) === '')
        {
            document.getElementById('bperrormsg').style.display = 'none';
            document.getElementById('createbptypeerrormsg').style.display = 'block';
            document.getElementById('createBpType').focus();
            return false;
        }
    }
    document.getElementById('bp').value = '';
    if (document.getElementById('createBpType') !== null) {
        document.getElementById('createBpType').value = '';

    }
    if (createBpType === undefined) {
        createBpType = '';
    }

    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createBP.jsp?company=" + companyId + "&bpName=" + encodeURIComponent(bpName) + "&cBpType=" + encodeURIComponent(createBpType) + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callbackBP(companyId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function callbackBP(company) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#BPpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newBp = xmlhttp.responseText;
            $('#c' + company + ' ul li.lastbp').before(newBp);
            var count = document.getElementById('bpcount' + company).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('bpcount' + company).innerHTML = count;
            if ($('#deletec' + company).length > 0) {
                $('#deletec' + company).remove();
            }

        }

    }
}
function editbp(bpId) {
    document.getElementById('editbpid').value = bpId;
    var bpname = document.getElementById('bpvalue' + bpId).value;
    var bpType = document.getElementById('bpType' + bpId).value;
    document.getElementById('editbpname').value = bpname;
    if (document.getElementById('bpType') !== null) {
        document.getElementById('bpType').value = bpType;
    }
    $('#overlay').fadeIn('fast', 'swing');
    $('#BPEditpopup').fadeIn('fast', 'swing');
}
function updateBP() {

    var bpId = document.getElementById('editbpid').value;
    var bpName = document.getElementById('editbpname').value;
    var bpType;
    if (document.getElementById('bpType') !== null) {
        bpType = document.getElementById('bpType').value;
    }

    if (trim(bpName) === '')
    {
        document.getElementById('bptypeerrormsg').style.display = 'none';
        document.getElementById('bpediterrormsg').style.display = 'block';
        document.getElementById('editbpname').focus();
        return false;
    }
    if (document.getElementById('bpType') !== null) {
        if (trim(bpType) === '')
        {
            document.getElementById('bpediterrormsg').style.display = 'none';
            document.getElementById('bptypeerrormsg').style.display = 'block';
            document.getElementById('bpType').focus();
            return false;
        }
    }

//            if (!isPositiveInteger(trim(bpName)))
//            {
//                document.getElementById('bpediterrormsg').innerHTML='Please enter the valid characters in BP Name';
//   		document.getElementById('bpediterrormsg').style.display='block';
//                
//                document.getElementById('editbpname').focus();
//                return false;
//            }
    closeEditBP();
    document.getElementById('bpspan' + bpId).innerHTML = bpName;
    if (document.getElementById('bpType') !== null) {
        if (bpType === 'Non SAP') {
            document.getElementById('bpspan' + bpId).style.color = 'red';
        } else {
            document.getElementById('bpspan' + bpId).style.color = '';
        }
        document.getElementById('bpType' + bpId).value = bpType;
    }
    document.getElementById('bpvalue' + bpId).value = bpName;
    if (bpType === undefined) {
        bpType = '';
    }

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateBP.jsp?bpId=" + bpId + "&bpName=" + encodeURIComponent(bpName) + "&bpType=" + bpType + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditBP() {
    document.getElementById('editbpid').value = '';
    document.getElementById('editbpname').value = '';
    if (document.getElementById('bpType') !== null) {
        document.getElementById('bpType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#BPEditpopup').fadeOut('fast', 'swing');

}
function deleteBP(bpId, cId) {
    if (confirm("Do you want to delete Business Process?"))
    {
        var count = document.getElementById('bpcount' + cId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('bpcount' + cId).innerHTML = count;
        if (count === 0) {
            var a = $('#bp' + bpId).parent();

            var li = $(a).parent();
            var c = $(li).attr("id");


            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletebp' + cId);
            spn.onclick = new Function("javascript:deleteCompany('" + cId + "');");
            spn.appendChild(img);
            var id = '#' + c + ' ul';
            $(spn).insertBefore(id);
        }
        $('#bp' + bpId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteBP.jsp?bpId=" + bpId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showMP(bpId) {

    document.getElementById('bpid').value = bpId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#MPpopup').fadeIn('fast', 'swing');

}
;
function closeMP() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MPpopup').fadeOut('fast', 'swing');
}

function viewMP(bpId) {
    $('#bp' + bpId + ' div').toggleClass('treeExpand');
    if ($('#bp' + bpId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewMP.jsp?bpId=" + bpId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackMP(bpId);
                };

                xmlhttp.send(null);
            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#bp' + bpId + ' ul').toggle('slow');
    }

}
function callbackMP(bpId)
{
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var bp = xmlhttp.responseText;
        $('#bp' + bpId).append(bp);

    }
}
function createMP() {

    var bpId = document.getElementById('bpid').value;
    var mpName = document.getElementById('mp').value;
    var createMpType;
    if (document.getElementById('createMpType') !== null) {
        createMpType = document.getElementById('createMpType').value;
    }

    if (trim(mpName) === '')
    {
        document.getElementById('createmptypeerrormsg').style.display = 'none';
        document.getElementById('mperrormsg').style.display = 'block';
        document.getElementById('mp').focus();
        return false;
    }

//            if (!isPositiveInteger(trim(mpName)))
//            {
//   		document.getElementById('mperrormsg').style.display='block';
//               document.getElementById('mp').focus();
//                return false;
//            }
    if (document.getElementById('createMpType') !== null) {
        if (trim(createMpType) === '')
        {
            document.getElementById('mperrormsg').style.display = 'none';
            document.getElementById('createmptypeerrormsg').style.display = 'block';
            document.getElementById('createMpType').focus();
            return false;
        }
    }
    document.getElementById('mp').value = '';
    if (document.getElementById('createMpType') !== null) {
        document.getElementById('createMpType').value = '';
    }
    if (createMpType === undefined) {
        createMpType = '';
    }
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createMP.jsp?bpId=" + bpId + "&mpName=" + encodeURIComponent(mpName) + "&cMpType=" + encodeURIComponent(createMpType) + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            appendMP(bpId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendMP(bp) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MPpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newMp = xmlhttp.responseText;
            $('#bp' + bp + ' ul li.lastmp').before(newMp);
            var count = document.getElementById('mpcount' + bp).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('mpcount' + bp).innerHTML = count;
            if ($('#deletebp' + bp).length > 0) {
                $('#deletebp' + bp).remove();
            }

        }

    }
}
function editmp(mpId) {
    document.getElementById('editmpid').value = mpId;
    var mpname = document.getElementById('mpvalue' + mpId).value;
    var mpType = document.getElementById('mpType' + mpId).value;
    document.getElementById('editmpname').value = mpname;
    if (document.getElementById('mpType') !== null) {
        document.getElementById('mpType').value = mpType;
    }
    $('#overlay').fadeIn('fast', 'swing');
    $('#MPEditpopup').fadeIn('fast', 'swing');
}
function updateMP() {

    var mpId = document.getElementById('editmpid').value;
    var mpName = document.getElementById('editmpname').value;
    var mpType;
    if (document.getElementById('mpType') !== null) {
        mpType = document.getElementById('mpType').value;
    }
    if (trim(mpName) === '')
    {
        document.getElementById('mptypeerrormsg').style.display = 'none';
        document.getElementById('mpediterrormsg').style.display = 'block';
        document.getElementById('editmpname').focus();
        return false;
    }
    if (document.getElementById('mpType') !== null) {
        if (trim(mpType) === '')
        {
            document.getElementById('mpediterrormsg').style.display = 'none';
            document.getElementById('mptypeerrormsg').style.display = 'block';
            document.getElementById('mpType').focus();
            return false;
        }
    }
    closeEditMP();
    document.getElementById('mpspan' + mpId).innerHTML = mpName;
    if (document.getElementById('mpType') !== null) {
        if (mpType === 'Non SAP') {
            document.getElementById('mpspan' + mpId).style.color = 'red';
        } else {
            document.getElementById('mpspan' + mpId).style.color = '';
        }
        document.getElementById('mpType' + mpId).value = mpType;
    } else {
        mpType = '';
    }
    document.getElementById('mpvalue' + mpId).value = mpName;

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateMP.jsp?mpId=" + mpId + "&mpName=" + encodeURIComponent(mpName) + "&mpType=" + encodeURIComponent(mpType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditMP() {
    document.getElementById('editmpid').value = '';
    document.getElementById('editmpname').value = '';
    if (document.getElementById('mpType') !== null) {
        document.getElementById('mpType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#MPEditpopup').fadeOut('fast', 'swing');

}
function deleteMP(mpId, bpId) {
    if (confirm("Do you want to delete Main Process?"))
    {
        var count = document.getElementById('mpcount' + bpId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('mpcount' + bpId).innerHTML = count;
        if (count === 0) {
            var a = $('#mp' + mpId).parent();

            var li = $(a).parent();
            var bp = $(li).attr("id");
            var bpId = (bp).replace('bp', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('c', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletebp' + cId);
            spn.onclick = new Function("javascript:deleteBP('" + bpId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + bp + ' ul';
            $(spn).insertBefore(id);
        }
        $('#mp' + mpId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteMP.jsp?mpId=" + mpId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showSP(mpId) {

    document.getElementById('mpid').value = mpId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#SPpopup').fadeIn('fast', 'swing');

}
;
function closeSP() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#SPpopup').fadeOut('fast', 'swing');
}

function viewSP(mpId) {
    $('#mp' + mpId + ' div').toggleClass('treeExpand');
    if ($('#mp' + mpId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewSP.jsp?mpId=" + mpId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackSP(mpId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#mp' + mpId + ' ul').toggle('slow');
    }
}
function callbackSP(mpId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var sp = xmlhttp.responseText;
        $('#mp' + mpId).append(sp);
    }
}
function createSP() {

    var mpId = document.getElementById('mpid').value;
    var spName = document.getElementById('sp').value;
    var createSpType;
    if (document.getElementById('createSpType') !== null) {
        createSpType = document.getElementById('createSpType').value;
    }
    document.getElementById('mpid').value = '';
    if (trim(spName) === '')
    {
        document.getElementById('createsptypeerrormsg').style.display = 'none';
        document.getElementById('sperrormsg').style.display = 'block';
        document.getElementById('sp').focus();
        return false;
    }

//            if (!isPositiveInteger(trim(spName)))
//            {
//   		document.getElementById('sperrormsg').style.display='block';
//               document.getElementById('sp').focus();
//                return false;
//            }
    if (createSpType !== undefined) {
        if (trim(createSpType) === '')
        {
            document.getElementById('sperrormsg').style.display = 'none';
            document.getElementById('createsptypeerrormsg').style.display = 'block';
            document.getElementById('createSpType').focus();
            return false;
        }
    } else {
        createSpType = '';
    }
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createSP.jsp?mpId=" + mpId + "&spName=" + encodeURIComponent(spName) + "&cSpType=" + encodeURIComponent(createSpType) + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            appendSP(mpId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendSP(mp) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#SPpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newSp = xmlhttp.responseText;
            $('#mp' + mp + ' ul li.lastsp').before(newSp);
            var count = document.getElementById('spcount' + mp).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('spcount' + mp).innerHTML = count;
            if ($('#deletemp' + mp).length > 0) {
                $('#deletemp' + mp).remove();
            }
        }

    }
}
function editsp(spId) {
    document.getElementById('editspid').value = spId;
    var spname = document.getElementById('spvalue' + spId).value;
    var spType = document.getElementById('spType' + spId).value;
    document.getElementById('editspname').value = spname;
    if (document.getElementById('spType') !== null) {
        document.getElementById('spType').value = spType;
    }
    $('#overlay').fadeIn('fast', 'swing');
    $('#SPEditpopup').fadeIn('fast', 'swing');
}
function updateSP() {

    var spId = document.getElementById('editspid').value;

    var spName = document.getElementById('editspname').value;
    var spType;
    if (document.getElementById('spType') !== null) {
        spType = document.getElementById('spType').value;
    }

    if (trim(spName) === '')
    {
        document.getElementById('sptypeerrormsg').style.display = 'none';
        document.getElementById('spediterrormsg').style.display = 'block';
        document.getElementById('editspname').focus();
        return false;
    }
    if (spType !== undefined) {
        if (trim(spType) === '')
        {
            document.getElementById('spediterrormsg').style.display = 'none';
            document.getElementById('sptypeerrormsg').style.display = 'block';
            document.getElementById('spType').focus();
            return false;
        }
    }

    closeEditSP();
    document.getElementById('spspan' + spId).innerHTML = spName;
    if (spType !== undefined) {
        if (spType === 'Non SAP') {
            document.getElementById('spspan' + spId).style.color = 'red';
        } else {
            document.getElementById('spspan' + spId).style.color = '';
        }
        document.getElementById('spType' + spId).value = spType;
    } else {
        spType = '';
    }
    document.getElementById('spvalue' + spId).value = spName;

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateSP.jsp?spId=" + spId + "&spName=" + encodeURIComponent(spName) + "&spType=" + encodeURIComponent(spType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditSP() {
    document.getElementById('editspid').value = '';
    document.getElementById('editspname').value = '';
    if (document.getElementById('spType') !== null) {
        document.getElementById('spType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#SPEditpopup').fadeOut('fast', 'swing');

}
function deleteSP(spId, mpId) {
    if (confirm("Do you want to delete Sub Process?"))
    {
        var count = document.getElementById('spcount' + mpId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('spcount' + mpId).innerHTML = count;
        if (count === 0) {
            var a = $('#sp' + spId).parent();

            var li = $(a).parent();
            var mp = $(li).attr("id");
            var mpId = (mp).replace('mp', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('bp', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletemp' + cId);
            spn.onclick = new Function("javascript:deleteMP('" + mpId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + mp + ' ul';
            $(spn).insertBefore(id);
        }
        $('#sp' + spId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteSP.jsp?spId=" + spId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showSC(spId) {

    document.getElementById('spid').value = spId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#SCpopup').fadeIn('fast', 'swing');

}
function closeSC() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#SCpopup').fadeOut('fast', 'swing');
}

function viewSC(spId) {

    $('#sp' + spId + ' div').toggleClass('treeExpand');
    if ($('#sp' + spId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewSC.jsp?spId=" + spId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackSC(spId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#sp' + spId + ' ul').toggle('slow');
    }
}
function callbackSC(spId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var sp = xmlhttp.responseText;
        $('#sp' + spId).append(sp);
    }
}
function createSC() {

    var spId = document.getElementById('spid').value;
    var scName = document.getElementById('sc').value;
    var createScType;
    if (document.getElementById('createScType') !== null) {
        createScType = document.getElementById('createScType').value;
    }
    document.getElementById('spid').value = '';
    if (trim(scName) === '')
    {
        document.getElementById('createsctypeerrormsg').style.display = 'none';
        document.getElementById('scerrormsg').style.display = 'block';
        document.getElementById('sc').focus();
        return false;
    }
    scName = (scName);
//            if (!isPositiveInteger(trim(scName)))
//            {
//   		document.getElementById('scerrormsg').style.display='block';
//                document.getElementById('sc').focus();
//                return false;
//            }
    if (createScType !== undefined) {
        if (trim(createScType) === '')
        {
            document.getElementById('scerrormsg').style.display = 'none';
            document.getElementById('createsctypeerrormsg').style.display = 'block';
            document.getElementById('createScType').focus();
            return false;
        }
    } else {
        createScType = '';
    }
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createSC.jsp?spId=" + spId + "&scName=" + encodeURIComponent(scName) + "&cScType=" + encodeURIComponent(createScType) + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            appendSC(spId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendSC(scId) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#SCpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newSc = xmlhttp.responseText;
            $('#sp' + scId + ' ul li.lastsc').before(newSc);
            var count = document.getElementById('sccount' + scId).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('sccount' + scId).innerHTML = count;
            if ($('#deletesp' + scId).length > 0) {
                $('#deletesp' + scId).remove();
            }
        }

    }
}
function editsc(scId) {
    document.getElementById('editscid').value = scId;
    var scname = document.getElementById('scvalue' + scId).value;
    var scType = document.getElementById('scType' + scId).value;
    document.getElementById('editscname').value = scname;
    if (document.getElementById('scType') !== null) {
        document.getElementById('scType').value = scType;
    }
    $('#overlay').fadeIn('fast', 'swing');
    $('#SCEditpopup').fadeIn('fast', 'swing');
}
function updateSC() {

    var scId = document.getElementById('editscid').value;

    var scName = document.getElementById('editscname').value;
    var scType;
    if (document.getElementById('scType') !== null) {
        scType = document.getElementById('scType').value;
    }
    if (trim(scName) === '')
    {
        document.getElementById('sctypeerrormsg').style.display = 'none';
        document.getElementById('scediterrormsg').style.display = 'block';
        document.getElementById('editscname').focus();
        return false;
    }
    if (scType !== undefined) {
        if (trim(scType) === '')
        {
            document.getElementById('scediterrormsg').style.display = 'none';
            document.getElementById('sctypeerrormsg').style.display = 'block';
            document.getElementById('scType').focus();
            return false;
        }
    }

//            if (!isPositiveInteger(trim(scName)))
//            {
//                document.getElementById('scediterrormsg').innerHTML='Please enter valid character in Scenario';
//   		document.getElementById('scediterrormsg').style.display='block';
//                document.getElementById('editscname').focus();
//                return false;
//            }         
    closeEditSC();
    if (scType !== undefined) {
        document.getElementById('scspan' + scId).innerHTML = scName;
        if (scType === 'Non SAP') {
            document.getElementById('scspan' + scId).style.color = 'red';
        } else {
            document.getElementById('scspan' + scId).style.color = '';
        }
        document.getElementById('scType' + scId).value = scType;
    } else {
        scType = '';
    }
    document.getElementById('scvalue' + scId).value = scName;

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateSC.jsp?scId=" + scId + "&scName=" + encodeURIComponent(scName) + "&scType=" + encodeURIComponent(scType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditSC() {
    document.getElementById('editscid').value = '';
    document.getElementById('editscname').value = '';
    if (document.getElementById('scType') !== null) {
        document.getElementById('scType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#SCEditpopup').fadeOut('fast', 'swing');

}
function deleteSC(scId, spId) {
    if (confirm("Do you want to delete Scenario?"))
    {
        var count = document.getElementById('sccount' + spId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('sccount' + spId).innerHTML = count;
        if (count === 0) {
            var a = $('#sc' + scId).parent();

            var li = $(a).parent();
            var sp = $(li).attr("id");
            var spId = (sp).replace('sp', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('mp', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletesc' + cId);
            spn.onclick = new Function("javascript:deleteSP('" + spId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + sp + ' ul';
            $(spn).insertBefore(id);
        }
        $('#sc' + scId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteSC.jsp?scId=" + scId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showVT(scId) {
    document.getElementById('scid').value = scId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#VTpopup').fadeIn('fast', 'swing');

}
;
function closeVT() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#VTpopup').fadeOut('fast', 'swing');
}

function viewVT(scId) {
    $('#sc' + scId + ' div').toggleClass('treeExpand');
    if ($('#sc' + scId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewVT.jsp?scId=" + scId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackVT(scId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#sc' + scId + ' ul').toggle('slow');
    }
}
function callbackVT(scId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var sc = xmlhttp.responseText;
        $('#sc' + scId).append(sc);
    }
}
function createVT() {

    var scId = document.getElementById('scid').value;

    var vtName = document.getElementById('vt').value;
    var leadModule = document.getElementById('lead').value;
    var impactModule = document.getElementById('impact').value;
    var type = document.getElementById('type').value;
    var classification = document.getElementById('calssification').value;
    var priority = document.getElementById('priority').value;
    var createVtType;
    if (document.getElementById('createVtType') !== null) {
        createVtType = document.getElementById('createVtType').value;
    }
    if (trim(vtName) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Enter Variant Name";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('vt').focus();
        return false;
    }
    vtName = (vtName);

    if (trim(leadModule) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Select Lead module";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('lead').focus();
        return false;
    }
    if (trim(impactModule) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Select Impacted Module";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('impact').focus();
        return false;
    }
    if (trim(type) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Select Data Type";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('type').focus();
        return false;
    }
    if (trim(classification) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Select Classification";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('calssification').focus();
        return false;
    }
    if (trim(priority) === '')
    {
        document.getElementById('vterrormsg').innerHTML = "Please Select Priority";
        document.getElementById('vterrormsg').style.display = 'block';
        document.getElementById('priority').focus();
        return false;
    }
    if (createVtType !== undefined) {
        if (trim(createVtType) === '')
        {
            document.getElementById('vterrormsg').innerHTML = "Please Select Process Yype";
            document.getElementById('vterrormsg').style.display = 'block';
            document.getElementById('createVtType').focus();
            return false;
        }
    } else {
        createVtType = '';
    }
    document.getElementById('vterrormsg').style.display = 'none';
    document.getElementById('vt').value = '';
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createVT.jsp?scId=" + scId + "&vtName=" + encodeURIComponent(vtName) + "&leadModule=" + leadModule + "&impactModule=" + impactModule + "&type=" + type + "&classification=" + classification + "&priority=" + priority + "&cVtType=" + encodeURIComponent(createVtType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            appendVT(scId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendVT(sc) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#VTpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newVt = xmlhttp.responseText;
            $('#sc' + sc + ' ul li.lastvt').before(newVt);
            var count = document.getElementById('vtcount' + sc).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('vtcount' + sc).innerHTML = count;
            if ($('#deletesc' + sc).length > 0) {
                $('#deletesc' + sc).remove();
            }

        }

    }
}
function editvt(vtId, lead, impact, classification, type, priority, saptype) {
    document.getElementById('editvtid').value = vtId;
    var vtname = document.getElementById('vtvalue' + vtId).value;
    var vtType = document.getElementById('vtType' + vtId).value;
    document.getElementById('editvtname').value = vtname;
    if (document.getElementById('vtType') !== null) {
        document.getElementById('vtType').value = vtType;
    }

    $('#editlead').val(lead).change();
    $('#editimpact').val(impact).change();
    $('#edittype').val(type).change();
    $('#editcalssification').val(classification).change();
    $('#editpriority').val(priority).change();

    $('#overlay').fadeIn('fast', 'swing');
    $('#VTEditpopup').fadeIn('fast', 'swing');
}
function updateVT() {

    var vtId = document.getElementById('editvtid').value;

    var vtName = document.getElementById('editvtname').value;
    var editlead = document.getElementById('editlead').value;
    var editimpact = document.getElementById('editimpact').value;
    var edittype = document.getElementById('edittype').value;
    var editcalssification = document.getElementById('editcalssification').value;
    var editpriority = document.getElementById('editpriority').value;
    var vtType;
    if (document.getElementById('vtType') !== null) {
        vtType = document.getElementById('vtType').value;
    }
    if (trim(vtName) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Enter Variant Name";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('editvtname').focus();
        return false;
    }
    if (trim(editlead) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Select Lead Module";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('editlead').focus();
        return false;
    }
    if (trim(editimpact) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Select Impacted Module";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('editimpact').focus();
        return false;
    }
    if (trim(edittype) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Select Data Type";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('edittype').focus();
        return false;
    }
    if (trim(editcalssification) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Select Classification";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('editcalssification').focus();
        return false;
    }
    if (trim(editpriority) === '')
    {
        document.getElementById('vtediterrormsg').innerHTML = "Please Select Priority";
        document.getElementById('vtediterrormsg').style.display = 'block';
        document.getElementById('editpriority').focus();
        return false;
    }
    if (vtType !== undefined) {
        if (trim(vtType) === '')
        {
            document.getElementById('vtediterrormsg').innerHTML = "Please Select Type";
            document.getElementById('vtediterrormsg').style.display = 'block';
            document.getElementById('vtType').focus();
            return false;
        }
    } else {
        vtType = '';
    }
    closeEditVT();
    document.getElementById('vtspan' + vtId).innerHTML = vtName;
    if (vtType !== undefined) {
        if (vtType === 'Non SAP') {
            document.getElementById('vtspan' + vtId).style.color = 'red';
        } else {
            document.getElementById('vtspan' + vtId).style.color = '';
        }
        document.getElementById('vtType' + vtId).value = vtType;
    }

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateVT.jsp?vtId=" + vtId + "&editvtname=" + encodeURIComponent(vtName) + "&editlead=" + encodeURIComponent(editlead) + "&editimpact=" + encodeURIComponent(editimpact) + "&edittype=" + encodeURIComponent(edittype) + "&editcalssification=" + encodeURIComponent(editcalssification) + "&editpriority=" + encodeURIComponent(editpriority) + "&vtType=" + encodeURIComponent(vtType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            document.getElementById('editspan' + vtId).removeAttribute('onclick');
            document.getElementById('editspan' + vtId).onclick = new Function("javascript:editvt(" + vtId + "," + editlead + "," + editimpact + ",'" + editcalssification + "','" + edittype + "','" + editpriority + "','" + vtType + "')");
            ;

        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditVT() {
    document.getElementById('editvtid').value = '';
    document.getElementById('editvtname').value = '';
    if (document.getElementById('vtType') !== null) {
        document.getElementById('vtType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#VTEditpopup').fadeOut('fast', 'swing');

}
function deleteVT(vtId, scId) {
    if (confirm("Do you want to delete Variant?"))
    {
        var count = document.getElementById('vtcount' + scId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('vtcount' + scId).innerHTML = count;
        if (count === 0) {
            var a = $('#vt' + vtId).parent();

            var li = $(a).parent();
            var sc = $(li).attr("id");
            var scId = (sc).replace('sc', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('sp', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletesc' + cId);
            spn.onclick = new Function("javascript:deleteSC('" + scId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + sc + ' ul';
            $(spn).insertBefore(id);
        }
        $('#vt' + vtId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteVT.jsp?vtId=" + vtId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showTC(vtId) {
    document.getElementById('vtid').value = vtId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#TCpopup').fadeIn('fast', 'swing');

}
;
function closeTC() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TCpopup').fadeOut('fast', 'swing');
}

function viewTC(vtId) {
    $('#vt' + vtId + ' div').toggleClass('treeExpand');
    if ($('#vt' + vtId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewTC.jsp?vtId=" + vtId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackTC(vtId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#vt' + vtId + ' ul').toggle('slow');
    }
}
function callbackTC(vtId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var vt = xmlhttp.responseText;
        $('#vt' + vtId).append(vt);
    }
}
function createTC() {

    var vtId = document.getElementById('vtid').value;

    var tcName = document.getElementById('tc').value;
    var createTcType;
    if (document.getElementById('createTcType') !== null) {
        createTcType = document.getElementById('createTcType').value;
    }
    if (trim(tcName) === '')
    {
        document.getElementById('createtctypeerrormsg').style.display = 'none';
        document.getElementById('tcerrormsg').style.display = 'block';
        document.getElementById('tc').focus();
        return false;
    }
    tcName = (tcName);
//            if (!isPositiveInteger1(trim(tcName)))
//            {
//   		document.getElementById('tcerrormsg').style.display='block';
//               document.getElementById('tc').focus();
//                return false;
//            }
    if (createTcType !== undefined) {
        if (trim(createTcType) === '')
        {
            document.getElementById('tcerrormsg').style.display = 'none';
            document.getElementById('createtctypeerrormsg').style.display = 'block';
            document.getElementById('createTcType').focus();
            return false;
        }
        document.getElementById('createTcType').value = '';
    } else {
        createTcType = '';
    }
    document.getElementById('tc').value = '';

    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createTC.jsp?vtId=" + vtId + "&tcName=" + encodeURIComponent(tcName) + "&cTcType=" + encodeURIComponent(createTcType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            appendTC(vtId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendTC(vt) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TCpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newTC = xmlhttp.responseText;
            $('#vt' + vt + ' ul li.lasttc').before(newTC);
            var count = document.getElementById('tccount' + vt).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('tccount' + vt).innerHTML = count;
            if ($('#deletevt' + vt).length > 0) {
                $('#deletevt' + vt).remove();
            }
        }

    }
}
function edittc(tcId) {
    document.getElementById('edittcid').value = tcId;
    var tcname = document.getElementById('tcvalue' + tcId).value;
    var tcType = document.getElementById('tcType' + tcId).value;
    document.getElementById('edittcname').value = tcname;
    if (document.getElementById('tcType') !== null) {
        document.getElementById('tcType').value = tcType;
    }
    $('#overlay').fadeIn('fast', 'swing');
    $('#TCEditpopup').fadeIn('fast', 'swing');
}
function updateTC() {

    var tcId = document.getElementById('edittcid').value;

    var tcName = document.getElementById('edittcname').value;
    var tcType;
    if (document.getElementById('tcType') !== null) {
        tcType = document.getElementById('tcType').value;
    }

    if (trim(tcName) === '')
    {
        document.getElementById('tctypeerrormsg').style.display = 'none';
        document.getElementById('tcediterrormsg').style.display = 'block';
        document.getElementById('edittcname').focus();
        return false;
    }
    if (tcType !== undefined) {
        if (trim(tcType) === '')
        {
            document.getElementById('tcediterrormsg').style.display = 'none';
            document.getElementById('tctypeerrormsg').style.display = 'block';
            document.getElementById('tcType').focus();
            return false;
        }
    }


    closeEditTC();
    document.getElementById('tcspan' + tcId).innerHTML = tcName;
    if (tcType !== undefined) {
        if (tcType === 'Non SAP') {
            document.getElementById('tcspan' + tcId).style.color = 'red';
        } else {
            document.getElementById('tcspan' + tcId).style.color = '';
        }
        document.getElementById('tcType' + tcId).value = tcType;
    } else {
        tcType = '';
    }
    document.getElementById('tcvalue' + tcId).value = tcName;

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateTC.jsp?tcId=" + tcId + "&tcName=" + encodeURIComponent(tcName) + "&tcType=" + encodeURIComponent(tcType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditTC() {
    document.getElementById('edittcid').value = '';
    document.getElementById('edittcname').value = '';
    if (document.getElementById('tcType') !== null) {
        document.getElementById('tcType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#TCEditpopup').fadeOut('fast', 'swing');

}
function deleteTC(tcId, vtId) {
    if (confirm("Do you want to delete Test Case?"))
    {
        var count = document.getElementById('tccount' + vtId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('tccount' + vtId).innerHTML = count;
        if (count === 0) {
            var a = $('#tc' + tcId).parent();

            var li = $(a).parent();
            var vt = $(li).attr("id");
            var vtId = (vt).replace('vt', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('sc', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletevt' + cId);
            spn.onclick = new Function("javascript:deleteVT('" + vtId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + vt + ' ul';
            $(spn).insertBefore(id);
        }
        $('#tc' + tcId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteTC.jsp?tcId=" + tcId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function showTS(tcId) {
    document.getElementById('tcid').value = tcId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#TSpopup').fadeIn('fast', 'swing');

}
;
function closeTS() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSpopup').fadeOut('fast', 'swing');
}

function viewTS(tcId) {
    $('#tc' + tcId + ' div').toggleClass('treeExpand');
    if ($('#tc' + tcId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewTS.jsp?tcId=" + tcId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackTS(tcId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
    } else {
        $('#tc' + tcId + ' ul').toggle('slow');
    }
}
function callbackTS(tcId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var ts = xmlhttp.responseText;
        $('#tc' + tcId).append(ts);
    }
}
function createTS() {

    var tcId = document.getElementById('tcid').value;

    var tsName = (document.getElementById('ts').value);
    var createTsType;
    if (document.getElementById('createTsType') !== null) {
        createTsType = document.getElementById('createTsType').value;
    }

    if (trim(tsName) === '')
    {
        document.getElementById('createtstypeerrormsg').style.display = 'none';
        document.getElementById('tserrormsg').style.display = 'block';
        document.getElementById('ts').focus();
        return false;
    }

//            if (!isPositiveInteger1(trim(tsName)))
//            {
//   		document.getElementById('tserrormsg').style.display='block';
//               document.getElementById('ts').focus();
//                return false;
//            }
    if (createTsType !== undefined) {
        if (trim(createTsType) === '')
        {
            document.getElementById('tserrormsg').style.display = 'none';
            document.getElementById('createtstypeerrormsg').style.display = 'block';
            document.getElementById('createTsType').focus();
            return false;
        }
        document.getElementById('createTsType').value = '';
    } else {
        createTsType = '';
    }
    document.getElementById('ts').value = '';

    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createTS.jsp?tcId=" + tcId + "&tsName=" + encodeURIComponent(tsName) + "&cTsType=" + encodeURIComponent(createTsType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            appendTS(tcId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function appendTS(tc) {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var newTs = xmlhttp.responseText;
            $('#tc' + tc + ' ul li.lastts').before(newTs);
            var count = document.getElementById('tscount' + tc).innerHTML;
            count = (count * 1) + 1;
            document.getElementById('tscount' + tc).innerHTML = count;
            if ($('#deletetc' + tc).length > 0) {
                $('#deletetc' + tc).remove();
            }
        }

    }
}
function editts(tsId) {
    document.getElementById('edittsid').value = tsId;
    var tsname = document.getElementById('tsvalue' + tsId).value;
    var tsType = document.getElementById('tsType' + tsId).value;
    document.getElementById('edittsname').value = tsname;
    if (document.getElementById('tsType') !== null) {
        document.getElementById('tsType').value = tsType;
    }

    $('#overlay').fadeIn('fast', 'swing');
    $('#TSEditpopup').fadeIn('fast', 'swing');
}

function updateTS() {

    var tsId = document.getElementById('edittsid').value;

    var tsName = document.getElementById('edittsname').value;
    var tsType;
    if (document.getElementById('tsType') !== null) {
        tsType = document.getElementById('tsType').value;
    }
    if (trim(tsName) === '')
    {
        document.getElementById('tstypeerrormsg').style.display = 'none';
        document.getElementById('tsediterrormsg').style.display = 'block';
        document.getElementById('edittsname').focus();
        return false;
    }
    if (tsType !== undefined) {
        if (trim(tsType) === '')
        {
            document.getElementById('tsediterrormsg').style.display = 'none';
            document.getElementById('tstypeerrormsg').style.display = 'block';
            document.getElementById('tsType').focus();
            return false;
        }
    }
    closeEditTS();
    document.getElementById('tsspan' + tsId).innerHTML = tsName;
    if (tsType !== undefined) {
        if (tsType === 'Non SAP') {
            document.getElementById('tsspan' + tsId).style.color = 'red';
        } else {
            document.getElementById('tsspan' + tsId).style.color = '';
        }
        document.getElementById('tsType' + tsId).value = tsType;
    } else {
        tsType = '';
    }
    document.getElementById('tsvalue' + tsId).value = tsName;

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateTS.jsp?tsId=" + tsId + "&tsName=" + encodeURIComponent(tsName) + "&tsType=" + encodeURIComponent(tsType) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function closeEditTS() {
    document.getElementById('edittsid').value = '';
    document.getElementById('edittsname').value = '';
    if (document.getElementById('tsType') !== null) {
        document.getElementById('tsType').value = '';
    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSEditpopup').fadeOut('fast', 'swing');

}

function showTSC(tsId) {
    document.getElementById('tsid').value = tsId;
    $('#overlay').fadeIn('fast', 'swing');
    $('#TSCpopup').fadeIn('fast', 'swing');

}
;
function closeTSC() {
    document.getElementById('terrormsg').style.display = 'none';
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSCpopup').fadeOut('fast', 'swing');
    document.getElementById('file-form').reset();
    document.getElementById('testScript').value = '';
    document.getElementById('expRslt').value = '';
}
function deleteTS(tsId, tcId) {
    if (confirm("Do you want to delete Test Step?"))
    {
        var count = document.getElementById('tscount' + tcId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('tscount' + tcId).innerHTML = count;
        if (count === 0) {
            var a = $('#ts' + tsId).parent();

            var li = $(a).parent();
            var tc = $(li).attr("id");
            var tcId = (tc).replace('tc', '');
            //           alert(bpId);

            var ul = $(li).parent();

            var target = $(ul).parent();
            var cId = $(target).attr("id").replace('vt', '');

            //        alert(cId); 

            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletetc' + cId);
            spn.onclick = new Function("javascript:deleteTC('" + tcId + "','" + cId + "');");
            spn.appendChild(img);
            var id = '#' + tc + ' ul';
            $(spn).insertBefore(id);
        }
        $('#ts' + tsId).remove();
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteTS.jsp?tsId=" + tsId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }
}
function viewTSC(tsId) {
    $('#ts' + tsId + ' div').toggleClass('treeExpand');
    if ($('#ts' + tsId).has("ul").length === 0) {
        try {
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/UserBPM/viewTestScript.jsp?tsId=" + tsId + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackTSC(tsId);
                };
                xmlhttp.send(null);

            }
        } catch (e) {
            alert(e);
        }
        $.ajax({
            url: '/eTracker/UserBPM/getTSCNo.jsp?tsId=' + tsId,
            success: function (data) {
                $("#tsrcount" + tsId).html(data);
            }
        });
    } else {
        $('#ts' + tsId + ' ul').remove();
    }
}
function callbackTSC(tsId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var testscript = xmlhttp.responseText;
        $('#ts' + tsId).append(testscript);
    }
}
function createTSC() {

    var tsId = document.getElementById('tsid').value;
    var pId = document.getElementById('pid').value;
    // var testScript      =   encodeURIComponent(CKEDITOR.instances.testScript.getData());
    var testScript = (document.getElementById('testScript').value);

    //  var expRslt      =   encodeURIComponent(CKEDITOR.instances.expRslt.getData());
    var expRslt = document.getElementById('expRslt').value;


    if (trim(testScript) === '')
    {
        document.getElementById('terrormsg').style.display = 'block';
        document.getElementById('testScript').focus();
        return false;
    }
//            if (!isPositiveInteger1(trim(testScript)))
//            {
//   		document.getElementById('tserrormsg').style.display='block';
//                document.getElementById('testScript').focus();
//                return false;
//            }
    if (trim(expRslt) === '')
    {
        document.getElementById('terrormsg').style.display = 'block';
        document.getElementById('expRslt').focus();
        return false;
    }
//            if (!isPositiveInteger1(trim(expRslt)))
//            {
//   		document.getElementById('terrormsg').style.display='block';
//                document.getElementById('expRslt').focus();
//                return false;
//            }
    document.getElementById('testScript').value = '';
    document.getElementById('expRslt').value = '';
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/UserBPM/createTestScript.jsp?tsId=" + tsId + "&scriptName=" + encodeURIComponent(testScript) + "&expRslt=" + encodeURIComponent(expRslt) + "&pid=" + pId + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            var ptcid;
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                var testscript = xmlhttp.responseText.split(",");
                ptcid = testscript[1];

                // $('#ts' + tsId).append(testscript);
                //file upload start
                var formq = document.getElementById('file-form');
                var fileSelect = document.getElementById('file-select');

                var files = fileSelect.files;
                var formData = new FormData();
                formData.append('testscript', ptcid);
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    // Add the file to the request.
                    formData.append('photos[]', file, file.name);
                }
                if (files.length > 0) {
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', '/eTracker/handler.jsp', false);
                    xhr.send(formData);
                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // File(s) uploaded.
                            //      alert('Uploaded!!!');
                        } else {
                            //        alert('An error occurred!');
                        }
                    };
                }

                //file upload end

            }
            viewNewTSC(tsId);
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
    document.getElementById('file-form').reset();
}
var newRequest = createRequest();
function viewNewTSC(tsId) {

    try {
        if (newRequest !== null) {
            newRequest.open("GET", '/eTracker/UserBPM/viewTestScript.jsp?tsId=' + tsId + '&rand=' + Math.random(1, 10), true);
            newRequest.onreadystatechange = function () {
                $('#ts' + tsId + ' ul').remove();
                if ($('#deletets' + tsId).length > 0) {
                    $('#deletets' + tsId).remove();
                }
                callbackTSCView(tsId);
            };
            newRequest.send(null);

        }
    } catch (e) {
        alert(e);
    }

}
function callbackTSCView(tsId) {

    if (newRequest.readyState === 4 && newRequest.status === 200) {
        var testscript = newRequest.responseText;
        $('#ts' + tsId).append(testscript);
        $.ajax({
            url: '/eTracker/UserBPM/getTSCNo.jsp?tsId=' + tsId,
            success: function (data) {
                $("#tsrcount" + tsId).html(data);
            }
        });

    }
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSCpopup').fadeOut('fast', 'swing');
}
function showComments(ptcId, tsId) {

    var qId = ptcId;
    var uId = qId + tsId;
    var id = "ptc" + uId;

    $('#' + tsId + ' tr td #' + uId).toggleClass('treeExpand');

    if ($('#' + tsId + ' tr td #' + uId).hasClass('treeExpand')) {
        $.ajax({
            url: '/eTracker/UserBPM/executionHistory.jsp?ptcId=' + qId,
            success: function (data) {
                $('#' + id).html(data);

            }
        });


    } else {
        $('#' + id).empty();
    }

}
function callbackComments(ptcId) {
    if (newRequest.readyState === 4 && newRequest.status === 200) {

        var comments = newRequest.responseText;
        var obj = document.getElementById('ptc' + ptcId);
        obj.appendChild(comments);

    }
}
function deleteTSC(tscId, tsId) {
    if (confirm("Do you want to delete Test Script?"))
    {
        var count = document.getElementById('tsrcount' + tsId).innerHTML;
        count = (count * 1) - 1;
        document.getElementById('tsrcount' + tsId).innerHTML = count;

        if (count === 0) {
            var tbody = $('#' + tscId).parent();

            var table = $(tbody).parent();
            var li = $(table).parent();
            //            var tcId    =   (tc).replace('tc','')
            //           alert(tc);

            var ul = $(li).parent();

            var current = $(ul).parent();
            var cId = $(current).attr("id").replace('ts', '');
            var uul = $(current).parent();
            var target = $(uul).parent();
            var tcId = $(target).attr("id").replace('tc', '');
            //          alert(target); 



            var img = document.createElement('img');

            img.style.position = 'relative';
            img.style.cursor = 'pointer';
            img.setAttribute('src', '/eTracker/images/close.png');
            var spn = document.createElement('span');
            spn.setAttribute('id', 'deletets' + tcId);
            spn.onclick = new Function("javascript:deleteTS('" + tsId + "','" + tcId + "');");
            spn.appendChild(img);
            var id = '#ts' + tsId + ' ul';
            if (!($('#deletets' + tcId).length > 0)) {
                $(spn).insertBefore(id);
            }
            $(ul).remove();
            $('#ts' + tsId + ' div').toggleClass('treeExpand');
        } else {
            $('#' + tscId).remove();
        }

        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/deleteTSC.jsp?tscId=" + tscId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
            };
            xmlhttp.send(null);
        } else {
            alert('no ajax request');
        }
    }

}
function viewAttachment(ptcId) {
    window.open("/eTracker/viewFiles.jsp?ptcId=" + ptcId);
}

function summaryOfTree(pid) {

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/summaryOfTree.jsp?pid=" + pid + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
            callbackSummaryOfTree();
        };
        xmlhttp.send(null);
    }

}
function callbackSummaryOfTree() {
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            var comp = xmlhttp.responseText;
            $('#summary').empty();
            $('#summary').append(comp);

        }

    }

}
function tStepCtreateIssue(tsId) {

    var project = document.getElementById('pname').value;
    var ps = project.split(':');
    var pname = ps[0];
    var version = ps[1];
    var next = new Date().getTime();
    var tsname = document.getElementById('tsvalue' + tsId).value;
    document.theForm.action = "/eTracker/editmodule.jsp?project=" + pname + "&version=" + version + "&tsname=" + encodeURIComponent(tsname) + "&tsId=" + tsId + "&next=" + next;
    theForm.target = "_blank";
    theForm.submit();
}


function editTSC(tscId) {
    document.getElementById('edittscid').value = tscId;
    var tscname = document.getElementById('tscvalue' + tscId).value;
    var tscresult = document.getElementById('tscresult' + tscId).value;
    var ptcId = document.getElementById('ptcId' + tscId).value;

    document.getElementById('edittscname').value = tscname;
    document.getElementById('edittscresult').value = tscresult;
    document.getElementById('ptcId').value = ptcId;

    $('#overlay').fadeIn('fast', 'swing');
    $('#TSCEditpopup').fadeIn('fast', 'swing');
}


function closeEditTSC() {
    document.getElementById('edittscid').value = '';
    document.getElementById('edittscname').value = '';
    document.getElementById('edittscresult').value = '';


    $('#overlay').fadeOut('fast', 'swing');
    $('#TSCEditpopup').fadeOut('fast', 'swing');

}


function updateTSC() {

    var tscId = document.getElementById('edittscid').value;
    var tscName = document.getElementById('edittscname').value;
    var tscResult = document.getElementById('edittscresult').value;
    var ptcId = document.getElementById('ptcId').value;
    $('#tdtscresult' + tscId).html(tscResult);
    $('#tdtscvalue' + tscId).html(tscName);

    if (trim(tscName) === '')
    {
        document.getElementById('tscediterrormsg').style.display = 'block';
        document.getElementById('tscResultediterrormsg').style.display = 'none';
        document.getElementById('edittscname').focus();
        return false;
    }

    if (trim(tscResult) === '')
    {
        document.getElementById('tscediterrormsg').style.display = 'none';
        document.getElementById('tscResultediterrormsg').style.display = 'block';
        document.getElementById('edittscresult').focus();
        return false;
    }

    closeEditTSC();

    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/updateTSC.jsp?ptcId=" + ptcId + "&tscId=" + tscId + "&tscName=" + encodeURIComponent(tscName) + "&tscResult=" + encodeURIComponent(tscResult) + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);

    } else {
        alert('no ajax request');
    }

}

function viewIssueTS(tsId) {
    var pid = document.getElementById('pid').value;
    try {
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/viewIssuesTS.jsp?pid=" + pid + "&tsId=" + tsId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
                callbackIssue(tsId);
            };
            xmlhttp.send(null);
        }
    } catch (e) {
        alert(e);
    }

}
function callbackIssue(tsId) {
    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        var issuesList = xmlhttp.responseText;
        $("#popupIssueList").html(issuesList);
        $('#overlay').fadeIn('fast', 'swing');
        $('#TSISSUEpopup').fadeIn('fast', 'swing');
    }
}

function closeIssueTS() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSISSUEpopup').fadeOut('fast', 'swing');
}


function assignIssueTS() {
    var pid = document.getElementById('pid').value;
    var tsid = document.getElementById('issueTsID').value;
    var issues = document.getElementsByName('issues');
    var selected = 0;
    var issueList = "";
    var n = issues.length;
    for (var i = 0; i < n; i++) {
        if (issues[i].checked)
        {
            issueList += issues[i].value + ",";
            selected = 1;
        }
    }
    if (selected === 0)
    {
        document.getElementById('tsissueerrormsg').style.display = 'block';
        return false;
    }
    closeIssueTS();
    if (xmlhttp !== null) {
        xmlhttp.open("GET", "/eTracker/UserBPM/addIssueTS.jsp?pid=" + pid + "&tsid=" + tsid + "&issues=" + issueList + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = function () {
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }

}
function showModuleAttach() {
    document.getElementById('mdaterrormsg').style.display = 'none';
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#MDApopup').fadeIn('fast', 'swing');

}
function closeModuleAttach() {
    document.getElementById('mdaterrormsg').style.display = 'none';
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDApopup').fadeOut('fast', 'swing');
    document.getElementById('file-form').reset();
    document.getElementById('module').value = '';
}
function createModuleAttach() {

    var moduleId = document.getElementById('moduleId').value;
    var pId = document.getElementById('projId').value;
    var uploadButton = document.getElementById('upload-button');

    if (trim(moduleId) === '')
    {
        document.getElementById('mdaterrormsg').style.display = 'block';
        document.getElementById('moduleId').focus();
        return false;
    } else if (document.getElementById("file-mod-select").value == '') {
        document.getElementById('mdaterrormsg').style.display = 'block';
        document.getElementById('mdaterrormsg').innerHTML = "Please select the file";
        var formmod = document.getElementById('file-mod-form');
        formmod.file1.focus();
        return false;
    } else {
        if (xmlhttp !== null) {
            var formmod = document.getElementById('file-mod-form');
            var fileModSelect = document.getElementById('file-mod-select');
            document.getElementById('mod-upload-button').value = "Processing";
            document.getElementById('mod-upload-button').disabled = true;
            document.getElementById('mod-upload-cancel').value = "Processing";
            document.getElementById('mod-upload-cancel').disabled = true;

            var files = fileModSelect.files;
            var formData = new FormData();
            formData.append('moduleId', moduleId);
            formData.append('pId', pId);
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                // Add the file to the request.
                formData.append('photos[]', file, file.name);
            }
            if (files.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/eTracker/moduleHandler.jsp', true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        $("#mdaterrormsg").html($.trim(xhr.responseText));
                        document.getElementById('mdaterrormsg').style.display = 'block';
                        document.getElementById('file-mod-form').reset();
                        document.getElementById('moduleId').value = '';
                        document.getElementById('mod-upload-button').value = "Add Document";
                        document.getElementById('mod-upload-button').disabled = false;
                        document.getElementById('mod-upload-cancel').value = "Cancel";
                        document.getElementById('mod-upload-cancel').disabled = false;
                        ;
                    } else {
                        //        alert('An error occurred!');
                    }
                };
                xhr.send(formData);

            }
            //file upload end

//        viewNewTSC(tsId);
        } else {
            alert('no ajax request');
        }
        document.getElementById('file-form').reset();
    }
}
function displayModuleAttach(pId) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/viewDocument.jsp?pId=" + pId + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callModuleAttach();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callModuleAttach() {

    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $("#MDAVpopupFiles").html(xmlhttp.responseText);
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#MDAVpopup').fadeIn('fast', 'swing');

        }

    }
}

function closeMDVAPopup() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#MDAVpopup').fadeOut('fast', 'swing');
}

function viewIssueByTSID(tsId) {
    $(".Ajax-loder").show();
    try {
        if (xmlhttp !== null) {
            xmlhttp.open("GET", "/eTracker/UserBPM/viewIssuesByTSID.jsp?tsId=" + tsId + "&rand=" + Math.random(1, 10), false);
            xmlhttp.onreadystatechange = function () {
                callbackIssuesList(tsId);
            };
            xmlhttp.send(null);
        }
    } catch (e) {
        alert(e);
    }

}
function callbackIssuesList() {


    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $(".Ajax-loder").hide();
            $('#dialog').html(xmlhttp.responseText);
            $("#dialog").dialog("open");
        }

    }
}

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
            $("#MDAVpopupFiles").html(xmlhttp.responseText);
            $(".popupHeading").html("View Attached Files ( " + issueId + " )");
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#MDAVpopup').fadeIn('fast', 'swing');
        }
    }
}


function moveUp() {
    var tr = $(this).parents('tr');
    var table = $(this).closest('table');

    moveRow(table, tr, 'up');
}

// Move the row down
function moveDown() {
    var tr = $(this).parents('tr');
    var table = $(this).closest('table');
    moveRow(table, tr, 'down');
}

function moveRow(table, row, direction) {
    var index = table.row(row).index();
    var order = -1;
    if (direction === 'down') {
        order = 1;
    }

    var data1 = table.row(index).data();
    data1.order += order;

    var data2 = table.row(index + order).data();
    data2.order += -order;

    table.row(index).data(data2);
    table.row(index + order).data(data1);

    table.page(0).draw(false);
}

function tStepAttachFile(tsId) {

    document.getElementById('testStepId').value = tsId;
    document.getElementById('tsamsg').style.display = 'none';
    $('#overlay').attr('height', $(window).height());
    $('#overlay').fadeIn('fast', 'swing');
    $('#TSApopup').fadeIn('fast', 'swing');
}

function closeTSAttach() {
    document.getElementById('tsamsg').style.display = 'none';
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSApopup').fadeOut('fast', 'swing');
    document.getElementById('file-form').reset();
}
function createTSAttach() {

    var tsId = document.getElementById('testStepId').value;
    if (trim(tsId) === '')
    {
        document.getElementById('tsamsg').style.display = 'block';
        return false;
    } else if (document.getElementById("file-ts-select").value == '') {
        document.getElementById('tsamsg').style.display = 'block';
        document.getElementById('tsamsg').innerHTML = "Please select the file";
        var formmod = document.getElementById('file-ts-form');
        formmod.file1.focus();
        return false;
    } else {
        if (xmlhttp !== null) {
            var formmod = document.getElementById('file-ts-form');
            var fileModSelect = document.getElementById('file-ts-select');
            document.getElementById('ts-upload-button').value = "Processing";
            document.getElementById('ts-upload-button').disabled = true;
            document.getElementById('ts-upload-cancel').value = "Processing";
            document.getElementById('ts-upload-cancel').disabled = true;

            var files = fileModSelect.files;
            var formData = new FormData();
            formData.append('tsid', tsId);
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                // Add the file to the request.
                formData.append('photos[]', file, file.name);
            }
            if (files.length > 0) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/eTracker/tsFileAttach.jsp', true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        $("#tsamsg").html($.trim(xhr.responseText));
                        document.getElementById('tsamsg').style.display = 'block';
                        document.getElementById('file-ts-form').reset();
                        document.getElementById('ts-upload-button').value = "Add Document";
                        document.getElementById('ts-upload-button').disabled = false;
                        document.getElementById('ts-upload-cancel').value = "Cancel";
                        document.getElementById('ts-upload-cancel').disabled = false;
                    }
                };
                xhr.send(formData);
            }
        } else {
            alert('no ajax request');
        }
        document.getElementById('file-form').reset();
    }
}


function viewFilesByTSID(tsId) {
    if (xmlhttp !== null) {

        xmlhttp.open("GET", "/eTracker/viewTsAttachment.jsp?tsId=" + tsId + "&rand=" + Math.random(1, 10), false);

        xmlhttp.onreadystatechange = function () {
            callTSAttach();
        };
        xmlhttp.send(null);
    } else {
        alert('no ajax request');
    }
}
function callTSAttach() {

    $('#overlay').fadeOut('fast', 'swing');
    $('#TSAVpopup').fadeOut('fast', 'swing');
    if (xmlhttp.readyState === 4)
    {
        if (xmlhttp.status === 200)
        {
            $("#TSAVpopupFiles").html(xmlhttp.responseText);
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#TSAVpopup').fadeIn('fast', 'swing');

        }

    }
}
function closeTSVAPopup() {
    $('#overlay').fadeOut('fast', 'swing');
    $('#TSAVpopup').fadeOut('fast', 'swing');
}