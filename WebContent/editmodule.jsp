<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Date"%>
<!--<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@ include file="noScript.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("Edit Module");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
        <meta name="Generator" content="EditPlus">
            <meta name="Author" content="">
                <meta name="Keywords" content="">
                    <meta name="Description" content="">
                        <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
                        <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
                        <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
                        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
                        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
                        <script  type="text/javascript" src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>
                        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
                            <script src="<%= request.getContextPath()%>/javaScript/jquery.min.js"></script>

                            <style type="text/css">
                                input[type='file'] {
                                    border: 3px dashed #999;
                                    padding: 40px 50px 10px 408px;
                                    cursor: move;
                                    position: relative;
                                }
                                input[type='file']:before {
                                    content: "Drag & drop your file here";
                                    display: block;
                                    position: absolute;
                                    text-align: center;
                                    top: 50%;
                                    left: 36%;
                                    width: 250px;
                                    height: 40px;
                                    margin: -25px 0 0 -100px;
                                    font-size: 18px;
                                    font-weight: bold;
                                    color: #999;
                                }
                                .filename
                                {
                                    display:inline-block;
                                    vertical-align:top;
                                    width:250px;
                                    font-size: 12px;
                                    font-weight: bold;
                                    padding: 10px;
                                }
                                .filesize
                                {
                                    display:inline-block;
                                    vertical-align:top;                                   
                                    width:150px;
                                    margin-left:10px;
                                    margin-right:5px;
                                    font-size: 12px;
                                    font-weight: bold;
                                    padding: 10px;
                                }
                                .progressBar {
                                    width: 200px;
                                    height: 22px;
                                    border: 1px solid #ddd;
                                    border-radius: 5px; 
                                    overflow: hidden;
                                    display:inline-block;
                                    margin:5px 10px 5px 5px;
                                    vertical-align:top;                                    
                                }
                                .progressBar div {
                                    height: 100%;
                                    color: #fff;
                                    text-align: right;
                                    line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                                    width: 0;
                                    background-color: #0ba1b5; border-radius: 3px;                                                                       
                                }


                            </style>
                            <script type="text/javascript">
                            function createStatusbar(obj)
                            {
                                this.statusbar = $("<div class='statusbar '></div>");
                                this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
                                this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);

                                obj.after(this.statusbar);


                                this.setFileNameSize = function (name, size)
                                {
                                    var sizeStr = "";
                                    var sizeKB = size / 1024;
                                    if (parseInt(sizeKB) > 1024)
                                    {
                                        var sizeMB = sizeKB / 1024;
                                        sizeStr = sizeMB.toFixed(2) + " MB";
                                    } else
                                    {
                                        sizeStr = sizeKB.toFixed(2) + " KB";
                                    }

                                    this.filename.html('File Name :' + name);
                                    this.size.html('File Name :' + sizeStr);
                                }

                            }

                            function handleFileUpload(files, obj)
                            {

                                var status = new createStatusbar(obj); //Using this we can set progress.
                                status.setFileNameSize(files[0].name, files[0].size);
                            }
                            $(document).ready(function ()
                            {
                                var obj = $("#files");
                                obj.on('dragenter', function (e)
                                {
                                    $(this).css('background-color', 'white');
                                });
                                obj.on('drop', function (e)
                                {
                                    var files = e.originalEvent.dataTransfer.files;
                                    var count = 0
                                    var fileName = files[0].name;
                                    var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                    var file_extension = fileName.split('.').pop().toLowerCase(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                    for (var i = 0; i <= allowed_extensions.length; i++)
                                    {
                                        if (allowed_extensions[i] == file_extension)
                                        {
                                            count = 1;
                                        }
                                    }
                                    if (count == 1) {
                                        handleFileUpload(this.files, obj);
                                    } else {
                                        e.preventDefault();
                                        alert("You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".");
                                    }
                                    $(this).css('background-color', '#e8eef7');
                                });
                            });
                            function check(searchpg)
                            {
                                var x = document.getElementById("issueno").value;
                                searchpg.action = 'MyIssueView1.jsp?issno=' + x;
                                searchpg.submit();
                            }
                            </script>
                            </head>
                            <script type="text/javascript">
                                function proposalOk() {
                                    document.getElementById('pChecker').value = "Yes";
                                    var objLinkLista = eval(document.getElementById("creatissueforma"));
                                    objLinkLista.style.display = "none";
                                }
                                function proposalNotOk() {
                                    document.getElementById('pChecker').value = "No";
                                    var objLinkList = eval(document.getElementById("date"));
                                    var objLinkLista = eval(document.getElementById("prposIssue"));
                                    objLinkLista.innerHTML = "";
                                    objLinkList.value = prDate;
                                    document.getElementById("creatissueform").style.display = "block";
                                    document.getElementById("creatissueforma").innerHTML = "<table width=\"100%\"  bgcolor=\"#E8EEF7\" align=\"center\"><tr>" +
                                            "<td align=\"center\">" +
                                            " <input type=\"submit\" id=\"submit\" name=\"submit\" value=\"Submit\"/></td></tr></table>";
                                }
                                function isDate(str)
                                {
                                    var pattern = "1234567890-";
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
                                function textCounter(field, cntfield, maxlimit) {
                                    if (field.value.length > maxlimit) {
                                        field.value = field.value.substring(0, maxlimit);
                                        if (maxlimit === 4000)
                                            alert('Description size is exceeding 4000 characters');
                                        else
                                            alert('Expected Result size is exceeding 2000 characters');
                                    } else {
                                        cntfield.value = maxlimit - field.value.length;
                                    }
                                }
                                function editorTextCounter(field, cntfield, maxlimit)
                                {
                                    if (field > maxlimit)
                                    {

                                        if (maxlimit === 4000)
                                            alert('Description size is exceeding 4000 characters');
                                        else
                                            alert('Expected Result size is exceeding 2000 characters');
                                    } else
                                        cntfield.value = maxlimit - field;
                                }
                            </script>

                            <script type="text/javascript">
                                function trim(str) {
                                    while (str.charAt(str.length - 1) === " ")
                                        str = str.substring(0, str.length - 1);
                                    while (str.charAt(0) === " ")
                                        str = str.substring(1, str.length);
                                    return str;
                                }
                                function callduedate() {
                                    xmlhttp = createRequest();
                                    if (xmlhttp !== null) {

                                        var product = document.getElementById("project").value;
                                        var version = document.getElementById("version").value;
                                        var module = document.getElementById("module").value;
                                        var severity = document.getElementById("severity").value;
                                        var priority = document.getElementById("priority").value;
                                        xmlhttp.open("GET", "<%= request.getContextPath()%>/CreateIssue/proposedDuedate.jsp?product=" + product + "&version=" + version + "&module=" + module + "&severity=" + severity + "&priority=" + priority + "&rand=" + Math.random(1, 10), false);
                                        xmlhttp.onreadystatechange = proposeduedate;
                                        xmlhttp.send(null);
                                    }
                                }
                                function proposeduedate() {

                                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                                        var name = xmlhttp.responseText;
                                        var result = xmlhttp.responseText.split(";");
                                        var results = result[1].split(",");

                                        for (i = 0; i < results.length; i++) {
                                            objLinkList = eval(document.getElementById("date"));
                                            objLinkList.value = results[i];
                                        }
                                    }
                                }
                                var pIssues = '';
                                function displayAlertPrposalIssues() {
                                    var product = document.getElementById("project").value;
                                    var version = document.getElementById("version").value;
                                    var module = document.getElementById("module").value;
                                    var severity = document.getElementById("severity").value;
                                    var priority = document.getElementById("priority").value;
                                    var orgDueDate = document.theForm.date.value;
                                    xmlhttp.open("GET", "<%= request.getContextPath()%>/CreateIssue/prposeAlert.jsp?product=" + product + "&version=" + version + "&module=" + module + "&severity=" + severity + "&priority=" + priority + "&pDate=" + prDate + "&orgDueDate=" + orgDueDate + "&rand=" + Math.random(1, 10), false);
                                    xmlhttp.onreadystatechange = AlertPrposalIssues;
                                    xmlhttp.send(null);
                                }
                                function AlertPrposalIssues() {
                                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                                        var name = xmlhttp.responseText;
                                        var result = xmlhttp.responseText.split(";");
                                        var flag = true;
                                        for (i = 0; i < result.length; i++) {

                                            var results = result[i].split(",");
                                            if (results[1] !== undefined) {
                                                if (flag === true) {
                                                    pIssues = "<table style=\"width:100%;\"><tr bgcolor=\"#C3D9FF\" style=\"font-weight:bold;\"><td style=\"width:10%;\">Issue No</td><td style=\"width:10%;\">Old Due Date</td><td style=\"width:10%;\">New Due Date</td><td style=\"width:78%;\">Subject</td>";
                                                    flag = false;
                                                }
                                                if (i % 2 === 0) {
                                                    pIssues = pIssues + "<tr bgcolor=\"#E8EEF7\"><td >" + results[0] + "</td><td >" + results[1] + "</td><td >" + results[2] + "</td><td >" + results[3] + "</td></tr>";
                                                } else {
                                                    pIssues = pIssues + "<tr ><td >" + results[0] + "</td><td >" + results[1] + "</td><td >" + results[2] + "</td><td >" + results[3] + "</td></tr>";
                                                }
                                            }

                                        }
                                        if (flag === false) {
                                            pIssues = pIssues + "</table>";
                                            document.getElementById("creatissueforma").innerHTML = "<table align=\"center\"><tr><td ><input type=\"submit\" name=\"submit\" id=\"submit\" value=\"Confirm & Submit\" onclick=\"proposalOk()\"/></td><td>" +
                                                    "<input type=\"button\" value=\"Cancel\" onclick=\"proposalNotOk()\"/></td></tr></table>";
                                        }
                                    }
                                }

                                var prDate = '';
                                function prposalCheck() {
                                    xmlhttp = createRequest();
                                    if (xmlhttp !== null) {

                                        var product = document.getElementById("project").value;
                                        var version = document.getElementById("version").value;
                                        var module = document.getElementById("module").value;
                                        var severity = document.getElementById("severity").value;
                                        var priority = document.getElementById("priority").value;
                                        xmlhttp.open("GET", "<%= request.getContextPath()%>/CreateIssue/proposedDuedate.jsp?product=" + product + "&version=" + version + "&module=" + module + "&severity=" + severity + "&priority=" + priority + "&rand=" + Math.random(1, 10), false);
                                        xmlhttp.onreadystatechange = prposalCheckDueDate;
                                        xmlhttp.send(null);
                                    }
                                }
                                function prposalCheckDueDate() {

                                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                                        var name = xmlhttp.responseText;
                                        var result = xmlhttp.responseText.split(";");
                                        var results = result[1].split(",");

                                        for (i = 0; i < results.length; i++) {
                                            objLinkList = eval(document.getElementById("date"));
                                            prDate = results[i];
                                        }

                                    }

                                }
                                function validate() {

                                    if (document.getElementById('project').value === "--Select One--")
                                    {
                                        alert("Please select the Project Name");
                                        document.theForm.project.focus();
                                        return false;
                                    }

                                    if (document.getElementById('version').value === "--Select One--")
                                    {
                                        alert("Please select the Version Name");
                                        document.theForm.version.focus();
                                        return false;
                                    }

                                    if (document.getElementById('module').value === "--Select One--")
                                    {
                                        alert("Please select the Module Name");
                                        document.theForm.module.focus();
                                        return false;
                                    }

                                    if (trim(document.getElementById('date').value) === "")
                                    {
                                        alert("Please Enter the Due Date ");
                                        document.theForm.date.focus();
                                        return false;
                                    }
                                    if (!isDate(trim(theForm.date.value)))
                                    {
                                        alert('Please enter the valid Due Date');
                                        document.theForm.date.value = "";
                                        theForm.date.focus();
                                        return false;
                                    }
                                    var str = document.theForm.date.value;

                                    var first = str.indexOf("-");
                                    var last = str.lastIndexOf("-");
                                    var year = str.substring(last + 1, last + 5);
                                    var month = str.substring(first + 1, last);
                                    var date = str.substring(0, first);
                                    var form_date = new Date(year, month - 1, date);
                                    var current_date = new Date();

                                    var current_year = current_date.getFullYear();
                                    var current_month = current_date.getMonth();
                                    current_date = current_date.getDate();
                                    var today = new Date(current_year, current_month, current_date);

                                    if (form_date.getTime() == today.getTime()) {
                                        if (today.getHours() < 17) {
                                            alert('Due Date cannot be today after 5PM');
                                            document.theForm.date.value = "";
                                            theForm.date.focus();
                                            return false;
                                        }
                                    }
                                    if (form_date < today) {
                                        alert('Due Date cannot be less than Today');
                                        document.theForm.date.value = "";
                                        theForm.date.focus();
                                        return false;
                                    }
                                    if (trim(document.theForm.subject.value) === "")
                                    {
                                        alert("Please Enter the Subject ");
                                        document.theForm.subject.focus();
                                        return false;
                                    }
                                    if (trim(CKEDITOR.instances.descriptions.getData()) === "")
                                    {
                                        alert("Please Enter the Description");
                                        CKEDITOR.instances.descriptions.focus();
                                        return false;
                                    }
                                    if (CKEDITOR.instances.descriptions.getData().length > 4000)
                                    {
                                        alert(" Description exceeds 4000 character");
                                        CKEDITOR.instances.descriptions.focus();
                                        //        document.theForm.description.value == "";
                                        return false;
                                    }
                                    if (trim(document.theForm.rootCause.value) === "")
                                    {
                                        alert("Please Enter the Root Cause if you know or Nil if you don't ");
                                        document.theForm.rootCause.focus();
                                        return false;
                                    }
                                    if (trim(CKEDITOR.instances.expectedResult.getData()) === "")
                                    {
                                        alert("Please Enter the Expected result");
                                        CKEDITOR.instances.expectedResult.focus();
                                        return false;
                                    }
                                    if (CKEDITOR.instances.expectedResult.getData().length > 2000)
                                    {
                                        alert(" Expected Result exceeds 2000 character");
                                        CKEDITOR.instances.expectedResult.focus();
                                        //        document.theForm.expectedResult.value == "";
                                        return false;
                                    }
                                    prposalCheck();
                                    if (prDate !== '') {

                                        var pChecker = document.getElementById('pChecker').value;
                                        if (pChecker === 'No') {
                                            displayAlertPrposalIssues();

                                            var pfirst = prDate.indexOf("-");
                                            var plast = prDate.lastIndexOf("-");
                                            var pyear = prDate.substring(plast + 1, plast + 5);
                                            var pmonth = prDate.substring(pfirst + 1, plast);
                                            var pdate = prDate.substring(0, pfirst);
                                            var pform_date = new Date(pyear, pmonth - 1, pdate);
                                            if (form_date < pform_date) {
                                                if (pIssues !== '') {
                                                    document.getElementById("prposIssue").innerHTML = "The proposed <b>new due date for the exisisting</b> issue(s) becasue of this new issue creation is listed below: \n" + pIssues;
                                                    document.getElementById("creatissueform").style.display = "none";
                                                    return false;
                                                }
                                            }
                                        }
                                    }
                                    if (trim(document.getElementById('files').value) === "")
                                    {
                                    } else {
                                        var count = 0;
                                        var fileName = document.getElementById('files').value;
                                        var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                        var file_extension = fileName.split('.').pop().toLowerCase(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                        for (var i = 0; i <= allowed_extensions.length; i++)
                                        {
                                            if (allowed_extensions[i] == file_extension)
                                            {
                                                count = 1;
                                            }
                                        }
                                        if (count == 1) {
                                        } else {
                                            document.getElementById('files').value = '';
                                            alert("You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".");
                                            return false;
                                        }
                                    }
                                    $("#progressbar").fadeIn('slow');
                                    disableSubmit();

                                }
                                function clearRootCause() {
                                    if (document.getElementById('rootCause').value === 'If you know the root cause  type in') {
                                        document.getElementById('rootCause').value = '';
                                        document.getElementById('rootCause').focus();
                                    }
                                }
                                function popRootCause() {
                                    if (trim(document.getElementById('rootCause').value) === '') {
                                        document.getElementById('rootCause').value = 'If you know the root cause  type in';

                                    }

                                }


                            </script>
                            <body bgcolor="#FFFFFF">

                                <%

                                    String proj = request.getParameter("project");
                                    float var = Float.parseFloat(request.getParameter("version"));
                                    Long getTime = MoMUtil.parseLong(request.getParameter("next"), 0);
                                    Date date1 = new Date(getTime);
                                    String next = request.getParameter("next");
                                    Date date2 = new Date(System.currentTimeMillis());
                                    long diff = date2.getTime() - date1.getTime();
                                    boolean allowToCreate = false;
                                    if (var >= 3.0 && proj.equals("eTracker") && getTime == 0) {
                                        if (next != null) {
                                            if (next.equalsIgnoreCase("Yes")) {
                                                allowToCreate = true;
                                            }
                                        }
                                    } else if (diff <= 1800000l) {
                                        allowToCreate = true;
                                    }
                                    if (allowToCreate) {

                                %>
                                <FORM name="theForm"  onSubmit='return validate(this);' ACTION="/eTracker/createBug/createBugIssue.jsp" METHOD="POST" enctype="multipart/form-data" >
                                    <%@ page import="java.sql.*"%>

                                    <%                                        String bug = "yes";
                                        session.setAttribute("bug", bug);
                                        String flag = request.getParameter("flag");
                                        if (flag != null && flag.equalsIgnoreCase("true")) {
                                            String issueId = (String) session.getAttribute("issueid");
                                    %>
                                    <center><FONT SIZE="4" COLOR="#33CC33">The issue has
                                            been created successfully.Issue id : <%= issueId%></center>

                                    <%
                                        }

                                        flag = null;

                                        Statement stmt0 = null, stmt1 = null, stmt2 = null, stmt3 = null, stmt6 = null, stmt7 = null;
                                        ResultSet rs0 = null, rs1 = null, rs2 = null, rs3 = null, rs6 = null, rs7 = null;
                                        Connection connection = null;
                                        String project = request.getParameter("project");
                                        String ver = request.getParameter("version");
                                        String mdoule = request.getParameter("mdoule");
                                        logger.info("Project Name    :" + project);
                                        logger.info("Project Version :" + ver);
                                        try {
                                            connection = MakeConnection.getConnection();


                                    %> <br>
                                        <div id="prposIssue"></div>
                                        <input type="hidden" name="pChecker" id="pChecker" value="No"/>
                                        <div class="addTargetCount " style="display: none;">
                                            <div>
                                            </div>
                                        </div>
                                        <div id="creatissueform">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr border="2">
                                                    <td width="145" align="left"><a
                                                            href="http://www.eminentlabs.net" target="_new"><img border="0"
                                                                                                             alt="Eminentlabs Software Pvt Ltd Pvt. Ltd."
                                                                                                             src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                                                    <td border="1" align="center" width="100%"  ><font size="4"
                                                                                                       COLOR="#0000FF"><b></b></font> <FONT SIZE="3"
                                                                                             COLOR="#0000FF"> </FONT></td>
                                                    <td align="right">
                                                        <img alt="Eminentlabs Software Pvt Ltd" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                                                    </td>
                                                </tr>
                                                <tr><td height="21" width="100%" align="center"><b>File your New Feature Request, Enhancement Request or Bugs Found in <%=project%> v<%=ver%> here</b></td></tr>
                                            </table>
                                            <table width="100%" border="0" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2">

                                                <tr>
                                                    <td height="21" width="20%"><B> Project</B></td>
                                                    <td height="21" width="20%"><B> Found Version</B></td>
                                                    <td height="21" width="20%"><B> Module</B></td>
                                                    <td height="21" width="20%"><B> Type</B></td>

                                                </tr>
                                                <tr>
                                                    <td height="21" width="20%"><font size="2"
                                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <input
                                                                type="text" name="project" id="project" value="<%= project%> " readonly>
                                                        </font></td>
                                                    <td height="21" width="20%"><font size="2"
                                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <input
                                                                type="text" name="version" id="version" value="<%= ver%>" readonly> </font></td>

                                                    <td height="21" width="20%">
                                                        <%

                                                            stmt6 = connection.createStatement();
                                                            rs6 = stmt6.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE  UPPER(PNAME) = '" + project.toUpperCase() + "' and version='" + ver + "' and modules.pid=project.pid GROUP BY Modules.MODULE order by upper(module)");
                                                        %> <select name="module" id="module" size="1" onChange="javascript:callduedate();">
                                                            <option value="--Select One--" selected>--Select One--</option>
                                                            <%				if (rs6 != null) {
                                                                    while (rs6.next()) {
                                                                        String module = rs6.getString("module");

                                                            %>
                                                            <option value="<%=module%>"><%=module%></option>
                                                            <%

                                                                    }
                                                                }

                                                            %>
                                                        </select></td>
                                                    <td height="21" width="20%">
                                                        <%                                    String type1 = "New Task";
                                                            String type2 = "Enhancement";
                                                            String type3 = "Bug";
                                                            String type = "";
                                                        %> <select name="type" size="1" id="type">
                                                            <option selected value="<%= type3%>"><%= type3%></option>
                                                            <option value="<%= type2%>"><%= type2%></option>
                                                            <option value="<%= type1%>"><%= type1%></option>
                                                        </select></td>
                                                    <tr>
                                                        <td height="21" width="20%"><B> Severity </B></td>
                                                        <td height="21" width="20%"><B> Priority </B></td>
                                                        <td height="21" width="20%"><B> Due Date </B></td>
                                                    </tr>
                                                    <tr>
                                                        <%
                                                            String severity1 = "S1- Fatal";
                                                            String severity2 = "S2- Critical";
                                                            String severity3 = "S3- Important";
                                                            String severity4 = "S4- Minor";
                                                            String severity = "";
                                                        %>
                                                        <td height="21" width="20%"><SELECT NAME="severity" id="severity" size="1" onChange="javascript:callduedate();">
                                                                <OPTION selected VALUE="<%=severity3%>">S3- Important</option>
                                                                    <%
                                                                        if (severity1.equals(request.getParameter("severity"))) {
                                                                            severity = severity1;
                                                                    %>
                                                                <option value="<%=severity%>" selected><%=severity%></option>
                                                                <%
                                                                } else {
                                                                    severity = severity1;
                                                                %>
                                                                <option value="<%=severity%>"><%=severity%></option>
                                                                <%
                                                                    }
                                                                    if (severity2.equals(request.getParameter("severity"))) {
                                                                        severity = severity2;
                                                                %>
                                                                <option value="<%=severity%>" selected><%=severity%></option>
                                                                <%
                                                                } else {
                                                                    severity = severity2;
                                                                %>
                                                                <option value="<%=severity%>"><%=severity%></option>
                                                                <%
                                                                    }

                                                                    if (severity4.equals(request.getParameter("severity"))) {
                                                                        severity = severity4;
                                                                %>
                                                                <option value="<%=severity%>" selected><%=severity%></option>
                                                                <%
                                                                } else {
                                                                    severity = severity4;
                                                                %>
                                                                <option value="<%=severity%>"><%=severity%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </SELECT></td>

                                                        <%
                                                            String priority1 = "P1-Now";
                                                            String priority2 = "P2-High";
                                                            String priority3 = "P3-Medium";
                                                            String priority4 = "P4-Low";
                                                            String priority = "";
                                                        %>

                                                        <td height="21" width="20%"><SELECT NAME="priority" id="priority" size="1" onChange="javascript:callduedate();">
                                                                <OPTION SELECTED VALUE="<%=priority3%>">P3-Medium</option>
                                                                    <%
                                                                        if (priority1.equals(request.getParameter("priority"))) {
                                                                            priority = priority1;
                                                                    %>
                                                                <option value="<%=priority%>" selected><%=priority%></option>
                                                                <%
                                                                } else {
                                                                    priority = priority1;
                                                                %>
                                                                <option value="<%=priority%>"><%=priority%></option>
                                                                <%
                                                                    }
                                                                    if (priority2.equals(request.getParameter("priority"))) {
                                                                        priority = priority2;
                                                                %>
                                                                <option value="<%=priority%>" selected><%=priority%></option>
                                                                <%
                                                                } else {
                                                                    priority = priority2;
                                                                %>
                                                                <option value="<%=priority%>"><%=priority%></option>
                                                                <%
                                                                    }

                                                                    if (priority4.equals(request.getParameter("priority"))) {
                                                                        priority = priority4;
                                                                %>
                                                                <option value="<%=priority%>" selected><%=priority%></option>
                                                                <%
                                                                } else {
                                                                    priority = priority4;
                                                                %>
                                                                <option value="<%=priority%>"><%=priority%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </SELECT></td>

                                                        <%
                                                            if (rs6 != null) {
                                                                rs6.close();
                                                            }
                                                            if (stmt6 != null) {
                                                                stmt6.close();
                                                            }
                                                        %>
                                                        <td height="21" width="20%"><input type="text" id="date" name="date"
                                                                                           maxlength="10" size="14" readonly /></td>
                                                    </tr>
                                            </table>
                                            <table width="100%" border="0" bgcolor="#E8EEF7" cellspacing="2"
                                                   cellpadding="2" align="center">
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr>
                                                    <td height="21"><b>
                                                            <div id="subject1" style="position: relative; visibility: visible">Subject</div>
                                                        </b></td>


                                                    <%
                                                        String subject = request.getParameter("subject");
                                                        if (subject == null) {
                                                            subject = "";
                                                        }
                                                    %>
                                                    <td height="21"><input type="text" id="subject" name="subject" size="91" spellcheck="true"
                                                                           maxlength="100" value="<%=subject%>">
                                                            <span><img style="position: realtive;cursor:pointer; height:12px;margin-left:10px;" src="/eTracker/images/link.png" title='View Issues'  id="mainIssues"></span>
                                                            <input type="hidden" name="mainIssue" id="mainIssue" value=""/>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="right"><input readonly type="text"
                                                                                         name="remLen1" size="3" maxlength="3" value="4000">characters
                                                            left</td>
                                                </tr>

                                                <tr>
                                                    <td height="21" width="12%"><b>
                                                            <div id="description1"
                                                                 style="position: relative; visibility: visible">Description</div>
                                                        </b></td>

                                                    <%
                                                        String description = request.getParameter("descriptions");
                                                        if (description == null) {
                                                            description = "Found in build:<br>                                                             " + "Detailed Issue Description:<br>                                                        " + "Related issue:";
                                                        }
                                                    %>
                                                    <td height="21" width="80%"><font size="2"
                                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                                name="descriptions" wrap="physical" cols="84" rows="4"
                                                                onKeyDown="textCounter(document.theForm.descriptions, document.theForm.remLen1, 4000);"
                                                                onKeyUp="textCounter(document.theForm.descriptions, document.theForm.remLen1, 4000);"><%=description%></textarea></font></td>
                                                    <script type="text/javascript">
                                                        CKEDITOR.replace('descriptions', {toolbar: 'Basic', height: 100});
                                                        var editor_data = CKEDITOR.instances.descriptions.getData();
                                                        CKEDITOR.instances["descriptions"].on("instanceReady", function ()
                                                        {

                                                            //set keyup event
                                                            this.document.on("keyup", updateTextArea);
                                                            //and paste event
                                                            this.document.on("paste", updateTextArea);

                                                        });

                                                        function updateTextArea()
                                                        {
                                                            CKEDITOR.tools.setTimeout(function ()
                                                            {
                                                                var desc = CKEDITOR.instances.descriptions.getData();
                                                                var leng = desc.length;
                                                                editorTextCounter(leng, document.theForm.remLen1, 4000);

                                                            }, 0);
                                                        }
                                                    </script>                                                        
                                                </tr>
                                                <tr>

                                                </tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr></tr>
                                                <tr>
                                                    <td height="21" width="12%"><b>
                                                            <div id="rootcause1" style="position: relative; visibility: visible">Root
                                                                Cause</div>
                                                        </b></td>

                                                    <%
                                                        String rootCause = request.getParameter("rootCause");
                                                        rootCause = request.getParameter("tsname");
                                                        String teststepId = request.getParameter("tsId");
                                                        logger.info("teststepId : " + teststepId);
                                                        if (rootCause == null) {
                                                            rootCause = "If you know the root cause  type in";
                                                        }
                                                    %>
                                                    <td height="21" width="80%">
                                                        <input type="hidden" name="teststepId" value="<%=teststepId%>"/>
                                                        <input type="text" id="rootCause" name="rootCause" spellcheck="true"
                                                               size="91" maxlength="110" value="<%= rootCause%>" onclick="clearRootCause();"  onblur="javascript:popRootCause();"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="right"><input readonly type="text"
                                                                                         name="remLen2" size="3" maxlength="3" value="2000">characters
                                                            left</td>
                                                </tr>

                                                <tr>
                                                    <td height="21" width="12%"><b>
                                                            <div id="expectedresult1"
                                                                 style="position: relative; visibility: visible">Expected
                                                                Result</div>
                                                        </b></td>

                                                    <%
                                                        String expectedResult = request.getParameter("expectedResult");
                                                        if (expectedResult == null) {
                                                            expectedResult = "";
                                                        }
                                                    %>

                                                    <td height="21" width="80%"><font size="2"
                                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                                name="expectedResult" wrap="physical" cols="84" rows="2"
                                                                onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000);"
                                                                onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000);"><%= expectedResult%></textarea></font></td>
                                                    <script type="text/javascript">
                                                        CKEDITOR.replace('expectedResult', {toolbar: 'Basic', height: 100});
                                                        var editor_data = CKEDITOR.instances.expectedResult.getData();
                                                        CKEDITOR.instances["expectedResult"].on("instanceReady", function ()
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
                                                                var desc = CKEDITOR.instances.expectedResult.getData();
                                                                var leng = desc.length;
                                                                editorTextCounter(leng, document.theForm.remLen2, 2000);

                                                            }, 0);
                                                        }
                                                    </script>
                                                </tr>
                                                <tr>

                                                    <td height="21" width="12%"><b>
                                                            Choose a file to upload
                                                        </b></td>                                
                                                    <td><input type="file" id="files" name="files" class="file" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="center"><img id="progressbar" style='display: none;' src='/eTracker/images/file-progress.gif'/></td>
                                                </tr>

                                            </table>
                                            <%

                                                } catch (Exception e) {
                                                    logger.error("Exception:" + e);
                                                } finally {
                                                    if (connection != null) {
                                                        connection.close();
                                                    }
                                                }

                                            %>
                                        </div> 
                                        <div  id="creatissueforma">
                                            <table  width="100%"  bgcolor="#E8EEF7" >
                                                <tr>
                                                    <td align="center"><input type="submit" id="submit" name="submit"
                                                                              value="Submit"/> </td>

                                                </tr>

                                            </table>
                                        </div>


                                        <br/>
                                        <%@ include file="footer.jsp"%>
                                </FORM>
                                <% } else {
                                %>
                                <p> <br/> <center><span style="font: bolder; color: red; font-size: 10px;">Please create a issue from Tree Map.</span>
                                        <br/>
                                        <input type="button" name="close" value="Close" onclick="window.close()"/>
                                    </center></p>
                                    <% }%>
                            </body>
                            <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                                <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
                                <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>
                                <style type="text/css">
                                    .ui-widget-overlay{
                                        z-index:10;
                                    }
                                </style>
                                <script type="text/javascript">
                                            $('#files').bind('change', function () {
                                                $('#progressbar').fadeIn('slow');
                                                $('div.statusbar').remove();

                                                var obj = $("#files");
                                                var count = 0;

                                                var fileName = document.getElementById('files').value;
                                                var allowed_extensions = new Array("docm", "dotm", "dotx", "potm", "potx", "ppam", "ppsm", "ppsx", "pptm", "pptx", "xlam", "xlsb", "xlsm", "xltm", "xltx", "xps", "xls", "xlsx", "xlsm", "doc", "docx", "bmp", "jpg", "jpeg", "gif", "png", "bmp", "pdf", "txt", "mht", "zip", "rar", "htm", "ppt", "pptx", "tif", "chm", "rtf", "html", "pps", "sql", "war", "uml", "xps", "xml", "avi", "idc", "msg", "csv");
                                                var file_extension = fileName.split('.').pop().toLowerCase(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
                                                for (var i = 0; i <= allowed_extensions.length; i++)
                                                {
                                                    if (allowed_extensions[i] == file_extension)
                                                    {
                                                        count = 1;
                                                    }
                                                }
                                                if (count == 1) {
                                                    var ua = window.navigator.userAgent;

                                                    var msie = ua.indexOf('MSIE ');
                                                    var trident = ua.indexOf('Trident/');
                                                    var edge = ua.indexOf('Edge/');

                                                    if (msie > 0 || trident > 0 || edge > 0) {

                                                    } else {
                                                        handleFileUpload(this.files, obj);
                                                    }

                                                } else {
                                                    document.getElementById('files').value = '';
                                                    alert("You must upload a file with one of the following extensions: " + allowed_extensions.join(', ') + ".");
                                                }
                                                $('#progressbar').fadeOut();
                                            });

                                            $("#mainIssues").click(function () {
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
                                                        $("body").css("overflow", "hidden");
                                                    },
                                                    close: function () {
                                                        $("body").css("overflow", "auto");
                                                    }

                                                });
                                                $(".addTargetCount > img").show();
                                                $(".addTargetCount > div").html("");
                                                $(".addTargetCount").dialog("open");
                                                var pname = "<%=request.getParameter("project")%>";
                                                var ver = "<%=request.getParameter("version")%>";
                                                var mainIssue = $("#mainIssue").val();
                                                var issueId = "";
                                                $.ajax({url: '<%=request.getContextPath()%>/getIssuesByPnameVersion.jsp',
                                                    data: {pname: pname, ver: ver, mainIssue: mainIssue, random: Math.random(1, 10)},
                                                    async: true,
                                                    type: 'GET',
                                                    success: function (responseText, statusTxt, xhr) {
                                                        if (statusTxt === "success") {
                                                            var result = $.trim(responseText);
                                                            $(".addTargetCount > div").html(result);
                                                            $('input:radio[name="selectedIssue"]').filter('[value=' + mainIssue + ']').attr('checked', true);

                                                        }
                                                    }
                                                });
                                            });
                                            $("#date").datepicker({
                                                showOn: "button",
                                                changeMonth: true,
                                                changeYear: true,
                                                buttonImage: "./images/newhelp.gif",
                                                buttonImageOnly: true,
                                                minDate: 0,
                                                dateFormat: "dd-mm-yy"
                                            });
                                            $('#date').click(function () {
                                                $('#date').datepicker('show');
                                            });

                                </script>


                                </html>
