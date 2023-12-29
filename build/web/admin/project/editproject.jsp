<%@page import="java.math.BigDecimal"%>
<%@page import="com.pack.ApmTargetIssueCount"%>
<%@page import="com.eminent.issue.ApmTeam"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="com.eminent.issue.controller.MaintainWRMDay,com.pack.ChangeFormat,org.apache.log4j.*,java.util.*,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjects"%>
<%
    Logger logger = Logger.getLogger("Edit Project");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">-->
<!doctype html public "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
            <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=12346"	type="text/css" rel=STYLESHEET>
                <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
                <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
                <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
                <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
                <script type="text/javascript">

                    function trim(str) {
                        while (str.charAt(str.length - 1) === " ")
                            str = str.substring(0, str.length - 1);
                        while (str.charAt(0) === " ")
                            str = str.substring(1, str.length);
                        return str;
                    }
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
                                alert('This selection includes the PM. So change the PM')
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
                            xmlhttp.onreadystatechange = function () {
                                callbackUserName(name);
                            }
                            xmlhttp.send(null);
                        }
                    }


                    function callbackUserName(name)
                    {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {

                                var nameoftheuser = xmlhttp.responseText.split(",");
                                var m2 = document.theForm.teamFinal;
                                teamFinalLength = m2.length;
                                var pM = document.getElementById(name).value;
                                m2.options[teamFinalLength] = new Option(nameoftheuser[1], pM);
                            }
                        }
                    }



                    function totalHours()
                    {
                        xmlhttp = createRequest();
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
                                var name = xmlhttp.responseText;
                                var results = xmlhttp.responseText.split(",");
                                document.getElementById('totalhours').value = results[1];
                            }
                        }

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
                        //edit by sowjanya
                        var domainValues = document.getElementById("domain_name").value;
                        var pid = "<%=request.getParameter("pid")%>";
                        //Edit end by sowjnaya
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest !== 'undefined')
                        {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp !== null)
                        {
                            var opt = document.theForm.team;
                            var numofoptions = opt.length;
                            var selValue;

                            for (i = 0; i < numofoptions; i++)
                            {
                                if (opt[i].selected === true)
                                {
                                    //Edit by sowjanya
                                    selValue = opt[i].value;

                                }
                            }
                            //   selValue = selValue.join(",");


                            if (domainValues.length > 0 && selValue.length > 0) {

                                xmlhttp.open("GET", "getTeamMembers.jsp?selValue=" + selValue + "&pid=" + pid + "&domainValues= " + domainValues + "&rand=" + Math.random(1, 10), true);

                                xmlhttp.onreadystatechange = callbackTeam;
                                xmlhttp.send(null);
                            } else if (selValue.length > 0) {
                                xmlhttp.open("GET", "getTeamMembers.jsp?selValue=" + selValue + "&pid=" + pid + "&rand=" + Math.random(1, 10), true);

                                xmlhttp.onreadystatechange = callbackTeam;
                                xmlhttp.send(null);
                            }
                        }
                    }
                    //Edit end by sowjanya
                    function callbackTeam()
                    {

                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var results = xmlhttp.responseText.split(";");
                                var objLinkList = eval("document.theForm.teamSelect");
                                objLinkList = eval("document.getElementById('teamSelect')");
                                objLinkList.length = 0;
                                //                alert("results"+results)
                                for (i = 0; i < results.length - 1; i++)
                                {
                                    var select = results[i].split(",");
                                    objLinkList.length++;
                                    //                      alert((select[0]));
                                    //                      alert((select[1]));
                                    objLinkList[i].text = (select[0]);
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

                    function trim(str)
                    {
                        while (str.charAt(str.length - 1) === " ")
                            str = str.substring(0, str.length - 1);
                        while (str.charAt(0) === " ")
                            str = str.substring(1, str.length);
                        return str;
                    }
                    function isNumber(str) {
                        var pattern = "0123456789."
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

                    /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

                    function isPositiveInteger(str) {
                        var pattern = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKL'MNOPQRSTUVWXYZ.-"
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
                        var pattern = "abcdefghijklmnopqrstuvwxyz. ABCDEFGHIJKLMNOPQRSTUVWXYZ - 1234567890";
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

                    /** Function To Validate The Input Form Data */

                    function fun(theForm)
                    {
                        /** This Loop Checks Whether There Is Any Input Data Present In The Project Manager Field */

                        if ((theForm.customer.value) === '')
                        {
                            alert('Please enter the Customer Name ');
                            theForm.customer.focus();
                            return false;
                        }

                        if ((theForm.customer.value.length) < 2)
                        {
                            alert('Please enter the valid Customer Name ');
                            theForm.customer.focus();
                            return false;
                        }

                        if ((theForm.platform.value) === '')
                        {
                            alert('Please enter the platform name ');
                            document.theForm.platform.value = "";
                            theForm.platform.focus();
                            return false;
                        }
                        if (!isPositiveInteger1(trim(theForm.platform.value)))
                        {
                            alert('Please enter the Alphabetical only in the platform ');
                            document.theForm.platform.value = "";
                            theForm.platform.focus();
                            return false;
                        }

                        if ((document.getElementById("platform").value === "Others") && !isPositiveInteger(trim(theForm.platform.value)))
                        {
                            alert('Please enter the Alphabetical only in the Platform ');
                            document.theForm.platform.value = "";
                            theForm.platform.focus();
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
                        if (!isPositiveInteger(theForm.pname.value))
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
                            alert('Please enter the Version Info');
                            document.theForm.versionInfo.value = "";
                            theForm.versionInfo.focus();
                            return false;
                        }
                        if ((theForm.versionInfo.value.indexOf('0')) === 0)
                        {
                            alert('Please enter the Valid Version Info ');
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




                        /** This Loop Checks Whether There Is Any Input Data Present In The Project Manager Field */
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
                            alert('Please enter the Project Manager name');
                            theForm.deliveryManager.focus();
                            return false;
                        }

                        if ((document.getElementById("projectManager").value) === "--Select Manager--")
                        {
                            alert('Please enter the Project Manager name');
                            theForm.projectManager.focus();
                            return false;
                        }


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
                            alert('Please enter the Start date ');
                            theForm.startdate.focus();
                            return false;
                        }


                        if ((theForm.enddate.value) === '')
                        {
                            alert('Please enter the enddate ');
                            theForm.enddate.focus();
                            return false;
                        }
                        if (end_date < form_date)
                        {
                            alert('Please enter the valid End Date');
                            theForm.enddate.focus();
                            return false;
                        }

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
                        if ((theForm.totalhours.value) === '')
                        {
                            alert('Please enter the Total Hours ');
                            theForm.totalhours.focus();
                            return false;
                        }


                        if (!isNumber(trim(theForm.totalhours.value)))
                        {
                            alert('Please enter a Numerical value only in the "total hours" box');
                            document.theForm.totalhours.value = "";
                            theForm.totalhours.focus();
                            return false;
                        }
                        if (document.getElementById("phase").value === "--Select Status--")
                        {
                            alert("Please select Status.");
                            return false;
                        }
                        if (document.getElementById("wrmday").value === "0")
                        {
                            alert("Please select WRM Day.");
                            return false;
                        }

                        var startHour = document.getElementById("startH").value;
                        var startMinute = document.getElementById("startM").value;
                        var startSecond = "00";
                        var endHour = document.getElementById("endH").value;
                        var endMinute = document.getElementById("endM").value;
                        var endSecond = "00";
                        //Create date object and set the time to that
                        var startTimeObject = new Date();
                        startTimeObject.setHours(startHour, startMinute, startSecond);
                        //Create date object and set the time to that
                        var endTimeObject = new Date(startTimeObject);
                        endTimeObject.setHours(endHour, endMinute, endSecond);
                        if ((startHour) * 1 < 6)
                        {
                            alert("Please select Valid WRM Start Time.");
                            return false;
                        }
                        if ((endHour) * 1 < 6)
                        {
                            alert("Please select Valid WRM Start Time.");
                            return false;
                        }
                        if (startTimeObject > endTimeObject) {
                            alert("WRM Start Time should not be greater than WRM End Time.");
                            return false;
                        }

                        var tCount = document.getElementById("targetCount").value;
                        var oCount = document.getElementById("openIssues").value;
                        var targetCount = new Number(tCount);
                        var OpenCount = new Number(oCount);
                        if (targetCount > OpenCount) {
                            alert("Target Issue Count should not be greater than Open Issue Count. Please enter the value less then " + targetCount);
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
                        if (teamFinalOLength < 1)
                        {
                            alert("No Selections in the team\nPlease Select using the [Add] button");
                            return false;
                        }
                        for (var i = 0; i < teamFinalOLength; i++)
                        {
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
                    }

                    /** Function To Set Focus On The Project Name Field In The Form */


                </SCRIPT>
                <body onload="isCorrectEndDate();">
                    <jsp:include page="/header.jsp" />
                    <jsp:useBean id="mwd" class="com.eminent.issue.controller.MaintainWRMDay"></jsp:useBean>
                    <jsp:useBean id="pu" class="com.eminent.projectuser.DetailsDAO"/>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr bgcolor="#C3D9FF">
                            <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>
                                        Edit Project</b> </font><FONT SIZE="3" COLOR="#0000FF"> <a href="#" id="server">Server Maintenance</a><a style="display: none;" href="#" id="assignExceeds">Assignment Exceeds Maintenance</a></FONT></td>
                        </tr>
                    </table>
                    <div class="addTargetCount " style="display: none;">
                        <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 10% auto;"/>
                        <div>
                        </div>
                    </div>
                    <br/>

                    <br>
                        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"></jsp:useBean>
                        <jsp:useBean id="apmEditController" class="com.pack.controller.ViewModulesController"></jsp:useBean>

                            <FORM name=theForm onsubmit="return fun(this);" action="<%=request.getContextPath()%>/admin/project/projectupdate.jsp"	method=post>
                            <%@ page import="java.sql.*,pack.eminent.encryption.*"%>
                            <%
                                apmEditController.getAllEditProject(request);
                                int roleId = (Integer) session.getAttribute("Role");
                                if (roleId == 1) {
                                    Connection connection = null;
                                    ResultSet rs = null;
                                    Statement st = null, st4 = null;
                                    PreparedStatement ps1 = null, ps2 = null, ps3 = null;
                                    ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
                                    String category = "";
                                    String pname = "";
                                    int pmanager = 0;
                                    int esopnsorer = 0;
                                    int pstakeholder = 0;
                                    int pcoordinator = 0;
                                    int amanager = 0;
                                    int dmanager = 0;
                                    String platform = "";
                                    String version = "";
                                    String customer = "";
                                    String startdate = "";
                                    String enddate = "";
                                    String phase = "", wrmDay = "";
                                    int starth = 0, startm = 0, endh = 0, endm = 0;
                                    String type = null;
                                    String projectStatus = null;
                                    String deliverables = null;
                                    int totalhours = 0;
                                    int pid = Integer.parseInt(request.getParameter("pid"));
                                    String projectDomain = "";
                                    String[] status = {"To be started", "Work in progress", "Aborted", "Finished"};
                                    try {
                                        HashMap pm = GetProjectMembers.getTeamMembersByProject(pid);
                                        pm.putAll(GetProjectMembers.getEminentUsers());
                                        pm = GetProjectMembers.sortHashMapByValues(pm, true);
                                        HashMap am = (HashMap) pm.clone();
                                        HashMap es = (HashMap) pm.clone();
                                        HashMap ps = (HashMap) pm.clone();
                                        HashMap pc = (HashMap) pm.clone();
                                        HashMap dm = (HashMap) pm.clone();

                                        // ApmTargetIssueCount atic = GetProjects.getTargetCount(pid);
                                        int openIssues = GetProjects.getOpenIssues(pid);
                                        connection = MakeConnection.getConnection();
                                        if (connection != null) {
                                            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            //Edit By sowjnaya
                                            rs = st.executeQuery("SELECT pname,pmanager,amanager,dmanager,sponsorer,coordinator,stakeholder,version,platform,customer,category,startdate,enddate,totalhours,phase,status,deliverables,wrm_day,starttimeh,starttimem,endtimeh,endtimem,project_domain from project where pid=" + pid + " order by pid");
                                            if (rs != null) {
                                                while (rs.next()) {
                                                    category = rs.getString("category");
                                                    pname = rs.getString("pname");
                                                    pmanager = rs.getInt("pmanager");
                                                    amanager = rs.getInt("amanager");
                                                    dmanager = rs.getInt("dmanager");
                                                    esopnsorer = rs.getInt("sponsorer");
                                                    pstakeholder = rs.getInt("stakeholder");
                                                    pcoordinator = rs.getInt("coordinator");
                                                    platform = rs.getString("platform");
                                                    version = rs.getString("version");
                                                    customer = rs.getString("customer");
                                                    startdate = rs.getString("startdate");
                                                    enddate = rs.getString("enddate");
                                                    phase = rs.getString("phase");
                                                    totalhours = rs.getInt("totalhours");
                                                    projectStatus = rs.getString("status");
                                                    deliverables = rs.getString("deliverables");
                                                    wrmDay = rs.getString("wrm_day");
                                                    starth = rs.getInt("starttimeh");
                                                    endh = rs.getInt("endtimeh");
                                                    startm = rs.getInt("starttimem");
                                                    endm = rs.getInt("endtimem");
                                                    //Edit by sowjanya
                                                    projectDomain = rs.getString("project_domain");
                                                    if (projectDomain == null) {
                                                        projectDomain = "";
                                                    }//Edit end by sowjanya
                                                    logger.info("Category" + category);

                                                    session.setAttribute("editPname", pname);
                                                    session.setAttribute("editVersion", version);
                            %>
                            <TABLE width="100%" bgColor=#E8EEF7 border="0" align="center" style="margin-left:auto;margin-right:auto">
                                <TBODY>
                                    <tr>


                                        <td width="15%"><strong>Customer</strong></td>
                                        <td><input type="text" name="customer" id="customer" maxlength="70" size=25
                                                   value="<%=customer%>"><input type="hidden" name="pid" id="pid" value="<%=pid%>"></td>
                                                    <td width="15%"><strong>Category</strong></td>
                                                    <td><input type="text" id="category" name="category" maxlength="30" size=25
                                                               value="<%=category%>"></td>
                                                    <td width="15%"><strong>Status</strong></td>
                                                    <td><input type="hidden" id="platform" name="platform" maxlength="20" size=25 value="<%=platform%>">
                                                            <select NAME="status" id="status" size="1">

                                                                <%
                                                                    for (int i = 0; i < status.length; i++) {
                                                                        if (projectStatus.equals(status[i])) {

                                                                %>

                                                                <option value="<%= projectStatus%>" selected><%= projectStatus%></option>
                                                                <%
                                                                } else {

                                                                %>
                                                                <option value="<%= status[i]%>"><%= status[i]%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select>

                                                    </td>

                                                    </tr>
                                                    <tr>
                                                        <td width="15%"><strong>Project Name </strong></td>
                                                        <td><input type="text" name="pname" id="pname" maxlength="20" size=25
                                                                   value="<%=pname%>" onblur="javascript:duplicateProject();"> <strong class="style20"></strong><input
                                                                    type="hidden" name="category" id="category" value="<%=category%>"></td>

                                                                    <td width="15%"><strong>Version Info </strong></td>
                                                                    <td><input type="text" id="versionInfo" name="versionInfo" maxlength="15" size=25
                                                                               value="<%=version%>" onblur="javascript:duplicateProject();"> <span class="style13"></span></td>
                                                                        <%
                                                                            String[] productphaseExist = {"To be started", "Requirment gathering", "Design Documentation", "Database Design", "User Unterface",
                                                                                "File names and flow review", "Development", "Testing", "Finished", "User Acceptance Testing", "Production",
                                                                                "Maintenance", "End of Life", "Closed", "Suspended", "Pilot Demo"};
                                                                            String[] projectimplExist = {"Project Preparation", "Business Blueprint", "Realization", "Final Preparation", "Go Live and support"};
                                                                            String[] projectupgradeExist = {"Project Preparation", "Upgrade Blueprint", "Upgrade Realization", "Final Preparation for Cutover", "Production Cutover and Support"};
                                                                            String[] projectsupportExist = {"Project Preparation", "Support Blueprint", "Support Realization", "Final Preparation for Cutover", "Maintenence and edcuating end users"};

                                                                        %>
                                                                    <td width="10%"><strong>Project Phase</strong></td>
                                                                    <td align="left" width="20%"><SELECT NAME="phase" id="phase" size="1">

                                                                            <%                                                                                            if (category.equals("Product") || category.equals("Outsource") || category.equals("Project")) {
                                                                                    logger.info("Inside Product,Project,Outsource loop");

                                                                                    for (int i = 0; i < productphaseExist.length; i++) {
                                                                                        if (phase.equals(productphaseExist[i])) {

                                                                            %>

                                                                            <option value="<%= phase%>" selected><%= phase%></option>
                                                                            <%
                                                                            } else {

                                                                            %>
                                                                            <option value="<%= productphaseExist[i]%>"><%= productphaseExist[i]%></option>
                                                                            <%
                                                                                    }
                                                                                }

                                                                            } else if (category.equals("SAP Project")) {
                                                                                logger.info("Inside Sap Project loop");

                                                                                ps3 = connection.prepareStatement("SELECT type FROM project_type WHERE pid=?");
                                                                                ps3.setInt(1, pid);
                                                                                rs3 = ps3.executeQuery();

                                                                                if (rs3 != null) {
                                                                                    while (rs3.next()) {
                                                                                        type = rs3.getString("type");
                                                                                    }
                                                                                    LinkedHashMap phaseDetails = GetProjects.getProjectPhases(type);
                                                                                    Collection se = phaseDetails.keySet();
                                                                                    Iterator iter = se.iterator();
                                                                                    int currentPhaseId = 0;
                                                                                    while (iter.hasNext()) {

                                                                                        int phaseid = (Integer) iter.next();
                                                                                        String phasename = (String) phaseDetails.get(phaseid);
                                                                                        logger.info("Phase Id-->" + phaseid);
                                                                                        logger.info("Name-->" + phasename);

                                                                                        if (phasename.equalsIgnoreCase(phase)) {
                                                                                            currentPhaseId = phaseid;
                                                                            %>
                                                                            <option value="<%=phasename%>" selected><%=phasename%></option>
                                                                            <%
                                                                            } else {
                                                                                if (currentPhaseId > 0) {
                                                                            %>
                                                                            <option value="<%=phasename%>"><%=phasename%></option>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <option value="<%=phasename%>" disabled><%=phasename%></option>
                                                                            <%
                                                                                            }
                                                                                        }

                                                                                    }

                                                                                }
                                                                            %>
                                                                        </SELECT> <%
                                                                            }
                                                                        %>
                                                                    </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td width="20%"><strong>Executive Sponsorer</strong></td>
                                                                        <td>
                                                                            <select name="executiveSponsorer" id="executiveSponsorer" size="1" onchange="addPM('executiveSponsorer');">
                                                                                <option value="--Select Manager--" selected>--Select Executive Sponsorer--</option>
                                                                                <%
                                                                                    Collection setES = es.keySet();
                                                                                    Iterator iterES = setES.iterator();
                                                                                    while (iterES.hasNext()) {
                                                                                        int key = (Integer) iterES.next();
                                                                                        String nameofuser = (String) es.get(key);
                                                                                        if (key == esopnsorer) {
                                                                                %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </td>

                                                                        <td width="15%"><strong>Project Stakeholder</strong></td>
                                                                        <td>
                                                                            <select name="projectStakeholder" id="projectStakeholder" size="1" onchange="addPM('projectStakeholder');">
                                                                                <option value="--Select Manager--" selected>--Select Project Stakeholder--</option>
                                                                                <%
                                                                                    Collection setPS = ps.keySet();
                                                                                    Iterator iterPS = setPS.iterator();
                                                                                    while (iterPS.hasNext()) {
                                                                                        int key = (Integer) iterPS.next();
                                                                                        String nameofuser = (String) ps.get(key);
                                                                                        if (key == pstakeholder) {
                                                                                %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </td>

                                                                        <td width="15%"><strong>Project Coordinator</strong></td>
                                                                        <td>
                                                                            <select name="projectCoordinator" id="projectCoordinator" size="1" onchange="addPM('projectCoordinator');">
                                                                                <option value="--Select Manager--" selected>--Select Project Coordinator--</option>
                                                                                <%
                                                                                    Collection setPC = pc.keySet();
                                                                                    Iterator iterPC = setPS.iterator();
                                                                                    while (iterPC.hasNext()) {
                                                                                        int key = (Integer) iterPC.next();
                                                                                        String nameofuser = (String) pc.get(key);
                                                                                        if (key == pcoordinator) {
                                                                                %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="15%"><strong>Account Manager</strong></td>
                                                                        <td>
                                                                            <select name="accountManager" id="accountManager" size="1" onchange="addPM('accountManager');">
                                                                                <option value="--Select Manager--" selected>--Select Account Manager--</option>
                                                                                <%
                                                                                    Collection setAM = am.keySet();
                                                                                    Iterator iterAM = setAM.iterator();
                                                                                    while (iterAM.hasNext()) {
                                                                                        int key = (Integer) iterAM.next();
                                                                                        String nameofuser = (String) am.get(key);
                                                                                        if (key == amanager) {
                                                                                %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </td>

                                                                        <td width="15%"><strong>Delivery Manager</strong></td>
                                                                        <td>
                                                                            <select name="deliveryManager" id="deliveryManager" size="1" onchange="addPM('deliveryManager');">
                                                                                <option value="--Select Manager--" selected>--Select Delivery Manager--</option>
                                                                                <%
                                                                                    Collection setDM = dm.keySet();
                                                                                    Iterator iterDM = setDM.iterator();
                                                                                    while (iterDM.hasNext()) {
                                                                                        int key = (Integer) iterDM.next();
                                                                                        String nameofuser = (String) dm.get(key);
                                                                                        if (key == dmanager) {
                                                                                %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </td>

                                                                        <td width="15%"><strong>Project Manager</strong></td>
                                                                        <%
                                                                            String name = null;
                                                                        %>
                                                                        <td><select name="projectManager" id="projectManager" size="1" onchange="addPM('projectManager');">
                                                                                <option value="--Select Manager--" selected>--Select Project
                                                                                    Manager--</option>
                                                                                    <%
                                                                                        Collection setPM = pm.keySet();
                                                                                        Iterator iterPM = setPM.iterator();
                                                                                        while (iterPM.hasNext()) {
                                                                                            int key = (Integer) iterPM.next();
                                                                                            String nameofuser = (String) pm.get(key);
                                                                                            if (key == pmanager) {
                                                                                    %>
                                                                                <option value="<%=key%>" selected><%=nameofuser%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=key%>"><%=nameofuser%></option>
                                                                                <%
                                                                                        }
                                                                                    }
                                                                                %>
                                                                            </select></td>

                                                                    </tr>


                                                                    <%
                                                                        String duedates[][] = GetProjects.phaseDates(((Integer) pid).toString());
                                                                        if (type != null && duedates.length > 0) {
                                                                    %>
                                                                    <tr id="header" >
                                                                        <td> <b>Project Phase</b></td>
                                                                        <td align="center"><b>Phase Start Date</b></td>
                                                                        <td align="left"><b>Actual Start Date</b></td>
                                                                        <td align="center"><b>Phase End Date</b></td>
                                                                        <td align="left"><b>Actual End Date</b></td>
                                                                        <td align="center"><b>Total Hours</b></td>
                                                                    </tr>
                                                                    <%
                                                                        for (int i = 0; i < duedates.length; i++) {
                                                                            String prjphase = duedates[i][0];
                                                                            String plstartdate = duedates[i][1];
                                                                            if (plstartdate == null) {
                                                                                plstartdate = "NA";
                                                                            } else {
                                                                                plstartdate = ChangeFormat.getDate(plstartdate);
                                                                            }
                                                                            String acstartdate = duedates[i][2];
                                                                            if (acstartdate == null) {
                                                                                acstartdate = "NA";
                                                                            } else {
                                                                                acstartdate = ChangeFormat.getDate(acstartdate);
                                                                            }
                                                                            String plenddate = duedates[i][3];
                                                                            if (plenddate == null) {
                                                                                plenddate = "NA";
                                                                            } else {
                                                                                plenddate = ChangeFormat.getDate(plenddate);
                                                                            }
                                                                            String acenddate = duedates[i][4];
                                                                            if (acenddate == null) {
                                                                                acenddate = "NA";
                                                                            } else {
                                                                                acenddate = ChangeFormat.getDate(acenddate);
                                                                            }
                                                                            String totHrs = duedates[i][5];
                                                                            if (totHrs == null) {
                                                                                totHrs = "NA";
                                                                            }

                                                                    %>
                                                                    <tr >
                                                                        <td><b><input type="hidden" name="firstPhase" value="Project Preparation"/><%=prjphase%></b></td>
                                                                        <td><input type="Text" name="impstartdate1" id="impstartdate1" value="<%=plstartdate%>" readonly="true" maxlength="25" size="25"/></td>
                                                                        <td><input type="Text" name="impstartdate1" id="impstartdate1" value="<%=acstartdate%>" readonly="true" maxlength="25" size="15"/></td>
                                                                        <td><input type="Text" name="impenddate1" id="impenddate1" value="<%=plenddate%>" readonly="true" maxlength="25" size="25" /></td>
                                                                        <td><input type="Text" name="impstartdate1" id="impstartdate1" value="<%=acenddate%>" readonly="true" maxlength="25" size="15"/></td>
                                                                        <td><input type="text" id="imptotalhours1" name="imptotalhours1" value="<%=totHrs%>" maxlength="30" size=25 /></td>
                                                                    </tr>
                                                                    <%
                                                                            }

                                                                        }
                                                                        String newstartdate = ChangeFormat.getDate(startdate);
                                                                        String newenddate = ChangeFormat.getDate(enddate);
                                                                    %>
                                                                    <tr>
                                                                        <td width="15%"><strong>Start Date</strong></td>
                                                                        <td><input type="text" name="startdate" id="startdate" maxlength="25" size="25"
                                                                                   readonly="true" value="<%=newstartdate%>"></td>

                                                                        <td width="15%"><strong>End Date</strong></td>
                                                                        <td><input type="text" id="enddate" name="enddate" maxlength="25" size="25"
                                                                                   readonly="true" value="<%=newenddate%>">&nbsp<a
                                                                                    href="javascript:NewCal('enddate','ddmmyyyy')"><img
                                                                                        src="images/newhelp.gif" width="16" height="16" border="0"
                                                                                        alt="Pick a date"></a></td>

                                                                        <td width="15%"><strong>Total Hours</strong></td>
                                                                        <td><input type="text" name="totalhours" id="totalhours" maxlength="30" size=25
                                                                                   value="<%=totalhours%>" onClick="javascript:totalHours();"></td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td><b>WRM Day</b></td>
                                                                        <td>
                                                                            <select name="wrmday" id="wrmday">

                                                                                <%
                                                                                    int day = 0;//default value is -1

                                                                                    if (wrmDay != null) {
                                                                                        day = Integer.parseInt(wrmDay);
                                                                                    }

                                                                                    for (Map.Entry<Integer, String> entrya : mwd.days().entrySet()) {
                                                                                        if (day == entrya.getKey()) {
                                                                                %>
                                                                                <option value="<%=entrya.getKey()%>" selected=""><%=entrya.getValue()%></option>
                                                                                <%} else {%>
                                                                                <option value="<%=entrya.getKey()%>" ><%=entrya.getValue()%></option>
                                                                                <%}
                                                                                    }%>
                                                                            </select>

                                                                        </td>
                                                                        <td style="font-weight: bold;">WRM Start Time</td>

                                                                        <td><select name="startH" id="startH" >
                                                                                <%
                                                                                    String val = "";
                                                                                    for (int i = 0; i < 20; i++) {
                                                                                        val = String.valueOf(i);
                                                                                        if (i < 10) {
                                                                                            val = "0" + val;
                                                                                        }
                                                                                        if (i == starth) {


                                                                                %>
                                                                                <option value="<%=val%>" selected><%=val%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=val%>"><%=val%></option>
                                                                                <%}
                                                                                    }%>
                                                                            </select><select name="startM" id="startM" >
                                                                                <%for (int i = 0; i < 60; i++) {
                                                                                        val = String.valueOf(i);
                                                                                        if (i < 10) {
                                                                                            val = "0" + val;
                                                                                        }
                                                                                        if (i == startm) {
                                                                                %>
                                                                                <option value="<%=val%>" selected><%=val%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=val%>"><%=val%></option>
                                                                                <%}
                                                                                    }%>
                                                                            </select></td>
                                                                        <td style="font-weight: bold;">WRM End Time</td>

                                                                        <td><select name="endH" id="endH">
                                                                                <%for (int i = 0; i < 20; i++) {
                                                                                        val = String.valueOf(i);
                                                                                        if (i < 10) {
                                                                                            val = "0" + val;
                                                                                        }
                                                                                        if (i == endh) {
                                                                                %>
                                                                                <option value="<%=val%>" selected><%=val%></option>
                                                                                <%
                                                                                } else {

                                                                                %>
                                                                                <option value="<%=val%>"><%=val%></option>
                                                                                <%}
                                                                                    }%>
                                                                            </select><select name="endM" id="endM" >
                                                                                <%for (int i = 0; i < 60; i++) {
                                                                                        val = String.valueOf(i);
                                                                                        if (i < 10) {
                                                                                            val = "0" + val;
                                                                                        }
                                                                                        if (i == endm) {
                                                                                %>
                                                                                <option value="<%=val%>" selected><%=val%></option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="<%=val%>"><%=val%></option>
                                                                                <%}
                                                                                    }%>
                                                                            </select></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <input type="hidden" name="openIssues" id="openIssues"  size=4 value="<%=openIssues%>"/>      </td>
                                                                        <td ><strong>Target Count</strong></td>
                                                                        <td ><input type="text" name="targetCount" id="targetCount"  size=4 value="<%=apmEditController.getTotalNoOFTarget()%>" readonly="true"/> 
                                                                            <%--edit by sowjnaya--%>
                                                                            <td><strong>Domains</strong><td id="titledomain" title="<%=projectDomain%>"><input type="text" name="domain_name" class="moduleTarget" id="domain_name" maxlength="200" value="<%=projectDomain%>" readonly="true" ></td></td>
                                                                                <%--edit end by sowjanya--%>
                                                                                <%-- Added By sowjanya--%>
                                                                                <% String showdetails = "";
                                                                                    showdetails = pu.getShowDetails(BigDecimal.valueOf(Long.valueOf(pid)));

                                                                                %>
                                                                            <td><strong>Contact Details:</strong></td>
                                                                            <td><input type="checkbox" name="details" value="true"<% if (showdetails.contains("true")) {%> checked="true" <%}%>/></td>

                                                                            <%-- Added By sowjanya--%>

                                                                    </tr>
                                                                    <%
                                                                        if (deliverables != null) {
                                                                    %>

                                                                    <td width="15%"><strong>Deliverables</strong></td>
                                                                    <td colspan="3"><%=deliverables%><span class="refer"></span></td>

                                                                    <%
                                                                        }
                                                                    %>
                                                                    <tr>
                                                                        <td width="10%"><strong>Team</strong></td>
                                                                        <td><SELECT id="team" NAME="team" onChange="javascript:selectteams();" style="width: 200px;" width="200"
                                                                                    size="6">
                                                                                <% for (ApmTeam apmTeam : atc.findAllTeams()) {%>
                                                                                <option value="<%=apmTeam.getTeamName()%>"><%=apmTeam.getTeamName()%></option>
                                                                                <%}%>
                                                                            </SELECT></td>
                                                                        <td></td>
                                                                        <td align="center"><select id="teamSelect" name=teamSelect style="width: 200px;"
                                                                                                   width="200" size="8" multiple>
                                                                            </select>


                                                                        </td>
                                                                        <td>
                                                                            <p align="center"><input type="button" onClick="one2two();" 	value=" >> "></p>
                                                                            <p align="center"><input type="button" onClick="two2one();" 	value=" << "></p>
                                                                        </td>
                                                                        <td align="center">
                                                                            <%  //edit by sowjanya
                                                                                String fullname = "", fname = "", lname = "", allIds = "";
                                                                                st4 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                                rs4 = st4.executeQuery("SELECT userid,FIRSTNAME,LASTNAME,USERID,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON from users where roleid=" + -2 + " order by lower(firstname) asc");
                                                                                rs4.last();
                                                                                rs4.beforeFirst();
                                                                                while (rs4.next()) {
                                                                                    //  fname = rs4.getString("firstname");
                                                                                    //  lname = rs4.getString("lastname");
                                                                                    //  fullname = fname + " " + lname;
                                                                                    allIds = allIds + "," + rs4.getString(1);
                                                                                    //allnames = allnames + "," + fullname;
                                                                                }
                                                                                //edit end by sowjanya
                                                                                int teamFinal = 0;
                                                                                String f2 = "";
                                                                                String l2 = "";
                                                                                String full2 = "";
                                                                                //edited by sowjanya
                                                                                ps1 = connection.prepareStatement("select u.userid from userproject up, users u  where up.pid=? and u.userid=up.userid ORDER BY lower(firstname) asc");
                                                                                ps1.setInt(1, pid);
                                                                                rs1 = ps1.executeQuery();
                                                                            %> <select id=teamFinal
                                                                                    name=teamFinal style="width: 200px;" width="200" size="8" multiple>
                                                                                <%String AllNames[] = allIds.split(",");
                                                                                    if (rs1 != null) {
                                                                                        while (rs1.next()) {
                                                                                            teamFinal = rs1.getInt(1);
                                                                                            boolean s = Arrays.asList(AllNames).contains(teamFinal);
                                                                                            if (s == false) {

                                                                                                ps2 = connection.prepareStatement("select distinct firstname||' '||lastname as fullname from users where userid=? order by fullname asc");
                                                                                                ps2.setInt(1, teamFinal);
                                                                                                rs2 = ps2.executeQuery();//CORRECT
                                                                                                while (rs2.next()) {
                                                                                                    // f2 = rs2.getString("firstname");
                                                                                                    // l2 = rs2.getString("lastname");
                                                                                                    // full2 = f2 + " " + l2;
                                                                                                    full2 = rs2.getString("fullname");
                                                                                                    //    boolean s = Arrays.asList(AllNames).contains(teamFinal);
                                                                                                    //  System.out.print(full2+"comaprision with"+Arrays.asList(AllNames).contains(full2)+",s value is:"+s);
                                                                                                    // if (s == false) { //edit end by sowjanya
%>
                                                                                <option value="<%= teamFinal%>"><%=full2%></option>
                                                                                <%
                                                                                                }
                                                                                            }
                                                                                            if (rs2 != null) {
                                                                                                rs2.close();
                                                                                            }
                                                                                            if (ps2 != null) {
                                                                                                ps2.close();
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    if (rs1 != null) {
                                                                                        rs1.close();
                                                                                    }
                                                                                    if (ps1 != null) {
                                                                                        ps1.close();
                                                                                    }

                                                                                %>
                                                                            </select>


                                                                        </td>
                                                                    </tr>



                                                                    <tr>
                                                                        <td width="12%" align="left">
                                                                            <b>Comments</b>
                                                                        </td>


                                                                        <td colspan="4">
                                                                            <textarea
                                                                                name="comments" wrap="physical" cols="84" rows="2"
                                                                                onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"
                                                                                onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"></textarea>
                                                                            <script type="text/javascript">
                                                                                CKEDITOR.replace('comments', {height: 100});
                                                                                var editor_data = CKEDITOR.instances.comments.getData();
                                                                                CKEDITOR.instances["comments"].on("instanceReady", function ()
                                                                                {

                                                                                    //set keyup event
                                                                                    this.document.on("keyup", updateExpectedResult);
                                                                                    //and paste event
                                                                                    this.document.on("paste", updateExpectedResult);
                                                                                });
                                                                                function updateExpectedResult()
                                                                                {
                                                                                    CKEDITOR.tools.setTimeout(function ()
                                                                                    {
                                                                                        var desc = CKEDITOR.instances.comments.getData();
                                                                                        var leng = desc.length;
                                                                                        editorTextCounter(leng, document.theForm.remLen1, 2000);
                                                                                    }, 0);
                                                                                }

                                                                            </script>



                                                                            <input readonly type="text" name="remLen1"
                                                                                   size="3" maxlength="4" value="2000">
                                                                        </td>
                                                                    </tr>


                                                                    <tr>
                                                                        <TD>&nbsp;</TD>
                                                                        <TD>&nbsp;</TD>
                                                                        <TD align="right"><INPUT type=submit id="submit" value=Update name=submit></TD>
                                                                        <TD align="left">	<INPUT type=reset id="reset" value=" Reset "></TD>
                                                                        <TD><input type="hidden" name="currentphase" value="<%=phase%>">&nbsp;</TD>
                                                                        <TD>&nbsp;</TD>
                                                                    </tr>               
                                                                    </TBODY>
                                                                    </TABLE>
                                                                    <div>
                                                                        <iframe src="projectComments.jsp?pid=<%= pid%>" scrolling="auto" frameborder="2" h width="100%"></iframe>
                                                                    </div>
                                                                    <%--edit by sowjanya--%>
                                                                    <div id="overlay"></div>

                                                                    <div id="TSISSUEpopup" class="popup" style="width:50%;height: 50%;">
                                                                        <h3 class="popupHeading">Issue Assignment Exceeds Mail </h3>
                                                                        <div>
                                                                            <div class="tableshow">
                                                                                <div class="mid" id="popupIssueList">
                                                                                </div>

                                                                                <div>
                                                                                    <input type="button" class="assignment ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Submit" />
                                                                                    <input type="button" class="assignmentClose ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"  value="Close"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div id="MDAVpopup" class="popup">
                                                                        <h3 class="popupHeading">Manage Servers</h3>
                                                                        <div>
                                                                            <div class="clear"></div>
                                                                            <div class="tableshow">
                                                                                <div class="mid" id="MDAVpopupServer">

                                                                                </div>
                                                                                <input type="button" class="escBut ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Submit" />
                                                                                <input type="button" class="newserver ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Add Server" />
                                                                                <button class="custom-popup-close" onclick="closeMDVAPopup();"   type="button">close</button>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="addServer" class="popup" style="display: none;">
                                                                        <form name="theheForm" id="theheForm" method="post" >

                                                                            <div>
                                                                                <p><input type="button" class="addservertype ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"   value="Add Server Type" > &nbsp;&nbsp;&nbsp;</p>
                                                                                <hr />

                                                                                <table id="monitor">
                                                                                    <tr><td>Server Type</td></tr>
                                                                                    <tr>
                                                                                        <td><input type="text" name="server"/></td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td colspan="2" align="right">

                                                                                            <input type="button" class="addserversubmit ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Submit" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>

                                                                        </form>
                                                                    </div>



                                                                    <div id="domainpopup" class="popup">
                                                                        <form name="theheForm" id="theheForm" method="post" >

                                                                            <div >
                                                                                <p id="myElem" style="color:green;display: none">Domains are added successfully</p>
                                                                                <div style="color:red;display: none;" id="errormsg">Please enter the correct domain name with out duplicate</div>
                                                                                <p><input type="button" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"   value="Add Domain"  onclick="javascript:incrDomain();"> &nbsp;&nbsp;&nbsp;</p>
                                                                                <hr />
                                                                                <!-- Update form action -->
                                                                                <table id="domaintable" >
                                                                                    <tr id="id0" style="font-weight: bold;">
                                                                                        <td width='25px' >Sl. N</td>
                                                                                        <td >Domain Name</td>
                                                                                    </tr>
                                                                                    <tr id="id1" style="height: 20px;">
                                                                                        <td width='25px' >1</td>
                                                                                        <td colspan="2" id="cellid1">
                                                                                            <input type="text" name="domain" id='domain' size="25" maxlength="50"/>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td colspan="3" align="right">
                                                                                            <input type="hidden" name="action" value="Create"/>
                                                                                            <input type="hidden" name="domain_name" id="domain_name" value=""/>
                                                                                            <input type="hidden" name="executiveSponsorer" id="executiveSponsorer" value=""/>

                                                                                            <input type="button" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Create Domain" onclick='return createDomain(this);'/>
                                                                                            <input type="button" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Manage Domain" onclick='return manageDomain(<%=pid%>);'/>


                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </form>
                                                                    </div>

                                                                    <div id="viewComponentpopup" class="popup"> 
                                                                        <h3 class="popupHeading">View Domains</h3>
                                                                        <br/>
                                                                        <p id="myElem2" style="color:green;display:none">Domain Deletion is  success</p>
                                                                        <div>The below list shows total available Domains are</div>
                                                                        <br/>
                                                                        <div class="clear"></div>
                                                                        <div class="tableshow">
                                                                            <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
                                                                                <table id="domainstable" style="width: 100%;">
                                                                                    <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                                                                                        <td style="width: 20%;">ProjectDomain</td>
                                                                                        <td style="width: 25%;">Manage</td>

                                                                                    </tr>


                                                                                </table>
                                                                            </div> 
                                                                            <button class="custom-popup-close" onclick="javascript:closeViewComponent();" type="button">close</button>
                                                                        </div></div>
                                                                    <div id="domainEditpopup" class="popup">
                                                                        <div>
                                                                            <p id="myElem1" style="color:green;display: none">Domains are Updated successfully</p>
                                                                            <div style="color:red;display: none;" id="editcerrormsgs">Please enter the correct domain name with out duplicate</div>

                                                                            <table id='domainEdit'>
                                                                                <tr>
                                                                                    <td>
                                                                                        <label for="pswd">Domain Name</label>
                                                                                    </td>
                                                                                    <td colspan="2">
                                                                                        <input type="text" name="editdomain" id='editdomain' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3" align="right">
                                                                                        <input type="hidden" name="domainName" id="domainName" maxlength="50" value=""/>
                                                                                        <input type="submit" class="addtarget ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Update Domain" onclick='return updateDomain(this);'/>

                                                                                    </td>
                                                                                </tr>
                                                                        </div></div>



                                                                    </table>


                                                                    <%-- edit end by sowjanya--%>
                                                                    <br>
                                                                        <br>
                                                                            <br>
                                                                                </FORM>

                                                                                <%
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    } catch (Exception e) {
                                                                                        logger.error(e.getMessage());

                                                                                    } finally {
                                                                                        if (rs != null) {
                                                                                            rs.close();
                                                                                        }
                                                                                        if (rs1 != null) {
                                                                                            rs1.close();
                                                                                        }
                                                                                        if (rs2 != null) {
                                                                                            rs2.close();
                                                                                        }
                                                                                        if (rs3 != null) {
                                                                                            rs3.close();
                                                                                        }
                                                                                        if (rs4 != null) {
                                                                                            rs4.close();
                                                                                        }
                                                                                        if (ps1 != null) {
                                                                                            ps1.close();
                                                                                        }
                                                                                        if (ps2 != null) {
                                                                                            ps2.close();
                                                                                        }
                                                                                        if (ps3 != null) {
                                                                                            ps3.close();
                                                                                        }
                                                                                        if (st != null) {
                                                                                            st.close();
                                                                                        }
                                                                                        if (st4 != null) {
                                                                                            st4.close();
                                                                                        }

                                                                                        if (connection != null) {
                                                                                            connection.close();
                                                                                        }

                                                                                    }
                                                                                } else {
                                                                                %>
                                                                                <BR>
                                                                                    <table align="center">
                                                                                        <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
                                                                                    </table>
                                                                                    <%    }
                                                                                    %>

                                                                                    <BR>
                                                                                        </script>
                                                                                        </body>
                                                                                        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                                                                                            <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
                                                                                            <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>
                                                                                            <style type="text/css">
                                                                                                .ui-widget-overlay{
                                                                                                    z-index:10;
                                                                                                }
                                                                                            </style>
                                                                                            <script>
                                                                                            $("#targetCount").click(function () {
                                                                                                $(".addTargetCount").dialog({
                                                                                                    title: "Add monthly module target ",
                                                                                                    draggable: true,
                                                                                                    modal: true,
                                                                                                    width: 500,
                                                                                                    maxHeight: 500,
                                                                                                    position: {my: "center",
                                                                                                        at: "top",
                                                                                                        of: window,
                                                                                                        collision: "fit",
                                                                                                        // Ensure the titlebar is always visible
                                                                                                        using: function (pos) {
                                                                                                            var topOffset = $(this).css(pos).offset().top;
                                                                                                            if (topOffset < 0) {
                                                                                                                $(this).css("top", pos.top - topOffset);
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    resizable: false,
                                                                                                    show: {
                                                                                                        effect: "blind",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    hide: {
                                                                                                        effect: "blind",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    buttons: {
                                                                                                        Close: function () {
                                                                                                            $('.addTargetCount').dialog('close');
                                                                                                        }
                                                                                                    },
                                                                                                    open: function () {
                                                                                                        $("body").css("overflow", "hidden");
                                                                                                    },
                                                                                                    close: function () {
                                                                                                        $("body").css("overflow", "auto");
                                                                                                    }

                                                                                                });
                                                                                                $(".addTargetCount > img").show();
                                                                                                $(".addTargetCount > div").html("");
                                                                                                $(".addTargetCount").dialog("open");
                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                $.ajax({url: '<%=request.getContextPath()%>/admin/project/addTargetCountAjax.jsp',
                                                                                                    data: {pid: pid, random: Math.random(1, 10)},
                                                                                                    async: true,
                                                                                                    type: 'GET',
                                                                                                    success: function (responseText, statusTxt, xhr) {
                                                                                                        if (statusTxt === "success") {
                                                                                                            var result = $.trim(responseText);
                                                                                                            $(".addTargetCount > div").html(result);
                                                                                                            $(".addTargetCount > img").hide();
                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                            });
                                                                                            $(document).on('click', '.ui-dialog-buttonset, .ui-dialog-titlebar-close', function () {
                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                $.ajax({
                                                                                                    url: '<%=request.getContextPath()%>/admin/project/getTargetCountByPid.jsp',
                                                                                                    data: {pid: pid, random: Math.random(1, 10)},
                                                                                                    async: true,
                                                                                                    type: 'GET',
                                                                                                    success: function (responseText, statusTxt, xhr) {
                                                                                                        if (statusTxt === "success") {
                                                                                                            var result = $.trim(responseText);
                                                                                                            $("#targetCount").val(result);
                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                            });
                                                                                            function  updatedCount() {
                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                $.ajax({
                                                                                                    url: '<%=request.getContextPath()%>/admin/project/getTargetCountByPid.jsp',
                                                                                                    data: {pid: pid, random: Math.random(1, 10)},
                                                                                                    async: true,
                                                                                                    type: 'GET',
                                                                                                    success: function (responseText, statusTxt, xhr) {
                                                                                                        if (statusTxt === "success") {
                                                                                                            var result = $.trim(responseText);
                                                                                                            $("#targetCount").val(result);
                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                            //edit by sowjanya
                                                                                            function incrDomain() {
                                                                                                var table = document.getElementById('domaintable');
                                                                                                var rowCount = table.rows.length;
                                                                                                if (rowCount < 11) {
                                                                                                    var row1 = table.insertRow(rowCount);
                                                                                                    var idno = rowCount;
                                                                                                    row1.id = "id" + idno;
                                                                                                    var cell1 = document.createElement('td');
                                                                                                    cell1.id = "cellid" + idno;
                                                                                                    cell1.width = "25px";
                                                                                                    var lable1 = document.createTextNode(idno);
                                                                                                    cell1.appendChild(lable1);
                                                                                                    var cell2 = document.createElement('td');
                                                                                                    cell2.align = "left";
                                                                                                    var appre = document.createElement("input");
                                                                                                    appre.type = "text";
                                                                                                    appre.name = "domain";
                                                                                                    appre.size = "25";
                                                                                                    appre.maxLength = "50";
                                                                                                    cell2.appendChild(appre);
                                                                                                    var sub = document.createElement("img");
                                                                                                    sub.src = "/eTracker/images/remove.gif";
                                                                                                    sub.id = "remove";
                                                                                                    sub.alt = "Remove";
                                                                                                    sub.onclick = new Function("javascript:decrdomain('id" + rowCount + "');");
                                                                                                    sub.title = "Remove Domain";
                                                                                                    cell2.appendChild(sub);
                                                                                                    row1.appendChild(cell1);
                                                                                                    row1.appendChild(cell2);
                                                                                                }
                                                                                            }
                                                                                            function decrdomain(row) {
                                                                                                var tables = document.getElementById("domaintable");
                                                                                                var rows = tables.rows.length;
                                                                                                var removed = 'false';

                                                                                                for (var i = 0; i < rows; i++) {
                                                                                                    if (tables.rows[i] != undefined) {
                                                                                                        if (tables.rows[i].id == row)
                                                                                                        {
                                                                                                            tables.deleteRow(i);
                                                                                                            i--;
                                                                                                            removed = true;
                                                                                                        }
                                                                                                        if (removed == true) {
                                                                                                            if (i < (rows - 1)) {
                                                                                                                tables.rows[i].cells[0].innerHTML = i;
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }


                                                                                            function createDomain() {

                                                                                                var addeDomains = "";
                                                                                                var domainValues = document.getElementsByName('domain');
                                                                                                var domainvalue = document.getElementById("domain_name").value;
                                                                                                var pid = "<%=request.getParameter("pid")%>";

                                                                                                for (var i = 0; i < domainValues.length; i++) {

                                                                                                    if (trim(domainValues[i].value) === '')
                                                                                                    {
                                                                                                        document.getElementById('errormsg').style.display = 'block';
                                                                                                        domainValues[i].focus();
                                                                                                        return false;
                                                                                                    }
                                                                                                    for (var j = 0; j < domainValues.length; j++) {
                                                                                                        if (i !== j) {
                                                                                                            if (trim(domainValues[i].value.toUpperCase()) === trim(domainValues[j].value.toUpperCase())) {
                                                                                                                document.getElementById('errormsg').style.display = 'block';
                                                                                                                domainValues[j].value = '';
                                                                                                                domainValues[j].focus();
                                                                                                                return false;
                                                                                                            }

                                                                                                        }
                                                                                                        if (trim(domainValues[i].value) == "eminentlabs.net") {
                                                                                                            document.getElementById('errormsg').style.display = 'block';
                                                                                                            document.getElementById('errormsg').innerHTML = domainValues[i].value + " is Default Domain no need to add";
                                                                                                            domainValues[i].focus();
                                                                                                            return false;
                                                                                                        }
                                                                                                    }
                                                                                                    if (domainvalue.length > 0) {

                                                                                                        var alldomain = domainvalue.split(",");
                                                                                                        for (var k = 0; k < alldomain.length; k++) {
                                                                                                            if (trim(domainValues[i].value) == "eminentlabs.net") {
                                                                                                                document.getElementById('errormsg').style.display = 'block';
                                                                                                                document.getElementById('errormsg').innerHTML = domainValues[i].value + " is Default Domain no need to add";
                                                                                                                domainValues[i].focus();
                                                                                                                return false;
                                                                                                            } else if (trim(alldomain[k].toUpperCase()) === trim(domainValues[i].value.toUpperCase())) {
                                                                                                                document.getElementById('errormsg').style.display = 'block';
                                                                                                                document.getElementById('errormsg').innerHTML = domainValues[i].value + " is Duplicate Element";
                                                                                                                domainValues[i].focus();
                                                                                                                return false;
                                                                                                            }
                                                                                                        }
                                                                                                    }

                                                                                                    addeDomains = addeDomains + trim(domainValues[i].value) + ",";
                                                                                                }


                                                                                                if (addeDomains.length > 2) {
                                                                                                    addeDomains = addeDomains.substring(0, addeDomains.length - 1);
                                                                                                }
                                                                                                var dvalue = document.getElementById("domain_name").value;
                                                                                                if (dvalue === "") {
                                                                                                    $('#domain_name').val(trim(addeDomains));

                                                                                                } else {
                                                                                                    $('#domain_name').val(dvalue + "," + trim(addeDomains));



                                                                                                }


                                                                                                var dValues = document.getElementById("domain_name").value;
                                                                                                document.getElementById('domain_name').title = dValues;

                                                                                                xmlhttp = createRequest();
                                                                                                if (xmlhttp !== null) {

                                                                                                    xmlhttp.open("GET", "/eTracker/admin/project/createDomain.jsp?&action=update" + "&domains=" + encodeURIComponent(dValues) + "&pid=" + pid + "&rand=" + Math.random(1, 10), false);
                                                                                                    xmlhttp.onreadystatechange = function () {
                                                                                                        if (xmlhttp.readyState === 4)
                                                                                                        {
                                                                                                            if (xmlhttp.status === 200)
                                                                                                            {

                                                                                                                $("#myElem").show();
                                                                                                                setTimeout(function () {
                                                                                                                    $("#myElem").hide();
                                                                                                                }, 3000);
                                                                                                            }
                                                                                                        }

                                                                                                    };
                                                                                                    xmlhttp.send(null);
                                                                                                } else {
                                                                                                    alert('no ajax request');
                                                                                                }

                                                                                                $("#errormsg").css({"display": "none"});

                                                                                                $('#domainpopup').dialog('close');
                                                                                                var team = document.getElementById('team').value;
                                                                                                if (team != undefined) {
                                                                                                    selectteams();
                                                                                                }

                                                                                            }

//                                                                                                        
                                                                                            function updateDomain() {

                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                getAllDomains(pid);
                                                                                                var domainName = document.getElementById("domainName").value;

                                                                                                var prevDomain = document.getElementById('domainValue' + domainName).innerHTML;


                                                                                                var currentDomain = document.getElementById('editdomain').value;
                                                                                                if (trim(currentDomain) == "eminentlabs.net") {
                                                                                                    document.getElementById('editcerrormsgs').style.display = 'block';
                                                                                                    document.getElementById('editcerrormsgs').innerHTML = currentDomain + " is Default Domain no need to add";
                                                                                                    document.getElementById('editdomain').focus();
                                                                                                    return false;
                                                                                                }
                                                                                                if (trim(currentDomain) === '')
                                                                                                {
                                                                                                    document.getElementById('editcerrormsgs').style.display = 'block';
                                                                                                    document.getElementById('editcerrormsgs').innerHTML = "Please enter correct domain without duplicate";
                                                                                                    document.getElementById('editdomain').focus();
                                                                                                    return false;
                                                                                                } else if (alldomains != undefined) {
                                                                                                    var alldomain = alldomains.split(",");
                                                                                                    for (var k = 0; k < alldomain.length; k++) {
                                                                                                        if (trim(prevDomain.toUpperCase()) !== trim(alldomain[k].toUpperCase())) {
                                                                                                            if (trim(alldomain[k].toUpperCase()) === trim(currentDomain.toUpperCase())) {
                                                                                                                document.getElementById('editcerrormsgs').style.display = 'block';
                                                                                                                document.getElementById('editcerrormsgs').innerHTML = currentDomain + " is Duplicate Element";
                                                                                                                document.getElementById('editdomain').focus();
                                                                                                                return false;
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }

                                                                                                var ele = document.getElementById("domain_name").value;

                                                                                                var elementposition = ele.indexOf(trim(prevDomain));

                                                                                                var elementposition1 = ele.indexOf(",", elementposition);

                                                                                                if (elementposition1 > 0) {
                                                                                                    var updatelement = ele.substring(0, elementposition) + currentDomain + ele.substring(elementposition1, ele.length);

                                                                                                } else {
                                                                                                    var updatelement = ele.substring(0, elementposition) + currentDomain;

                                                                                                }

                                                                                                document.getElementById("domain_name").value = updatelement;
                                                                                                document.getElementById('domainValue' + domainName).value = currentDomain;
                                                                                                document.getElementById('domainValue' + domainName).innerHTML = currentDomain;
                                                                                                xmlhttp = createRequest();
                                                                                                if (xmlhttp !== null) {

                                                                                                    xmlhttp.open("GET", "/eTracker/admin/project/createDomain.jsp?&action=update" + "&domains=" + encodeURIComponent(updatelement) + "&pid=" + pid + "&rand=" + Math.random(1, 10), false);
                                                                                                    xmlhttp.onreadystatechange = function () {
                                                                                                        if (xmlhttp.readyState === 4)
                                                                                                        {
                                                                                                            if (xmlhttp.status === 200)
                                                                                                            {
                                                                                                                $("#myElem1").show();
                                                                                                                setTimeout(function () {
                                                                                                                    $("#myElem1").hide();
                                                                                                                }, 1000);
                                                                                                            }
                                                                                                        }
                                                                                                    };
                                                                                                    xmlhttp.send(null);
                                                                                                } else {
                                                                                                    alert('no ajax request');
                                                                                                }
                                                                                                var team = document.getElementById("team").value;
                                                                                                if (team != undefined) {
                                                                                                    selectteams();
                                                                                                }
                                                                                                $('#editcerrormsgs').css({"display": "none"});

                                                                                                document.getElementById('editdomain').value = '';
                                                                                                $('#domainEditpopup').dialog('close');
                                                                                                document.getElementById('domain_name').title = updatelement;

                                                                                            }

                                                                                            function deleteDomain(domainName) {


                                                                                                var pid = "<%=request.getParameter("pid")%>";

                                                                                                var ele = document.getElementById("domain_name").value;


                                                                                                var searchString = document.getElementById('domainValue' + domainName).innerHTML;

                                                                                                ele = $.trim(ele);
                                                                                                ele = ele.replace(trim(searchString), "");
                                                                                                ele = $.trim(ele);

                                                                                                var lastChar = ele.substr(ele.length - 1);
                                                                                                var firstChar = ele.substr(0, 1);
                                                                                                ele = ele.replace(", ,", ",");
                                                                                                ele = ele.replace(",,", ",");
                                                                                                if (lastChar == ',') {

                                                                                                    ele = ele.substr(0, ele.length - 1);
                                                                                                } else if (firstChar == ',') {
                                                                                                    ele = ele.substr(1, ele.length);


                                                                                                } else {

                                                                                                }

                                                                                                document.getElementById("domain_name").value = ele;
                                                                                                xmlhttp = createRequest();
                                                                                                if (xmlhttp !== null) {

                                                                                                    xmlhttp.open("GET", "/eTracker/admin/project/createDomain.jsp?&action=update" + "&domains=" + encodeURIComponent(ele) + "&pid=" + pid + "&rand=" + Math.random(1, 10), false);
                                                                                                    xmlhttp.onreadystatechange = function () {
                                                                                                        if (xmlhttp.readyState === 4)
                                                                                                        {
                                                                                                            if (xmlhttp.status === 200)
                                                                                                            {
                                                                                                                $("#myElem2").show();
                                                                                                                setTimeout(function () {

                                                                                                                    $("#myElem2").hide();
                                                                                                                }, 2000);
                                                                                                            }
                                                                                                        }
                                                                                                    };
                                                                                                    xmlhttp.send(null);
                                                                                                } else {
                                                                                                    alert('no ajax request');
                                                                                                }
                                                                                                document.getElementById('domain_name').title = ele;
                                                                                                var team = document.getElementById("team").value;
                                                                                                if (team != undefined) {
                                                                                                    selectteams();
                                                                                                }
                                                                                            }
                                                                                            function manageDomain(pid) {
                                                                                                var domainValue = document.getElementById("domain_name").value;
                                                                                                getDomainByPid(pid);
                                                                                                $('#domainpopup').dialog('close');
                                                                                                $('#overlay').fadeIn('fast', 'swing');
                                                                                                $('#viewComponentpopup').fadeIn('fast', 'swing');
                                                                                            }
                                                                                            function closeViewComponent() {
                                                                                                $("#errormsg").css({"display": "none"});

                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#viewComponentpopup').fadeOut('fast', 'swing');
                                                                                                $('#domainpopup').dialog('close');
                                                                                            }
                                                                                            function  getDomainByPid(pid) {
                                                                                                $("#domainstable").find("tr:gt(0)").remove();
                                                                                                xmlhttp = createRequest();
                                                                                                if (xmlhttp !== null) {
                                                                                                    xmlhttp.open("GET", "/eTracker/admin/project/retrieveDomain.jsp?pid=" + pid + "&action=retrieve" + "&rand=" + Math.random(1, 10), false);
                                                                                                    xmlhttp.onreadystatechange = function () {
                                                                                                        callbackAllDomain();
                                                                                                    };
                                                                                                    xmlhttp.send(null);
                                                                                                } else {
                                                                                                    alert('no ajax request');
                                                                                                }
                                                                                            }
                                                                                            function callbackAllDomain() {
                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#domainpopup').fadeOut('fast', 'swing');
                                                                                                if (xmlhttp.readyState === 4)
                                                                                                {
                                                                                                    if (xmlhttp.status === 200)
                                                                                                    {
                                                                                                        var Domain = xmlhttp.responseText;

                                                                                                        if (Domain !== "No Domains") {
                                                                                                            $('#domainstable').append(Domain);
                                                                                                        }

                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                            function editDomain(domainName) {
                                                                                                $('#domainpopup').dialog('close');
                                                                                                $('#editcerrormsgs').css({"display": "none"});
                                                                                                document.getElementById('domainName').value = domainName;

                                                                                                document.getElementById('editdomain').value = domainName;
                                                                                            }
                                                                                            function  getAllDomains(pid) {

                                                                                                xmlhttp = createRequest();
                                                                                                if (xmlhttp !== null) {
                                                                                                    xmlhttp.open("GET", "/eTracker/admin/project/retrieveDomain.jsp?pid=" + pid + "&action=retrieveByPid" + "&rand=" + Math.random(1, 10), false);
                                                                                                    xmlhttp.onreadystatechange = function () {
                                                                                                        callbackDomain();
                                                                                                    };
                                                                                                    xmlhttp.send(null);
                                                                                                } else {
                                                                                                    alert('no ajax request');
                                                                                                }
                                                                                            }
                                                                                            var alldomains;
                                                                                            function callbackDomain() {
                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#domainpopup').fadeOut('fast', 'swing');
                                                                                                if (xmlhttp.readyState === 4)
                                                                                                {
                                                                                                    if (xmlhttp.status === 200)
                                                                                                    {
                                                                                                        var Domain = xmlhttp.responseText;
                                                                                                        alldomains = Domain;
                                                                                                    }
                                                                                                }
                                                                                            }

                                                                                            $(document).ready(function () {

                                                                                                $("#domainstable").on('click', '.btnDelete', function () {
                                                                                                    $(this).closest('tr').remove();
                                                                                                });
                                                                                            });

                                                                                            $("#domain_name").click(function () {
                                                                                                $("#domainpopup").dialog({
                                                                                                    title: "Add Domains ",
                                                                                                    draggable: true,
                                                                                                    modal: true,
                                                                                                    width: 500,
                                                                                                    maxHeight: 500,
                                                                                                    position: {my: "center",
                                                                                                        at: "center",
                                                                                                        of: window,
                                                                                                        collision: "fit",
                                                                                                        using: function (pos) {
                                                                                                            var topOffset = $(this).css(pos).offset().top;
                                                                                                            if (topOffset < 0) {
                                                                                                                $(this).css("top", pos.top - topOffset);
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    resizable: false,
                                                                                                    show: {
                                                                                                        effect: "blind",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    hide: {
                                                                                                        effect: "blind",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    buttons: {
                                                                                                        Close: function () {
                                                                                                            $("#errormsg").css({"display": "none"});
                                                                                                            $('#domainpopup').dialog('close');
                                                                                                        }
                                                                                                    },
                                                                                                    open: function () {
                                                                                                        $("body").css("overflow", "hidden");
                                                                                                    },
                                                                                                    close: function () {
                                                                                                        var table = document.getElementById('domaintable');
                                                                                                        var rowCount = table.rows.length;

                                                                                                        $("body").css("overflow", "auto");
                                                                                                        $("#domainpopup input[type='text']").each(function (index, element) {
                                                                                                            $(element).val("");

                                                                                                        });
                                                                                                        decrdomains();
                                                                                                    }

                                                                                                });
                                                                                            });
                                                                                            $("#domainstable").on('click', '.btnEdit', function () {
                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#viewComponentpopup').fadeOut('fast', 'swing');
                                                                                                $("#domainEditpopup").dialog({
                                                                                                    title: "Edit Domain Value",
                                                                                                    modal: true,
                                                                                                    width: 300,
                                                                                                    maxHeight: 300,
                                                                                                    position: {my: "center",
                                                                                                        at: "center",
                                                                                                        of: window,
                                                                                                        collision: "fit",
                                                                                                        using: function (pos) {
                                                                                                            var topOffset = $(this).css(pos).offset().top;
                                                                                                            if (topOffset < 0) {
                                                                                                                $(this).css("top", pos.top - topOffset);
                                                                                                            }
                                                                                                        }
                                                                                                    },
                                                                                                    resizable: false,
                                                                                                    show: {
                                                                                                        effect: "fade",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    hide: {
                                                                                                        effect: "fade",
                                                                                                        duration: 1000
                                                                                                    },
                                                                                                    buttons: {
                                                                                                        submit: function () {


                                                                                                            $('#domainEditpopup').dialog('close');
                                                                                                            $('#overlay').fadeIn('fast', 'swing');
                                                                                                            $('#viewComponentpopup').fadeIn('fast', 'swing');
                                                                                                        }
                                                                                                    },
                                                                                                    open: function () {
                                                                                                        $("body").css("overflow", "hidden");
                                                                                                    },
                                                                                                    close: function () {
                                                                                                        $("body").css("overflow", "auto");
                                                                                                    }

                                                                                                });
                                                                                            });
//edit end by sowjanya                              
                                                                                            function decrdomains() {
                                                                                                var tables = document.getElementById("domaintable");
                                                                                                var rows = tables.rows.length;
                                                                                                var removed = 'false';
                                                                                                for (var i = rows - 1; i >= 2; i--) {
                                                                                                    if (tables.rows[i] != undefined) {

                                                                                                        if (tables.rows[i].id == "id" + i)
                                                                                                        {
                                                                                                            tables.deleteRow(i);

                                                                                                            removed = true;
                                                                                                        }
//                                                                                                                    
                                                                                                    }
                                                                                                }
                                                                                            }

                                                                                            $("#assignExceeds").click(function () {
                                                                                                $('span.error2').remove();
                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#TSISSUEpopup').fadeOut('fast', 'swing');
                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                $.ajax({url: '<%=request.getContextPath()%>/admin/project/assignmentExceeds.jsp',
                                                                                                    data: {pid: pid, random: Math.random(1, 10)},
                                                                                                    async: true,
                                                                                                    type: 'GET',
                                                                                                    success: function (responseText, statusTxt, xhr) {
                                                                                                        if (statusTxt === "success") {
                                                                                                            var result = $.trim(responseText);
                                                                                                            $("#popupIssueList").html(result);
                                                                                                            $('#overlay').fadeIn('fast', 'swing');
                                                                                                            $('#TSISSUEpopup').fadeIn('fast', 'swing');

                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                            });


                                                                                            $("#server").click(function () {
                                                                                                $('span.error2').remove();
                                                                                                $('#overlay').fadeOut('fast', 'swing');
                                                                                                $('#MDAVpopup').fadeOut('fast', 'swing');
                                                                                                var pid = "<%=request.getParameter("pid")%>";
                                                                                                $.ajax({url: '<%=request.getContextPath()%>/admin/project/serverMaintenance.jsp',
                                                                                                    data: {pid: pid, random: Math.random(1, 10)},
                                                                                                    async: true,
                                                                                                    type: 'GET',
                                                                                                    success: function (responseText, statusTxt, xhr) {
                                                                                                        if (statusTxt === "success") {
                                                                                                            var result = $.trim(responseText);
                                                                                                            $("#MDAVpopupServer").html(result);
                                                                                                            $('#overlay').fadeIn('fast', 'swing');
                                                                                                            $('#MDAVpopup').fadeIn('fast', 'swing');

                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                            });
                                                                                            </script>    
                                                                                            <script>
                                                                                                $(".escBut").on("click", function () {
                                                                                                    $('span.error2').remove();
                                                                                                    var checkedVals = $('.serverMaintain:checkbox:checked').map(function () {
                                                                                                        return this.value;
                                                                                                    }).get();
                                                                                                    if (checkedVals.length === 0) {
                                                                                                        $("<span class='error2'>Please maintain the server types with system</span>").insertAfter(".newserver");
                                                                                                    } else {
                                                                                                        var pid = $.trim($("#pid").val());

                                                                                                        $.ajax({url: '<%=request.getContextPath()%>/admin/project/maintainServerMatix.jsp',
                                                                                                            data: {pid: pid, marix: checkedVals, random: Math.random(1, 10)},
                                                                                                            async: true,
                                                                                                            type: 'GET',
                                                                                                            success: function (responseText, statusTxt, xhr) {
                                                                                                                if (statusTxt === "success") {
                                                                                                                    var result = $.trim(responseText);
                                                                                                                    if (result === "suceess") {
                                                                                                                        $("<span class='error2' style='color:green;'>Server Matrix Maintained Successfully</span>").insertAfter(".newserver");
                                                                                                                    } else {
                                                                                                                        $("<span class='error2'>" + result + "</span>").insertAfter(".newserver");
                                                                                                                    }

                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    }
                                                                                                });


                                                                                                $(".newserver").on("click", function () {
                                                                                                    $('#overlay').fadeOut('fast', 'swing');
                                                                                                    $('#MDAVpopup').fadeOut('fast', 'swing');
                                                                                                    $(".addServer").dialog({
                                                                                                        title: "Add Server Types",
                                                                                                        draggable: true,
                                                                                                        modal: true,
                                                                                                        width: 300,
                                                                                                        maxHeight: 300,
                                                                                                        position: {my: "center",
                                                                                                            at: "top",
                                                                                                            of: window,
                                                                                                            collision: "fit",
                                                                                                            // Ensure the titlebar is always visible
                                                                                                            using: function (pos) {
                                                                                                                var topOffset = $(this).css(pos).offset().top;
                                                                                                                if (topOffset < 0) {
                                                                                                                    $(this).css("top", pos.top - topOffset);
                                                                                                                }
                                                                                                            }
                                                                                                        },
                                                                                                        resizable: false,
                                                                                                        show: {
                                                                                                            effect: "blind",
                                                                                                            duration: 1000
                                                                                                        },
                                                                                                        hide: {
                                                                                                            effect: "blind",
                                                                                                            duration: 1000
                                                                                                        },
                                                                                                        open: function () {
                                                                                                            $('span.error2').remove();
                                                                                                            $('input[name="server"]').each(function (index, element) {
                                                                                                                $(element).val("");
                                                                                                            });
                                                                                                            $("body").css("overflow", "hidden");
                                                                                                        },
                                                                                                        close: function () {
                                                                                                            $('#server').trigger('click');

                                                                                                            $("body").css("overflow", "auto");
                                                                                                        }
                                                                                                    });

                                                                                                });

                                                                                                function closeMDVAPopup() {
                                                                                                    $('#overlay').fadeOut('fast', 'swing');
                                                                                                    $('#MDAVpopup').fadeOut('fast', 'swing');
                                                                                                }
                                                                                                $(".addservertype").on("click", function () {
                                                                                                    $('span.error2').remove();
                                                                                                    var tr = "<tr>\n\
<td><input type='text' name='server'/><img class='deleteservertype'  src='/eTracker/images/remove.gif' alt='Remove Server Type' title='Remove Server Type'/></td></tr>";
                                                                                                    $("#monitor").append(tr);
                                                                                                });

                                                                                                $('#monitor').on('click', '.deleteservertype', function () {
                                                                                                    $('span.error2').remove();
                                                                                                    $(this).closest('tr').remove();
                                                                                                });
                                                                                                $(".addserversubmit").on("click", function () {
                                                                                                    $('span.error2').remove();

                                                                                                    var values = [];
                                                                                                    var count = 0;
                                                                                                    $('input[name="server"]').each(
                                                                                                            function () {
                                                                                                                if (this.value === '') {
                                                                                                                    $(this).css("border-color", "red");
                                                                                                                    count = 1;
                                                                                                                }
                                                                                                            }
                                                                                                    );
                                                                                                    if (count === 1) {
                                                                                                        $("<span class='error2'>Pleaase enter server</span>").insertAfter(".addserversubmit");
                                                                                                    } else {
                                                                                                        $('input[name="server"]').each(
                                                                                                                function () {
                                                                                                                    $('span.error2').remove();
                                                                                                                    if (values.indexOf(this.value) >= 0) {
                                                                                                                        $(this).css("border-color", "red");
                                                                                                                        $("<span class='error2'>Duplicate</span>").insertAfter(".addserversubmit");
                                                                                                                        count = 1;
                                                                                                                        ''
                                                                                                                    } else {
                                                                                                                        $(this).css("border-color", ""); //clears since last check
                                                                                                                        values.push(this.value);
                                                                                                                        count = 0;
                                                                                                                    }
                                                                                                                }
                                                                                                        );
                                                                                                    }

                                                                                                    if (count === 1) {

                                                                                                    } else {
                                                                                                        var checkedVals = $('input[name="server"]').map(function () {
                                                                                                            return this.value;
                                                                                                        }).get();
                                                                                                        if (checkedVals.length === 0) {
                                                                                                            $("<span class='error2' style='color:green;'>Please maintain the server types with system</span>").insertAfter(".addserversubmit");
                                                                                                        } else {
                                                                                                            $.ajax({url: '<%=request.getContextPath()%>/admin/project/maintainservertypes.jsp',
                                                                                                                data: {server: checkedVals, random: Math.random(1, 10)},
                                                                                                                async: true,
                                                                                                                type: 'GET',
                                                                                                                success: function (responseText, statusTxt, xhr) {
                                                                                                                    if (statusTxt === "success") {
                                                                                                                        var result = $.trim(responseText);
                                                                                                                        if (statusTxt === "success") {
                                                                                                                            $('input[name="server"]').each(function (index, element) {
                                                                                                                                $(element).val("");
                                                                                                                            });
                                                                                                                            $("<span class='error2' style=color:green;>Server Type Added Succuessfully</span>").insertAfter(".addserversubmit");

                                                                                                                        } else {
                                                                                                                            $("<span class='error2'>" + result + "</span>").insertAfter(".addserversubmit");

                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            });
                                                                                                        }
                                                                                                    }
                                                                                                });
                                                                                                $(".assignment").on("click", function () {
                                                                                                    $('span.error2').remove();
                                                                                                    var days = $('#days').val();
                                                                                                    var atype = $('input[name="atype"]:checked').val();

                                                                                                    var checkedVals = $('.utype:checkbox:checked').map(function () {
                                                                                                        return this.value;
                                                                                                    }).get();
                                                                                                    if (checkedVals.length === 0) {
                                                                                                        $("<span class='error2'>Please select user type(s)</span>").insertAfter(".assignmentClose");
                                                                                                    } else {
                                                                                                        var pid = $.trim($("#pid").val());

                                                                                                        $.ajax({url: '<%=request.getContextPath()%>/admin/project/maintainAssigExceeds.jsp',
                                                                                                            data: {pid: pid, days: days, assignType: atype, userType: checkedVals, random: Math.random(1, 10)},
                                                                                                            async: true,
                                                                                                            type: 'GET',
                                                                                                            success: function (responseText, statusTxt, xhr) {
                                                                                                                if (statusTxt === "success") {
                                                                                                                    var result = $.trim(responseText);
                                                                                                                    if (result === "suceess") {
                                                                                                                        $("<span class='error2' style='color:green;'>Issue Assignment Exceeds Maintained Successfully</span>").insertAfter(".assignmentClose");
                                                                                                                    } else {
                                                                                                                        $("<span class='error2'>" + result + "</span>").insertAfter(".assignmentClose");
                                                                                                                    }

                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    }
                                                                                                });
                                                                                                $(".assignmentClose").click(function () {
                                                                                                    $('span.error2').remove();
                                                                                                    $('#overlay').fadeOut('fast', 'swing');
                                                                                                    $('#TSISSUEpopup').fadeOut('fast', 'swing');
                                                                                                });
                                                                                            </script>
                                                                                            <style>
                                                                                                img.deleteservertype{
                                                                                                    cursor: pointer;
                                                                                                }
                                                                                            </style>


                                                                                            </html>