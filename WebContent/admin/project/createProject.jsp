<%--
    Document   : createProject
    Created on : 7 Sep, 2010, 11:43:52 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.issue.ApmTeam"%>
<!doctype html public "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="java.util.*" language="java"
         contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>

<%
    Logger logger = Logger.getLogger("Add New Project");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <style type="text/css">
            body { margin:0}
            p { margin: 1em }
            ul { list-style: none }
            div { overflow: hidden }
        </style>
        <meta http-equiv="Content-Type" content="text/html ">
            <link id="noscript_css" rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/eminentech support files/noscript.css" />
            <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
                <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
                <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
                <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
                <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
                <style type="text/css">
                    .show {display:block}
                    .hide {display:none}
                </style>

                <script type="text/javascript">
                    function editorTextCounter(field, cntfield, maxlimit)
                    {
                        if (field > maxlimit)
                        {

                            if (maxlimit === 2000)
                                alert('Comments size is exceeding 2000 characters');
                            else
                                alert('Comments size is exceeding 2000 characters');
                        } else
                            cntfield.value = maxlimit - field;
                    }

                    function enablePhaseDate() {
                        var prjType = document.getElementById('projecttype').value;
                        if (prjType === 'Implementation') {
                            document.getElementById('header').style.display = '';
                            document.getElementById('imp1').style.display = '';
                            document.getElementById('imp2').style.display = '';
                            document.getElementById('imp3').style.display = '';
                            document.getElementById('imp4').style.display = '';
                            document.getElementById('imp5').style.display = '';

                            document.getElementById('upg1').style.display = 'none';
                            document.getElementById('upg2').style.display = 'none';
                            document.getElementById('upg3').style.display = 'none';
                            document.getElementById('upg4').style.display = 'none';
                            document.getElementById('upg5').style.display = 'none';

                            document.getElementById('sup1').style.display = 'none';
                            document.getElementById('sup2').style.display = 'none';
                            document.getElementById('sup3').style.display = 'none';
                            document.getElementById('sup4').style.display = 'none';
                            document.getElementById('sup5').style.display = 'none';
                        }
                        if (prjType === 'Upgradation') {
                            document.getElementById('header').style.display = '';
                            document.getElementById('upg1').style.display = '';
                            document.getElementById('upg2').style.display = '';
                            document.getElementById('upg3').style.display = '';
                            document.getElementById('upg4').style.display = '';
                            document.getElementById('upg5').style.display = '';

                            document.getElementById('sup1').style.display = 'none';
                            document.getElementById('sup2').style.display = 'none';
                            document.getElementById('sup3').style.display = 'none';
                            document.getElementById('sup4').style.display = 'none';
                            document.getElementById('sup5').style.display = 'none';

                            document.getElementById('imp1').style.display = 'none';
                            document.getElementById('imp2').style.display = 'none';
                            document.getElementById('imp3').style.display = 'none';
                            document.getElementById('imp4').style.display = 'none';
                            document.getElementById('imp5').style.display = 'none';

                        }
                        if (prjType === 'Support') {
                            document.getElementById('header').style.display = '';
                            document.getElementById('sup1').style.display = '';
                            document.getElementById('sup2').style.display = '';
                            document.getElementById('sup3').style.display = '';
                            document.getElementById('sup4').style.display = '';
                            document.getElementById('sup5').style.display = '';

                            document.getElementById('imp1').style.display = 'none';
                            document.getElementById('imp2').style.display = 'none';
                            document.getElementById('imp3').style.display = 'none';
                            document.getElementById('imp4').style.display = 'none';
                            document.getElementById('imp5').style.display = 'none';

                            document.getElementById('upg1').style.display = 'none';
                            document.getElementById('upg2').style.display = 'none';
                            document.getElementById('upg3').style.display = 'none';
                            document.getElementById('upg4').style.display = 'none';
                            document.getElementById('upg5').style.display = 'none';
                        }
                    }
                    function isRepeat(m1, m2) {

                        m1len = m1.length;
                        teamLength = m2.length;
                        var flag = false;
                        if (teamLength !== 0) {
                            for (i = 0; i < m1len; i++) {
                                if (m1.options[i].selected === true) {
                                    for (j = 0; j < teamLength; j++) {
                                        if (flag === false) {
                                            if (m1.options[i].value === m2.options[j].value) {

                                                flag = true;

                                            }
                                        }
                                    }
                                }
                            }

                        }
                        return flag;

                    }

                    function one2two() {
                        var m1 = document.theForm.teamSelect;
                        var m2 = document.theForm.teamFinal;
                        m1len = m1.length;
                        teamFinalLength = m2.length;
                        var flag = isRepeat(m1, m2);

                        if (flag === true) {
                            alert('There is a repetition in the selection');
                        } else {
                            for (i = 0; i < m1len; i++) {
                                if (m1.options[i].selected === true) {
                                    m2len = m2.length;
                                    m2.options[m2len] = new Option(m1.options[i].text, m1.options[i].value);
                                }
                            }

                            for (i = (m1len - 1); i >= 0; i--) {
                                if (m1.options[i].selected === true) {
                                    m1.options[i] = null;
                                }
                            }
                        }
                    }

                    function two2one() {
                        var m1 = document.theForm.teamSelect;
                        var m2 = document.theForm.teamFinal;
                        m2len = m2.length;
                        teamLength = m1.length;
                        teamSelectLength = m2.length;
                        pM = false;
                        for (i = 0; i < m2len; i++) {
                            if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("projectManager").value)) {
                                pM = true;
                                alert('This selection includes the PM. So change the PM');
                            } else if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("deliveryManager").value)) {
                                pM = true;
                                alert('This selection includes the DeliveryManager. So change the DeliveryManager');
                            } else if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("accountManager").value)) {
                                pM = true;
                                alert('This selection includes the AccountManager. So change the AccountManager')
                            } else if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("projectCoordinator").value)) {
                                pM = true;
                                alert('This selection includes the ProjectCoordinator. So change the ProjectCoordinator')
                            } else if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("projectStakeholder").value)) {
                                pM = true;
                                alert('This selection includes the ProjectStakeholder. So change the ProjectStakeholder')
                            } else if (m2.options[i].selected === true && (m2.options[i].value === document.getElementById("executiveSponsorer").value)) {
                                pM = true;
                                alert('This selection includes the ExecutiveSponsorer. So change the ExecutiveSponsorer')
                            }
                        }
                        if (pM === false) {


                            if (m2len !== 0) {
                                for (i = 0; i < m2len; i++) {
                                    // alert(m2.options[i].text);
                                    if (m2.options[i].selected === true) {
                                        flag = false;
                                        for (j = 0; j < teamLength; j++) {
                                            // alert(m1.options[j].text);

                                            if (m2.options[i].value === m1.options[j].value) {
                                                flag = true;

                                            }
                                        }
                                        if (flag !== true) {
                                            m1index = m1.length;
                                            m1.options[m1index] = new Option(m2.options[i].text, m2.options[i].value);
                                        }
                                    }
                                }


                            }

                            for (i = (m2len - 1); i >= 0; i--) {
                                if (m2.options[i].selected === true) {
                                    m2.options[i] = null;
                                }
                            }
                        }
                    }


                    function addPM(name) {
                        var m2 = document.theForm.teamFinal;
                        teamFinalLength = m2.length;
                        var pM = document.getElementById(name).value;
                        var flag = true;
                        if (teamFinalLength !== 0) {
                            for (i = 0; i < teamFinalLength; i++) {
                                if (pM === m2.options[i].value) {
                                    flag = false;
                                }
                            }
                        }
                        if (flag === true) {
                            userName(name);
                        }

                    }


                    function createRequest()
                    {
                        var reqObj = null;
                        try
                        {
                            reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                        } catch (err)
                        {
                            try
                            {
                                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                            } catch (err2)
                            {
                                try
                                {
                                    reqObj = new XMLHttpRequest();
                                } catch (err3)
                                {
                                    reqObj = null;
                                }
                            }
                        }
                        return reqObj;
                    }

                    function userName(name)
                    {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {

                            var pM = document.getElementById(name).value;
                            xmlhttp.open("GET", "getUser.jsp?userId=" + pM + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = function() {
                                callbackUserName(name);
                            };
                            xmlhttp.send(null);
                        }
                    }


                    function callbackUserName(name)
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {

                                var nameofuser = xmlhttp.responseText.split(",");
                                var m2 = document.theForm.teamFinal;
                                teamFinalLength = m2.length;
                                var pM = document.getElementById(name).value;

                                m2.options[teamFinalLength] = new Option(nameofuser[1], pM);
                            }
                        }
                    }


                    function totalHours()
                    {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var startDate = document.getElementById("startdate").value;
                            var endDate = document.getElementById("enddate").value;
                            xmlhttp.open("GET", "getTotalHours.jsp?startDate=" + startDate + "&endDate=" + endDate + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = callback;
                            xmlhttp.send(null);
                        }
                    }


                    function callback()
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var name = xmlhttp.responseText.split(",");
                                document.theForm.totalhours.value = name[1];
                            }
                        }
                    }
                    function phaseHours(name)
                    {
                        var prjType = document.getElementById('projecttype').value;
                        if (prjType === 'Implementation') {
                            var starthourId = "impstartdate" + name;
                            var endhourId = "impenddate" + name;
                            var hourId = "imptotalhours" + name;
                        }
                        if (prjType === 'Upgradation') {
                            var starthourId = "upgstartdate" + name;
                            var endhourId = "upgenddate" + name;
                            var hourId = "upgtotalhours" + name;
                        }
                        if (prjType === 'Support') {
                            var starthourId = "supstartdate" + name;
                            var endhourId = "supenddate" + name;
                            var hourId = "suptotalhours" + name;
                        }
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var startDate = document.getElementById(starthourId).value;
                            var endDate = document.getElementById(endhourId).value;
                            xmlhttp.open("GET", "getTotalHours.jsp?startDate=" + startDate + "&endDate=" + endDate + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = function() {
                                if (xmlhttp.readyState === 4)
                                {
                                    //              alert(hourId)
                                    if (xmlhttp.status === 200)
                                    {
                                        var hours = xmlhttp.responseText.split(",");

                                        document.getElementById(hourId).value = hours[1];
                                    }
                                }
                                if (name === '1') {
                                    document.getElementById("startdate").value = startDate;
                                }
                                if (name === '5') {
                                    document.getElementById("enddate").value = endDate;
                                }
                            };
                            xmlhttp.send(null);
                        }
                    }


                    function callbackPhaseHours()
                    {



                    }


                    function duplicateProject()
                    {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var project = document.theForm.pname.value;
                            var version = document.theForm.versionInfo.value;
                            xmlhttp.open("GET", "projectexist.jsp?project=" + project + "&version=" + version + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = callWarn;
                            xmlhttp.send(null);
                        }
                    }


                    function callWarn()
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var name = xmlhttp.responseText.split(",");
                                var flag = name[1];
                                if (flag === 'yes') {

                                    alert("This project is already present. So please enter something else");
                                    document.theForm.pname.value = "";
                                    document.theForm.versionInfo.value = "";
                                    theForm.pname.focus();
                                }

                            }
                        }
                    }
                    var maxendDate = '';
                    function isCorrectEndDate() {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var project = document.theForm.pname.value;
                            var version = document.theForm.versionInfo.value;
                            xmlhttp.open("GET", "projectEndDate.jsp?project=" + project + "&version=" + version + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = callEnd;
                            xmlhttp.send(null);
                        }
                    }

                    function callEnd()
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var name = xmlhttp.responseText.split(",");
                                var flag = name[1];
                                maxendDate = flag;

                            }
                        }
                    }

                    function selectteams()
                    {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var opt = document.theForm.team;
                            var numofoptions = opt.length;
                            var selValue = new Array;
                            var j = 0;
                            for (i = 0; i < numofoptions; i++)
                            {
                                if (opt[i].selected === true)
                                {
                                    selValue[j] = opt[i].value;
                                    j++;
                                }
                            }
                            selValue = selValue.join(",");
                            xmlhttp.open("GET", "getTeamMembers.jsp?selValue=" + selValue + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = callbackTeam;
                            xmlhttp.send(null);
                        }
                    }

                    function callbackTeam()
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var name = xmlhttp.responseText;
                                var results = xmlhttp.responseText.split(";");

                                var objLinkList = eval("document.getElementById('teamSelect')");
                                objLinkList.length = 0;

                                for (i = 0; i < results.length - 1; i++)
                                {
                                    var select = results[i].split(",");
                                    objLinkList.length++;
                                    objLinkList[i].text = select[0];
                                    objLinkList[i].value = select[1];

                                }
                            }
                        }
                    }
                </script>
                </head>
                <!-- Start Of Java Script For Front End Validation -->

                <SCRIPT language=JAVASCRIPT type="text/javascript">


                    /** Java Script Function For Trimming A String To Get Only The Required String Input */

                    function Activatetype()
                    {
                        if (document.getElementById('category').value === '--Select One--')
                        {
                            alert("The first \"Select\" option is not a valid selection. Please choose a (whatever).");
                            document.getElementById('category').focus();
                            return false;
                        }

                        document.getElementById("projecttypelabel").style.visibility = "hidden";
                        document.getElementById("projecttypelabel").style.position = "absolute";
                        document.getElementById("projecttypelabel").value = "hello";

                        if (document.getElementById('category').value === 'SAP Project')
                        {
                            document.getElementById("projecttypelabel").style.visibility = "visible";
                            document.getElementById("projecttypelabel").style.Position = "relative";
                            document.getElementById('projecttype').style.visibility = 'visible';
                            document.getElementById('projecttype').style.display = '';
                            document.getElementById('projecttype').disabled = false;
                            document.getElementById('projecttype').focus();

                            return true;
                        } else
                        {
                            document.getElementById("projecttypelabel").style.visibility = "hidden";
                            document.getElementById("projecttypelabel").style.Position = "relative";
                            document.getElementById('projecttype').disabled = true;
                            document.getElementById('projecttype').style.visibility = 'hidden';
                            document.getElementById('projecttype').style.display = 'none';

                            document.getElementById('header').style.display = 'none';
                            document.getElementById('imp1').style.display = 'none';
                            document.getElementById('imp2').style.display = 'none';
                            document.getElementById('imp3').style.display = 'none';
                            document.getElementById('imp4').style.display = 'none';
                            document.getElementById('imp5').style.display = 'none';

                            document.getElementById('upg1').style.display = 'none';
                            document.getElementById('upg2').style.display = 'none';
                            document.getElementById('upg3').style.display = 'none';
                            document.getElementById('upg4').style.display = 'none';
                            document.getElementById('upg5').style.display = 'none';

                            document.getElementById('sup1').style.display = 'none';
                            document.getElementById('sup2').style.display = 'none';
                            document.getElementById('sup3').style.display = 'none';
                            document.getElementById('sup4').style.display = 'none';
                            document.getElementById('sup5').style.display = 'none';

                            return true;
                        }
                        return true;
                    }

                    function Activate()
                    {
                        if (document.theForm.platform.value === '--Select One--')
                        {
                            alert("The first \"Select\" option is not a valid selection. Please choose a (whatever).");
                            document.theForm.platform.focus();
                            return false;
                        }
                        if (document.theForm.platform.value === 'Others')
                        {
                            document.theForm.platforms.style.visibility = 'visible';
                            document.theForm.platforms.style.display = '';
                            document.theForm.platforms.disabled = false;
                            document.theForm.platforms.focus();
                            document.theForm.platforms.select();
                            return true;
                        } else
                        {
                            document.theForm.platforms.disabled = true;
                            document.theForm.platforms.style.visibility = 'hidden';
                            document.theForm.platforms.style.display = 'none';
                            return true;
                        }
                        return true;
                    }

                    function trim(str)
                    {
                        while (str.charAt(str.length - 1) === " ")
                            str = str.substring(0, str.length - 1);
                        while (str.charAt(0) === " ")
                            str = str.substring(1, str.length);
                        return str;
                    }

                    function isNumber(str)
                    {
                        var pattern = "0123456789.";
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

                    /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

                    function isPositiveInteger(str)
                    {
                        var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ-'";
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
                        var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ-1234567890";
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
                    function validatePhaseDate(phasestartdate, phaseenddate) {

                        var strdt = document.getElementById(phasestartdate).value;
                        if ((document.getElementById(phasestartdate).value) === '')
                        {
                            alert('Please enter the Valid Date ');
                            document.getElementById(phasestartdate).focus();
                            return false;
                        }
                        if ((document.getElementById(phaseenddate).value) === '')
                        {
                            alert('Please enter the Valid Date ');
                            document.getElementById(phaseenddate).focus();
                            return false;
                        }
                        var first = strdt.indexOf("-");
                        var last = strdt.lastIndexOf("-");
                        var year = strdt.substring(last + 1, last + 5);
                        var month = strdt.substring(first + 1, last);
                        var date = strdt.substring(0, first);
                        var form_date = new Date(year, month - 1, date);
                        var current_date = new Date();

                        var enddt = document.getElementById(phaseenddate).value;
                        first = enddt.indexOf("-");
                        last = enddt.lastIndexOf("-");

                        year = enddt.substring(last + 1, last + 5);
                        month = enddt.substring(first + 1, last);
                        date = enddt.substring(0, first);
                        var end_date = new Date(year, month - 1, date);


                        if (form_date.getYear() < current_date.getYear())
                        {
                            window.alert("Enter the valid Start Date");
                            document.getElementById(phasestartdate).focus();
                            return false;
                        }
                        if (form_date.getYear() === current_date.getYear())
                        {
                            if (form_date.getMonth() < current_date.getMonth())
                            {
                                window.alert("Enter the valid Start Date");
                                document.getElementById(phasestartdate).focus();
                                return false;
                            }
                            if (form_date.getMonth() === current_date.getMonth())
                            {
                                if (form_date.getDate() < current_date.getDate())
                                {
                                    window.alert("Enter the valid Start Date");
                                    document.getElementById(phasestartdate).focus();
                                    return false;
                                }
                            }
                        }

                        if (end_date < form_date)
                        {
                            alert('Please enter the valid End Date');
                            document.getElementById(phaseenddate).focus();
                            return false;
                        }
                        return true;
                    }

                    /** Function To Validate The Input Form Data */
                    function fun(theForm)
                    {
                        if (document.theForm.category.selectedIndex === 0)
                        {
                            alert("Please select category.");
                            return false;
                        }
                        if (document.getElementById("category").value === "--Select Category--")
                        {
                            alert("Please select category.");
                            return false;
                        }

                        if (document.getElementById("customer").value === "--Select Customer--")
                        {
                            alert('Please select the Customer Name ');
                            theForm.customer.focus();
                            return false;
                        }

                        if (document.theForm.platform.selectedIndex === 0)
                        {
                            alert("Please select platform.");
                            return false;
                        }
                        if (document.getElementById("platform").value === "--Select One--")
                        {
                            alert("Please select platform.");
                            return false;
                        }
                        var x = document.getElementById("platform");
                        if ((document.getElementById("platform").value === "Others") && theForm.platforms.value === '')
                        {
                            alert('Please enter the  Platform');
                            theForm.platforms.focus();
                            return false;
                        }
                        if ((document.getElementById("platform").value === "Others") && !isPositiveInteger(trim(theForm.platforms.value)))
                        {
                            alert('Please enter the Alphabetical only in the Platform ');
                            document.theForm.platforms.value = "";
                            theForm.platforms.focus();
                            return false;
                        }
                        /** This Loop Checks Whether There Is Any Integer Present In The Project Name Field */
                        if ((theForm.pname.value) === '')
                        {
                            alert('Please enter the project name ');
                            document.theForm.pname.value = "";
                            theForm.pname.focus();
                            return false;
                        }
                        if (!isPositiveInteger(trim(theForm.pname.value)))
                        {
                            alert('Please enter the Alphabetical only in the ProjectName ');
                            document.theForm.pname.value = "";
                            theForm.pname.focus();
                            return false;
                        }
                        /** This Loop Checks Whether There Is Any Input Data Present In The Version Info Field */
                        if ((theForm.versionInfo.value) === '')
                        {
                            alert('Please enter the Version Info ');
                            document.theForm.versionInfo.value = "";
                            theForm.versionInfo.focus();
                            return false;
                        }
                        if ((theForm.versionInfo.value.indexOf('.')) === -1 || (theForm.versionInfo.value.indexOf('.')) === 0)
                        {
                            alert('Please enter the Version Info with Valid data ');
                            document.theForm.versionInfo.value = "";
                            theForm.versionInfo.focus();
                            return false;
                        }
                        if ((theForm.versionInfo.value.indexOf('0')) === 0)
                        {
                            alert('Please Enter the version info with valid data ');
                            document.theForm.versionInfo.value = "";
                            theForm.versionInfo.focus();
                            return false;
                        }
                        if (!isNumber(trim(theForm.versionInfo.value)))
                        {
                            alert('Please enter number only in the "versionInfo" box');
                            document.theForm.versionInfo.value = "";
                            theForm.versionInfo.focus();
                            return false;
                        }
                        if (document.theForm.phase.selectedIndex === 0)
                        {
                            alert("Please select the phase.");
                            return false;
                        }
                        if (document.getElementById("phase").value === "--Select Phase--")
                        {
                            alert("Please select Phase.");
                            return false;
                        }
                        if ((document.getElementById("executiveSponsorer").value) === "--Select Manager--")
                        {
                            alert('Please select the Executive Sponsorer name');
                            theForm.executiveSponsorer.focus();
                            return false;
                        }
                        if ((document.getElementById("projectStakeholder").value) === "--Select Manager--")
                        {
                            alert('Please enter the Project Stakeholder name');
                            theForm.projectStakeholder.focus();
                            return false;
                        }
                        if ((document.getElementById("projectCoordinator").value) === "--Select Manager--")
                        {
                            alert('Please enter the Project Coordinator name');
                            theForm.projectCoordinator.focus();
                            return false;
                        }
                        if ((document.getElementById("accountManager").value) === "--Select Manager--")
                        {
                            alert('Please enter the Account Manager name');
                            theForm.accountManager.focus();
                            return false;
                        }
                        if ((document.getElementById("deliveryManager").value) === "--Select Manager--")
                        {
                            alert('Please enter the Delivery Manager name');
                            theForm.deliveryManager.focus();
                            return false;
                        }
                        if ((document.getElementById("projectManager").value) === "--Select Manager--")
                        {
                            alert('Please enter the Project Manager name');
                            theForm.projectManager.focus();
                            return false;
                        }

                        if (document.getElementById("category").value === "SAP Project") {
                            if (document.getElementById('projecttype').value === "Implementation") {

                                if (!validatePhaseDate('impstartdate1', 'impenddate1')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impenddate1', 'impstartdate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impstartdate2', 'impenddate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impenddate2', 'impstartdate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impstartdate3', 'impenddate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impenddate3', 'impstartdate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impstartdate4', 'impenddate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impenddate4', 'impstartdate5')) {
                                    return false;
                                }
                                if (!validatePhaseDate('impstartdate5', 'impenddate5')) {
                                    return false;
                                }

                            }
                            if (document.getElementById('projecttype').value === "Support") {

                                if (!validatePhaseDate('supstartdate1', 'supenddate1')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supenddate1', 'supstartdate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supstartdate2', 'supenddate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supenddate2', 'supstartdate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supstartdate3', 'supenddate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supenddate3', 'supstartdate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supstartdate4', 'supenddate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supenddate4', 'supstartdate5')) {
                                    return false;
                                }
                                if (!validatePhaseDate('supstartdate5', 'supenddate5')) {
                                    return false;
                                }

                            }
                            if (document.getElementById('projecttype').value === "Upgradation") {
                                var starthourId = "upgstartdate" + name;
                                var endhourId = "upgenddate" + name;
                                if (!validatePhaseDate('upgstartdate1', 'upgenddate1')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgenddate1', 'upgstartdate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgstartdate2', 'upgenddate2')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgenddate2', 'upgstartdate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgstartdate3', 'upgenddate3')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgenddate3', 'upgstartdate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgstartdate4', 'upgenddate4')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgenddate4', 'upgstartdate5')) {
                                    return false;
                                }
                                if (!validatePhaseDate('upgstartdate5', 'upgenddate5')) {
                                    return false;
                                }

                            }

                        }

                        /** This Loop Checks Whether There Is Any Input Data Present In The Project Manager Field */



                        var str = document.theForm.startdate.value;
                        var first = str.indexOf("-");
                        var last = str.lastIndexOf("-");
                        var year = str.substring(last + 1, last + 5);
                        var month = str.substring(first + 1, last);
                        var date = str.substring(0, first);
                        var form_date = new Date(year, month - 1, date);
                        var current_date = new Date();

                        str = document.theForm.enddate.value;
                        first = str.indexOf("-");
                        last = str.lastIndexOf("-");

                        year = str.substring(last + 1, last + 5);
                        month = str.substring(first + 1, last);
                        date = str.substring(0, first);
                        var end_date = new Date(year, month - 1, date);

                        if ((theForm.startdate.value) === '')
                        {
                            alert('Please enter the Start date of project ');
                            theForm.startdate.focus();
                            return false;
                        }
                        if (form_date.getYear() < current_date.getYear())
                        {
                            window.alert("Enter the valid Start Date");
                            theForm.startdate.focus();
                            return false;
                        }
                        if (form_date.getYear() === current_date.getYear())
                        {
                            if (form_date.getMonth() < current_date.getMonth())
                            {
                                window.alert("Enter the valid Start Date");
                                theForm.startdate.focus();
                                return false;
                            }
                            if (form_date.getMonth() === current_date.getMonth())
                            {
                                if (form_date.getDate() < current_date.getDate())
                                {
                                    window.alert("Enter the valid Start Date");
                                    theForm.startdate.focus();
                                    return false;
                                }
                            }
                        }
                        if ((theForm.enddate.value) === '')
                        {
                            alert('Please enter End date of the project ');
                            theForm.enddate.focus();
                            return false;
                        }
                        if (end_date < form_date)
                        {

                            alert('Please enter the valid End Date');
                            theForm.enddate.focus();
                            return false;
                        }
                        isCorrectEndDate();
                        if (maxendDate !== '') {
                            var first = maxendDate.indexOf("-");
                            var last = maxendDate.lastIndexOf("-");
                            var year = maxendDate.substring(last + 1, last + 5);
                            var month = maxendDate.substring(first + 1, last);
                            var date = maxendDate.substring(0, first);
                            var max_Enddate = new Date(year, month - 1, date);
                            if (end_date < max_Enddate) {
                                alert('Project end date is must be greater than' + maxendDate);
                                theForm.enddate.value = "";
                                theForm.enddate.focus();
                                return false;
                            }
                        }

                        if (!isNumber(trim(theForm.totalhours.value)))
                        {
                            alert('Please enter the Total Hours in Numbers');
                            document.theForm.totalhours.value = "";
                            theForm.totalhours.focus();
                            return false;
                        }
                        if ((theForm.totalhours.value) === '')
                        {
                            alert('Please enter the Total Hours ');
                            theForm.totalhours.focus();
                            return false;
                        }

                        var n = document.getElementById('teamFinal').options.length;
                        if (n === 0)
                        {
                            alert("please select the Team Members");
                            return false;
                        }
                        var teamFinal = document.getElementById("teamFinal");
                        var teamFinalOptions = teamFinal.options;
                        var teamFinalOLength = teamFinalOptions.length;
                        if (teamFinalOLength < 1) {
                            alert("No Selections in the team\nPlease Select using the [Add] button");
                            return false;
                        }
                        for (var i = 0; i < teamFinalOLength; i++) {
                            teamFinalOptions[i].selected = true;
                        }
                        if (trim(CKEDITOR.instances.comments.getData()) === "")
                        {
                            alert("Please Enter the Comments");
                            CKEDITOR.instances.comments.focus();
                            return false;
                        }
                        if (CKEDITOR.instances.comments.getData().length > 2000)
                        {
                            alert(" Comments exceeds 2000 character");
                            CKEDITOR.instances.comments.focus();
                            return false;
                        }
                        monitorSubmit();
                        return true;

                        return true;
                    }

                    /** Function To Set Focus On The Project Name Field In The Form */

                    function setFocus()
                    {
                        document.theForm.pname.focus();
                    }
                    window.onload = setFocus;
                    //-->

                </SCRIPT>

                <!-- End Of Java Script Code -->

                <body>
                    <!-- Declaring The Form And Its Attributes -->

                    <FORM name=theForm onsubmit="return fun(this);"
                          action="newproject.jsp"
                          method=post onReset="return setFocus();"><!-- Table To Display Current User And The Links For User Profile, Mails, And Logout -->

                        <%@ include file="/header.jsp"%>
                        <%@ page import="java.sql.*,com.eminent.util.GetProjects,pack.eminent.encryption.*,com.eminent.util.GetProjectMembers,java.util.HashMap"%>
                        <%!
                            Connection connection = null;
                            ResultSet userResult = null;

                        %>
                        <%
                            HashMap pm = GetProjectMembers.getAllMembers();

                            HashMap am = (HashMap) pm.clone();
                            HashMap es = (HashMap) pm.clone();
                            HashMap ps = (HashMap) pm.clone();
                            HashMap pc = (HashMap) pm.clone();
                            HashMap dm = (HashMap) pm.clone();

                            String implementation[] = {"Project Preparation", "Business Blueprint", "Realization", "Final Preparation", "Go Live & support"};
                            String upgrade[] = {"Project Preparation", "Upgrade Blueprint", "Upgrade Realization", "Final Preparation for Cutover", "Production Cutover and Support"};
                            String support[] = {"Project Preparation", "Support Blueprint", "Support Realization", "Final Preparation for Cutover", "Maintenence and edcuating end users"};

                        %>
                        <div align="center">
                            <center><!-- Table To Display The Formatted String "Add New Project" -->
                                <table cellpadding="2" cellspacing="1" width="100%">
                                    <tr border="2" bgcolor="C3D9FF">
                                        <td border="1" align="left" width="100%"><font size="4"
                                                                                       COLOR="#0000FF"><b> Add New Project</b></font> <FONT SIZE="3"
                                                                                                 COLOR="#0000FF"> </FONT></td>
                                    </tr>
                                </table>
                                <br>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td><a
                                                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                                                    Project</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp" style="cursor: pointer;font-weight: bold;">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                                                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                                                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                                                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                                                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>

                                            </td>
                                            <td></td>

                                        </tr>
                                    </table>
                                    <br>

                                        <!-- Table To Display The Form Input Elements Project Name, Version, Project Manager, Customer  And The Submit, Reset Buttons-->
                                        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"></jsp:useBean>

                                            <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center">
                                                <TBODY>
                                                    <tr align="left">
                                                        <td width="15%"><strong>Category</strong></td>
                                                        <td align="left" width="20%"><SELECT NAME="category" id="category" size="1"
                                                                                             onChange="javascript:redirect(this.options.selectedIndex);
                                                                                                     javascript:Activatetype(this.value);">
                                                                <option value="--Select One--" selected>--Select Category--</option>
                                                                <option value="SAP Project">SAP Project</option>
                                                                <option value="Project">Project</option>
                                                                <option value="Product">Product</option>
                                                                <option value="Outsource">OutSource</option>
                                                            </SELECT></td>
                                                        <td>
                                                            <div id="projecttypelabel"	style="position: absolute; visibility: hidden"><B>Type</B></div>
                                                        </td>
                                                        <td><select id="projecttype" name="projecttype" size="1"
                                                                    disabled="disabled"
                                                                    onChange="javascript:redirect1(this.options.selectedIndex);
                                                                            javascript:enablePhaseDate();">
                                                                <option value="--Select One--" selected>--Select Type--</option>
                                                                <option value="Implementation">Implementation</option>
                                                                <option value="Upgradation">Upgradation</option>
                                                                <option value="Support">Support</option>
                                                            </select> <script language="javascript">
                                                                document.getElementById('projecttype').style.visibility = 'hidden';
                                                                document.getElementById('projecttype').style.display = 'none';
                                                            </script> <input type="hidden" name="isTestingSubmit" value="true" /></td>
                                                    </tr>
                                                    <tr align="left">
                                                        <td width="15%"><strong>Customer</strong></td>
                                                        <td>
                                                            <select name="customer" id="customer">
                                                                <option value="--Select Customer--">--Select Customer--</option>
                                                            <%
                                                                String customer[] = GetProjects.getCustomer();
                                                                for (int l = 0; l < customer.length; l++) {

                                                            %>
                                                            <option value="<%=customer[l]%>"><%=customer[l]%></option>
                                                            <%
                                                                }

                                                            %>
                                                        </select>

                                                    </td>

                                                    <td width="15%"><strong>Platform </strong></td>
                                                    <td align="left" width="20%"><SELECT NAME="platform" id="platform" size="1"
                                                                                         onChange="Activate(this.value);">
                                                            <option value="--Select One--" selected>--Select One--</option>
                                                            <option value="Windows">Windows</option>
                                                            <option value="Unix">Unix</option>
                                                            <option value="Linux">Linux</option>
                                                            <option value="Mac">Mac</option>
                                                            <option value="Others">Others</option>
                                                        </SELECT></td>
                                                    <td><input type="text" name="platforms" id="myval2"
                                                               maxlength="20" size=20 disabled="disabled" style="height: 25px;" />
                                                        <script language="javascript">
                                                            document.getElementById('myval2').style.visibility = 'hidden';
                                                            document.getElementById('myval2').style.display = 'none';
                                                        </script> <input type="hidden" name="isTestSubmit" value="true" /></td>
                                                </tr>
                                                <tr align="left">
                                                    <td width="15%"><strong>Project Name </strong></td>
                                                    <td><input type="text" name="pname" id="pname" maxlength="20" size=25><strong
                                                                class="style20"></strong></td>

                                                    <td width="15%"><strong>Version Info </strong></td>
                                                    <td><input type="text" name="versionInfo" id="versionInfo" maxlength="15" size=25 onblur="javascript:duplicateProject();"><span
                                                                class="style13"></span></td>
                                                    <td width="15%"><strong>Phase</strong><input type="hidden" name="status" id="status" value="To be Started"></td>
                                                    <td align="left" width="20%"><SELECT id="phase" NAME="phase"
                                                                                         size="1">
                                                            <option value=" " selected>--Select Phase--</option>

                                                        </SELECT></td>
                                                </tr>
                                                <tr align="left">
                                                    <td width="15%"><strong>Executive Sponsorer</strong></td>
                                                    <td>
                                                        <select id="executiveSponsorer" name="executiveSponsorer" size="1" onchange="addPM('executiveSponsorer');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Executive Sponsorer--</option>
                                                            <%                                    Collection setES = es.keySet();
                                                                Iterator iterES = setES.iterator();
                                                                while (iterES.hasNext()) {
                                                                    int key = (Integer) iterES.next();
                                                                    String nameofuser = (String) es.get(key);
                                                            %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select>
                                                    </td>

                                                    <td width="15%"><strong>Project Stakeholder</strong></td>
                                                    <td>
                                                        <select name="projectStakeholder" id="projectStakeholder" size="1" onchange="addPM('projectStakeholder');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Project Stakeholder--</option>
                                                            <%
                                                                Collection setPS = ps.keySet();
                                                                Iterator iterPS = setPS.iterator();
                                                                while (iterPS.hasNext()) {
                                                                    int key = (Integer) iterPS.next();
                                                                    String nameofuser = (String) ps.get(key);
                                                            %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select>
                                                    </td>

                                                    <td width="15%"><strong>Project Coordinator</strong></td>
                                                    <td>
                                                        <select name="projectCoordinator" id="projectCoordinator" size="1" onchange="addPM('projectCoordinator');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Project Coordinator--</option>
                                                            <%
                                                                Collection setPC = pc.keySet();
                                                                Iterator iterPC = setPS.iterator();
                                                                while (iterPC.hasNext()) {
                                                                    int key = (Integer) iterPC.next();
                                                                    String nameofuser = (String) pc.get(key);
                                                            %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr align="left">
                                                    <td width="15%"><strong>Account Manager</strong></td>
                                                    <td>
                                                        <select name="accountManager" id="accountManager" size="1" onchange="addPM('accountManager');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Account Manager--</option>
                                                            <%
                                                                Collection setAM = am.keySet();
                                                                Iterator iterAM = setAM.iterator();
                                                                while (iterAM.hasNext()) {
                                                                    int key = (Integer) iterAM.next();
                                                                    String nameofuser = (String) am.get(key);
                                                            %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select>
                                                    </td>

                                                    <td width="15%"><strong>Delivery Manager</strong></td>
                                                    <td>
                                                        <select name="deliveryManager" id="deliveryManager" size="1" onchange="addPM('deliveryManager');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Delivery Manager--</option>
                                                            <%
                                                                Collection setDM = dm.keySet();
                                                                Iterator iterDM = setDM.iterator();
                                                                while (iterDM.hasNext()) {
                                                                    int key = (Integer) iterDM.next();
                                                                    String nameofuser = (String) dm.get(key);
                                                            %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select>
                                                    </td>

                                                    <td width="15%"><strong>Project Manager</strong></td>
                                                    <%
                                                        String name = null;
                                                    %>
                                                    <td><select name="projectManager" id="projectManager" size="1" onchange="addPM('projectManager');
                                                                ">
                                                            <option value="--Select Manager--" selected>--Select Project
                                                                Manager--</option>
                                                                <%
                                                                    Collection setPM = pm.keySet();
                                                                    Iterator iterPM = setPM.iterator();
                                                                    while (iterPM.hasNext()) {
                                                                        int key = (Integer) iterPM.next();
                                                                        String nameofuser = (String) pm.get(key);
                                                                %>
                                                            <option value="<%=key%>"><%=nameofuser%></option>
                                                            <%
                                                                }
                                                            %>
                                                        </select></td>

                                                </tr>
                                                <tr id="header" style="display:none" align="left">
                                                    <td> <b>Project Phase</b></td>
                                                    <td align="center"><b>Phase Start Date</b></td>
                                                    <td></td>
                                                    <td align="center"><b>Phase End Date</b></td>
                                                    <td></td>
                                                    <td align="center"><b>Total Hours</b></td>
                                                </tr>
                                                <tr id="imp1" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="firstPhase" value="Project Preparation"/>Project Preparation</b></td>
                                                    <td><input type="Text" name="impstartdate1" id="impstartdate1" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('impstartdate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="impenddate1" id="impenddate1" readonly="true" maxlength="25" size="25" /><a href="javascript:NewCal('impenddate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="imptotalhours1" name="imptotalhours1" maxlength="30" size=25 onClick="javascript:phaseHours('1');"/></td>
                                                </tr>
                                                <tr id="imp2" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="secondPhase" value="Business Blueprint"/>Business Blueprint</b></td>
                                                    <td><input type="Text" name="impstartdate2" id="impstartdate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('impstartdate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="impenddate2" id="impenddate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('impenddate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="imptotalhours2" name="imptotalhours2" maxlength="30" size=25 onClick="javascript:phaseHours(2);"/></td>
                                                </tr>
                                                <tr id="imp3" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="thirdPhase" value="Realization"/>Realization</b></td>
                                                    <td><input type="Text" name="impstartdate3" id="impstartdate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impstartdate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="impenddate3" id="impenddate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impenddate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="imptotalhours3" name="imptotalhours3" maxlength="30" size=25 onClick="javascript:phaseHours(3);"></td>
                                                </tr>
                                                <tr id="imp4" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="fourthPhase" value="Final Preparation"/>Final Preparation</b></td>
                                                    <td><input type="Text" name="impstartdate4" id="impstartdate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impstartdate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="impenddate4" id="impenddate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impenddate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="imptotalhours4" name="imptotalhours4" maxlength="30" size=25 onClick="javascript:phaseHours(4);"></td>
                                                </tr>
                                                <tr id="imp5" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="fifthPhase" value="Go Live & support"/>Go Live & support</b></td>
                                                    <td><input type="Text" name="impstartdate5" id="impstartdate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impstartdate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="impenddate5" id="impenddate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('impenddate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td><td></td>
                                                    <td><input type="text" id="imptotalhours5" name="imptotalhours5" maxlength="30" size=25 onClick="javascript:phaseHours(5);"></td>
                                                </tr>
                                                <tr id="upg1" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="upgfirstPhase" value="Project Preparation"/>Project Preparation</b></td>
                                                    <td><input type="Text" name="upgstartdate1" id="upgstartdate1" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('upgstartdate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="upgenddate1" id="upgenddate1" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('upgenddate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="upgtotalhours1" name="upgtotalhours1" maxlength="30" size=25 onClick="javascript:phaseHours(1);"/></td>
                                                </tr>
                                                <tr id="upg2" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="upgsecondPhase" value="Upgrade Blueprint"/>Upgrade Blueprint</b></td>
                                                    <td><input type="Text" name="upgstartdate2" id="upgstartdate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('upgstartdate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="upgenddate2" id="upgenddate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('upgenddate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="upgtotalhours2" name="upgtotalhours2" maxlength="30" size=25 onClick="javascript:phaseHours(2);"/></td>
                                                </tr>
                                                <tr id="upg3" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="upgthirdPhase" value="Upgrade Realization"/>Upgrade Realization</b></td>
                                                    <td><input type="Text" name="upgstartdate3" id="upgstartdate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgstartdate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="upgenddate3" id="upgenddate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgenddate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="upgtotalhours3" name="upgtotalhours3" maxlength="30" size=25 onClick="javascript:phaseHours(3);"></td>
                                                </tr>
                                                <tr id="upg4" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="upgfourthPhase" value="Final Preparation for Cutover"/>Final Preparation for Cutover</b></td>
                                                    <td><input type="Text" name="upgstartdate4" id="upgstartdate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgstartdate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="upgenddate4" id="upgenddate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgenddate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="upgtotalhours4" name="upgtotalhours4" maxlength="30" size=25 onClick="javascript:phaseHours(4);"></td>
                                                </tr>
                                                <tr id="upg5" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="upgfifthPhase" value="Production Cutover and Support"/>Production Cutover and Support</b></td>
                                                    <td><input type="Text" name="upgstartdate5" id="upgstartdate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgstartdate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="upgenddate5" id="upgenddate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('upgenddate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td><td></td>
                                                    <td><input type="text" id="upgtotalhours5" name="upgtotalhours5" maxlength="30" size=25 onClick="javascript:phaseHours(5);"></td>
                                                </tr>
                                                <tr id="sup1" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="supfirstPhase" value="Project Preparation"/>Project Preparation</b></td>
                                                    <td><input type="Text" name="supstartdate1" id="supstartdate1" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('supstartdate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="supenddate1" id="supenddate1" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('supenddate1','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="suptotalhours1" name="suptotalhours1" maxlength="30" size=25 onClick="javascript:phaseHours(1);"/></td>
                                                </tr>
                                                <tr id="sup2" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="supsecondPhase" value="Support Blueprint"/>Support Blueprint</b></td>
                                                    <td><input type="Text" name="supstartdate2" id="supstartdate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('supstartdate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="supenddate2" id="supenddate2" readonly="true" maxlength="25" size="25"/><a href="javascript:NewCal('supenddate2','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"/></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="suptotalhours2" name="suptotalhours2" maxlength="30" size=25 onClick="javascript:phaseHours(2);"/></td>
                                                </tr>
                                                <tr id="sup3" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="supthirdPhase" value="Support Realization"/>Support Realization</b></td>
                                                    <td><input type="Text" name="supstartdate3" id="supstartdate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supstartdate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="supenddate3" id="supenddate3" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supenddate3','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="suptotalhours3" name="suptotalhours3" maxlength="30" size=25 onClick="javascript:phaseHours(3);"></td>
                                                </tr>
                                                <tr id="sup4" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="supfourthPhase" value="Final Preparation for Cutover"/>Final Preparation for Cutover</b></td>
                                                    <td><input type="Text" name="supstartdate4" id="supstartdate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supstartdate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="supenddate4" id="supenddate4" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supenddate4','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="text" id="suptotalhours4" name="suptotalhours4" maxlength="30" size=25 onClick="javascript:phaseHours(4);"></td>
                                                </tr>
                                                <tr id="sup5" style="display:none" align="left">
                                                    <td><b><input type="hidden" name="supfifthPhase" value="Maintenence and edcuating end users"/>Maintenence and edcuating end users</b></td>
                                                    <td><input type="Text" name="supstartdate5" id="supstartdate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supstartdate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
                                                    <td></td>
                                                    <td><input type="Text" name="supenddate5" id="supenddate5" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('supenddate5','ddmmyyyy')"><img src="images/newhelp.gif" width="16" height="16" border="0" alt="Pick a date"></a></td><td></td>
                                                    <td><input type="text" id="suptotalhours5" name="suptotalhours5" maxlength="30" size=25 onClick="javascript:phaseHours(5);"></td>
                                                </tr>

                                                <tr align="left">
                                                    <td width="15%"><strong>Project Start Date</strong></td>
                                                    <td width="20%"><input type="Text" name="startdate"
                                                                           id="startdate" readonly="true" maxlength="25" size="25"><a href="javascript:NewCal('startdate','ddmmyyyy')"><img
                                                                    src="images/newhelp.gif" width="16" height="16" border="0"
                                                                    alt="Pick a date"></a></td>

                                                    <td width="15%"><strong>Project End Date</strong></td>
                                                    <td width="20%"><input type="Text" readonly="true" name="enddate" id="enddate"
                                                                           maxlength="25" size="25"><a
                                                                href="javascript:NewCal('enddate','ddmmyyyy')"><img
                                                                    src="images/newhelp.gif" width="16" height="16" border="0"
                                                                    alt="Pick a date" ></a></td>
                                                    <td width="15%"><strong>Total Hours</strong></td>
                                                    <td><input type="text" id="totalhours" name="totalhours"
                                                               maxlength="30" size=25 onClick="javascript:totalHours();"></td>

                                                </tr>
                                                <tr align="left">
                                                    <td width="15%"><strong>Team</strong></td>
                                                    <td><SELECT id="team" NAME="team"
                                                                ONCHANGE="javascript:selectteams();" style="width: 200px;" width="200"
                                                                size="6">
                                                            <% for (ApmTeam apmTeam : atc.findAllTeams()) {%>
                                                            <option value="<%=apmTeam.getTeamName()%>"><%=apmTeam.getTeamName()%></option>
                                                            <%}%>
                                                        </SELECT></td>
                                                    <td></td>
                                                    <td align="left"><select id=teamSelect name=teamSelect style="width: 200px;" width="200" size="6" multiple></select>

                                                    </td>
                                                    <td>
                                                        <p align="center"><input type="button" onClick="one2two();"	value=" >> "></p>
                                                        <p align="center"><input type="button" onClick="two2one();"	value=" << "></p>
                                                    </td>
                                                    <td align="left"><select id=teamFinal name=teamFinal
                                                                             style="width: 200px;" width="200" size="6" multiple></select>

                                                    </td>
                                                </tr>

                                                <tr align="left">
                                                    <td width="12%" align="left">
                                                        <b>Deliverables</b>
                                                    </td>


                                                    <td colspan="5">
                                                        <textarea
                                                            name="comments" wrap="physical" cols="84" rows="2"
                                                            onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"
                                                            onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"></textarea>
                                                        <script type="text/javascript">
                                                            CKEDITOR.replace('comments', {height: 100});
                                                            var editor_data = CKEDITOR.instances.comments.getData();
                                                            CKEDITOR.instances["comments"].on("instanceReady", function()
                                                            {

                                                                //set keyup event
                                                                this.document.on("keyup", updateComments);
                                                                //and paste event
                                                                this.document.on("paste", updateComments);

                                                            });
                                                            function updateComments()
                                                            {
                                                                CKEDITOR.tools.setTimeout(function()
                                                                {
                                                                    var desc = CKEDITOR.instances.comments.getData();
                                                                    var leng = desc.length;
                                                                    editorTextCounter(leng, document.theForm.remLen1, 2000);

                                                                }, 0);
                                                            }
                                                        </script>

                                                        <input readonly type="text" name="remLen1" size="3" maxlength="4" value="2000">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <TD>&nbsp;</TD>
                                                    <TD>&nbsp;</TD>
                                                    <TD align="right"><INPUT type=submit id="submit" value=Submit name=submit></TD>
                                                    <TD align="left">	<INPUT type=reset id="reset" value=" Reset "></TD>
                                                    <TD>&nbsp;</TD>
                                                    <TD>&nbsp;</TD>
                                                </tr>
                                            </TBODY>
                                        </TABLE>
                                        </center>
                                        </div>
                                        </FORM>
                                        <script>
                                            var groups = document.theForm.category.options.length;
                                            var group = new Array(groups);
                                            for (i = 0; i < groups; i++)
                                                group[i] = new Array();

                                            group[0][0] = new Option("--Select Phase--", " ");
                                            group[1][0] = new Option("--Select Phase--", " ");

                                            group[2][0] = new Option("--Select Phase--", " ");
                                            group[2][1] = new Option("To be started", "To be started");
                                            group[2][2] = new Option("Requirment gathering", "Requirment gathering");
                                            group[2][3] = new Option("Design Documentation", "Design Documentation");
                                            group[2][4] = new Option("Database Design", "Database Design");
                                            group[2][5] = new Option("User Unterface", "User Unterface");
                                            group[2][6] = new Option("File names and flow review", "File names and flow review");
                                            group[2][7] = new Option("Development", "Development");
                                            group[2][8] = new Option("Testing", "Testing");
                                            group[2][9] = new Option("Finished", "Finished");
                                            group[2][10] = new Option("User Acceptance Testing", "User Acceptance Testing");
                                            group[2][11] = new Option("Production", "Production");
                                            group[2][12] = new Option("Maintenance", "Maintenance");
                                            group[2][13] = new Option("End of Life", "End of Life");
                                            group[2][14] = new Option("Closed", "Closed");
                                            group[2][15] = new Option("Suspended", "Suspended");
                                            group[2][16] = new Option("Pilot Demo", "Pilot Demo");

                                            group[3][0] = new Option("--Select Phase--", " ");
                                            group[3][1] = new Option("To be started", "To be started");
                                            group[3][2] = new Option("Requirment gathering", "Requirment gathering");
                                            group[3][3] = new Option("Design Documentation", "Design Documentation");
                                            group[3][4] = new Option("Database Design", "Database Design");
                                            group[3][5] = new Option("User Unterface", "User Unterface");
                                            group[3][6] = new Option("File names and flow review", "File names and flow review");
                                            group[3][7] = new Option("Development", "Development");
                                            group[3][8] = new Option("Testing", "Testing");
                                            group[3][9] = new Option("Finished", "Finished");
                                            group[3][10] = new Option("User Acceptance Testing", "User Acceptance Testing");
                                            group[3][11] = new Option("Production", "Production");
                                            group[3][12] = new Option("Maintenance", "Maintenance");
                                            group[3][13] = new Option("End of Life", "End of Life");
                                            group[3][14] = new Option("Closed", "Closed");
                                            group[3][15] = new Option("Suspended", "Suspended");
                                            group[3][16] = new Option("Pilot Demo", "Pilot Demo");

                                            group[4][0] = new Option("--Select Phase--", " ");
                                            group[4][1] = new Option("To be started", "To be started");
                                            group[4][2] = new Option("Requirment gathering", "Requirment gathering");
                                            group[4][3] = new Option("Design Documentation", "Design Documentation");
                                            group[4][4] = new Option("Database Design", "Database Design");
                                            group[4][5] = new Option("User Unterface", "User Unterface");
                                            group[4][6] = new Option("File names and flow review", "File names and flow review");
                                            group[4][7] = new Option("Development", "Development");
                                            group[4][8] = new Option("Testing", "Testing");
                                            group[4][9] = new Option("Finished", "Finished");
                                            group[4][10] = new Option("User Acceptance Testing", "User Acceptance Testing");
                                            group[4][11] = new Option("Production", "Production");
                                            group[4][12] = new Option("Maintenance", "Maintenance");
                                            group[4][13] = new Option("End of Life", "End of Life");
                                            group[4][14] = new Option("Closed", "Closed");
                                            group[4][15] = new Option("Suspended", "Suspended");
                                            group[4][16] = new Option("Pilot Demo", "Pilot Demo");

                                            var temp = document.getElementById('phase');

                                            function redirect(x)
                                            {
                                                for (m = temp.options.length - 1; m > 0; m--)
                                                    temp.options[m] = null;
                                                for (i = 0; i < group[x].length; i++)
                                                    temp.options[i] = new Option(group[x][i].text, group[x][i].value);
                                                temp.options[0].selected = true;
                                            }
                                            var projectgroups = document.getElementById('projecttype').options.length;
                                            var projectgroup = new Array(projectgroups);
                                            for (i = 0; i < projectgroups; i++)
                                                projectgroup[i] = new Array();

                                            projectgroup[0][0] = new Option("--Select Phase--", " ");
                                            projectgroup[1][0] = new Option("--Select Phase--", " ");
                                            projectgroup[1][1] = new Option("Project Preparation", "Project Preparation");
                                            projectgroup[1][2] = new Option("Business Blueprint", "Business Blueprint");
                                            projectgroup[1][3] = new Option("Realization", "Realization");
                                            projectgroup[1][4] = new Option("Final Preparation", "Final Preparation");
                                            projectgroup[1][5] = new Option("Go Live & support", "Go Live & support");

                                            projectgroup[2][0] = new Option("--Select Phase--", " ");
                                            projectgroup[2][1] = new Option("Project Preparation", "Project Preparation");
                                            projectgroup[2][2] = new Option("Upgrade Blueprint", "Upgrade Blueprint");
                                            projectgroup[2][3] = new Option("Upgrade Realization", "Upgrade Realization");
                                            projectgroup[2][4] = new Option("Final Preparation for Cutover", "Final Preparation for Cutover");
                                            projectgroup[2][5] = new Option("Production Cutover and Support", "Production Cutover and Support");

                                            projectgroup[3][0] = new Option("--Select Phase--", " ");
                                            projectgroup[3][1] = new Option("Project Preparation", "Project Preparation");
                                            projectgroup[3][2] = new Option("Support Blueprint", "Support Blueprint");
                                            projectgroup[3][3] = new Option("Support Realization", "Support Realization");
                                            projectgroup[3][4] = new Option("Final Preparation for Cutover", "Final Preparation for Cutover");
                                            projectgroup[3][5] = new Option("Maintenence and edcuating end users", "Maintenence and edcuating end users");

                                            var temp1 = document.theForm.phase;
                                            function redirect1(y)
                                            {
                                                for (m = temp1.options.length - 1; m > 0; m--)
                                                    temp1.options[m] = null;
                                                for (i = 0; i < projectgroup[y].length; i++)
                                                    temp1.options[i] = new Option(projectgroup[y][i].text, projectgroup[y][i].value);
                                                temp1.options[0].selected = true;
                                            }

                                            // -->
                                        </script>
                                        <BR>
                                            <!-- Table To Display The Footer That Contains Terms Of Use And The Contact Email Address -->
                                            </body>
                                            </html>
