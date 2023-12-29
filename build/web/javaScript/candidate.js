window.history.forward(1);
//Ajax Request
function trim(str)
{
    while (str.charAt(str.length - 1) == " ")
        str = str.substring(0, str.length - 1);
    while (str.charAt(0) == " ")
        str = str.substring(1, str.length);
    return str;
}
var reqObj = null;
var xmlhttp = null;
function createRequest() {

    try
    {
        reqObj = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (err)
    {
        try {
            reqObj = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (err2) {
            try {
                reqObj = new XMLHttpRequest();
            } catch (err3) {
                reqObj = null;
            }
        }
    }
    return reqObj;
}


function callproduct()
{

    xmlhttp = createRequest();
    if (xmlhttp != null)
    {
        var refempid = document.getElementById("refempid").value;


        xmlhttp.open("GET", "getEmployees.jsp?refempid=" + refempid + "&rand=" + Math.random(1, 10), false);
        xmlhttp.onreadystatechange = callbackreferral;
        xmlhttp.send(null);
    }
}
function callbackreferral()
{
    if (xmlhttp.readyState == 4)
    {
        if (xmlhttp.status == 200)
        {
            var name = parseInt(trim(xmlhttp.responseText));
            if (name == 0) {
                $(".erroruser").remove();
                $("<span class='error12 erroruser'>Please enter the correct Reference ID</span>").insertAfter("#userDetails");
                document.getElementById('refempid').value = '';
                document.getElementById('refempid').focus();
            } else {
                $(".erroruser").remove();
            }
        }
    }
}

var upload_number = 2;
function addTableInput() {
    var d = document.createElement('div');
    var table1 = document.createElement('table');
    table1.setAttribute("width", "90%");
    table1.setAttribute("cellspacing", "1");
    table1.setAttribute("cellpadding", "1");
    table1.setAttribute("border", "0");


    var tbody1 = document.createElement('tbody');
    var row1 = document.createElement('tr');
    var cell1 = document.createElement('td');
    cell1.setAttribute("width", "18%");

    var lable1 = document.createTextNode("Project Name");

    var bold1 = document.createElement("b");
    bold1.appendChild(lable1);
    var cell2 = document.createElement('td');




    var text = document.createElement("input")
    text.setAttribute("type", "text");
    text.setAttribute("size", "16");
    text.setAttribute("name", "projectname" + upload_number);



    var cell3 = document.createElement('td');
    cell3.setAttribute("width", "10%");
    var lable2 = document.createTextNode("Duration");
    var bold2 = document.createElement("b");
    bold2.appendChild(lable2);

    var cell4 = document.createElement('td');
    var duration = document.createElement("input")
    duration.setAttribute("type", "text");
    duration.setAttribute("size", "6");
    duration.setAttribute("class", "duration" + upload_number);
    duration.setAttribute("name", "duration" + upload_number);


    var lable3 = document.createTextNode("Months");


    var cell5 = document.createElement('td');
    cell5.setAttribute("width", "10%");
    var lable4 = document.createTextNode("Team Size");
    var bold3 = document.createElement("b");
    bold3.appendChild(lable4);

    var cell6 = document.createElement('td');

    var team = document.createElement("input")
    team.setAttribute("type", "text");
    team.setAttribute("size", "6");
    team.setAttribute("class", "teamsize" + upload_number);
    team.setAttribute("name", "teamsize" + upload_number);



    cell1.appendChild(bold1);
    cell2.appendChild(text);
    cell3.appendChild(bold2);
    cell4.appendChild(duration);
    cell4.appendChild(lable3);
    cell5.appendChild(bold3);
    cell6.appendChild(team);

    row1.appendChild(cell1);
    row1.appendChild(cell2);
    row1.appendChild(cell3);
    row1.appendChild(cell4);
    row1.appendChild(cell5);
    row1.appendChild(cell6);



    var row2 = document.createElement('tr');

    var r2c1 = document.createElement('td');
    r2c1.setAttribute("width", "18%");
    var r2l1 = document.createTextNode("Client");
    var r2b1 = document.createElement("b");
    r2b1.appendChild(r2l1);

    var r2c2 = document.createElement('td');

    var client = document.createElement("input")
    client.setAttribute("type", "text");
    client.setAttribute("size", "16");
    client.setAttribute("name", "client" + upload_number);

    var r2c3 = document.createElement('td');
    r2c3.setAttribute("width", "10%");
    var r2l2 = document.createTextNode("Environment");
    var r2b2 = document.createElement("b");
    r2b2.appendChild(r2l2);

    var r2c4 = document.createElement('td');
    r2c4.setAttribute("colspan", "3");
    var Environment = document.createElement("input")
    Environment.setAttribute("type", "text");
    Environment.setAttribute("size", "30");
    Environment.setAttribute("name", "environment" + upload_number);

    r2c1.appendChild(r2b1);
    r2c2.appendChild(client);
    r2c3.appendChild(r2b2);
    r2c4.appendChild(Environment);

    row2.appendChild(r2c1);
    row2.appendChild(r2c2);
    row2.appendChild(r2c3);
    row2.appendChild(r2c4);

    var row3 = document.createElement('tr');
    var r3c1 = document.createElement('td');
    r3c1.setAttribute("colspan", "2");
    var r3l1 = document.createTextNode("PROJECT DESCRIPTION");
    var r3b1 = document.createElement("b");

    r3b1.appendChild(r3l1);
    r3c1.appendChild(r3b1);

    row3.appendChild(r3c1);

    var row4 = document.createElement('tr');
    var r4c1 = document.createElement('td');
    r4c1.setAttribute("colspan", "6");
    var textarea = document.createElement("textarea");
    textarea.setAttribute("cols", "90");
    textarea.setAttribute("rows", "5");
    textarea.setAttribute("wrap", "physical");
    var idno = "description" + upload_number;
    textarea.setAttribute("name", idno);
    textarea.setAttribute("id", idno);

    r4c1.appendChild(textarea);

    row4.appendChild(r4c1);



    var row5 = document.createElement('tr');
    var r5c1 = document.createElement('td');
    r5c1.setAttribute("colspan", "2");
    var r5l1 = document.createTextNode("ROLES & RESPONSIBILITIES");
    var r5b1 = document.createElement("b");

    var r5c2 = document.createElement('td');
    r5c2.setAttribute("colspan", "2");
    var getvalue = document.createElement("input")
    getvalue.setAttribute("name", "noofproject");
    getvalue.setAttribute("value", upload_number);
    getvalue.setAttribute("type", "hidden");
    getvalue.setAttribute("size", "30");
    r5c2.appendChild(getvalue);

    r5b1.appendChild(r5l1);
    r5c1.appendChild(r5b1);

    row5.appendChild(r5c1);
    row5.appendChild(r5c2);

    var row6 = document.createElement('tr');
    var r6c1 = document.createElement('td');
    r6c1.setAttribute("colspan", "5");
    var l = document.createElement("a");

    var roles = document.createElement("textarea");
    roles.setAttribute("cols", "90");
    roles.setAttribute("rows", "5");
    roles.setAttribute("wrap", "physical");
    var idno = "roles" + upload_number;
    roles.setAttribute("name", idno);
    roles.setAttribute("id", idno);

    l.setAttribute("href", "javascript:removeFileInput('f" + upload_number + "');");
    l.appendChild(document.createTextNode("remove"));
    d.setAttribute("id", "f" + upload_number);
    r6c1.appendChild(roles);
    r6c1.appendChild(l);
    row6.appendChild(r6c1);


    tbody1.appendChild(row1);
    tbody1.appendChild(row2);
    tbody1.appendChild(row3);
    tbody1.appendChild(row4);
    tbody1.appendChild(row5);
    tbody1.appendChild(row6);

    table1.appendChild(tbody1);
    d.appendChild(table1);

    document.getElementById("moreUploads").appendChild(d);



    upload_number++;
}

function removeFileInput(i) {
    var elm = document.getElementById(i);
    document.getElementById("moreUploads").removeChild(elm);
}

var employer_number = 2;
function addEmployerInput() {
    var d = document.createElement('div');
    var table1 = document.createElement('table');
    table1.setAttribute("border", "0");
    table1.setAttribute("width", "90%");
    var tbody1 = document.createElement('tbody');
    var row1 = document.createElement('tr');
    var cell1 = document.createElement('td');
    cell1.setAttribute("width", "13%");


    var lable1 = document.createTextNode("Prev Employer");

    var bold1 = document.createElement("b");
    bold1.appendChild(lable1);
    var cell2 = document.createElement('td');



    var text = document.createElement("input")
    text.setAttribute("type", "text");
    text.setAttribute("size", "20");
    text.setAttribute("name", "previousemployer" + employer_number);



    var cell3 = document.createElement('td');
    var lable2 = document.createTextNode("CTC");
    var bold2 = document.createElement("b");
    bold2.appendChild(lable2);

    var cell4 = document.createElement('td');
    var duration = document.createElement("input")
    duration.setAttribute("type", "text");
    duration.setAttribute("size", "6");
    duration.setAttribute("name", "ctc" + employer_number);


    var lable3 = document.createTextNode("Lakhs per annum in INR");

    var cell5 = document.createElement('td');
    var r3l1 = document.createTextNode("Joining Date");
    var r3b1 = document.createElement("b");

    r3b1.appendChild(r3l1);
    cell5.appendChild(r3b1);

    var cell6 = document.createElement('td');
    var joiningdate = document.createElement("input")

    joiningdate.setAttribute("name", "joiningdate" + employer_number);
    joiningdate.setAttribute("id", "joiningdate" + employer_number);

    joiningdate.setAttribute("type", "text");
    joiningdate.setAttribute("size", "8");

    var replace = "'" + "joiningdate" + employer_number + "'";

    var link1 = document.createElement("a");
    link1.href = "javascript:NewCal(" + replace + ",'ddmmyyyy')";

    var image = document.createElement("img");
    image.setAttribute("src", "../images/newhelp.gif");
    image.setAttribute("border", "0");
    link1.appendChild(image);
    cell6.appendChild(joiningdate);

    cell6.appendChild(link1);




    cell1.appendChild(bold1);
    cell2.appendChild(text);
    cell3.appendChild(bold2);
    cell4.appendChild(duration)
    cell4.appendChild(lable3);


    row1.appendChild(cell1);
    row1.appendChild(cell2);
    row1.appendChild(cell3);
    row1.appendChild(cell4);
    row1.appendChild(cell5);
    row1.appendChild(cell6);



    var row2 = document.createElement('tr');

    var r2c1 = document.createElement('td');

    var r2l1 = document.createTextNode("Designation");
    var r2b1 = document.createElement("b");
    r2b1.appendChild(r2l1);

    var r2c2 = document.createElement('td');

    var client = document.createElement("input")
    client.setAttribute("type", "text");
    client.setAttribute("size", "20");
    client.setAttribute("name", "designation" + employer_number);

    var r2c3 = document.createElement('td');
    var r2l2 = document.createTextNode("Role");
    var r2b2 = document.createElement("b");
    r2b2.appendChild(r2l2);

    var r2c4 = document.createElement('td');

    var Environment = document.createElement("input")
    Environment.setAttribute("type", "text");
    Environment.setAttribute("size", "10");
    Environment.setAttribute("name", "role" + employer_number);

    var r2c5 = document.createElement('td');
    var r3l3 = document.createTextNode("Relieving Date");
    var r3b3 = document.createElement("b");

    r3b3.appendChild(r3l3);
    r2c5.appendChild(r3b3);

    var r2c6 = document.createElement('td');
    var getvaluerelievingdate = document.createElement("input")
    getvaluerelievingdate.setAttribute("name", "relievingdate" + employer_number);
    getvaluerelievingdate.setAttribute("id", "relievingdate" + employer_number);

    getvaluerelievingdate.setAttribute("type", "text");
    getvaluerelievingdate.setAttribute("size", "8");


    var link2 = document.createElement("a");
    var fetch = "'" + "relievingdate" + employer_number + "'";

    link2.setAttribute("href", "javascript:NewCal(" + fetch + ",'ddmmyyyy')");

    var image1 = document.createElement("img");
    image1.setAttribute("src", "../images/newhelp.gif");
    image1.setAttribute("border", "0");
    link2.appendChild(image1);



    r2c6.appendChild(getvaluerelievingdate);

    r2c6.appendChild(link2);

    r2c1.appendChild(r2b1);
    r2c2.appendChild(client);
    r2c3.appendChild(r2b2);
    r2c4.appendChild(Environment);

    row2.appendChild(r2c1);
    row2.appendChild(r2c2);
    row2.appendChild(r2c3);
    row2.appendChild(r2c4);
    row2.appendChild(r2c5);
    row2.appendChild(r2c6);


    var row4 = document.createElement('tr');
    var r4c1 = document.createElement('td');
    var r4l1 = document.createTextNode("Job Profile");
    var r4b1 = document.createElement("b");

    r4b1.appendChild(r4l1);
    r4c1.appendChild(r4b1);



//	var row4=document.createElement('tr');
    var r4c2 = document.createElement('td');
    r4c2.setAttribute("colspan", "4");
    var textarea = document.createElement("textarea");
    textarea.setAttribute("cols", "75");
    textarea.setAttribute("rows", "2");
    textarea.setAttribute("wrap", "physical");
    var idno = "jobprofile" + employer_number;
    textarea.setAttribute("name", idno);
    textarea.setAttribute("id", idno);

    r4c2.appendChild(textarea);


    var r4c3 = document.createElement('td');
    var getvalue = document.createElement("input")
    getvalue.setAttribute("name", "maxemp");
    getvalue.setAttribute("value", employer_number);
    getvalue.setAttribute("type", "hidden");
    getvalue.setAttribute("size", "30");
    r4c3.appendChild(getvalue);


    var remove = document.createElement("a");
    remove.setAttribute("href", "javascript:removeEmployerInput('f" + employer_number + "');");
    remove.appendChild(document.createTextNode("remove"));
    r4c3.appendChild(remove);


    row4.appendChild(r4c1);
    row4.appendChild(r4c2);
    row4.appendChild(r4c3);







    d.setAttribute("id", "f" + employer_number);



    tbody1.appendChild(row1);
    tbody1.appendChild(row2);

    tbody1.appendChild(row4);


    table1.appendChild(tbody1);
    d.appendChild(table1);

    document.getElementById("moreEmployer").appendChild(d);



    employer_number++;
}

function removeEmployerInput(i) {
    var el = document.getElementById(i);
    document.getElementById("moreEmployer").removeChild(el);
}


function isNumber(str)
{
    var pattern = "0123456789"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isCTC(str)
{
    var pattern = "0123456789."
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}

/** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

function isPositiveInteger(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ."
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isStringValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isAlphaNumeric(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.@_"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isPanValid(str)
{
    var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isDlValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isEmailValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.@_-"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isDesignationValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890:-"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.@_(),&:"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isEnvironmentValid(str)
{
    var pattern = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-.,/"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function isDate(str)
{
    var pattern = "1234567890-"
    var i = 0;
    do
    {
        var pos = 0;
        for (var j = 0; j < pattern.length; j++)
            if (str.charAt(i) == pattern.charAt(j))
            {
                pos = 1;
                break;
            }
        i++;
    } while (pos == 1 && i < str.length)
    if (pos == 0)
        return false;
    return true;
}
function fun(theForm)
{
    $(".error12").remove();
    if ($('input[name="apj"]').prop("checked") || $('#noApj').prop("checked")) {
        var val = $('input[name="apj"]:checked:first').val();
        val = $.trim(val);
        if (val.length > 0)
        {
            var water = $.trim(theForm.water.value);
            var rti = $.trim(theForm.rti.value);
            var rte = $.trim(theForm.rte.value);
            var habits = $.trim(theForm.habits.value);

            if (trim(theForm.water.value) == '')
            {
                $("<span class='error12 errorapj'>Please give the answer of  all  question</span>").insertAfter("#errApj");
                document.theForm.water.value = "";
                theForm.water.focus();
                return false;
            }
            if (water.length < 200) {
                $("<span class='error12 errorapj'>Please enter more than 200 characters</span>").insertAfter("#errApj");
                theForm.water.focus();
                return false;
            }
            if (trim(theForm.rti.value) == '')
            {
                $("<span class='error12 errorapj'>Please give the answer of  all  question</span>").insertAfter("#errApj");
                document.theForm.rti.value = "";
                theForm.rti.focus();
                return false;
            }
            if (rti.length < 200) {
                $("<span class='error12 errorapj'>Please enter more than 200 characters</span>").insertAfter("#errApj");
                theForm.rti.focus();
                return false;
            }
            if (trim(theForm.rte.value) == '')
            {
                $("<span class='error12 errorapj'>Please give the answer of  all  question</span>").insertAfter("#errApj");
                document.theForm.rte.value = "";
                theForm.rte.focus();
                return false;
            }
            if (rte.length < 200) {
                $("<span class='error12 errorapj'>Please enter more than 200 characters</span>").insertAfter("#errApj");
                theForm.rte.focus();
                return false;
            }

            if (trim(theForm.habits.value) == '')
            {
                $("<span class='error12 errorapj'>Please give the answer of  all  question </span>").insertAfter("#errApj");
                document.theForm.habits.value = "";
                theForm.habits.focus();
                return false;
            }
            if (habits.length < 200) {
                $("<span class='error12 errorapj'>Please enter more than 200 characters</span>").insertAfter("#errApj");
                theForm.water.focus();
                return false;
            }
            if (trim(theForm.social.value) == '')
            {
                $("<span class='error12 errorapj'>Please give the answer of this question</span>").insertAfter("#errApj");
                document.theForm.social.value = "";
                theForm.social.focus();
                return false;
            }
        } else {
            $("<span class='error12 errorapj'>Please answer Have you read the Governance for Growth in India by APJ Abdul Kalam?</span>").insertAfter("#errApj");
            document.theForm.elements["apj"][0].focus();
            return false;
        }
    } else {
        $("<span class='error12 errorapj'>Please answer Have you read the Governance for Growth in India by APJ Abdul Kalam?</span>").insertAfter("#errApj");
        document.theForm.elements["apj"][0].focus();
        return false;
    }


    if (trim(theForm.firstname.value) == '')
    {
        $("<span class='error12 erroruser'>Please Enter the First Name</span>").insertAfter("#userDetails");
        document.theForm.firstname.value = "";
        theForm.firstname.focus();
        return false;
    }
    if (!isStringValid(trim(theForm.firstname.value)))
    {
        $("<span class='error12 erroruser'>Please enter the valid First Name </span>").insertAfter("#userDetails");
        document.theForm.firstname.value = "";
        theForm.firstname.focus();
        return false;
    }
    if (trim(theForm.lastname.value) == '')
    {
        $("<span class='error12 erroruser'>Please Enter the Last Name</span>").insertAfter("#userDetails");
        document.theForm.lastname.value = "";
        theForm.lastname.focus();
        return false;
    }
    if (!isStringValid(trim(theForm.lastname.value)))
    {
        $("<span class='error12 erroruser'>Please enter the valid Last Name </span>").insertAfter("#userDetails");
        document.theForm.lastname.value = "";
        theForm.lastname.focus();
        return false;
    }
    if (!isNumber(trim(theForm.phone.value)) && trim(theForm.phone.value) != '')
    {
        $("<span class='error12 erroruser'>Please enter only Numerical Characters in the Phone </span>").insertAfter("#userDetails");
        theForm.phone.focus();
        return false;
    }
    if (trim(theForm.mobile.value) == '')
    {
        $("<span class='error12 erroruser'>Please enter the Mobile No </span>").insertAfter("#userDetails");
        document.theForm.mobile.value = "";
        theForm.mobile.focus();
        return false;
    }
    if (!isNumber(trim(theForm.mobile.value)))
    {
        $("<span class='error12 erroruser'>Please enter only Numerical values in the mobile </span>").insertAfter("#userDetails");
//			document.theForm.mobile.value="";
        theForm.mobile.focus();
        return false;
    }
    if (!((trim(theForm.mobile.value)).length == 10)) {
        $("<span class='error12 erroruser'>Please enter the valid mobile no </span>").insertAfter("#userDetails");

//			document.theForm.mobile.value="";
        theForm.mobile.focus();
        return false;
    }
    if (trim(theForm.email.value) == '')
    {
        $("<span class='error12 erroruser'>Please enter the email id </span>").insertAfter("#userDetails");
        document.theForm.email.value = "";
        theForm.email.focus();
        return false;
    }
    if (!isEmailValid(trim(theForm.email.value)))
    {
        $("<span class='error12 erroruser'>Please enter valid email id </span>").insertAfter("#userDetails");
        //		document.theForm.email.value="";
        theForm.email.focus();
        return false;
    }

    if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(theForm.email.value)))
    {
        $("<span class='error12 erroruser'>Invalid E-mail Address! Please re-enter.</span>").insertAfter("#userDetails");
        //		document.theForm.email.value="";
        theForm.email.focus();
        return (false);
    }

    if (trim(theForm.location.value) == '')
    {
        $("<span class='error12 erroruser'>Please enter the location</span>").insertAfter("#userDetails");

//			document.theForm.location.value="";
        theForm.location.focus();
        return false;
    }
    if (!isStringValid(trim(theForm.location.value)))
    {
        $("<span class='error12 erroruser'>Please enter only Alphabets in the location</span>").insertAfter("#userDetails");

//			document.theForm.location.value="";
        theForm.location.focus();
        return false;
    }
    if (trim(theForm.refempid.value) == '')
    {
        $("<span class='error12 erroruser'>Please enter the Ref Emp ID  </span>").insertAfter("#userDetails");
        //	document.theForm.refempid.value="";
        theForm.refempid.focus();
        return false;
    }
    if (!isPanValid(trim(theForm.refempid.value)))
    {
        $("<span class='error12 erroruser'>Please enter the valid Ref Emp ID   </span>").insertAfter("#userDetails");
        //		document.theForm.refempid.value="";
        theForm.refempid.focus();
        return false;
    }
    if (trim(theForm.Resume.value) == '')
    {
        $("<span class='error12 errorProject'>Please upload your resume</span>").insertAfter("#Resume");
        document.theForm.Resume.value = "";
        theForm.Resume.focus();
        return false;
    }

    if (trim(theForm.userPhoto.value) == '')
    {
        $("<span class='error12 errorProject'>Please upload your photo</span>").insertAfter("#userPhoto");
        document.theForm.userPhoto.value = "";
        theForm.userPhoto.focus();
        return false;
    }

    if (trim(theForm.ugcourse.value) == '')
    {

        $("<span class='error12 erroruserCous'>Please Enter UG Cource</span>").insertAfter("#userCourse");
        document.theForm.ugcourse.value = "";
        theForm.ugcourse.focus();
        return false;
    }
    if (!isPositiveInteger(trim(theForm.ugcourse.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the Alphabets only in the UG Course </span>").insertAfter("#userCourse");
        document.theForm.ugcourse.value = "";
        theForm.ugcourse.focus();
        return false;
    }
    if (trim(theForm.ugbranch.value) == '')
    {
        $("<span class='error12 erroruserCous'>Please Enter UG Branch </span>").insertAfter("#userCourse");
        document.theForm.ugbranch.value = "";
        theForm.ugbranch.focus();
        return false;
    }
    if (!isStringValid(trim(theForm.ugbranch.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid UG Branch </span>").insertAfter("#userCourse");
        document.theForm.ugbranch.value = "";
        theForm.ugbranch.focus();
        return false;
    }
    if (trim(theForm.uginstitute.value) == '')
    {
        $("<span class='error12 erroruserCous'>Please Enter UG Institute</span>").insertAfter("#userCourse");
        document.theForm.uginstitute.value = "";
        theForm.uginstitute.focus();
        return false;
    }
    if (!isStringValid(trim(theForm.uginstitute.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid UG Institute </span>").insertAfter("#userCourse");
        document.theForm.uginstitute.value = "";
        theForm.uginstitute.focus();
        return false;
    }
    if (trim(theForm.uggraduationyear.value) == '0')
    {
        $("<span class='error12 erroruserCous'>Please Enter UG Graduation year </span>").insertAfter("#userCourse");
        document.theForm.uggraduationyear.value = "";
        theForm.uggraduationyear.focus();
        return false;
    }

    if (trim(theForm.uggraduationyear.value) == '')
    {
        $("<span class='error12 erroruserCous'>Please Enter UG Graduation year </span>").insertAfter("#userCourse");
        document.theForm.uggraduationyear.value = "";
        theForm.uggraduationyear.focus();
        return false;
    }

    var current_date = new Date();
    if (trim(document.getElementById('uggraduationyear').value) > current_date.getFullYear())
    {
        $("<span class='error12 erroruserCous'>Please enter the correct  UG Graduation year</span>").insertAfter("#userCourse");

        document.theForm.uggraduationyear.value = "";
        theForm.uggraduationyear.focus();
        return false;
    }
    if (trim(theForm.ugpercentage.value) == '')
    {
        $("<span class='error12 erroruserCous'>Please enter the UG Percentage</span>").insertAfter("#userCourse");
        document.theForm.ugpercentage.value = "";
        theForm.ugpercentage.focus();
        return false;
    }
    if (!isCTC(trim(theForm.ugpercentage.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid UG Percentage</span>").insertAfter("#userCourse");

        document.theForm.ugpercentage.value = "";
        theForm.ugpercentage.focus();
        return false;
    }
    if (trim(theForm.ugpercentage.value) > 100)
    {
        $("<span class='error12 erroruserCous'>Please enter the correct UG Percentage</span>").insertAfter("#userCourse");
        document.theForm.ugpercentage.value = "";
        theForm.ugpercentage.focus();
        return false;
    }
    if (trim(theForm.pgcourse.value) != '' && !isPositiveInteger(trim(theForm.pgcourse.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid PG course</span>").insertAfter("#userCourse");
        document.theForm.pgcourse.value = "";
        theForm.pgcourse.focus();
        return false;
    }
    if (trim(theForm.pgbranch.value) != '' && !isStringValid(trim(theForm.pgbranch.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid PG branch</span>").insertAfter("#userCourse");
        document.theForm.pgbranch.value = "";
        theForm.pgbranch.focus();
        return false;
    }
    if (trim(theForm.pginstitute.value) != '' && !isStringValid(trim(theForm.pginstitute.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid PG Institute </span>").insertAfter("#userCourse");
        document.theForm.pginstitute.value = "";
        theForm.pginstitute.focus();
        return false;
    }

    if (trim(theForm.pggraduationyear.value) != '0' && (trim(theForm.pggraduationyear.value) < trim(theForm.uggraduationyear.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter valid PG Graduation year </span>").insertAfter("#userCourse");
        document.theForm.pggraduationyear.value = "";
        theForm.pggraduationyear.focus();
        return false;
    }

    if (trim(theForm.pgpercentage.value) != '' && !isCTC(trim(theForm.pgpercentage.value)))
    {
        $("<span class='error12 erroruserCous'>Please enter the valid PG percentage</span>").insertAfter("#userCourse");
        document.theForm.pgpercentage.value = "";
        theForm.pgpercentage.focus();
        return false;
    }
    if (trim(theForm.pgpercentage.value) > 100)
    {
        $("<span class='error12 erroruserCous'>Please enter the correct  PG Percentage </span>").insertAfter("#userCourse");
        document.theForm.pgpercentage.value = "";
        theForm.pgpercentage.focus();
        return false;
    }
    if (trim(theForm.sapyears.value) != '' && !isNumber(trim(theForm.sapyears.value)))
    {
        $("<span class='error12 errorSkill'>Please enter the Numerical only in the sap years</span>").insertAfter("#candidateSkill");
        document.theForm.sapyears.value = "";
        theForm.sapyears.focus();
        return false;
    }
    if (trim(theForm.sapmonths.value) != '' && !isNumber(trim(theForm.sapmonths.value)))
    {
        $("<span class='error12 errorSkill'>Please enter the Numerical only in the sap months</span>").insertAfter("#candidateSkill");
        document.theForm.sapmonths.value = "";
        theForm.sapmonths.focus();
        return false;
    }
    if (trim(theForm.sapmonths.value) != '' && trim(theForm.sapmonths.value) > 11)
    {
        $("<span class='error12 errorSkill'>SAP months should be less than 12</span>").insertAfter("#candidateSkill");
        document.theForm.sapmonths.value = "";
        theForm.sapmonths.focus();
        return false;
    }


    if (trim(theForm.totalyears.value) != '' && !isNumber(trim(theForm.totalyears.value)))
    {
        $("<span class='error12 errorSkill'>Please enter the Numerical only in the total years</span>").insertAfter("#candidateSkill");
        document.theForm.totalyears.value = "";
        theForm.totalyears.focus();
        return false;
    }
    if (trim(theForm.totalmonths.value) != '' && !isNumber(trim(theForm.totalmonths.value)))
    {
        $("<span class='error12 errorSkill'>Please enter the Numerical only in the total months</span>").insertAfter("#candidateSkill");
        document.theForm.totalmonths.value = "";
        theForm.totalmonths.focus();
        return false;
    }
    if (trim(theForm.totalmonths.value) != '' && trim(theForm.totalmonths.value) > 11)
    {
        $("<span class='error12 errorSkill'>Total months should be less than 12</span>").insertAfter("#candidateSkill");
        document.theForm.totalmonths.value = "";
        theForm.totalmonths.focus();
        return false;
    }
    if (trim(theForm.sapmonths.value) != '' || trim(theForm.sapyears.value) != '') {

        if (trim(theForm.totalmonths.value) == '' && trim(theForm.totalyears.value) == '') {
            $("<span class='error12 errorSkill'>Please enter the Total Experience</span>").insertAfter("#candidateSkill");
            document.theForm.totalyears.value = "";
            theForm.totalyears.focus();
            return false;

        }
        var sMonth = 0, sYear = 0, tMonth = 0, tYear = 0;
        if (trim(theForm.sapmonths.value) != '') {
            sMonth = trim(theForm.sapmonths.value);
        }
        if (trim(theForm.sapyears.value) != '') {
            sYear = trim(theForm.sapyears.value);
        }
        if (trim(theForm.totalmonths.value) != '') {
            tMonth = trim(theForm.totalmonths.value);
        }
        if (trim(theForm.totalyears.value) != '') {
            tYear = trim(theForm.totalyears.value);
        }

        var sapEx = (sYear * 12) + sMonth;
        var totalEx = (tYear * 12) + tMonth;

        if (totalEx < sapEx) {
            $("<span class='error12 errorSkill'>Please check the Total Experience</span>").insertAfter("#candidateSkill");
            document.theForm.totalyears.value = "";
            document.theForm.totalmonths.value = "";
            theForm.totalyears.focus();
            return false;

        }



    }

	  if (trim(document.theForm.corecompetence.value) == "XX")
    {
        $("<span class='error12 errorSkill'>Please select core competence</span>").insertAfter("#candidateSkill");
        document.theForm.corecompetence.focus();
        return false;
    }
    if (trim(document.theForm.areaofexpertise.value) == "XX")
    {
        $("<span class='error12 errorSkill'>Please select Area of Expertise</span>").insertAfter("#candidateSkill");
        document.theForm.areaofexpertise.focus();
        return false;
    }
    if (trim(theForm.tools.value) != '' && !isEnvironmentValid(trim(theForm.tools.value)))
    {
        $("<span class='error12 errorSkill'>Please enter the AlphaNumerical Characters only in the tools </span>").insertAfter("#candidateSkill");
        document.theForm.tools.value = "";
        theForm.tools.focus();
        return false;
    }

    if (trim(theForm.totalmonths.value) != '' || trim(theForm.totalyears.value) != '') {

        var tMonth = 0, tYear = 0;

        if (trim(theForm.totalmonths.value) != '') {
            tMonth = trim(theForm.totalmonths.value);
        }
        if (trim(theForm.totalyears.value) != '') {
            tYear = trim(theForm.totalyears.value);
        }


        var totalEx = (tYear * 12) + tMonth;


        if (totalEx > 0) {

            if (trim(theForm.previousemployer1.value) == '') {

                $("<span class='error12 errorSkill'>Please enter the Current Employer </span>").insertAfter("#candidatePrevExp");
                document.theForm.previousemployer1.value = "";
                theForm.previousemployer1.focus();
                return false;
            }
            if (trim(theForm.ctc1.value) == '') {
                $("<span class='error12 errorPrevExpSkill'>Please enter the CTC</span>").insertAfter("#candidatePrevExp");
                document.theForm.ctc1.value = "";
                theForm.ctc1.focus();
                return false;
            }
            if (trim(theForm.joiningdate1.value) == '') {
                $("<span class='error12 errorPrevExpSkill'>Please enter the Joining Date </span>").insertAfter("#candidatePrevExp");
                document.theForm.joiningdate1.value = "";
                theForm.joiningdate1.focus();
                return false;
            }
            if (trim(theForm.designation1.value) == '') {
                $("<span class='error12 errorPrevExpSkill'>Please enter the Designation</span>").insertAfter("#candidatePrevExp");
                document.theForm.designation1.value = "";
                theForm.designation1.focus();
                return false;
            }
            if (trim(theForm.role1.value) == '') {
                $("<span class='error12 errorPrevExpSkill'>Please enter the Role</span>").insertAfter("#candidatePrevExp");
                document.theForm.role1.value = "";
                theForm.role1.focus();
                return false;
            }

            if (trim(theForm.relievingdate1.value) == '') {
                $("<span class='error12 errorPrevExpSkill'>Please enter the Relieving Date</span>").insertAfter("#candidatePrevExp");
                document.theForm.relievingdate1.value = "";
                theForm.relievingdate1.focus();
                return false;
            }

        }

    }

    if (trim(theForm.previousemployer1.value) != '' && !isValid(trim(theForm.previousemployer1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter only  valid characters in the previous employer</span>").insertAfter("#candidatePrevExp");
        document.theForm.previousemployer1.value = "";
        theForm.previousemployer1.focus();
        return false;
    }
    if (trim(theForm.ctc1.value) != '' && !isCTC(trim(theForm.ctc1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the valid CTC</span>").insertAfter("#candidatePrevExp");
        document.theForm.ctc1.value = "";
        theForm.ctc1.focus();
        return false;
    }
    if (trim(theForm.designation1.value) != '' && !isDesignationValid(trim(theForm.designation1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter only valid characters in the Designation</span>").insertAfter("#candidatePrevExp");
        document.theForm.designation1.value = "";
        theForm.designation1.focus();
        return false;
    }
    if (trim(theForm.role1.value) != '' && !isPositiveInteger(trim(theForm.role1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter only Alphabets in the Role</span>").insertAfter("#candidatePrevExp");
        document.theForm.role1.value = "";
        theForm.role1.focus();
        return false;
    }
    if (trim(theForm.joiningdate1.value) != '' && !isDate(trim(theForm.joiningdate1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the valid Joining Date</span>").insertAfter("#candidatePrevExp");
        document.theForm.joiningdate1.value = "";
        theForm.joiningdate1.focus();
        return false;
    }
    if (trim(theForm.relievingdate1.value) != '' && !isDate(trim(theForm.relievingdate1.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the valid Relieving Date</span>").insertAfter("#candidatePrevExp");
        document.theForm.relievingdate1.value = "";
        theForm.relievingdate1.focus();
        return false;
    }

    if (trim(theForm.position.value) != '' && !isPositiveInteger(trim(theForm.position.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter only valid characters in the positions</span>").insertAfter("#candidatePrevExp");
        document.theForm.position.value = "";
        theForm.position.focus();
        return false;
    }
      if (trim(theForm.jobtype.value) == '')
    {
        $("<span class='error12 errorPrevExpSkill'>Please select job type</span>").insertAfter("#desiredJob");
     
        return false;
    }
    if (trim(theForm.desiredlocation.value) == '')
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the desired location</span>").insertAfter("#desiredJob");
        document.theForm.desiredlocation.value = "";
        theForm.desiredlocation.focus();
        return false;
    }
      
    if (!isPositiveInteger(trim(theForm.desiredlocation.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter only valid characters in the preferred location</span>").insertAfter("#desiredJob");
        document.theForm.desiredlocation.value = "";
        theForm.desiredlocation.focus();
        return false;
    }
    if (trim(theForm.noticeperiod.value) != '' && !isNumber(trim(theForm.noticeperiod.value)))
    {

        $("<span class='error12 errorPrevExpSkill'>Please enter only Numerical values in Notice Period</span>").insertAfter("#desiredJob");
        document.theForm.noticeperiod.value = "";
        theForm.noticeperiod.focus();
        return false;
    }
    if (trim(theForm.ectc.value) == '')
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the Expected CTC </span>").insertAfter("#desiredJob");
        document.theForm.ectc.value = "";
        theForm.ectc.focus();
        return false;
    }
    if (!isCTC(trim(theForm.ectc.value)))
    {
        $("<span class='error12 errorPrevExpSkill'>Please enter the valid Expected CTC </span>").insertAfter("#desiredJob");
        document.theForm.ectc.value = "";
        theForm.ectc.focus();
        return false;
    }
    if (trim(theForm.referencename.value) != '' && !isPositiveInteger(trim(theForm.referencename.value)))
    {
        $("<span class='error12 errorReff'>Please enter only valid characters in the reference name</span>").insertAfter("#candidateReffrance");
        document.theForm.referencename.value = "";
        theForm.referencename.focus();
        return false;
    }
    if (trim(theForm.referencedesignation.value) != '' && !isDesignationValid(trim(theForm.referencedesignation.value)))
    {
        $("<span class='error12 errorReff'>Please enter only valid characters in the reference designation </span>").insertAfter("#candidateReffrance");
        document.theForm.referencedesignation.value = "";
        theForm.referencedesignation.focus();
        return false;
    }
    if (trim(theForm.organization.value) != '' && !isAlphaNumeric(trim(theForm.organization.value)))
    {
        $("<span class='error12 errorReff'>Please enter the AlphaNumerical only in the organization </span>").insertAfter("#candidateReffrance");
        document.theForm.organization.value = "";
        theForm.organization.focus();
        return false;
    }
    if (trim(theForm.refemployeeid.value) != '' && !isAlphaNumeric(trim(theForm.refemployeeid.value)))
    {
        $("<span class='error12 errorReff'>Please enter the AlphaNumerical only in the refemployee id </span>").insertAfter("#candidateReffrance");
        document.theForm.refemployeeid.value = "";
        theForm.refemployeeid.focus();
        return false;
    }
    if (trim(theForm.refcountrycode.value) != '' && !isNumber(trim(theForm.refcountrycode.value)))
    {
        $("<span class='error12 errorReff'>Please enter the Numerical only in the refcountry code </span>").insertAfter("#candidateReffrance");
        document.theForm.refcountrycode.value = "";
        theForm.refcountrycode.focus();
        return false;
    }
    if (trim(theForm.refstdcode.value) != '' && !isNumber(trim(theForm.refstdcode.value)))
    {
        $("<span class='error12 errorReff'>Please enter the Numerical only in the std code  </span>").insertAfter("#candidateReffrance");
        document.theForm.refstdcode.value = "";
        theForm.refstdcode.focus();
        return false;
    }
    if (trim(theForm.refphone.value) != '' && !isNumber(trim(theForm.refphone.value)))
    {
        $("<span class='error12 errorReff'>Please enter the Numerical only in the ref phone  </span>").insertAfter("#candidateReffrance");
        document.theForm.refphone.value = "";
        theForm.refphone.focus();
        return false;
    }
    if (trim(theForm.refmobileno.value) != '' && !isNumber(trim(theForm.refmobileno.value)))
    {

        $("<span class='error12 errorReff'>Please enter only Numerical values in the Ref mobile No </span>").insertAfter("#candidateReffrance");
        document.theForm.refmobileno.value = "";
        theForm.refmobileno.focus();
        return false;
    }
    if (trim(theForm.refmobileno.value) != '' && !((trim(theForm.refmobileno.value)).length == 10))
    {
        $("<span class='error12 errorReff'>Please enter the valid Ref mobile No</span>").insertAfter("#candidateReffrance");
        document.theForm.refmobileno.value = "";
        theForm.refmobileno.focus();
        return false;
    }
    if (trim(theForm.refmailid.value) != '' && !isEmailValid(trim(theForm.refmailid.value)))
    {
        $("<span class='error12 errorReff'>Please enter valid ref email id </span>").insertAfter("#candidateReffrance");
        document.theForm.refmailid.value = "";
        theForm.refmailid.focus();
        return false;
    }
    if (trim(theForm.dateofbirth.value) == '')
    {

        $("<span class='error12 errorPerDetails'>Please select the Date of Birth </span>").insertAfter("#candidatePerDetail");
        document.theForm.dateofbirth.value = "";
        theForm.dateofbirth.focus();
        return false;
    }
    var str = document.theForm.dateofbirth.value;
    var first = str.indexOf("-");
    var last = str.lastIndexOf("-");
    var year = str.substring(last + 1, last + 5);
    var month = str.substring(first + 1, last);
    var date = str.substring(0, first);
    var form_date = new Date(year, month - 1, date);
    //            var current_date = new Date();
    //            alert(form_date.getFullYear());

    if (!isDate(trim(theForm.dateofbirth.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid Date of Birth</span>").insertAfter("#candidatePerDetail");
        document.theForm.dateofbirth.value = "";
        theForm.dateofbirth.focus();
        return false;
    }

    if ((form_date.getFullYear()) > (current_date.getFullYear() - 18))
    {
        $("<span class='error12 errorPerDetails'>Enter the valid Date of Birth</span>").insertAfter("#candidatePerDetail");
        theForm.dateofbirth.focus();
        return false;
    }

    if (trim(theForm.uggraduationyear.value) < (form_date.getYear() + 1918))
    {
        $("<span class='error12 erroruserCous'>Please check the UG graduation year</span>").insertAfter("#userCourse");
        theForm.uggraduationyear.focus();
        return false;
    }


    var joinYear = '';
    if (trim(theForm.joiningdate1.value) != '') {
        var str = document.theForm.joiningdate1.value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        joinYear = str.substring(last + 1, last + 5);
        if ((trim(theForm.uggraduationyear.value) > joinYear)) {
            $("<span class='error12 errorPrevExpSkill'>Please check the joining date</span>").insertAfter("#candidatePrevExp");
            theForm.joiningdate1.focus();
            return false;
        }
    }


    var relieveYear = '';
    if (trim(theForm.relievingdate1.value) != '') {
        var str = document.theForm.relievingdate1.value;
        var first = str.indexOf("-");
        var last = str.lastIndexOf("-");
        relieveYear = str.substring(last + 1, last + 5);

        if (relieveYear < joinYear) {
            $("<span class='error12 errorPrevExpSkill'>Please check the relieving date</span>").insertAfter("#candidatePrevExp");
            theForm.relievingdate1.focus();
            return false;
        }
    }

    if (trim(theForm.city.value) != '' && !isPositiveInteger(trim(theForm.city.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter only valid characters in the city </span>").insertAfter("#candidatePerDetail");
        document.theForm.city.value = "";
        theForm.city.focus();
        return false;
    }
    if (trim(theForm.pincode.value) != '' && !isNumber(trim(theForm.pincode.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the Numerical only in the pincode </span>").insertAfter("#candidatePerDetail");
        document.theForm.pincode.value = "";
        theForm.pincode.focus();
        return false;
    }



  
        if (trim(theForm.aadhaar.value) == '') {
            $("<span class='error12 errorPerDetails'>Please enter aadhaar no</span>").insertAfter("#candidatePerDetail");
            document.theForm.aadhaar.value = "";
            theForm.aadhaar.focus();
            return false;
        }
   
    if (trim(theForm.totalyears.value) >= 1 && trim(theForm.totalyears.value) <= 2) {
        if (trim(theForm.pancardno.value) == '') {
            $("<span class='error12 errorPerDetails'>Please enter PAN No</span>").insertAfter("#candidatePerDetail");
            document.theForm.pancardno.value = "";
            theForm.pancardno.focus();
            return false;
        }
    }

    if (trim(theForm.totalyears.value) >= 3) {
        if (trim(theForm.pancardno.value) == '') {
            $("<span class='error12 errorPerDetails'>Please enter PAN No</span>").insertAfter("#candidatePerDetail");
            document.theForm.pancardno.value = "";
            theForm.pancardno.focus();
            return false;
        }
    }
    if (trim(theForm.totalyears.value) >= 3) {
        if (trim(theForm.passportno.value) == '') {
            $("<span class='error12 errorPerDetails'>Please enter Passport No</span>").insertAfter("#candidatePerDetail");
            document.theForm.passportno.value = "";
            theForm.passportno.focus();
            return false;
        }
    }
    if (trim(theForm.pancardno.value) != '' && !isPanValid(trim(theForm.pancardno.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid pancard no </span>").insertAfter("#candidatePerDetail");
        document.theForm.pancardno.value = "";
        theForm.pancardno.focus();
        return false;
    }
    if (trim(theForm.passportno.value) != '' && !((trim(theForm.pancardno.value)).length == 10))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid PAN no </span>").insertAfter("#candidatePerDetail");
        document.theForm.pancardno.value = "";
        theForm.pancardno.focus();
        return false;
    }
    if (trim(theForm.passportno.value) != '' && !isPanValid(trim(theForm.passportno.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid passport no </span>").insertAfter("#candidatePerDetail");

        document.theForm.passportno.value = "";
        theForm.passportno.focus();
        return false;
    }
    if (trim(theForm.passportno.value) != '' && !(trim(theForm.passportno.value).length == 8))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid passport no </span>").insertAfter("#candidatePerDetail");
        document.theForm.passportno.value = "";
        theForm.passportno.focus();
        return false;
    }
    if (trim(theForm.dlno.value) != '' && !isDlValid(trim(theForm.dlno.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid DL no</span>").insertAfter("#candidatePerDetail");
        document.theForm.dlno.value = "";
        theForm.dlno.focus();
        return false;
    }
    if (trim(theForm.voteridno.value) != '' && !isDlValid(trim(theForm.voteridno.value)))
    {
        $("<span class='error12 errorPerDetails'>Please enter the valid voter id no</span>").insertAfter("#candidatePerDetail");
        document.theForm.voteridno.value = "";
        theForm.voteridno.focus();
        return false;
    }
    if (trim(theForm.projectname1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter project name</span>").insertAfter("#candidateproject");
        document.theForm.projectname1.value = "";
        theForm.projectname1.focus();
        return false;
    }
    if (!isValid(trim(theForm.projectname1.value)))
    {
        $("<span class='error12 errorProject'>Please enter valid project name </span>").insertAfter("#candidateproject");
        document.theForm.projectname1.value = "";
        theForm.projectname1.focus();
        return false;
    }
    if (trim(theForm.duration1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the duration </span>").insertAfter("#candidateproject");

        document.theForm.duration1.value = "";
        theForm.duration1.focus();
        return false;
    }
    if (!isNumber(trim(theForm.duration1.value)))
    {
        $("<span class='error12 errorProject'>Please enter only numeric value in the duration</span>").insertAfter("#candidateproject");

        document.theForm.duration1.value = "";
        theForm.duration1.focus();
        return false;
    }
    if (trim(theForm.teamsize1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the team size</span>").insertAfter("#candidateproject");


        document.theForm.teamsize1.value = "";
        theForm.teamsize1.focus();
        return false;
    }
    if (!isNumber(trim(theForm.teamsize1.value)))
    {

        $("<span class='error12 errorProject'>Please enter only  numeric value in the teamsize </span>").insertAfter("#candidateproject");
        document.theForm.teamsize1.value = "";
        theForm.teamsize1.focus();
        return false;
    }
    if (trim(theForm.client1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the client</span>").insertAfter("#candidateproject");
        document.theForm.client1.value = "";
        theForm.client1.focus();
        return false;
    }
    if (!isValid(trim(theForm.client1.value)))
    {
        $("<span class='error12 errorProject'>Please enter the valid client name</span>").insertAfter("#candidateproject");
        document.theForm.client1.value = "";
        theForm.client1.focus();
        return false;
    }
    if (trim(theForm.environment1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the environment</span>").insertAfter("#candidateproject");
        document.theForm.environment1.value = "";
        theForm.environment1.focus();
        return false;
    }
    if (!isEnvironmentValid(trim(theForm.environment1.value)))
    {
        $("<span class='error12 errorProject'>Please enter the valid environment name</span>").insertAfter("#candidateproject");
        document.theForm.environment1.value = "";
        theForm.environment1.focus();
        return false;
    }
    if (trim(theForm.description1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the description</span>").insertAfter("#candidateproject");
        document.theForm.description1.value = "";
        theForm.description1.focus();
        return false;
    }

    if (trim(theForm.roles1.value) == '')
    {
        $("<span class='error12 errorProject'>Please enter the roles</span>").insertAfter("#candidateproject");
        document.theForm.roles1.value = "";
        theForm.roles1.focus();
        return false;
    }

    
    monitorSubmit();

    return true;
}
function setFocus()
{
    document.theForm.elements["apj"][0].focus();
}


window.onload = setFocus;




