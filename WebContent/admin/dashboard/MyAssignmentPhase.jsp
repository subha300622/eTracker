
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="com.eminent.issue.controller.ApmComponentController"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.issue.Modules"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.Map"%>
<%@ page import="com.eminent.tqm.StatusFlow,com.eminent.tqm.IssueTestCaseUtil,org.apache.log4j.*,java.util.List,java.util.HashMap,java.util.LinkedHashMap,com.eminent.util.*,java.text.*,java.util.Collection, java.util.ArrayList, java.util.Iterator"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("Dashboard View");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">-->
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <script type="text/javascript"	src="<%= request.getContextPath()%>/javaScript/feedbackSelect.js"></script>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
            <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=180720161121"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"/>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/testCases.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
            <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/javaScript/cr.js?test=22042020" type="text/javascript"></script>
            <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">
                    <LINK title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css" type="text/css" rel="STYLESHEET"/>
                    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
                    <script src="<%=request.getContextPath()%>/javaScript/prevnext.js?test=11233344" type="text/javascript"></script>
                    <script type="text/javascript">
                $(document).ready(function() {

                    $('.credit').hide();
                });
                function  openEdit() {
                    $('.credit').show();
                    $('#crrow').css({backgroundColor: '#C3D9FE'});
                    $('.crnormal').hide();
                }
                function  openNormal() {
                    $('.credit').hide();
                    $('#crrow').css({backgroundColor: '#E8EEF7'});
                    $('.crnormal').show();
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
                    </script>
                    <SCRIPT type="text/javascript" language="JavaScript">

                        function trim(str) {
                            while (str.charAt(str.length - 1) === " ")
                                str = str.substring(0, str.length - 1);
                            while (str.charAt(0) === " ")
                                str = str.substring(1, str.length);
                            return str;
                        }
                        function clearCRID(id) {
                            document.getElementById(id).value = '';
                            document.getElementById(id).focus();
                        }

                        function createRequest() {
                            var reqObj = null;
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

                        function isModuleExist() {
                            xmlhttp = createRequest();
                            if (!xmlhttp && typeof XMLHttpRequest !== 'undefined') {
                                xmlhttp = new XMLHttpRequest();
                            }
                            if (xmlhttp !== null) {

                                var version = theForm.fix_version.value;
                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/admin/dashboard/moduleCheck.jsp?version=" + version + "&rand=" + Math.random(1, 10), true);
                                xmlhttp.onreadystatechange = userAlert;
                                xmlhttp.send(null);
                            }
                        }


                        function userAlert() {
                            if (xmlhttp.readyState === 4) {
                                if (xmlhttp.status === 200) {

                                    var module = xmlhttp.responseText.split(",");
                                    var flag = module[1];
                                    if (flag === 'no') {

                                        alert("This module is not present in the selected version. Please contact your Project Manager");
                                        document.theForm.fix_version.value = module[2];
                                        theForm.fix_version.focus();
                                    } else {
                                        callmodule();
                                    }

                                }
                            }
                        }
                        function callmodule() {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null) {

                                var product = theForm.project.value;
                                var version = theForm.fix_version.value;
                                xmlhttp.open("GET", "<%= request.getContextPath()%>/newModuleDetails.jsp?product=" + product + "&version=" + version + "&rand=" + Math.random(1, 10), false);
                                xmlhttp.onreadystatechange = callbackmodule;
                                xmlhttp.send(null);
                            }
                        }



                        function callbackmodule()
                        {
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var newModule = $("#newModule option:selected").text();
                                    var result = xmlhttp.responseText.split(";");
                                    var objLinkList = eval("document.getElementById('newModule')");
                                    objLinkList.length = 0;
                                    for (var i = 0; i < result.length - 1; i++)
                                    {
                                        var results = result[i].split(",");
                                        if (results[1] != undefined) {
                                            objLinkList.length++;
                                            objLinkList[i].text = results[1];
                                            objLinkList[i].value = results[0];
                                            if (newModule == results[1]) {
                                                objLinkList[i].selected = true;
                                            }
                                        }

                                    }
                                } else
                                {
                                }
                            }
                        }
                        function assignedusers() {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null) {
                                var issueid = document.getElementById("issu").value;
                                var status = document.getElementById("issuestatus").value;
                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/MyIssues/assignedToDetails.jsp?issueid=" + issueid + "&status=" + status + "&rand=" + Math.random(1, 10), false);
                                xmlhttp.onreadystatechange = callassignedto;
                                xmlhttp.send(null);
                            }
                        }
                        function callassignedto()
                        {
                            var results = "";
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var results = "";
                                    var result = xmlhttp.responseText.split(";");
                                    //            alert("Result:"+result);
                                    var results = result[1].split(",");
                                    var presentUser = document.getElementById('assignedto').value;
                                    objLinkList = eval("document.getElementById('assignedto')");
                                    objLinkList.length = 0;
                                    var assigned = results[results.length - 1];
                                    for (i = 0; i < results.length - 1; i++)
                                    {

                                        var k = results[i];
                                        var id = k.substring(0, k.indexOf('-'));
                                        var name = k.substring(k.indexOf('-') + 1, k.length);
                                        objLinkList.length++;
                                        objLinkList[i].text = name;
                                        objLinkList[i].value = id;
                                        if (presentUser === id) {
                                            objLinkList[i].selected = true;
                                        }

                                    }
                                    var results = "";
                                    var result = "";
                                }
                            }
                        }


                        function textCounter(field, cntfield, maxlimit)
                        {
                            if (field.value.length > maxlimit)
                            {
                                field.value = field.value.substring(0, maxlimit);
                                alert('Comments size is exceeding 2000 characters');
                            } else
                                cntfield.value = maxlimit - field.value.length;
                        }

                        function call(theForm)
                        {
                            if (theForm.comments.value.length <= 0)
                            {
                                alert('Enter your comments');
                                theForm.comments.focus();
                                return false;
                            }

                            if (theForm.comments.value.length > 2000)
                            {
                                alert('Comments Should not exceed 2000 Characters');
                                theForm.comments.focus();
                                return false;
                            }
                            return true;
                        }

                        function callphase1()
                        {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null)
                            {
                                var projecttype = document.getElementById("projecttype").value;
                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/admin/dashboard/PhaseDetails.jsp?projecttype=" + projecttype + "&rand=" + Math.random(1, 10), false);
                                xmlhttp.onreadystatechange = callbackphase1;
                                xmlhttp.send(null);
                            }
                        }

                        function callbackphase1()
                        {
                            var results = "";
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var name = xmlhttp.responseText;
                                    var result = xmlhttp.responseText.split(";");
                                    var results = result[1].split(",");
                                    objLinkList = eval("document.getElementById('phase')");
                                    objLinkList.length = 0;
                                    for (i = 0; i < results.length - 1; i++)
                                    {
                                        objLinkList.length++;
                                        objLinkList[i].text = results[i];
                                        objLinkList[i].value = results[i];
                                    }
                                }
                            }
                        }

                        function callsubphase1()
                        {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null)
                            {
                                var projecttype = document.getElementById("projecttype").value;
                                var phase = document.getElementById("phase").value;
                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/admin/dashboard/SubPhaseDetails.jsp?projecttype=" + projecttype + "&phase=" + phase + "&rand=" + Math.random(1, 10), false);
                                xmlhttp.onreadystatechange = callbacksubphase1;
                                xmlhttp.send(null);
                            }
                        }

                        function callbacksubphase1()
                        {
                            var results = "";
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var name = xmlhttp.responseText;
                                    var result = xmlhttp.responseText.split(";");
                                    var results = result[1].split(",");
                                    objLinkList = eval("document.getElementById('subphase')");
                                    objLinkList.length = 0;
                                    for (i = 0; i < results.length - 1; i++)
                                    {
                                        objLinkList.length++;
                                        objLinkList[i].text = results[i];
                                        objLinkList[i].value = results[i];
                                    }
                                }
                            }
                        }

                        function callsubsubphase1()
                        {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null)
                            {
                                var projecttype = document.getElementById("projecttype").value;
                                if (projecttype === "Implementation") {
                                    var phase = document.getElementById("phase").value;
                                    var subphase = document.getElementById("subphase").value;
                                    xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/admin/dashboard/SubSubPhaseDetails.jsp?projecttype=" + projecttype + "&phase=" + phase + "&subphase=" + subphase + "&rand=" + Math.random(1, 10), false);
                                    xmlhttp.onreadystatechange = callbacksubsubphase1;
                                    xmlhttp.send(null);
                                }
                            }
                        }

                        function callbacksubsubphase1()
                        {
                            var results = "";
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var name = xmlhttp.responseText;
                                    var result = xmlhttp.responseText.split(";");
                                    var results = result[1].split(",");
                                    objLinkList = eval("document.getElementById('subsubphase')");
                                    objLinkList.length = 0;
                                    for (i = 0; i < results.length - 1; i++)
                                    {
                                        objLinkList.length++;
                                        objLinkList[i].text = results[i];
                                        objLinkList[i].value = results[i];
                                    }
                                }
                            }
                        }

                        function callsubsubsubphase1()
                        {
                            xmlhttp = createRequest();
                            if (xmlhttp !== null)
                            {
                                var projecttype = document.getElementById("projecttype").value;
                                if (projecttype === "Implementation") {
                                    var phase = document.getElementById("phase").value;
                                    var subphase = document.getElementById("subphase").value;
                                    var subsubphase = document.getElementById("subsubphase").value;
                                    xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/admin/dashboard/SubSubSubPhaseDetails.jsp?projecttype=" + projecttype + "&phase=" + phase + "&subphase=" + subphase + "&subsubphase=" + subsubphase + "&rand=" + Math.random(1, 10), false);
                                    xmlhttp.onreadystatechange = callbacksubsubsubphase1;
                                    xmlhttp.send(null);
                                }
                            }
                        }

                        function callbacksubsubsubphase1()
                        {
                            var results = "";
                            if (xmlhttp.readyState === 4)
                            {
                                if (xmlhttp.status === 200)
                                {
                                    var name = xmlhttp.responseText;
                                    var result = xmlhttp.responseText.split(";");
                                    var results = result[1].split(",");
                                    objLinkList = eval("document.getElementById('subsubsubphase')");
                                    objLinkList.length = 0;
                                    for (i = 0; i < results.length - 1; i++)
                                    {
                                        objLinkList.length++;
                                        objLinkList[i].text = results[i];
                                        objLinkList[i].value = results[i];
                                    }
                                }
                            }
                        }
                        function callsubphase()
                        {
                            if (document.getElementById('phase').value === '--Select One--')
                            {
                                document.getElementById("subphase1").style.visibility = "hidden";
                                document.getElementById("subphase1").style.position = "relative";
                                document.getElementById("subphase1").value = "hello";
                                document.getElementById("subphase").style.visibility = "hidden";
                                document.getElementById("subphase").style.position = "relative";
                                document.getElementById("subphase").value = "hello";
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('phase').value === 'Maintenance and educating end users')
                            {
                                document.getElementById("subphase1").style.visibility = "hidden";
                                document.getElementById("subphase1").style.position = "relative";
                                document.getElementById("subphase1").value = "hello";
                                document.getElementById("subphase").style.visibility = "hidden";
                                document.getElementById("subphase").style.position = "relative";
                                document.getElementById("subphase").value = "hello";
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else
                            {
                                document.getElementById("subphase1").style.visibility = "visible";
                                document.getElementById("subphase1").style.Position = "relative";
                                document.getElementById('subphase').style.visibility = 'visible';
                                document.getElementById("subphase").style.Position = "relative";
                                document.getElementById('subphase').style.display = '';
                                document.getElementById('subphase').disabled = false;
                                document.getElementById('subphase').focus();
                            }
                            return true;
                        }

                        function callsubsubphase()
                        {
                            if (document.getElementById('subphase').value === '--Select One--')
                            {
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subphase').value === 'The Online Service System' || document.getElementById('subphase').value === 'Remote Consulting' || document.getElementById('subphase').value === 'Early Watch Services' || document.getElementById('subphase').value === 'Production support facilities' || document.getElementById('subphase').value === 'Validation of business processes and their configuration' || document.getElementById('subphase').value === 'Follow-up training for users' || document.getElementById('subphase').value === 'Signoffs' || document.getElementById('subphase').value === 'System and Release Upgrade' || document.getElementById('subphase').value === 'Upgrade and Release changes' || document.getElementById('subphase').value === 'R fining the Cutover' || document.getElementById('subphase').value === 'Going Live Check' || document.getElementById('subphase').value === 'Business Process Master List' || document.getElementById('subphase').value === 'Business process procedure')
                            {
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subphase').value === 'Existing system study questionnaire' || document.getElementById('subphase').value === 'Actual situation analysis' || document.getElementById('subphase').value === 'Define the objectives' || document.getElementById('subphase').value === 'Create the project plan' || document.getElementById('subphase').value === 'identify the project team' || document.getElementById('subphase').value === 'Execution plan with the level of support defined across team members' || document.getElementById('subphase').value === 'Escalation plan' || document.getElementById('subphase').value === 'Execution plan')
                            {
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('phase').value === 'Support Blueprint' || document.getElementById('phase').value === 'Support Realization' || document.getElementById('phase').value === 'Final Preparation for Cutover' || document.getElementById('phase').value === 'Production Cutover and Support' || document.getElementById('phase').value === 'Upgrade Blueprint' || document.getElementById('phase').value === 'Upgrade Realization')
                            {
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subphase').value === 'Project Team' || document.getElementById('subphase').value === 'Team Member Roles Definition' || document.getElementById('subphase').value === 'System Landscape' || document.getElementById('subphase').value === 'Technical Requirements' || document.getElementById('subphase').value === 'Issues Database' || document.getElementById('subphase').value === 'Project Team Training' || document.getElementById('subphase').value === 'Developing the System Environment' || document.getElementById('subphase').value === 'Defining the Organizational Structure')
                            {
                                document.getElementById("subsubphase").style.visibility = "hidden";
                                document.getElementById("subsubphase").style.position = "relative";
                                document.getElementById("subsubphase").value = "hello";
                                document.getElementById("subsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubphase1").style.position = "relative";
                                document.getElementById("subsubphase1").value = "hello";
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else
                            {
                                document.getElementById("subsubphase1").style.visibility = "visible";
                                document.getElementById("subsubphase1").style.Position = "relative";
                                document.getElementById('subsubphase').style.visibility = 'visible';
                                document.getElementById('subsubphase').style.display = '';
                                document.getElementById('subsubphase').disabled = false;
                                document.getElementById('subsubphase').focus();
                            }
                            return true;
                        }

                        function callsubsubsubphase()
                        {
                            if (document.getElementById('subsubphase').value === '--Select One--')
                            {
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subsubphase').value === 'Enterprise Area Scope Document' || document.getElementById('subsubphase').value === 'Project deliverables' || document.getElementById('subsubphase').value === 'Project work papers and internal project team documentation' || document.getElementById('subsubphase').value === 'Business processes to be implemented' || document.getElementById('subsubphase').value === 'R/3 design specifications for enterprise-specific enhancements' || document.getElementById('subsubphase').value === 'Documentation on R/3 configuration and Customizing settings' || document.getElementById('subsubphase').value === 'End user documentation' || document.getElementById('subsubphase').value === 'C de corrections using OSS notes or Hot Packages' || document.getElementById('subsubphase').value === 'Service reports and documentation')
                            {
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subsubphase').value === 'Conducting Status Meetings for the Project Team' || document.getElementById('subsubphase').value === 'Conducting the Steering Committee Meetings' || document.getElementById('subsubphase').value === 'General Project Management' || document.getElementById('subsubphase').value === 'Completing the Business Blueprint reviewing it and obtaining management signoff' || document.getElementById('subsubphase').value === 'Setting up an end user training schedule' || document.getElementById('subsubphase').value === 'The Baseline Scope document' || document.getElementById('subsubphase').value === 'Cycle Plan' || document.getElementById('subsubphase').value === 'Integration Test Plan' || document.getElementById('subsubphase').value === 'Configuring the Implementation Guide' || document.getElementById('subsubphase').value === 'IMG Project Documentation' || document.getElementById('subsubphase').value === 'Customizing Functionality' || document.getElementById('subsubphase').value === 'Customizing Wizards' || document.getElementById('subsubphase').value === 'Creating User Documentation' || document.getElementById('subsubphase').value === 'System Management Procedures')
                            {
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else if (document.getElementById('subsubphase').value === 'Testing conversion procedures and programs' || document.getElementById('subsubphase').value === 'Testing interface programs' || document.getElementById('subsubphase').value === 'Conducting volume and stress testing' || document.getElementById('subsubphase').value === 'Conducting final user acceptance testing' || document.getElementById('subsubphase').value === 'Developing a final go-live strategy')
                            {
                                document.getElementById("subsubsubphase1").style.visibility = "hidden";
                                document.getElementById("subsubsubphase1").style.position = "relative";
                                document.getElementById("subsubsubphase1").value = "hello";
                                document.getElementById("subsubsubphase").style.visibility = "hidden";
                                document.getElementById("subsubsubphase").style.position = "relative";
                                document.getElementById("subsubsubphase").value = "hello";
                                return false;
                            } else
                            {
                                document.getElementById("subsubsubphase1").style.visibility = "visible";
                                document.getElementById("subsubsubphase1").style.Position = "relative";
                                document.getElementById('subsubsubphase').style.visibility = 'visible';
                                document.getElementById('subsubsubphase').style.display = '';
                                document.getElementById('subsubsubphase').disabled = false;
                                document.getElementById('subsubsubphase').focus();
                            }
                            return true;
                        }
                        function phasechange()
                        {

                            document.getElementById("subphase").style.visibility = "hidden";
                            document.getElementById("subphase").style.position = "relative";
                            document.getElementById("subphase").value = "hello";
                            document.getElementById("subphase1").style.visibility = "hidden";
                            document.getElementById("subphase1").style.position = "relative";
                            document.getElementById("subsubphase").style.visibility = "hidden";
                            document.getElementById("subsubphase").style.position = "relative";
                            document.getElementById("subsubphase").value = "hello";
                            document.getElementById("subsubphase1").style.visibility = "hidden";
                            document.getElementById("subsubphase1").style.position = "relative";
                            document.getElementById("subsubsubphase1").style.visibility = "hidden";
                            document.getElementById("subsubsubphase1").style.position = "relative";
                            document.getElementById("subsubsubphase").style.visibility = "hidden";
                            document.getElementById("subsubsubphase").style.position = "relative";
                            document.getElementById("subsubsubphase").value = "hello";
                            return true;
                        }
                        function subphasechange()
                        {
                            document.getElementById("subsubphase").style.visibility = "hidden";
                            document.getElementById("subsubphase").style.position = "relative";
                            document.getElementById("subsubphase").value = "hello";
                            document.getElementById("subsubphase1").style.visibility = "hidden";
                            document.getElementById("subsubphase1").style.position = "relative";
                            document.getElementById("subsubsubphase1").style.visibility = "hidden";
                            document.getElementById("subsubsubphase1").style.position = "relative";
                            document.getElementById("subsubsubphase").style.visibility = "hidden";
                            document.getElementById("subsubsubphase").style.position = "relative";
                            document.getElementById("subsubsubphase").value = "hello";
                            return true;
                        }
                        function subsubphasechange()
                        {

                            document.getElementById("subsubsubphase1").style.visibility = "hidden";
                            document.getElementById("subsubsubphase1").style.position = "relative";
                            document.getElementById("subsubsubphase").style.visibility = "hidden";
                            document.getElementById("subsubsubphase").style.position = "relative";
                            document.getElementById("subsubsubphase").value = "hello";
                            return true;
                        }

                        function call() {
                            if (document.getElementById("phase").style.visibility !== "hidden" && document.theForm.phase.value === "--Select One--")
                            {
                                alert("Please select the Phase Name");
                                document.theForm.phase.focus();
                                return false;
                            }

                            if (document.getElementById("subphase").style.visibility !== "hidden" && document.theForm.subphase.value === "--Select One--")
                            {
                                alert("Please select the subPhase Name");
                                document.theForm.subphase.focus();
                                return false;
                            }
                            if (document.getElementById("subsubphase").style.visibility !== "hidden" && document.theForm.subsubphase.value === "--Select One--")
                            {
                                alert("Please select the subsubPhase Name");
                                document.theForm.subsubphase.focus();
                                return false;
                            }
                            if (document.getElementById("subsubsubphase").style.visibility !== "hidden" && document.theForm.subsubsubphase.value === "--Select One--")
                            {
                                alert("Please select the subsubsubPhase Name");
                                document.theForm.subsubsubphase.focus();
                                return false;
                            }
                            return true;
                        }
                        function calcCharLeft(theForm)
                        {
                            var mytext = theForm.description.value;
                            var availChars = 450;
                            if (mytext.length > availChars) {
                                theForm.description.value = mytext.substring(0, availChars);
                                theForm.description.focus();
                                return false;
                            }
                            return true;
                        }
                        function textCounter(field, cntfield, maxlimit) {
                            if (field.value.length > maxlimit)
                            {
                                field.value = field.value.substring(0, maxlimit);
                                alert('Description size is exceeding 2000 characters');
                            } else
                                cntfield.value = maxlimit - field.value.length;
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
                        function isAlphabet(str) {
                            var pattern = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
                        function printpost(post)
                        {
                            pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                            pp.focus();
                        }
                        var crids;
                        function getCRIds(issueid) {
                            if (xmlhttp !== null) {

                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/crIdByIssue.jsp?issueid=" + encodeURIComponent(issueid), false);
                                xmlhttp.onreadystatechange = function() {
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
                        function fun(theForm)
                        {
                            var fromPage = document.getElementById("issuestatus").value;
                            if (document.getElementById("phase").style.visibility !== "hidden" && document.theForm.phase.value === "--Select One--")
                            {
                                alert("Please select the Phase Name");
                                document.theForm.phase.focus();
                                return false;
                            }

                            if (document.getElementById("subphase").style.visibility !== "hidden" && document.theForm.subphase.value === "--Select One--")
                            {
                                alert("Please select the subPhase Name");
                                document.theForm.subphase.focus();
                                return false;
                            }
                            if (document.getElementById("subsubphase").style.visibility !== "hidden" && document.theForm.subsubphase.value === "--Select One--")
                            {
                                alert("Please select the subsubPhase Name");
                                document.theForm.subsubphase.focus();
                                return false;
                            }
                            if (document.getElementById("subsubsubphase").style.visibility !== "hidden" && document.theForm.subsubsubphase.value === "--Select One--")
                            {
                                alert("Please select the subsubsubPhase Name");
                                document.theForm.subsubsubphase.focus();
                                return false;
                            }
                            if (document.getElementById('dateChange').value !== document.getElementById('duedate').value) {

                                var str = document.getElementById('duedate').value;
                                var first = str.indexOf("-");
                                var last = str.lastIndexOf("-");
                                var year = str.substring(last + 1, last + 5);
                                var month = str.substring(first + 1, last);
                                var date = str.substring(0, first);
                                var form_date = new Date(year, month - 1, date);
                                var current_date = new Date();
                                if (form_date.getYear() < current_date.getYear())
                                {
                                    window.alert("Enter the valid Due Date");
                                    theForm.duedate.focus();
                                    return false;
                                }
                                if (form_date.getYear() === current_date.getYear())
                                {
                                    if (form_date.getMonth() < current_date.getMonth())
                                    {
                                        window.alert("Enter the valid Due Date");
                                        theForm.duedate.focus();
                                        return false;
                                    }
                                    if (form_date.getMonth() === current_date.getMonth())
                                    {
                                        if (form_date.getDate() < current_date.getDate())
                                        {
                                            window.alert("Enter the valid Due Date");
                                            theForm.duedate.focus();
                                            return false;
                                        }
                                        if (form_date.getDate() === current_date.getDate()) {
                                            if (current_date.getHours() < 17) {
                                                window.alert("Due Date cannot be today after 5PM");
                                                theForm.date.focus();
                                                return false;
                                            }
                                        }
                                    }
                                }

                            }
                            if (document.getElementById('pmClient') === null) {
                                if (fromPage != "Unconfirmed") {
                                    if (!(document.getElementById('timeestimation') === null)) {
                                        if (document.getElementById('timeestimation').value === '') {
                                            alert("Please enter the Estimated time for this Issue");
                                            document.getElementById('timeestimation').value = '';
                                            document.getElementById('timeestimation').focus();
                                            return false;
                                        }
                                    }
                                    if (!(document.getElementById('sapissuetype') === null)) {
                                        if (document.getElementById('sapissuetype').value === "--Select One--")
                                        {
                                            alert("Please select Issue Type");
                                            document.getElementById('sapissuetype').focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                            var issueid = document.getElementById('issu').value;
                            var currntstatus = document.getElementById('currentstatus').value;
                            if (currntstatus === 'Customizing Request' || currntstatus === 'Workbench Request') {
                                getCRIds(issueid);
                                if (crids === '') {
                                    alert('Please add CR ID before update');
                                    showcrid();
                                    return false;
                                }
                            }
                            var devtest = "notestcasesadded";
                            if (fromPage === "Development" && devtest === "notestcasesadded") {
                                var funct = document.getElementsByName("functionality");
                                if (funct.length === 0) {
                                    document.getElementById('testcaseindev').value = "notestcasesadded";
                                }
                                devtest = document.getElementById('testcaseindev').value;
                            }
                            if (fromPage === "QA-BTC" || devtest === "testcaseindev") {

                                var func = document.getElementsByName("functionality");
                                var desc = document.getElementsByName("description");
                                var rslt = document.getElementsByName("expectedresult");
                                for (var i = 0; i < func.length; i++) {

                                    if (trim(func[i].value) === '') {
                                        alert('Please enter the Functionality');
                                        func[i].focus();
                                        return false;
                                    }
                                    var functext = func[i].value;
                                    if ((functext.length) > 1000) {
                                        alert('Functionality length should be less than 1000');
                                        func[i].focus();
                                        return false;
                                    }
                                    if (trim(desc[i].value) === '') {
                                        alert('Please enter the Description');
                                        desc[i].focus();
                                        return false;
                                    }
                                    var desctext = desc[i].value;
                                    if ((desctext.length) > 1000) {
                                        alert('Description length should be less than 1000');
                                        desc[i].focus();
                                        return false;
                                    }
                                    if (trim(rslt[i].value) === '') {
                                        alert('Please enter the Expected Result');
                                        rslt[i].focus();
                                        return false;
                                    }
                                    var rslttext = rslt[i].value;
                                    if ((rslttext.length) > 1000) {
                                        alert('Expected Result length should be less than 1000');
                                        rslt[i].focus();
                                        return false;
                                    }

                                }
                                if (func.length === 0) {
                                    fromPage = "Development";
                                    devtest = "notestcasesadded";
                                }
                            }

                            if (document.getElementById("usub") !== null) {
                                if (trim(document.getElementById("usub").value) === "")
                                {
                                    alert("Please Enter the subject");
                                    document.getElementById("usub").focus();
                                    return false;
                                }
                            }
                            if (document.getElementById("udes") !== null) {
                                if (trim(CKEDITOR.instances.udes.getData()) === "")
                                {
                                    alert("Please Enter the description");
                                    CKEDITOR.instances.udes.focus();
                                    return false;
                                }
                                if (CKEDITOR.instances.udes.getData().length > 4000)
                                {
                                    alert(" description exceeds 4000 character");
                                    CKEDITOR.instances.udes.focus();
                                    //        document.theForm.description.value == "";
                                    return false;
                                }
                            }
                            if (document.getElementById("uexpected_result") !== null) {
                                if (trim(CKEDITOR.instances.uexpected_result.getData()) === "")
                                {
                                    alert("Please Enter the expected result");
                                    CKEDITOR.instances.uexpected_result.focus();
                                    return false;
                                }
                                if (CKEDITOR.instances.uexpected_result.getData().length > 2000)
                                {
                                    alert(" expected result exceeds 2000 character");
                                    CKEDITOR.instances.uexpected_result.focus();
                                    //        document.theForm.description.value == "";
                                    return false;
                                }
                            }

                            if (!(fromPage === "QA-BTC" || devtest === "testcaseindev")) {
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
                            if (document.getElementById('issuestatus').value === 'Closed') {
                                if ($('#lastRow').length) {
                                } else {
                                    newRow();
                                }
                                var check = document.getElementById('feedback').value;
                                if (check === 'Select') {
                                    alert('Your feedback is valuable for us');
                                    document.getElementById('feedback').focus();
                                    return false;
                                }

                            }
//                            if (document.getElementById("issues").value === '') {
//                                alert('Please select at least one component');
//                                document.getElementById('issues').value = '';
//                                $('.ms-choice').focus();
//                                return false;
//                            }

                            if (document.getElementById('issuestatus').value === 'Closed') {
                                if (document.getElementById('feedback').value === 'Excellent' && document.getElementById('feedbackString').value === '') {
                                    alert('Thanks for your recognition by providing Excellent rating! Please provide inputs for us to maintain the same rating');
                                    document.getElementById('feedbackString').focus();
                                    return false;
                                }
                                else if (document.getElementById('feedback').value === 'Good' && document.getElementById('feedbackString').value === '') {
                                    alert('Thanks for Good rating! Please provide your inputs for us to upgrade to Excellent rating');
                                    document.getElementById('feedbackString').focus();
                                    return false;
                                }
                                else if (document.getElementById('feedback').value === 'Average' && document.getElementById('feedbackString').value === '') {
                                    alert('We are sorry for not exceeding your expectations. Please provide your valuable feedback for improvement');
                                    document.getElementById('feedbackString').focus();
                                    return false;
                                }
                                else if (document.getElementById('feedback').value === 'Need Improvement' && document.getElementById('feedbackString').value === '') {
                                    alert('We apologize for not meeting your expectations. Please provide your valuable feedback for improvement');
                                    document.getElementById('feedbackString').focus();
                                    return false;
                                }
                            }

                            monitorSubmit();
                        }
                        function deleteCrid(sno) {
                            var issueid = document.getElementById('issu').value;
                            if (xmlhttp !== null) {

                                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/deleteCrId.jsp?sno=" + encodeURIComponent(sno) + "&issueIdForCr=" + issueid + "&random=" + Math.random(1, 10), false);
                                xmlhttp.onreadystatechange = function() {
                                    if (xmlhttp.readyState === 4)
                                    {
                                        if (xmlhttp.status === 200)
                                        {
                                            var comp = xmlhttp.responseText;
                                            $('#crrow').html("");
                                            $('.credit').remove();
                                            $('#crrow').replaceWith(comp);
                                            openEdit();
                                        }
                                    }
                                };
                                xmlhttp.send(null);
                            } else {
                                alert('no ajax request');
                            }

                        }
                        function incrCrId() {
                            var rowCount = $('#cridpopup > div > table tbody tr').length;
                            if (rowCount <= 5) {
                                var addNew = "<tr id='" + rowCount + "cr' style='height:30px;'><td  style='width:30%;'><input type='text' name='crId' maxlength='10'/></td><td colspan='2'><input type='text' name='crDescription'/><img class='removecr' src='/eTracker/images/remove.gif' onclick='removeCr(" + rowCount + ");' style='cursor:pointer;'></td></tr>";
                                $('#cridpopup > div > table tbody ').append(addNew);
                            } else {
                                $('#addissue').hide('Bounce');
                            }
                        }
                        function removeCr(current) {
                            $('#' + current + 'cr').remove();
                            $('#addissue').show('Bounce');
                        }

                    </SCRIPT>
                    </HEAD>
                    <BODY>
                        <jsp:useBean id="mu" class="com.eminent.util.ModuleUtil"/>
                        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
                        <% String userin = request.getParameter("userin");
                            String status1 = request.getParameter("status");
                            List<Modules> modules = new ArrayList<Modules>();
                        %>
                        <FORM name="theForm" onSubmit='return fun(this);' action="<%= request.getContextPath()%>/admin/dashboard/modifyIssueForAdmin.jsp" method="post">
                            <%@ page import="java.sql.*,java.text.*,com.pack.*,pack.eminent.encryption.*"%>
                            <%@ include file="/header.jsp"%>

                            <div class="addTargetCount " style="display: none;">
                                <div>
                                </div>
                            </div>

                            <div class="esclQues " style="display: none;">
                                <div>
                                </div>
                            </div>
                            <div align="center">
                                <center>

                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr border="2" bgcolor="#C3D9FF">
                                            <td border="1" align="left" width="70%"><font size="4"
                                                                                          COLOR="#0000FF"><b>Dashboard</b></font><FONT SIZE="3" COLOR="#0000FF"></FONT> <%if (userin != null) {
                                                                                                  if ((userin.equalsIgnoreCase("MyAssignment")) || (userin.equalsIgnoreCase("MyIssues")) || (userin.equalsIgnoreCase("statusWise")) || (userin.equalsIgnoreCase("MyDashboard")) || (userin.equalsIgnoreCase("MySearches")) || (userin.equalsIgnoreCase("MyViews"))) {%><td class="previous" align="right"><img id="prev"  class="prevBtn" src="<%=request.getContextPath()%>/images/prev.png"  style="cursor: pointer;" ></img>Prev Next<img id="next" class="nextBtn" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></img></td><%}
                                                                                                      }%>
                                                </FONT></td>
                                                <%
                                                    if (request.getParameter("updatestatus") != null) {
                                                %>
                                            <td colspan="3" align="CENTER" height="21"><font face="Tahoma"
                                                                                             size="3" color="#0000ff"><%= "Updated Successfully"%></font></td>
                                                    <%
                                                        }
                                                    %>
                                        </tr>
                                    </table>
                                    <%String sorton = request.getParameter("sorton");
                                        String sort_method = request.getParameter("sort_method");
                                        String mail = (String) session.getAttribute("theName");
                                        String url = null;
                                        if (mail != null) {
                                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                        }
                                        String no = request.getParameter("issueNo");
                                        String issueid = request.getParameter("issueid");
                                        String message = request.getParameter("message");
                                        if (no == null) {
                                            no = issueid;
                                        }
                                        session.setAttribute("theissu", no);
                                        int count = 0;
                                        if (url.equals("eminentlabs.net")) {
                                            count = IssueDetails.eTrackerIssueSearchCount(null, no);
                                        }
                                    %> <br>
                                        <table width="100%" bgcolor="#C3D9FF">
                                            <tr align="left">
                                                <td><b>Issue Number <font color="#0000FF"><%= (String) session.getAttribute("theissu")%></font></b>
                                                    <input type="hidden"  id="message" value="<%= message%>" /></td>
                                                <td align="right"><%if (url.equals("eminentlabs.net")) {%>
                                                    <span class="refer" style="color: blue;cursor: pointer;margin-right: 20px;">Reference<%if (count > 0) {%>
                                                        (<%=count%>)
                                                        <%}%></span>
                                                    <%}%><a
                                                        href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= session.getAttribute("theissu")%>"
                                                        target="_blank">Print this Issue</a></td>
                                            </tr>
                                        </table>
                                        <br>
                                            <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" /> 
                                            <%!
                                                HashMap hm;
                                                Connection connection = null;
                                                Statement stmt2 = null, stmt4 = null, stmt5 = null, stmt6 = null, st5 = null;
                                                PreparedStatement pt2 = null;
                                                ResultSet rs3 = null, rs2 = null, rs4 = null, rs5 = null, rs6 = null;
                                                String status = null;
                                                int role = 0, uid = 0, pmanager = 0, dmanager = 0, amanager = 0;
                                                String product = "", fixversion = "", pri = "";
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            %> 
                                            <%
                                                HashMap<Integer, String> member = GetProjectMembers.showUsers();

                                                String[][] crIdDetails = IssueDetails.getCRIDS(issueid);
                                                try {
                                                    connection = MakeConnection.getConnection();

                                                    product = request.getParameter("product");
                                                    String customer = request.getParameter("customer");
                                                    String foundversion = request.getParameter("foundversion");
                                                    fixversion = request.getParameter("fixversion");
                                                    String platform = request.getParameter("platform");
                                                    String module = request.getParameter("module");
                                                    pri = request.getParameter("priority");
                                                    String sev = request.getParameter("severity");
                                                    String type = request.getParameter("type");
                                                    String issuestatus = request.getParameter("issuestatus");
                                                    String createdon = request.getParameter("createdon");
                                                    String createdby = request.getParameter("createdby");
                                                    String assignedto = request.getParameter("assignedto");
                                                    String modifiedon = request.getParameter("modifiedon");
                                                    String dueDate = request.getParameter("dueDate");
                                                    String projecttype = request.getParameter("projecttype");
                                                    String subject = request.getParameter("subject");
                                                    String description = request.getParameter("description");
                                                    String rootcause = request.getParameter("rootcause");
                                                    String expected_result = request.getParameter("expected_result");
                                                    String estimated_time = request.getParameter("timeestimation");
                                                    String sapIssueType = request.getParameter("sapIssueType");
                                                    if (sapIssueType == null || sapIssueType.equals("null")) {
                                                        sapIssueType = "--Select One--";
                                                    }
                                                    String comment = request.getParameter("comment");
                                                    String pid = ProjectFinder.getProjectId(product, fixversion);
                                                    modules = mu.findModulesByPid(new BigDecimal(pid));
                                                    String viewDueDate = request.getParameter("viewDueDate");
                                                    String escalation = request.getParameter("escalation");
                                                    String mainIssue = request.getParameter("mainIssue");

                                                    role = (Integer) session.getAttribute("Role");
                                                    uid = (Integer) session.getAttribute("userid_curr");
                                                    pmanager = Integer.parseInt(GetProjectManager.getManager(product, fixversion));
                                                    dmanager = Integer.parseInt(GetProjectManager.getDManager(product, fixversion));
                                                    if (connection != null) {
                                                        if (hm == null) {
                                                            logger.info("Calling users");
                                                            hm = UpdateIssue.showUsers(connection);
                                                        }
                                                    }

                                                    // Selecting Test Cases for this issue
                                                    List testcaseobjects = IssueTestCaseUtil.viewIssueTestCase(issueid);
                                                    int noOfTestCases = testcaseobjects.size();
                                                    logger.info("No Of Test Cases" + noOfTestCases);
                                            %>
                                            <table width="100%" bgcolor="E8EEF7">
                                                <tbody id="mainBody">
                                                    <tr height="21" align="left">
                                                        <td width="17%"><B>Customer </B></td>
                                                        <td width="27%" align="left" color="#bbbbbb"><%= customer%></td>

                                                        <td width="8%"><B>Product </B></td>
                                                        <td width="22%"><%= product%><%=" v"%><%= foundversion%></td>

                                                        <td width="11%"><B>Fix Version</B></td>

                                                        <%
                                                            st5 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                            rs5 = st5.executeQuery("SELECT version FROM project p,project_type t WHERE p.pid=t.pid and pname='" + product + "'");
                                                            float found = Float.valueOf(foundversion).floatValue();
                                                            float fixVersion = Float.valueOf(fixversion).floatValue();
                                                            rs5.last();
                                                            int cnt = rs5.getRow();
                                                            rs5.beforeFirst();
                                                            if (cnt == 1) {
                                                                logger.info("Inside Fix Version" + fixversion);
                                                        %>
                                                        <td width="19%"><input type="text" name="fix_version"
                                                                               value="<%=fixversion%>" size="4" readonly="true"></td>
                                                            <%
                                                            } else {
                                                            %>
                                                        <td width="19%"><select name="fix_version" size="1" onchange="javascript:isModuleExist();">
                                                                <%
                                                                    if (rs5 != null) {
                                                                        while (rs5.next()) {

                                                                            String fix_ver = rs5.getString(1);
                                                                            float fixver = Float.valueOf(fix_ver).floatValue();
                                                                            logger.info("Found Version" + found + "Fix Version" + fixver);
                                                                            if (fixver >= found) {
                                                                                if (fixver == fixVersion) {
                                                                %>
                                                                <option value="<%= fixVersion%>" selected><%= fixVersion%></option>
                                                                <%
                                                                } else {
                                                                %>
                                                                <option value="<%=fix_ver%>"><%=fix_ver%></option>
                                                                <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                        </td>
                                                    </tr>
                                                    <tr height="21" align="left">
                                                        <td width="17%"><B>Type </B></td>
                                                        <td width="27%">
                                                            <%if (pmanager == uid || dmanager == uid) {
                                                                    String[] types = {"New Task", "Enhancement", "Bug"};
                                                            %>
                                                            <select name="newType">
                                                                <%
                                                                    for (int i = 0; i < types.length; i++) {
                                                                %>
                                                                <option value="<%= types[i]%>" <% if (type.equals(types[i])) {%> selected <%}%> ><%= types[i]%></option>                                                      
                                                                <% }%>
                                                            </select> 
                                                            <%} else {%>
                                                            <%=type%>
                                                            <%}%>                                                        
                                                        </td>

                                                        <td width="8%"><B>Module </B></td>
                                                        <td width="22%"><%if (pmanager == uid || dmanager == uid) {%>
                                                            <select name="newModule" id="newModule" >
                                                                <%for (Modules mod : modules) {
                                                                        if (mod.getModule().equalsIgnoreCase(module)) {
                                                                %>
                                                                <option value="<%=mod.getModuleid()%>" selected><%=mod.getModule()%></option>
                                                                <%} else {%>
                                                                <option value="<%=mod.getModuleid()%>" ><%=mod.getModule()%></option>
                                                                <%}
                                                                    }%>
                                                            </select>

                                                            <%} else {%>
                                                            <%=module%>
                                                            <%}%>
                                                        </td>

                                                        <td width="11%"><B>Platform</B></td>
                                                        <td width="19%"><%= platform%></td>
                                                    </tr>
                                                    <tr height="21" align="left">
                                                        <td width="17%"><B>Severity </B></td>

                                                        <%
                                                            String[] severityExist = {"S1- Fatal", "S2- Critical", "S3- Important", "S4- Minor"};
                                                            String severity = sev;
                                                        %>
                                                        <td width="27%">
                                                            <%
                                                                if ((role == 1) || pmanager == uid) {
                                                            %> <select name="severity" size="1">
                                                                <%
                                                                    for (int i = 0; i < severityExist.length; i++) {
                                                                        if (severity.equals(severityExist[i])) {
                                                                %>
                                                                <option value="<%= severity%>" selected><%= severity%></option>
                                                                <%
                                                                } else {
                                                                %>
                                                                <option value="<%= severityExist[i]%>"><%= severityExist[i]%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select> <%
                                                            } else {
                                                                for (int i = 0; i < severityExist.length; i++) {
                                                                    if (severity.equals(severityExist[i])) {
                                                            %> <input type=text size="10" name="severity"
                                                                   value="<%= severity%>" readonly="true" /> <%
                                                                               }

                                                                           }

                                                                       }
                                                            %>
                                                        </td>
                                                        <td width="8%"><B>Priority</B></td>

                                                        <%
                                                            String[] priorityExist = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};
                                                            String priority = pri;
                                                        %>
                                                        <td width="22%">
                                                            <%
                                                                if ((role == 1) || pmanager == uid) {
                                                            %> <select name="priority">
                                                                <%
                                                                    for (int i = 0; i < priorityExist.length; i++) {
                                                                        if (priority.equals(priorityExist[i])) {
                                                                %>
                                                                <option value="<%= priority%>" selected><%= priority%></option>

                                                                <%
                                                                } else {
                                                                %>
                                                                <option value="<%= priorityExist[i]%>"><%= priorityExist[i]%></option>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </select> <%
                                                            } else {
                                                                for (int i = 0; i < priorityExist.length; i++) {
                                                                    if (priority.equals(priorityExist[i])) {
                                                            %> <input type=text size="10" name="priority"
                                                                   value="<%= priority%>" readonly="true" /> <%
                                                                               }

                                                                           }
                                                                       }
                                                            %>
                                                        </td>
                                                        <td width="11%"><B>IssueStatus</B></td>

                                                        <%
                                                            String status = issuestatus.trim();
                                                            ArrayList<String> issueStatus = null;
                                                            if (projecttype.equalsIgnoreCase("Implementation") || projecttype.equalsIgnoreCase("Upgradation") || projecttype.equalsIgnoreCase("Support")) {
                                                                issueStatus = StatusSelector.getSapStatusList(projecttype, status);
                                                            } else {
                                                                issueStatus = StatusSelector.getStatusList(status);
                                                            }

                                                            int creBy = Integer.parseInt(createdby);

                                                            if (((role == 1) || (pmanager == uid || dmanager == uid)) && !(status.equalsIgnoreCase("QA-BTC")) && !(status.equalsIgnoreCase("QA-TCE"))) {
                                                                logger.info("Status" + status);
                                                                logger.info("Role" + role);
                                                                logger.info("Uid" + uid);
                                                                logger.info("P Manager" + pmanager);
                                                        %>
                                                        <td width="19%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
                                                                                            <option value="<%= status%>" selected><%= status%></option>
                                                                                            <%
                                                                                                issueStatus.remove(status);
                                                                                                for (String stat : issueStatus) {

                                                                                            %>
                                                                                            <option value="<%= stat%>"><%= stat%></option>
                                                                                            <%

                                                                                                }
                                                                                            %>

                                                                                        </SELECT></td>
                                                                                        <%
                                                                                        } else if ((status.equalsIgnoreCase("Unconfirmed")) && (!(pmanager == uid || dmanager == uid) || (!(role == 1)))) {

                                                                                            logger.info("Status for ordinory users" + status);
                                                                                        %>
                                                        <td width="19%"><B></B> <%= status%><input type="hidden"
                                                                                                       name="issuestatus" id="issuestatus" value="<%= status%>" /></td>




                                                        <%
                                                        } else if (status.equalsIgnoreCase("QA-BTC") && noOfTestCases < 1) {

                                                            logger.info("Status with no test case" + status);
                                                        %>
                                                        <td width="20%"><B></B> <%= status%><input type="hidden" id="issuestatus"
                                                                                                       name="issuestatus" value="<%= status%>" /></td>
                                                            <%

                                                            } else if (status.equalsIgnoreCase("QA-TCE")) {
                                                                boolean flag = StatusFlow.getFlow(issueid);
                                                                logger.info("Sap Status" + flag);
                                                                if (!flag) {
                                                                    issueStatus.remove("Transport to PS");

                                                                }
                                                            %>
                                                        <td width="19%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
                                                                                            <option value="<%= status%>" selected><%= status%></option>
                                                                                            <%
                                                                                                issueStatus.remove(status);
                                                                                                for (String stat : issueStatus) {

                                                                                            %>
                                                                                            <option value="<%= stat%>"><%= stat%></option>
                                                                                            <%

                                                                                                }
                                                                                            %>

                                                                                        </SELECT></td>
                                                                                        <%
                                                                                        } else {
                                                                                        %>
                                                        <td width="19%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
                                                                                            <option value="<%= status%>" selected><%= status%></option>
                                                                                            <%
                                                                                                issueStatus.remove(status);
                                                                                                for (String stat : issueStatus) {
                                                                                                    if (!stat.equalsIgnoreCase("Closed")) {
                                                                                            %>
                                                                                            <option value="<%= stat%>"><%= stat%></option>
                                                                                            <%
                                                                                            } else {

                                                                                                if (uid == creBy) {
                                                                                            %>
                                                                                            <option value="<%= stat%>"><%= stat%></option>
                                                                                            <%
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            %>
                                                                                        </SELECT></td>
                                                                                        <%
                                                                                            }

                                                                                            GetName g = new GetName();
                                                                                        %>
                                                    </tr>
                                                    <tr align="left">
                                                        <td width="13%"><B>DateCreated </B></td>
                                                        <td width="27%"><%= createdon%></td>

                                                        <td width="8%"><B>DateModified </B></td>
                                                        <td width="22%"><%= modifiedon%></td>

                                                        <td width="11%"><B>CreatedBy </B></td>
                                                        <td width="19%"><%= g.getUserName(createdby)%></td>
                                                    </tr>
                                                    <tr align="left">


                                                        <td width="15%"><B><img  title="Add CrId" src="/eTracker/images/plus.gif" style="height: 10px;" onclick="showcrid()"></img><B>Assigned To</B> </td>

                                                        <%

                                                            if (connection != null) {

                                                                int assigned = 0;
                                                                int useridassi = 0;
                                                                HashMap hm;
                                                                hm = GetProjectMembers.getMembers(product, fixversion, createdby, assignedto);
                                                                LinkedHashMap al = GetProjectMembers.sortHashMapByValues(hm, true);
                                                                Collection set = al.keySet();
                                                                Iterator iter = set.iterator();

                                                        %>
                                                        <%                            if (status.equalsIgnoreCase("Solution Review")) {
                                                                if (pmanager == Integer.parseInt(assignedto)) {
                                                        %>
                                                        <td width="27%">
                                                            <select name="assignedto" id="assignedto" size="1" maxlength="4">
                                                                <option value="<%=pmanager%>"><%=GetProjectManager.getUserName(pmanager)%></option>
                                                            </select>
                                                        </td>
                                                        <%} else {%>
                                                        <td width="27%"><select name="assignedto" id="assignedto" size="1" maxlength="4">
                                                                <%
                                                                    while (iter.hasNext()) {
                                                                        String key = (String) iter.next();
                                                                        String nameofuser = (String) al.get(key);
                                                                        useridassi = Integer.parseInt(key);
                                                                        if (useridassi == Integer.parseInt(assignedto)) {
                                                                            int assign = useridassi;
                                                                %>
                                                                <option value="<%=assign%>" selected><%=nameofuser%></option>
                                                                <%
                                                                } else {
                                                                    int assign = useridassi;
                                                                %>
                                                                <option value="<%=assign%>"><%=nameofuser%></option>
                                                                <%
                                                                        }
                                                                    }%></select></td><%
                                                                        }
                                                                    } else {%>
                                                        <td width="27%"><select name="assignedto" id="assignedto" size="1" maxlength="4">

                                                                <% while (iter.hasNext()) {

                                                                        String key = (String) iter.next();
                                                                        String nameofuser = (String) al.get(key);
                                                                        logger.info("Userid" + key);
                                                                        logger.info("Name" + nameofuser);
                                                                        useridassi = Integer.parseInt(key);
                                                                        if (useridassi == Integer.parseInt(assignedto)) {
                                                                            int assign = useridassi;
                                                                %>
                                                                <option value="<%=assign%>" selected><%=nameofuser%></option>
                                                                <%
                                                                } else {
                                                                    int assign = useridassi;
                                                                %>
                                                                <option value="<%=assign%>"><%=nameofuser%></option>
                                                                <%
                                                                        }
                                                                    }%>
                                                            </select></td>
                                                            <% }

                                                            %>

                                                        <td width="9%"><B>Files Attached </B><img  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showFileAttach()"></img></td>

                                                        <%                    int count1 = 1;
                                                            String sql3 = "select count(*) from fileattach where issueid='" + issueid + "' ";
                                                            pt2 = connection.prepareStatement(sql3);
                                                            rs3 = pt2.executeQuery();
                                                            if (rs3 != null) {
                                                                if (rs3.next()) {
                                                                    count1 = rs3.getInt(1);
                                                                    logger.debug("count1" + count1);
                                                                }
                                                            }

                                                            if (count1 > 0) {
                                                                if (!url.equals("continental-corporation.com")) {
                                                        %>
                                                        <td id="filesIssue"> <A	onclick="viewFileAttachForIssue('<%=issueid%>');" href="#"
                                                                                >ViewFiles(<%=count1%>)</A></td>
                                                                <%} else {%>
                                                        <td id="filesIssue"> ViewFiles</td>
                                                        <%}%>
                                                        <%
                                                        } else {
                                                        %>
                                                        <td id="filesIssue"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                                                <%
                                                                    }
                                                                %>

                                                        <td width="13%"><B>Due Date </B></td>
                                                                <%
                                                                    if ((role == 1) || (pmanager == uid || dmanager == uid)) {
                                                                %>
                                                        <td width="27%"><input type="text" id="duedate" name="duedate" maxlength="10" size="10"
                                                                               value="<%= dueDate%>" readonly /></td>
                                                            <%
                                                            } else {
                                                            %>
                                                        <td width="27%"><%= (String) session.getAttribute("dueDisplay")%></td>
                                                        <td><input type="hidden" name="duedate" id="duedate" value="<%= dueDate%>" /></td>
                                                        <%
                                                            }
                                                        %>
                                                    </tr>
                                                    <%//edited by sowjanya
                                                        if (pmanager == uid || dmanager == uid) {%>
                                                    <tr>     
                                                        <td width="12%"><B>Components </B></td>
                                                        <td width="30%"><div id="issuecomponent"> 
                                                                <select multiple="multiple" name="issues" id="issues" size="1">
                                                                    <%                                                                HashMap c1;
                                                                        c1 = ApmComponentController.getComponents();
                                                                        List<BigDecimal> values = atc.findcomponentsByIssueId(issueid);
                                                                        Collection setone = c1.keySet();
                                                                        Iterator<BigDecimal> iterator = setone.iterator();
                                                                        while (iterator.hasNext()) {

                                                                            BigDecimal key = iterator.next();
                                                                            String nameofcomponent = (String) c1.get(key);
                                                                            if (values.contains(key)) {

                                                                    %>
                                                                    <option value="<%=key%>" selected="selected"><%=nameofcomponent%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%=key%>" ><%=nameofcomponent%></option>
                                                                    <%
                                                                            }

                                                                        }
                                                                    %>

                                                                </select>


                                                            </div>
                                                        </td>
                                                        <td width="12%"><B>
                                                                <%if (escalation != null && escalation.equalsIgnoreCase("yes")) {%>
                                                                <span id="escshow" style="cursor: pointer;text-decoration: underline;">Escalation</span>
                                                                <%} else {%>
                                                                Escalation
                                                                <%}%>	
                                                            </B></td>
                                                        <td width="30%">

                                                            <%if (escalation == null || escalation.equalsIgnoreCase("null") || escalation.equalsIgnoreCase("no")) {%>
                                                            <input type="checkbox" name="escalation" value="yes"/>
                                                            <input type="hidden" name="que1" id="que1" />
                                                            <input type="hidden" name="que2" id="que2" />
                                                            <input type="hidden" name="que3" id="que3" />
                                                            <input type="hidden" name="que4" id="que4" />
                                                            <input type="hidden" name="que5" id="que5" />
                                                            <input type="hidden" name="que6" id="que6" />
                                                            <input type="hidden" name="que7" id="que7" />
                                                            <input type="hidden" name="que8" id="que8" />
                                                            <input type="hidden" name="que9" id="que9" />
                                                            <input type="hidden" name="que10" id="que10" />
                                                            <%} else {%>
                                                            <input type="hidden" name="escalation"  value="yes"/>
                                                            <input type="checkbox" name="escalation" checked="checked" value="yes" disabled="disabled"/>
                                                            <%}%>	
                                                        </td>
                                                    </tr>
                                                    <%} else {

                                                    %>   <tr height="21">
                                                        <td width="12%"><b>Components</b></td>
                                                        <%                                String cs = "", sc = "";
                                                            List<ApmComponentIssues> listc = atc.findByIssueId(issueid);
                                                            for (ApmComponentIssues listl : listc) {
                                                                cs = listl.getComponentId().getComponentName();

                                                                sc = sc + cs + ',';
                                                            }
                                                            if ((sc.length() > 2) && (sc.charAt(sc.length() - 1) == ',')) {
                                                                sc = sc.substring(0, (sc.length() - 1));
                                                            }

                                                        %>

                                                        <td  align="left"><b></b><%=sc%></td>
                                                        <td width="12%">                                                            
                                                            <B>
                                                                <%
                                                                    sql3 = "select amanager from ISSUE I, PROJECT P WHERE ISSUEID='" + issueid + "' AND I.PID = P.PID ";
                                                                    pt2 = connection.prepareStatement(sql3);
                                                                    rs3 = pt2.executeQuery();
                                                                    if (rs3 != null) {
                                                                        if (rs3.next()) {
                                                                            amanager = rs3.getInt(1);
                                                                        }
                                                                    }
                                                                    if (escalation != null && escalation.equalsIgnoreCase("yes") && amanager == uid || role == 1) {%>
                                                                <span id="escshow" style="cursor: pointer;text-decoration: underline;">Escalation</span>
                                                                <%} else {%>
                                                                Escalation
                                                                <%}%>	
                                                            </B>
                                                        </td>
                                                        <td colspan="3"  width="30%">
                                                            <%if (escalation != null && escalation.equalsIgnoreCase("yes")) {%>
                                                            <input type="hidden" name="escalation"  value="yes"/>
                                                            <input type="checkbox" name="escalation" checked="checked" value="yes" disabled="disabled"/>
                                                            <%} else {%>
                                                            <input type="hidden" name="escalation"  value="no"/>
                                                            <input type="checkbox" name="escalation" value="yes" disabled="disabled"/>
                                                            <%}%>
                                                        </td>
                                                    </tr>  <%}//edited by sowjanya
                                                    %>  
                                                    <%          if (crIdDetails.length < 1) {%>
                                                    <tr  style="font-weight: bold;" id="crrow" ></tr>
                                                    <%} else {%>
                                                    <tr  style="font-weight: bold;" id="crrow" ><td align="left" width="16%">CR ID <a  onclick="export2Excel();" href="#">Export</a></td><td align="left" class="crnormal" onclick="openEdit();" style="cursor: pointer;color:  #3333cc;" title="Expand All">View CRID(<%=crIdDetails.length%>)</td><td  class="credit" colspan="2" onclick="openNormal();" title="Collapse All" style="cursor: pointer;">CR ID Description</td><td  class="credit" >Created On</td><td  class="credit" >Status</td><td  class="credit" >Created By</td></tr>
                                                    <%

                                                        for (int i = 0; i < crIdDetails.length; i++) {
                                                            if (crIdDetails[i][0] != null) {
                                                                String key = crIdDetails[i][0].trim();
                                                                String desc = crIdDetails[i][1].trim();
                                                                String sno = crIdDetails[i][2].trim();
                                                                String createdBy = crIdDetails[i][3].trim();
                                                                String createdOn = crIdDetails[i][4].trim();
                                                                String crstatus = crIdDetails[i][5].trim();
                                                                if (i % 2 == 0) {%>
                                                    <tr class="credit" id="del<%=sno%>"  style="background-color:#FFFFFF;"  >  
                                                        <%} else {%>
                                                        <tr class="credit" id="del<%=sno%>" style="background-color:#C3D9FE;" >
                                                            <%}%>

                                                            <td class="key<%=sno%>" style="text-align: left;"><img  src='/eTracker/images/edit.png' onclick="editcrid('<%=sno%>', '<%=key%>', '<%=desc%>');" style="cursor: pointer;" ></img><%=key%></td>
                                                            <td class="desc<%=sno%>" colspan="2" style="text-align: left;"><%=desc%></td>
                                                            <td style="text-align: left;"><%=createdOn%></td>
                                                            <td style="text-align: left;"><%=crstatus%></td>
                                                            <td style="text-align: left;">
                                                                <%if (!createdBy.equalsIgnoreCase("Nil")) {%>
                                                                <%=member.get(Integer.valueOf(createdBy))%>
                                                                <%} else {%>
                                                                Nil
                                                                <% }%><img src="<%=request.getContextPath()%>/images/remove.gif" alt="Remove CrId" style="cursor: pointer;" onclick="javascript :deleteCrid('<%=sno%>');"/></td>
                                                        </tr>

                                                        <% }
                                                                }
                                                            }
                                                        %>


                                                        <%
                                                            String projecttypename = null;
                                                            String phase1 = null;
                                                            String subphase1 = null;
                                                            String subsubphase1 = null;
                                                            String subsubsubphase1 = null;
                                                            String phase2 = null;
                                                            String subphase2 = null;
                                                            String subsubphase2 = null;
                                                            String subsubsubphase2 = null;
                                                            String phase3 = null;
                                                            String subphase3 = null;
                                                            String subsubphase3 = null;
                                                            String subsubsubphase3 = null;
                                                            String phase4 = null;
                                                            String subphase4 = null;
                                                            String subsubphase4 = null;
                                                            String subsubsubphase4 = null;
                                                            String phase = null;
                                                            String subphase = null;
                                                            String subsubphase = null;
                                                            String subsubsubphase = null;
                                                            if (!request.getParameter("phase").equalsIgnoreCase("null") && !request.getParameter("subphase").equalsIgnoreCase("null") && !request.getParameter("subsubphase").equalsIgnoreCase("null") && !request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                                projecttypename = "project_" + projecttype.toLowerCase();
                                                                stmt2 = connection.createStatement();
                                                                if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                    rs2 = stmt2.executeQuery("SELECT DISTINCT PHASE,PHASEINDEX FROM " + projecttypename + " order BY PHASEINDEX");
                                                                }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><B>Phase</B><input type="hidden"
                                                                                                   id="projecttype" name="projecttype" value="<%=projecttype%>"></td>
                                                            <td colspan="5"><select id="phase" name="phase" size="1"
                                                                                    onchange="javascript:phasechange();
                                                                                            javascript:callsubphase();
                                                                                            javascript:callsubphase1();">
                                                                    <%
                                                                        phase = null;
                                                                        if (rs2 != null) {
                                                                            while (rs2.next()) {
                                                                                phase = rs2.getString(1);
                                                                                if (!phase.equalsIgnoreCase("null")) {
                                                                                    if (phase.equals(request.getParameter("phase"))) {
                                                                    %>
                                                                    <option value="<%=phase%>" selected><%=phase%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%=phase%>"><%=phase%></option>
                                                                    <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }

                                                                        stmt4 = connection.createStatement();
                                                                        phase1 = request.getParameter("phase");
                                                                        projecttypename = "project_" + projecttype.toLowerCase();
                                                                        if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                            rs4 = stmt4.executeQuery("SELECT DISTINCT SUBPHASE,SUBPHASEINDEX FROM " + projecttypename + " where phase= '" + phase1 + "' order BY SUBPHASEINDEX");
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subphase1" style="position: relative; visibility: visible">Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subphase" name="subphase" size="1"
                                                                                                  onchange="javascript:subphasechange();
                                                                                                          javascript:callsubsubphase();
                                                                                                          javascript:callsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subphase = null;
                                                                            if (rs4 != null) {
                                                                                while (rs4.next()) {
                                                                                    subphase = rs4.getString("SUBPHASE");
                                                                                    if (subphase != null) {
                                                                                        if (subphase.equals(request.getParameter("subphase"))) {
                                                                        %>
                                                                        <option value="<%=subphase%>" selected><%=subphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subphase%>"><%=subphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }

                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subphase').style.visibility = 'visible';
                                                                        document.getElementById('subphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubPhaseSubmit" value="true" /></td>
                                                        </tr>

                                                        <%                                                            projecttypename = "project_" + projecttype.toLowerCase();
                                                            phase2 = request.getParameter("phase");
                                                            subphase2 = request.getParameter("subphase");
                                                            stmt5 = connection.createStatement();
                                                            if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                rs5 = stmt5.executeQuery("SELECT DISTINCT SUBSUBPHASE,SUBSUBPHASEINDEX FROM " + projecttypename + " where phase='" + phase2 + "' and subphase='" + subphase2 + "' order BY SUBSUBPHASEINDEX");
                                                            }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubphase1" style="position: relative; visibility: visible">Sub
                                                                        Sub Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubphase" name="subsubphase" size="1"
                                                                                                  onchange="javascript:callsubsubsubphase();
                                                                                                          javascript:callsubsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subsubphase = null;
                                                                            if (rs5 != null) {
                                                                                while (rs5.next()) {
                                                                                    subsubphase = rs5.getString(1);
                                                                                    if (subsubphase != null) {
                                                                                        if (subsubphase.equals(request.getParameter("subsubphase"))) {
                                                                        %>
                                                                        <option value="<%=subsubphase%>" selected><%=subsubphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subsubphase%>"><%=subsubphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }

                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubphase').style.visibility = 'visible';
                                                                        document.getElementById('subsubphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                                                            projecttypename = "project_" + projecttype.toLowerCase();
                                                            phase3 = request.getParameter("phase");
                                                            subphase3 = request.getParameter("subphase");
                                                            subsubphase3 = request.getParameter("subsubphase");
                                                            stmt6 = connection.createStatement();
                                                            if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                rs6 = stmt6.executeQuery("SELECT DISTINCT SUBSUBSUBPHASE,SUBSUBSUBPHASEINDEX FROM " + projecttypename + " where phase='" + phase3 + "' and subphase='" + subphase3 + "' and subsubphase='" + subsubphase3 + "' order BY SUBSUBSUBPHASEINDEX");
                                                            }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubsubphase1"
                                                                         style="position: relative; visibility: visible">Sub Sub Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubsubphase" name="subsubsubphase"
                                                                                                  size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subsubsubphase = null;
                                                                            if (rs6 != null) {
                                                                                while (rs6.next()) {
                                                                                    subsubsubphase = rs6.getString(1);
                                                                                    if (subsubsubphase != null) {
                                                                                        if (subsubsubphase.equals(request.getParameter("subsubsubphase"))) {
                                                                        %>
                                                                        <option value="<%=subsubsubphase%>" selected><%=subsubsubphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subsubsubphase%>"><%=subsubsubphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }


                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubsubphase').style.visibility = 'visible';
                                                                        document.getElementById('subsubsubphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubsubPhaseSubmit" value="true" /></td>
                                                        </tr>

                                                        <%                                                            }
                                                            if (!request.getParameter("phase").equalsIgnoreCase("null") && !request.getParameter("subphase").equalsIgnoreCase("null") && !request.getParameter("subsubphase").equalsIgnoreCase("null") && request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                                projecttypename = "project_" + projecttype.toLowerCase();
                                                                stmt2 = connection.createStatement();
                                                                if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                    rs2 = stmt2.executeQuery("SELECT DISTINCT PHASE,PHASEINDEX FROM " + projecttypename + " order BY PHASEINDEX");
                                                                }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><B>Phase</B><input type="hidden"
                                                                                                   id="projecttype" name="projecttype" value="<%=projecttype%>"></td>
                                                            <td colspan="5"><select id="phase" name="phase" size="1"
                                                                                    onchange="javascript:phasechange();
                                                                                            javascript:callsubphase();
                                                                                            javascript:callsubphase1();">
                                                                    <%
                                                                        phase = null;
                                                                        if (rs2 != null) {
                                                                            while (rs2.next()) {
                                                                                phase = rs2.getString(1);
                                                                                if (!phase.equalsIgnoreCase("null")) {
                                                                                    if (phase.equals(request.getParameter("phase"))) {
                                                                    %>
                                                                    <option value="<%=phase%>" selected><%=phase%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%=phase%>"><%=phase%></option>
                                                                    <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }

                                                                        stmt4 = connection.createStatement();
                                                                        phase1 = request.getParameter("phase");
                                                                        projecttypename = "project_" + projecttype.toLowerCase();
                                                                        if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                            rs4 = stmt4.executeQuery("SELECT DISTINCT SUBPHASE,SUBPHASEINDEX FROM " + projecttypename + " where phase= '" + phase1 + "' order BY SUBPHASEINDEX");
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subphase1" style="position: relative; visibility: visible">Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subphase" name="subphase" size="1"
                                                                                                  onchange="javascript:subphasechange();
                                                                                                          javascript:callsubsubphase();
                                                                                                          javascript:callsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subphase = null;
                                                                            if (rs4 != null) {
                                                                                while (rs4.next()) {
                                                                                    subphase = rs4.getString("SUBPHASE");
                                                                                    if (subphase != null) {
                                                                                        if (subphase.equals(request.getParameter("subphase"))) {
                                                                        %>
                                                                        <option value="<%=subphase%>" selected><%=subphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subphase%>"><%=subphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }

                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subphase').style.visibility = 'visible';
                                                                        document.getElementById('subphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubPhaseSubmit" value="true" /></td>
                                                        </tr>

                                                        <%                                                            projecttypename = "project_" + projecttype.toLowerCase();
                                                            phase2 = request.getParameter("phase");
                                                            subphase2 = request.getParameter("subphase");
                                                            stmt5 = connection.createStatement();
                                                            if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                rs5 = stmt5.executeQuery("SELECT DISTINCT SUBSUBPHASE,SUBSUBPHASEINDEX FROM " + projecttypename + " where phase='" + phase2 + "' and subphase='" + subphase2 + "' order BY SUBSUBPHASEINDEX");
                                                            }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubphase1" style="position: relative; visibility: visible">Sub
                                                                        Sub Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubphase" name="subsubphase" size="1"
                                                                                                  onchange="javascript:callsubsubsubphase();
                                                                                                          javascript:callsubsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subsubphase = null;
                                                                            if (rs5 != null) {
                                                                                while (rs5.next()) {
                                                                                    subsubphase = rs5.getString(1);
                                                                                    if (subsubphase != null) {
                                                                                        if (subsubphase.equals(request.getParameter("subsubphase"))) {
                                                                        %>
                                                                        <option value="<%=subsubphase%>" selected><%=subsubphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subsubphase%>"><%=subsubphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }


                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubphase').style.visibility = 'visible';
                                                                        document.getElementById('subsubphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                                                            if (request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubsubphase1"
                                                                         style="position: relative; visibility: hidden">Sub Sub Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubsubphase" name="subsubsubphase"
                                                                                                  disabled="disabled" size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubsubphase').style.visibility = 'hidden';
                                                                        document.getElementById('subsubsubphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            }
                                                            if (!request.getParameter("phase").equalsIgnoreCase("null") && !request.getParameter("subphase").equalsIgnoreCase("null") && request.getParameter("subsubphase").equalsIgnoreCase("null") && request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                                projecttypename = "project_" + projecttype.toLowerCase();
                                                                stmt2 = connection.createStatement();
                                                                if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                    rs2 = stmt2.executeQuery("SELECT DISTINCT PHASE,PHASEINDEX FROM " + projecttypename + " order BY PHASEINDEX");
                                                                }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><B>Phase</B><input type="hidden"
                                                                                                   id="projecttype" name="projecttype" value="<%=projecttype%>"></td>
                                                            <td colspan="5"><select id="phase" name="phase" size="1"
                                                                                    onchange="javascript:callsubphase();
                                                                                            javascript:callsubphase1();">
                                                                    <%
                                                                        phase = null;
                                                                        if (rs2 != null) {
                                                                            while (rs2.next()) {
                                                                                phase = rs2.getString(1);
                                                                                if (!phase.equalsIgnoreCase("null")) {
                                                                                    if (phase.equals(request.getParameter("phase"))) {
                                                                    %>
                                                                    <option value="<%=phase%>" selected><%=phase%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%=phase%>"><%=phase%></option>
                                                                    <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }

                                                                        stmt4 = connection.createStatement();
                                                                        phase1 = request.getParameter("phase");
                                                                        projecttypename = "project_" + projecttype.toLowerCase();
                                                                        if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                            rs4 = stmt4.executeQuery("SELECT DISTINCT SUBPHASE,SUBPHASEINDEX FROM " + projecttypename + " where phase= '" + phase1 + "' order BY SUBPHASEINDEX");
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subphase1" style="position: relative; visibility: visible">Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subphase" name="subphase" size="1"
                                                                                                  onchange="javascript:subphasechange();
                                                                                                          javascript:callsubsubphase();
                                                                                                          javascript:callsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            subphase = null;
                                                                            if (rs4 != null) {
                                                                                while (rs4.next()) {
                                                                                    subphase = rs4.getString("SUBPHASE");
                                                                                    if (subphase != null) {
                                                                                        if (subphase.equals(request.getParameter("subphase"))) {
                                                                        %>
                                                                        <option value="<%=subphase%>" selected><%=subphase%></option>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <option value="<%=subphase%>"><%=subphase%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }

                                                                        %>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subphase').style.visibility = 'visible';
                                                                        document.getElementById('subphase').style.display = '';
                                                                    </script> <input type="hidden"
                                                                                     name="issubPhaseSubmit" value="true" /></td>
                                                        </tr>

                                                        <%                                                            if (request.getParameter("subsubphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubphase1" style="position: relative; visibility: hidden">
                                                                        Sub Sub Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubphase" name="subsubphase"
                                                                                                  disabled="disabled" size="1"
                                                                                                  onchange="javascript:callsubsubsubphase();
                                                                                                          javascript:callsubsubsubphase1();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubphase').style.visibility = 'hidden';
                                                                        document.getElementById('subsubphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            if (request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubsubphase1"
                                                                         style="position: relative; visibility: hidden">Sub Sub Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubsubphase" name="subsubsubphase"
                                                                                                  disabled="disabled" size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubsubphase').style.visibility = 'hidden';
                                                                        document.getElementById('subsubsubphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            }
                                                            if (!request.getParameter("phase").equalsIgnoreCase("null") && request.getParameter("subphase").equalsIgnoreCase("null") && request.getParameter("subsubphase").equalsIgnoreCase("null") && request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                                projecttypename = "project_" + projecttype.toLowerCase();
                                                                stmt2 = connection.createStatement();
                                                                if (projecttype.equals("Implementation") || projecttype.equals("Upgradation") || projecttype.equals("Support")) {
                                                                    rs2 = stmt2.executeQuery("SELECT DISTINCT PHASE,PHASEINDEX FROM " + projecttypename + " order BY PHASEINDEX");
                                                                }
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>Phase</b><input type="hidden"
                                                                                               id="projecttype" name="projecttype" value="<%=projecttype%>"></td>
                                                            <td colspan="5"><select id="phase" name="phase" size="1"
                                                                                    onchange="javascript:phasechange();
                                                                                            javascript:callsubphase();
                                                                                            javascript:callsubphase1();">
                                                                    <%
                                                                        phase = null;
                                                                        if (rs2 != null) {
                                                                            while (rs2.next()) {
                                                                                phase = rs2.getString(1);
                                                                                if (!phase.equalsIgnoreCase("null")) {
                                                                                    if (phase.equals(request.getParameter("phase"))) {
                                                                    %>
                                                                    <option value="<%=phase%>" selected><%=phase%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%=phase%>"><%=phase%></option>
                                                                    <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }

                                                                    %>
                                                                </select></td>
                                                        </tr>

                                                        <%                                                            if (request.getParameter("subphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subphase1" style="position: relative; visibility: hidden">Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subphase" name="subphase"
                                                                                                  disabled="disabled" size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subphase').style.visibility = 'hidden';
                                                                        document.getElementById('subphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            if (request.getParameter("subsubphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubphase1" style="position: relative; visibility: hidden">
                                                                        Sub Sub Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubphase" name="subsubphase"
                                                                                                  disabled="disabled" size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubphase').style.visibility = 'hidden';
                                                                        document.getElementById('subsubphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            if (request.getParameter("subsubsubphase").equalsIgnoreCase("null")) {
                                                        %>

                                                        <tr align="left">
                                                            <td width="17%"><b>
                                                                    <div id="subsubsubphase1"
                                                                         style="position: relative; visibility: hidden">Sub Sub Sub
                                                                        Phase</div>
                                                                </b></td>
                                                            <td colspan="5"><input type="hidden" id="projecttype" name="projecttype"
                                                                                   value="<%=projecttype%>"> <select id="subsubsubphase" name="subsubsubphase"
                                                                                                  disabled="disabled" size="1">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                    </select> <script language="javascript">
                                                                        document.getElementById('subsubsubphase').style.visibility = 'hidden';
                                                                        document.getElementById('subsubsubphase').style.display = 'none';
                                                                    </script> <input type="hidden"
                                                                                     name="issubsubsubPhaseSubmit" value="true" /></td>
                                                        </tr>


                                                        <%                              }
                                                            }
                                                        %><%
                                                            if (url.equals("eminentlabs.net")) {
                                                                logger.info("Estimated Time" + estimated_time);
                                                                String[] sapIssuetypes = {"--Select One--", "Technical", "Functional", "Techno-Functional"};
                                                                if ((pmanager == uid || dmanager == uid) && issuestatus.equalsIgnoreCase("Unconfirmed")) {
                                                        %>
                                                        <tr  align="left">
                                                            <td width="13%"><b>
                                                                    Time Estimation
                                                                </b></td>
                                                            <td>
                                                                <input type="number" id="timeestimation" name="timeestimation"  min="0" /> in Hrs
                                                            </td>
                                                            <td width="13%"><b>
                                                                    Issue Type
                                                                </b></td>
                                                            <td>
                                                                <select id="sapissuetype" name="sapissuetype">
                                                                    <%
                                                                        for (int i = 0; i < sapIssuetypes.length; i++) {
                                                                            if (sapIssueType.equals(sapIssuetypes[i])) {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>" selected><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>"><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <%
                                                        } else if (!(estimated_time.equals("null")) && !(estimated_time.equals("0"))) {
                                                        %>
                                                        <tr  align="left">
                                                            <td width="13%"><b>
                                                                    Time Estimation
                                                                </b></td>
                                                            <td >
                                                                <%=estimated_time%> Hrs
                                                                <input type="hidden" id="timeestimation" name="timeestimation" value="<%=estimated_time%>" />
                                                            </td>

                                                            <%
                                                                logger.info("IN second sap loop");
                                                                if ((pmanager == uid || dmanager == uid) && (sapIssueType.equals("--Select One--"))) {
                                                            %>
                                                            <td width="13%"><b>
                                                                    Issue Type
                                                                </b></td>
                                                            <td>
                                                                <select id="sapissuetype" name="sapissuetype">
                                                                    <%
                                                                        for (int i = 0; i < sapIssuetypes.length; i++) {
                                                                            if (sapIssueType.equals(sapIssuetypes[i])) {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>" selected><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>"><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                            <%
                                                            } else if (sapIssueType.equals("--Select One--")) {
                                                                logger.info("IN third sap loop");
                                                            %>
                                                            <td width="13%"><b>

                                                                </b></td>
                                                            <td >

                                                                <input type="hidden" id="sapissuetype" name="sapissuetype" value="Nil" >
                                                            </td>
                                                            <%
                                                            } else {
                                                                logger.info("IN fourth sap loop");
                                                            %>
                                                            <td width="13%"><b>
                                                                    Issue Type
                                                                </b></td>
                                                            <td >
                                                                <%=sapIssueType%>              
                                                                <input type="hidden" id="sapissuetype" name="sapissuetype" value="<%=sapIssueType%>" >
                                                            </td>
                                                            <%
                                                                }

                                                            %>


                                                        </tr>
                                                        <%} else {
                                                            logger.info("IN fifth sap loop");
                                                        %>
                                                        <tr  align="left">
                                                            <td width="13%"><b>
                                                                    Time Estimation
                                                                </b></td>
                                                            <td >

                                                                <input type="number" id="timeestimation" name="timeestimation" min="0" /> in Hrs
                                                            </td>
                                                            <td width="13%"><b>
                                                                    Issue Type
                                                                </b></td>
                                                            <td >
                                                                <select id="sapissuetype" name="sapissuetype">

                                                                    <%
                                                                        for (int i = 0; i < sapIssuetypes.length; i++) {
                                                                            if (sapIssueType.equals(sapIssuetypes[i])) {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>" selected><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="<%= sapIssuetypes[i]%>"><%= sapIssuetypes[i]%></option>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            } //edited by sowjanya

                                                        } else {
                                                        %>                           
                                                        <tr  align="left">

                                                            <td>
                                                                <input type="hidden" id="timeestimation" name="timeestimation" value="<%=estimated_time%>" />
                                                                <input type="hidden" id="sapissuetype" name="sapissuetype" value="<%=sapIssueType%>" />
                                                                <input type="hidden" id="pmClient" name="pmClient" value="pmClient"/>
                                                            </td>

                                                        </tr>
                                                        <%
                                                            }

                                                        %>



                                                        <tr height="21" align="left">
                                                            <td width="17%"><b>Subject</b></td>
                                                            <td colspan="5" align="left"><%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
                                                                <input type="text" name="usub" id="usub" size="91" maxlength="100" value="<%=subject%>"/>
                                                                <%} else {%>
                                                                <%=subject%>
                                                                <%}%>
                                                                <%if (pmanager == uid || dmanager == uid) {%>
                                                                <span><img style="position: realtive;cursor:pointer; height:12px;margin-left:10px;" src="/eTracker/images/link.png" title='View Issues'  id="mainIssues"></span>
                                                                <input type="hidden" name="mainIssue" id="mainIssue" value="<%=mainIssue%>"/>
                                                                <%}%>

                                                            </td>
                                                        </tr>

                                                        <tr height="21" align="left">
                                                            <td width="17%"><b>Description</b></td>
                                                            <%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
                                                            <td colspan="5" align="left"><textarea
                                                                    name="udes" id="udes" wrap="physical" cols="84" rows="4"
                                                                    onKeyDown="textCounter(document.theForm.udes, document.theForm.remLenDesc, 4000);"
                                                                    onKeyUp="textCounter(document.theForm.udes, document.theForm.remLenDesc, 4000);"><%=description%></textarea>
                                                                <script type="text/javascript">

                                                                    CKEDITOR.replace('udes');
                                                                    var editor_data = CKEDITOR.instances.udes.getData();
                                                                    CKEDITOR.instances["udes"].on("instanceReady", function()
                                                                    {
                                                                        //set keyup event
                                                                        this.document.on("keyup", updateTextArea);
                                                                        //and paste event
                                                                        this.document.on("paste", updateTextArea);
                                                                    });
                                                                    function updateTextArea()
                                                                    {
                                                                        //    alert(document.getElementById('description').value);
                                                                        CKEDITOR.tools.setTimeout(function()
                                                                        {
                                                                            var desc = CKEDITOR.instances.udes.getData();
                                                                            var leng = desc.length;
                                                                            editorTextCounter(leng, document.theForm.remLenDesc, 4000);
                                                                        }, 0);
                                                                    }
                                                                </script>
                                                            </td><td  align="left">
                                                                <input readonly type="text" name="remLenDesc" id="remLenDesc" size="3" maxlength="3" value="4000"/>characters left
                                                            </td>
                                                            <%} else {%>
                                                            <td colspan="5" align="left"><%=description%></td>
                                                            <%}%>
                                                        </tr>

                                                        <tr height="21" align="left">
                                                            <td width="17%"><b>Root Cause</b></td>
                                                            <td colspan="5" align="left"><B></B><%=rootcause%></td>
                                                        </tr>

                                                        <tr height="21" align="left">
                                                            <td width="17%"><b>Expected Result</b></td>
                                                            <%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
                                                            <td colspan="5" align="left"><textarea
                                                                    name="uexpected_result" id="uexpected_result" wrap="physical" cols="84" rows="2"
                                                                    onKeyDown="textCounter(document.theForm.uexpected_result, document.theForm.remLen2, 2000);"
                                                                    onKeyUp="textCounter(document.theForm.uexpected_result, document.theForm.remLen2, 2000);"><%= expected_result%></textarea>

                                                                </font></td>
                                                            <script type="text/javascript">
                                                                CKEDITOR.replace('uexpected_result', {height: 100});
                                                                var editor_data = CKEDITOR.instances.uexpected_result.getData();
                                                                CKEDITOR.instances["uexpected_result"].on("instanceReady", function()
                                                                {

                                                                    //set keyup event
                                                                    this.document.on("keyup", updateExpectedResult);
                                                                    //and paste event
                                                                    this.document.on("paste", updateExpectedResult);
                                                                });
                                                                function updateExpectedResult()
                                                                {
                                                                    CKEDITOR.tools.setTimeout(function()
                                                                    {
                                                                        var desc = CKEDITOR.instances.uexpected_result.getData();
                                                                        var leng = desc.length;
                                                                        editorTextCounter(leng, document.theForm.remLen2, 2000);
                                                                    }, 0);
                                                                }
                                                            </script>
                                                            <td  align="left"><input readonly type="text"
                                                                                     name="remLen2" size="3" maxlength="3" value="2000"/>characters
                                                                left</td>

                                                            <%} else {%>
                                                            <td colspan="5" align="left"><%=expected_result%></td>
                                                            <%}%>
                                                        </tr>

                                                        <tr height="21" align="left">
                                                            <td width="17%" align="left">
                                                                <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>

                                                            </td>

                                                            <td colspan="5" align="left"><font size="2"
                                                                                               face="Verdana, Arial, Helvetica, sans-serif">
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
                                                                        CKEDITOR.instances["comments"].on("change", function()
                                                                        {
                                                                            updateComments();
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

                                                                </font>
                                                                <input readonly type="text" name="remLen1"
                                                                       size="3" maxlength="4" value="2000"></td>
                                                        </tr>
                                                        <tr>
                                                            <td><input type="hidden" name="customer" value="<%=customer%>" /></td>
                                                            <td><input type="hidden" name="currentstatus" id="currentstatus" value="<%=status%>" /></td>
                                                            <td><input type="hidden" name="project" id="project" value="<%=product%>" /></td>
                                                            <td><input type="hidden" name="version" value="<%=foundversion%>" /></td>
                                                            <td><input type="hidden" name="module" value="<%=module%>" /></td>
                                                            <td><input type="hidden" name="oldfixversion" id="fversion" value="<%=fixversion%>" /></td>
                                                            <td><input type="hidden" name="platform" value="<%=platform%>" /></td>
                                                            <td><input type="hidden" name="type" value="<%=type%>" /></td>
                                                            <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                                                            <td><input type="hidden" name="pri"  value="<%=pri%>" /></td>
                                                            <td><input type="hidden" name="creby" value="<%=createdby%>" /></td>
                                                            <td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td>
                                                            <td><input type="hidden" name="creon" value="<%=createdon%>" /></td>
                                                            <td><input type="hidden" name="modon" value="<%= modifiedon%>" /></td>
                                                            <td><input type="hidden" name="sub" id="sub" value="<%=subject%>" /></td>
                                                            <td><input type="hidden" name="rootcause" value="<%=rootcause%>" /></td>
                                                            <td><input type=hidden name="des" value='<%=StringUtil.encodeHtmlTag(description)%>' /></td>
                                                            <td><input type=hidden name="expected_result" value='<%=expected_result%>' /></td>
                                                            <td><input type="hidden" name="com1" value="<%=comment%>" /></td>
                                                            <td><input type="hidden" name="issu" id="issu" value="<%=issueid%>" /></td>
                                                            <td><input type="hidden" name="status" id="status" value="<%=status%>"/>
                                                                <td> <input type="hidden" name='priority' id="priority" value="<%=pri%>"/>
                                                                    <td> <input type="hidden" name='issueId' id="issueId" value="<%=no%>"/>
                                                                        <td><input type="hidden" name="sorton" id="sorton" value="<%=sorton%>" /></td>
                                                                        <td><input type="hidden" name="sort_method" id="sort_method" value="<%=sort_method%>" /></td>
                                                                        <td><input type="hidden" name="userin" id="userin" value="<%=userin%>" /></td>

                                                                        </tr>

                                                                        </tbody>
                                                                        </table>
                                                                        <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2"
                                                                               align="center">
                                                                            <tr align="center">
                                                                                <TD>&nbsp;</TD>
                                                                                <TD><INPUT type="submit" value="Update" ID='submit' name='submit'>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
                                                                                            type=reset ID="reset" value=" Reset "></TD>
                                                                                            </tr>
                                                                                            <tr><td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td></tr>
                                                                                            </table>
                                                                                            <%

                                                                                                if (!url.equals("continental-corporation.com")) {
                                                                                            %>
                                                                                            <iframe
                                                                                                src="<%=request.getContextPath()%>/comments.jsp?issueId=<%= session.getAttribute("theissu")%>"
                                                                                                scrolling="auto" frameborder="0" height="20%" width="100%"></iframe>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                            </center>
                                                                                            </div>
                                                                                            <table>
                                                                                                <tr><td><input type="hidden" name="dateChange" id="dateChange" value="<%=dueDate%>"/></td></tr>
                                                                                            </table>
                                                                                            </FORM>
                                                                                            <%
                                                                                                    }
                                                                                                } catch (Exception e) {
                                                                                                    logger.error(e.getMessage());
                                                                                                } finally {
                                                                                                    if (rs3 != null) {
                                                                                                        rs3.close();
                                                                                                    }
                                                                                                    if (rs2 != null) {
                                                                                                        rs2.close();
                                                                                                    }
                                                                                                    if (rs4 != null) {
                                                                                                        rs4.close();
                                                                                                    }
                                                                                                    if (rs5 != null) {
                                                                                                        rs5.close();
                                                                                                    }
                                                                                                    if (rs6 != null) {
                                                                                                        rs6.close();
                                                                                                    }
                                                                                                    if (pt2 != null) {
                                                                                                        pt2.close();
                                                                                                    }

                                                                                                    if (stmt2 != null) {
                                                                                                        stmt2.close();
                                                                                                    }

                                                                                                    if (stmt4 != null) {
                                                                                                        stmt4.close();
                                                                                                    }

                                                                                                    if (stmt6 != null) {
                                                                                                        stmt6.close();
                                                                                                    }

                                                                                                    if (stmt5 != null) {
                                                                                                        stmt5.close();
                                                                                                    }

                                                                                                    if (stmt2 != null) {
                                                                                                        stmt2.close();
                                                                                                    }

                                                                                                    if (st5 != null) {
                                                                                                        st5.close();
                                                                                                    }
                                                                                                    if (stmt5 != null) {
                                                                                                        stmt5.close();
                                                                                                    }
                                                                                                    if (connection != null && !connection.isClosed()) {
                                                                                                        connection.close();
                                                                                                    }
                                                                                                }
                                                                                            %>
                                                                                            <div id="overlay"></div>

                                                                                            <div id="cridpopup" class="popup" style="width: 600px;height:450px;overflow: auto;top: 15%;left: 20%;">
                                                                                                <h3 class="popupHeading">Add CR Id</h3>
                                                                                                <div >
                                                                                                    <div style="color:red;display: none;" id="errormsg"></div>
                                                                                                    <p ><input type="button"  id="addissue" value="Add Cr Id" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:incrCrId();"> &nbsp;&nbsp;Enter New CR ID & Description</p>
                                                                                                    <hr />
                                                                                                    <!-- Update form action -->

                                                                                                    <table style="margin: 20px; " id="tablecrid">
                                                                                                        <thead>
                                                                                                            <tr style="height:30px;font-weight: bold;">
                                                                                                                <td style="width:50%;" >
                                                                                                                    <label for="pswd">CR ID</label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <label for="pswd">CR Description</label>
                                                                                                                </td>

                                                                                                            </tr>
                                                                                                        </thead>
                                                                                                        <tr style="height:30px;">
                                                                                                            <td  style="width:30%;">
                                                                                                                <input type="text" name="crId" id='crId' maxlength="10"/>
                                                                                                            </td>
                                                                                                            <td colspan="2">
                                                                                                                <input type="text" name="crDescription" id='crDescription' />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                    <div style="text-align: center;">
                                                                                                        <input type="hidden" name="issueIdForCr" id='issueIdForCr' value="<%=issueid%>" />
                                                                                                        <input type="hidden" name="statusForCR" id='statusForCR' value="<%=request.getParameter("issuestatus")%>"/>

                                                                                                        <input type="submit" value="Add CR ID" onclick='return createcrid("<%=request.getParameter("pid")%>")'/>

                                                                                                        <input type="button"  value="Cancel" onclick="javascript:closecrid();"  />
                                                                                                    </div>

                                                                                                </div>
                                                                                            </div>

                                                                                            <div id="crEditpopup" class="popup" style="width: 400px;height:250px;overflow: auto;top: 15%;left: 20%;">
                                                                                                <h3 class="popupHeading">Edit CR Details</h3>
                                                                                                <div>
                                                                                                    <div style="color:red;display: none;" id="editcrerrormsg">Please enter the correct company name</div>
                                                                                                    <p>Edit CR ID/ Description</p>
                                                                                                    <hr />
                                                                                                    <!-- Update form action -->

                                                                                                    <table>
                                                                                                        <tr style="height:30px;">
                                                                                                            <td>
                                                                                                                <label for="pswd">CR ID</label>
                                                                                                            </td>
                                                                                                            <td colspan="2">
                                                                                                                <input type="text" name="editcrId" id='editcrId' maxlength="10"
                                                                                                                       />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr style="height:30px;">
                                                                                                            <td>
                                                                                                                <label for="pswd">CR Description</label>
                                                                                                            </td>
                                                                                                            <td colspan="2">
                                                                                                                <input type="text" name="editcrDescription" id='editcrDescription'/>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr style="height:20px;"><td >&nbsp;</td></tr>
                                                                                                        <tr>
                                                                                                            <td colspan="3" align="right">
                                                                                                                <input type="hidden" name="sno" id='sno'/>
                                                                                                                <input type="hidden" name="oldcrId" id='oldcrId'/>
                                                                                                                <input type="hidden" name="issueIdForCr" id='issueIdForCr' value="<%=issueid%>" />
                                                                                                                <input type="submit" value="Update CR ID" onclick='return updatecrid("<%=request.getParameter("pid")%>");'/>

                                                                                                                <input type="button" value="Cancel" onclick="javascript:closeeditcrid();"  />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>

                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="refissuepopupa chartarea" style="display: none;">
                                                                                                <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 20% auto;"/>
                                                                                                <div>

                                                                                                </div>
                                                                                            </div>

                                                                                            <div id="MDAVpopup" class="popup">
                                                                                                <h3 class="popupHeading">View Attached Files</h3>
                                                                                                <div>
                                                                                                    <div class="clear"></div>
                                                                                                    <div class="tableshow">
                                                                                                        <div id="IssuePopupFiles">

                                                                                                        </div>
                                                                                                        <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div id="MDApopup" class="popup" style="height: 200px;">
                                                                                                <form id="file-mod-form" name="file-mod-form" enctype="multipart/form-data"  method="POST" action="<%=request.getContextPath()%>/fileAttachIssueIE.jsp" onsubmit="return validate(this);">
                                                                                                    <h3 class="popupHeadinga">Upload document for <%=issueid%></h3>
                                                                                                    <div style="color:red;display: none;" id="mdaterrormsg"></div>
                                                                                                    <div style="margin-bottom: 10px;">
                                                                                                        <table >
                                                                                                            <tr >
                                                                                                                <td><label style="margin-left: 0px;">Choose File(s) to upload</label></td>
                                                                                                                <td >
                                                                                                                    <label for="pswd"><input type="file" id="file-mod-select" name="photos[]" multiple/></label> 
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr style="height:40px;">
                                                                                                                <td>
                                                                                                                    <%
                                                                                                                        String requestURL = request.getServletPath() + "?" + request.getQueryString();
                                                                                                                    %>
                                                                                                                    <input type="hidden" name="issueId" id='issueId' value="<%=issueid%>"/>
                                                                                                                    <input type="hidden" name="url" id='url' value="<%=requestURL%>"/>
                                                                                                                    <input type="submit" id="upload" value="Upload"/>
                                                                                                                    <input type="button" id="mod-upload-button" value="Upload Document" onclick="javascript:createFileAttach();"/>
                                                                                                                    <input type="button" id="mod-upload-cancel"value="Cancel" onclick="javascript:closeFileAttach();"/>
                                                                                                                </td>
                                                                                                                <td></td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                                                                                                            </tr>

                                                                                                        </table>
                                                                                                    </div>
                                                                                                </form>
                                                                                                <div id="msgForIE">
                                                                                                    <p style="color: red;">This page will refresh after uploading file.So Please type the comments or changes after uploading.For better performance use other browsers.. </p>
                                                                                                </div>
                                                                                            </div>

                                                                                            <div id="TSApopup" class="popup" style="height: 200px;">
                                                                                                <form id="img-mod-form" name="img-mod-form" enctype="multipart/form-data"  method="POST" action="<%=request.getContextPath()%>/fileAttachIssueIE.jsp" onsubmit="return validate(this);">
                                                                                                    <h3 class="popupHeadinga">Upload images for <%= issueid%></h3>
                                                                                                    <div style="color:red;display: none;" id="imgerrormsg"></div>
                                                                                                    <div style="margin-bottom: 10px;">
                                                                                                        <table >
                                                                                                            <tr>
                                                                                                                <td><label style="margin-left: 0px;">Choose Image(s) to upload</label></td>
                                                                                                                <td >
                                                                                                                    <label for="pswd"><input type="file" id="img-mod-select" name="photos[]" multiple/></label> 
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr style="height:40px;">
                                                                                                                <td colspan="2">
                                                                                                                    <%
                                                                                                                        String requestURLa = request.getServletPath() + "?" + request.getQueryString();
                                                                                                                    %>
                                                                                                                    <input type="hidden" name="issueId" id='issueIda' value="<%= issueid%>"/>
                                                                                                                    <input type="hidden" name="url" id='urla' value="<%=requestURLa%>"/>
                                                                                                                    <input type="submit" id="uploadImg" value="Upload"/>
                                                                                                                    <input type="button" id="mod-update-button" value="Add image(s) to comments" onclick="javascript:updateFileAttach();"/>
                                                                                                                    <button class="custom-popup-close" onclick="closeImgAttach();" type="button">close</button>     
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td align="center"><img id="progressbara" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </div>
                                                                                                </form>
                                                                                                <div id="imgmsgForIE">
                                                                                                    <p style="color: red;">This page will refresh after uploading file.So Please type the comments or changes after uploading and copy the URL for uploaded image(s) from View Files.For better performance use other browsers.. </p>
                                                                                                </div>
                                                                                            </div>  

                                                                                            <%
                                                                                                String stat = request.getParameter("issuestatus");
                                                                                                if (crIdDetails.length < 1) {
                                                                                                    if (stat.equalsIgnoreCase("Customizing Request") || stat.equalsIgnoreCase("Workbench Request")) {%>
                                                                                            <script type="text/javascript">

                                                                                                showcrid();
                                                                                            </script>
                                                                                            <%}
                                                                                                }%>
                                                                                            <script type="text/javascript">
                                                                                                $('.refer').click(function(e) {
                                                                                                    $('.refissuepopupa').dialog("open");
                                                                                                    $(".refissuepopupa").dialog({position: {my: "right center", at: "right bottom"}
                                                                                                    });
                                                                                                });
                                                                                                $(function() {
                                                                                                    $(".refissuepopupa").dialog({
                                                                                                        autoOpen: false,
                                                                                                        width: 600,
                                                                                                        maxHeight: 500,
                                                                                                        title: "Reference Issues",
                                                                                                        position: {my: "left top", at: "right bottom", of: '.refer'},
                                                                                                        show: {
                                                                                                            effect: "slide",
                                                                                                            direction: "right",
                                                                                                            duration: 1000
                                                                                                        },
                                                                                                        hide: {
                                                                                                            effect: "slide",
                                                                                                            direction: "right",
                                                                                                            duration: 1000
                                                                                                        }
                                                                                                    });
                                                                                                });
                                                                                                $(".refer").click(function(e) {
                                                                                                    $(".refissuepopupa > img").show();
                                                                                                    $(".refissuepopupa > div").html("");
                                                                                                    $(".refissuepopupa").dialog("open");
                                                                                                    var issueId = $.trim($("#issu").val());
                                                                                                    var sub = $.trim($("#sub").val());
                                                                                                    $.ajax({
                                                                                                        url: '<%=request.getContextPath()%>/referenceIssues.jsp',
                                                                                                        data: {issueId: issueId, sub: sub, random: Math.random(1, 10)},
                                                                                                        async: true,
                                                                                                        type: 'GET',
                                                                                                        success: function(responseText, statusTxt, xhr) {
                                                                                                            if (statusTxt === "success") {
                                                                                                                var result = $.trim(responseText);
                                                                                                                $(".refissuepopupa > div").html(result);
                                                                                                                $(".refissuepopupa > img").hide();
                                                                                                            }
                                                                                                        }});
                                                                                                });
                                                                                                <%if (uid == 212) {%>
                                                                                                $(document).ready(function() {
                                                                                                    $('.refer').trigger('click');
                                                                                                });
                                                                                                <%}%>

                                                                                                $(document).ready(function() {
                                                                                                    var message = $('#message').val();
                                                                                                    var ua = window.navigator.userAgent;
                                                                                                    var msie = ua.indexOf('MSIE ');
                                                                                                    var trident = ua.indexOf('Trident/');
                                                                                                    var edge = ua.indexOf('Edge/');
                                                                                                    if (msie > 0 || trident > 0 || edge > 0) {
                                                                                                        $('#mod-upload-button').hide();
                                                                                                        $('#mod-update-button').hide();
                                                                                                        if (message === null || message === 'null') {
                                                                                                        } else {
                                                                                                            alert(message);
                                                                                                        }
                                                                                                    } else {
                                                                                                        $('#upload').hide();
                                                                                                        $('#msgForIE').hide();
                                                                                                        $('#uploadImg').hide();
                                                                                                        $('#imgmsgForIE').hide();
                                                                                                    }
                                                                                                });
                                                                                                function validate() {
                                                                                                    if (document.getElementById("file-mod-select").value == '') {
                                                                                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                                                                                        document.getElementById('mdaterrormsg').innerHTML = "Please select the file";
                                                                                                        return false;
                                                                                                    } else {
                                                                                                        var count = 1, abort = true;
                                                                                                        var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                                                                                        var ua = window.navigator.userAgent;
                                                                                                        var msie = ua.indexOf('MSIE ');
                                                                                                        var trident = ua.indexOf('Trident/');
                                                                                                        var edge = ua.indexOf('Edge/');
                                                                                                        if (msie > 0 || trident > 0 || edge > 0) {
                                                                                                            var fileName = document.getElementById('file-mod-select').value;
                                                                                                            var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                                                                                            for (var i = 0; i <= allowed_extensions.length; i++)
                                                                                                            {
                                                                                                                if (allowed_extensions[i] == file_extension)
                                                                                                                {
                                                                                                                    count = 0;
                                                                                                                }
                                                                                                            }
                                                                                                            if (count == 0) {
                                                                                                                $('#progressbar').fadeIn('slow');
                                                                                                                document.getElementById('upload').value = "Processing";
                                                                                                                document.getElementById('upload').disabled = true;
                                                                                                                document.getElementById('mod-upload-cancel').value = "Processing";
                                                                                                                document.getElementById('mod-upload-cancel').disabled = true;
                                                                                                            } else {
                                                                                                                return false;
                                                                                                            }
                                                                                                        }

                                                                                                    }
                                                                                                }
                                                                                                $('#file-mod-select').bind('change', function() {
                                                                                                    $('#progressbar').fadeIn('slow');
                                                                                                    var fileModSelect = document.getElementById('file-mod-select');
                                                                                                    document.getElementById('mdaterrormsg').innerHTML = "";
                                                                                                    var files = fileModSelect.files;
                                                                                                    var count = 1, abort = true;
                                                                                                    var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                                                                                    var ua = window.navigator.userAgent;
                                                                                                    var msie = ua.indexOf('MSIE ');
                                                                                                    var trident = ua.indexOf('Trident/');
                                                                                                    var edge = ua.indexOf('Edge/');
                                                                                                    if (msie > 0 || trident > 0 || edge > 0) {
                                                                                                        var fileName = document.getElementById('file-mod-select').value;
                                                                                                        var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                                                                                        for (var i = 0; i <= allowed_extensions.length; i++)
                                                                                                        {
                                                                                                            if (allowed_extensions[i] == file_extension)
                                                                                                            {
                                                                                                                count = 0;
                                                                                                            }
                                                                                                        }
                                                                                                    } else {
                                                                                                        for (var i = 0; i < files.length && abort; i++)
                                                                                                        {
                                                                                                            var fileName = files[i].name;
                                                                                                            var file_extension = fileName.split('.').pop().toLowerCase();
                                                                                                            for (var j = 0; j < allowed_extensions.length; j++)
                                                                                                            {
                                                                                                                if (allowed_extensions[j] == file_extension)
                                                                                                                {
                                                                                                                    abort = true
                                                                                                                    count = 0;
                                                                                                                    break;
                                                                                                                } else {
                                                                                                                    count = 1;
                                                                                                                    abort = false;
                                                                                                                }
                                                                                                            }
                                                                                                        }

                                                                                                    }
                                                                                                    if (count == 0) {
                                                                                                    } else {
                                                                                                        document.getElementById('file-mod-select').value = '';
                                                                                                        document.getElementById('mdaterrormsg').style.display = 'block';
                                                                                                        document.getElementById('mdaterrormsg').innerHTML = "You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".'";
                                                                                                    }
                                                                                                    $('#progressbar').fadeOut('slow');
                                                                                                });
                                                                                                $('#img-mod-select').bind('change', function() {
                                                                                                    $('#progressbara').fadeIn('slow');
                                                                                                    var fileModSelect = document.getElementById('img-mod-select');
                                                                                                    document.getElementById('imgerrormsg').innerHTML = "";
                                                                                                    var files = fileModSelect.files;
                                                                                                    var count = 1, abort = true;
                                                                                                    var allowed_extensions = new Array("bmp", "jpg", "jpeg", "gif", "png", "bmp");
                                                                                                    var ua = window.navigator.userAgent;
                                                                                                    var msie = ua.indexOf('MSIE ');
                                                                                                    var trident = ua.indexOf('Trident/');
                                                                                                    var edge = ua.indexOf('Edge/');
                                                                                                    if (msie > 0 || trident > 0 || edge > 0) {
                                                                                                        var fileName = document.getElementById('img-mod-select').value;
                                                                                                        var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                                                                                        for (var i = 0; i <= allowed_extensions.length; i++)
                                                                                                        {
                                                                                                            if (allowed_extensions[i] == file_extension)
                                                                                                            {
                                                                                                                count = 0;
                                                                                                            }
                                                                                                        }
                                                                                                    } else {
                                                                                                        for (var i = 0; i < files.length && abort; i++)
                                                                                                        {
                                                                                                            var fileName = files[i].name;
                                                                                                            var file_extension = fileName.split('.').pop().toLowerCase();
                                                                                                            for (var j = 0; j < allowed_extensions.length; j++)
                                                                                                            {
                                                                                                                if (allowed_extensions[j] == file_extension)
                                                                                                                {
                                                                                                                    abort = true
                                                                                                                    count = 0;
                                                                                                                    break;
                                                                                                                } else {
                                                                                                                    count = 1;
                                                                                                                    abort = false;
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                    if (count == 0) {
                                                                                                    } else {
                                                                                                        document.getElementById('img-mod-select').value = '';
                                                                                                        document.getElementById('imgerrormsg').style.display = 'block';
                                                                                                        document.getElementById('imgerrormsg').innerHTML = "You must upload the images with one of the following extensions: " + allowed_extensions.join(', ') + ".'";
                                                                                                    }
                                                                                                    $('#progressbara').fadeOut('slow');
                                                                                                });
                                                                                            </script>

                                                                                            </BODY>
                                                                                            <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                                                                                            <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

                                                                                            <script src="<%= request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

                                                                                            <script type="text/javascript">
                                                                                                $('#issues').multipleSelect({
                                                                                                    filter: true,
                                                                                                    maxHeight: 150,
                                                                                                    width: 200
                                                                                                });
                                                                                                //Edit by sowjanya
                                                                                                $('#prev').click(function() {


                                                                                                    var prev = "";
                                                                                                    var clickb = "prev";
                                                                                                    var userin = "<%=userin%>";
                                                                                                    var roleId = "<%=role%>";
                                                                                                    var uid = "<%=uid%>";
                                                                                                    var pmanager = "<%=pmanager%>";
                                                                                                    if (userin == "statusWise") {
                                                                                                        prev = callfunc(clickb);
                                                                                                        if (roleId == 1 || (uid == pmanager)) {
                                                                                                            var text = "<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=" + prev + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                            window.location = text;
                                                                                                        } else {
                                                                                                            var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + prev + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                            window.location = text;
                                                                                                        }
                                                                                                    } else {
                                                                                                        prev = callfunc(clickb);
                                                                                                    }
                                                                                                    var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + prev + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                    window.location = text;
                                                                                                });
                                                                                                $('#next').click(function() {




                                                                                                    var next = "";
                                                                                                    var clickb = "next";
                                                                                                    var userin = "<%=userin%>";
                                                                                                    var roleId = "<%=role%>";
                                                                                                    var uid = "<%=uid%>";
                                                                                                    var pmanager = "<%=pmanager%>";
                                                                                                    if (userin == "statusWise") {
                                                                                                        next = callfunc(clickb);
                                                                                                        if (roleId == 1 || (uid == pmanager)) {
                                                                                                            var text = "<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=" + next + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                            window.location = text;
                                                                                                        } else {
                                                                                                            var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + next + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                            window.location = text;
                                                                                                        }
                                                                                                    } else {
                                                                                                        next = callfunc(clickb);
                                                                                                    }
                                                                                                    var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + next + "&project=" + "<%=product%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + <%=fixversion%> + "&status=" + "<%=status%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                    window.location = text;
                                                                                                });
                                                                                                $(document).ready(function() {




                                                                                                    var position;
                                                                                                    position = callpos();
                                                                                                    if (position == "middle") {
                                                                                                        $(".nextBtn").removeClass("nextInactive");
                                                                                                        $(".prevBtn").removeClass("prevInactive");
                                                                                                    } else if (position == "last") {

                                                                                                        $(".prevBtn").removeClass("prevInactive");
                                                                                                        $(".nextBtn").addClass("nextInactive");
                                                                                                    } else if (position == "first") {

                                                                                                        $('#prev').addClass('prevInactive');
                                                                                                        $('#next').removeClass('nextInactive');
                                                                                                    } else if (position == "one") {
                                                                                                        $('#prev').addClass('prevInactive');
                                                                                                        $('#next').addClass('nextInactive');
                                                                                                    }


                                                                                                });
                                                                                                $(document).ready(function() {

                                                                                                    $("#prev").one('click', function(e) {
                                                                                                        e.preventDefault();
                                                                                                        e.stopPropagation();
                                                                                                        $(this).prop('disabled', true);
                                                                                                    });
                                                                                                    $("#next").one('click', function(e) {
                                                                                                        e.preventDefault();
                                                                                                        e.stopPropagation();
                                                                                                        $(this).prop('disabled', true);
                                                                                                    });

                                                                                                    $("#mainIssues").click(function() {
                                                                                                        $(".addTargetCount").dialog({
                                                                                                            title: "Select a Main Issue ",
                                                                                                            draggable: true,
                                                                                                            modal: true,
                                                                                                            width: 700,
                                                                                                            maxHeight: 700,
                                                                                                            position: {my: "center",
                                                                                                                at: "top",
                                                                                                                of: window,
                                                                                                                collision: "fit",
                                                                                                                // Ensure the titlebar is always visible
                                                                                                                using: function(pos) {
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
                                                                                                            open: function() {
                                                                                                                $("body").css("overflow", "hidden");
                                                                                                            },
                                                                                                            close: function() {
                                                                                                                $("body").css("overflow", "auto");
                                                                                                            }

                                                                                                        });
                                                                                                        $(".addTargetCount > img").show();
                                                                                                        $(".addTargetCount > div").html("");
                                                                                                        $(".addTargetCount").dialog("open");
                                                                                                        var pname = "<%=product%>";
                                                                                                        var ver = "<%=fixversion%>";
                                                                                                        var mainIssue = $("#mainIssue").val();
                                                                                                        $.ajax({url: '<%=request.getContextPath()%>/getIssuesByPnameVersion.jsp',
                                                                                                            data: {pname: pname, ver: ver, mainIssue: mainIssue, random: Math.random(1, 10)},
                                                                                                            async: true,
                                                                                                            type: 'GET',
                                                                                                            success: function(responseText, statusTxt, xhr) {
                                                                                                                if (statusTxt === "success") {
                                                                                                                    var result = $.trim(responseText);
                                                                                                                    $(".addTargetCount > div").html(result);
                                                                                                                    $('input:radio[name="selectedIssue"]').filter('[value=' + mainIssue + ']').attr('checked', true);
                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    });
                                                                                                    $('[name="escalation"]').change(function() {
                                                                                                        if ($(this).is(':checked')) {
                                                                                                            $(".esclQues").dialog({
                                                                                                                title: "Escalation Checklist",
                                                                                                                draggable: true,
                                                                                                                modal: true,
                                                                                                                width: 700,
                                                                                                                maxHeight: 700,
                                                                                                                position: {my: "center",
                                                                                                                    at: "top",
                                                                                                                    of: window,
                                                                                                                    collision: "fit",
                                                                                                                    // Ensure the titlebar is always visible
                                                                                                                    using: function(pos) {
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
                                                                                                                open: function() {
                                                                                                                    $("body").css("overflow", "hidden");
                                                                                                                },
                                                                                                                close: function() {
                                                                                                                    $('span.error2').remove();
                                                                                                                    if ($('input[type="radio"]:checked').size() < 10) {
                                                                                                                        $("<span class='error2'>Please answer all the questions</span>").insertAfter(".escBut");
                                                                                                                        $(".esclQues").dialog("open");
                                                                                                                    } else {
                                                                                                                        $("#que1").val($("input[name='que1']:checked").val());
                                                                                                                        $("#que2").val($("input[name='que2']:checked").val());
                                                                                                                        $("#que3").val($("input[name='que3']:checked").val());
                                                                                                                        $("#que4").val($("input[name='que4']:checked").val());
                                                                                                                        $("#que5").val($("input[name='que5']:checked").val());
                                                                                                                        $("#que6").val($("input[name='que6']:checked").val());
                                                                                                                        $("#que7").val($("input[name='que7']:checked").val());
                                                                                                                        $("#que8").val($("input[name='que8']:checked").val());
                                                                                                                        $("#que9").val($("input[name='que9']:checked").val());
                                                                                                                        $("#que10").val($("input[name='que10']:checked").val());
                                                                                                                        $("body").css("overflow", "auto");
                                                                                                                    }
                                                                                                                }

                                                                                                            });
                                                                                                            $(".esclQues > img").show();
                                                                                                            $(".esclQues > div").html("");
                                                                                                            $(".esclQues").dialog("open");

                                                                                                            $.ajax({url: '<%=request.getContextPath()%>/escalationQustions.jsp',
                                                                                                                data: {random: Math.random(1, 10)},
                                                                                                                async: true,
                                                                                                                type: 'GET',
                                                                                                                success: function(responseText, statusTxt, xhr) {
                                                                                                                    if (statusTxt === "success") {
                                                                                                                        var result = $.trim(responseText);
                                                                                                                        $(".esclQues > div").html(result);

                                                                                                                    }
                                                                                                                }
                                                                                                            });
                                                                                                        } else {
                                                                                                            $(".esclQues").hide();
                                                                                                        }
                                                                                                    });
                                                                                                });
                                                                                                $("#escShow").click(function() {
                                                                                                    var issueId = "<%=issueid%>";
                                                                                                    $(".esclQues").dialog({
                                                                                                        title: "Escalation Checklist",
                                                                                                        draggable: true,
                                                                                                        modal: true,
                                                                                                        width: 700,
                                                                                                        maxHeight: 700,
                                                                                                        position: {my: "center",
                                                                                                            at: "top",
                                                                                                            of: window,
                                                                                                            collision: "fit",
                                                                                                            // Ensure the titlebar is always visible
                                                                                                            using: function(pos) {
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
                                                                                                        open: function() {
                                                                                                            $("body").css("overflow", "hidden");
                                                                                                        },
                                                                                                        close: function() {
                                                                                                            $("body").css("overflow", "auto");
                                                                                                        }
                                                                                                    });
                                                                                                    $(".esclQues > img").show();
                                                                                                    $(".esclQues > div").html("");
                                                                                                    $(".esclQues").dialog("open");
                                                                                                    $.ajax({url: '<%=request.getContextPath()%>/escalationAnswers.jsp',
                                                                                                        data: {issueId: issueId, random: Math.random(1, 10)},
                                                                                                        async: true,
                                                                                                        type: 'GET',
                                                                                                        success: function(responseText, statusTxt, xhr) {
                                                                                                            if (statusTxt === "success") {
                                                                                                                var result = $.trim(responseText);
                                                                                                                $(".esclQues > div").html(result);
                                                                                                            }
                                                                                                        }});
                                                                                                });
                                                                                                $("#date").datepicker({
                                                                                                    showOn: "button",
                                                                                                    changeMonth: true,
                                                                                                    changeYear: true,
                                                                                                    buttonImage: "<%=request.getContextPath()%>/images/newhelp.gif",
                                                                                                    buttonImageOnly: true,
                                                                                                    minDate: 0,
                                                                                                    dateFormat: "dd-mm-yy"
                                                                                                });
                                                                                                $('#date').click(function() {
                                                                                                    $('#date').datepicker('show');
                                                                                                });

                                                                                            </script>
                                                                                            <style>
                                                                                                .nextInactive,
                                                                                                .nextInactive:hover,
                                                                                                .prevInactive:hover,
                                                                                                .prevInactive{
                                                                                                    opacity: 0.3;
                                                                                                    cursor:default;
                                                                                                    pointer-events: none;
                                                                                                }
                                                                                                input[type=number]{
                                                                                                    width: 60px;
                                                                                                } 
                                                                                            </style>
                                                                                            <%-- Edit end by sowjanya--%>
                                                                                            </HTML>
