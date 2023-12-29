<%-- 
    Document   : createTestIssues
    Created on : 28 Jul, 2010, 8:45:59 PM
    Author     : Tamilvelan
--%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%
    String ua = request.getHeader("User-Agent");
    boolean isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
    boolean isMSIE = (ua != null && ua.indexOf("MSIE") != -1);
    response.setHeader("Vary", "User-Agent");
    if (isFirefox) {
%>
<jsp:forward page="/CreateIssue/BrowserWarning.jsp"></jsp:forward>

<%    }

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("Edit Module");


%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <meta name="Generator" content="EditPlus">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <script  type="text/javascript" src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script> 
    <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
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
                var file_extension = fileName.split('.').pop(); // split function will split the filename by dot(.), and pop function will pop the last element from the array which will give you the extension as well. If there will be no extension then it will return the filename.                              
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
    function textCounter(field, cntfield, maxlimit) {
        if (field.value.length > maxlimit) {
            field.value = field.value.substring(0, maxlimit);
            if (maxlimit == 4000)
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


<script language="JavaScript">
    function trim(str) {
        while (str.charAt(str.length - 1) == " ")
            str = str.substring(0, str.length - 1);
        while (str.charAt(0) == " ")
            str = str.substring(1, str.length);
        return str;
    }
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

        if (document.theForm.module.value == "") {
            alert("Please select the Module Name");
            document.theForm.module.focus();
            return false;
        }
        if (trim(document.theForm.date.value) == "") {
            alert("Please Enter the Due Date ");
            document.theForm.date.focus();
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
        var current_day = current_date.getDate();
        var today = new Date(current_year, current_month, current_day);

        if (form_date < today) {
            alert('Due Date cannot be less than Today');
            document.theForm.date.value = "";
            theForm.date.focus();
            return false;
        }

        if (document.theForm.subject.value == "") {
            alert("Please select the Subject ");
            document.theForm.subject.focus();
            return false;
        }
        if (document.theForm.descriptions.value == "") {
            alert("Please select the Description");
            document.theForm.descriptions.focus();
            return false;
        }
        if (trim(document.theForm.rootCause.value) == "")
        {
            alert("Please Enter the Root Cause if you know or Nil if you don't ");
            document.theForm.rootCause.focus();
            return false;
        }
        if (trim(document.theForm.expectedResult.value) == "")
        {
            alert("Please Enter the Expected result");
            document.theForm.expectedResult.focus();
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
        monitorSubmit();
    }

</script>
<body bgcolor="#FFFFFF">
    <FORM name="theForm" onSubmit='return validate(this)' ACTION="/eTracker/createBug/createBugIssue.jsp" METHOD="POST" enctype="multipart/form-data" >
        <%@ page
            import="java.sql.*"%> <%@ page language="java"%>

            <%

                String bug = "yes";
                session.setAttribute("bug", bug);
                String flag = request.getParameter("flag");
                if (flag != null && flag.equalsIgnoreCase("true")) {
                    String issueId = (String) session.getAttribute("issueid");
            %>
            <center><font SIZE="4" COLOR="#33CC33">The issue has been created successfully.Issue id : <%= issueId%></font></center>

            <%
                }

                flag = null;

                Statement stmt0 = null, stmt1 = null, stmt2 = null, stmt3 = null, stmt6 = null, stmt7 = null;
                ResultSet rs0 = null, rs1 = null, rs2 = null, rs3 = null, rs6 = null, rs7 = null;
                Connection connection = null;
                String project = request.getParameter("project");
                String moduleName = request.getParameter("module");
                String ver = request.getParameter("version");
                String rootCause = request.getParameter("ptcid");
                String subject=null, description=null, expectedResult=null;
                logger.info("Project Name    :" + project);
                logger.info("Project Version :" + ver);
                logger.info("Module Name    :" + moduleName);
                try {
                    connection = MakeConnection.getConnection();

                    stmt0 = connection.createStatement();
                    rs0 = stmt0.executeQuery("SELECT functionality,description,expectedresult FROM TQM_PTCM WHERE ptcid='" + rootCause + "'");
                    while (rs0.next()) {
                        subject = rs0.getString("functionality");
                        description = rs0.getString("description");
                        expectedResult = rs0.getString("expectedresult");
                    }
                    rootCause = "Reference Test Case ID : " + rootCause;
            %> <br>
            <div id="prposIssue"></div>
            <input type="hidden" name="pChecker" id="pChecker" value="No"/>
            <div id="creatissueform">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2">
                        <td width="145" align="center"><a
                                href="http://www.eminentlabs.com" target="_new"><img border="0"
                                                                                 alt="Eminentlabs Software Pvt Ltd Pvt. Ltd."
                                                                                 src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                        <td border="1" align="center" width="100%"  ><font size="4"
                                                                           COLOR="#0000FF"><b></b></font> <FONT SIZE="3"
                                                                 COLOR="#0000FF"> </FONT></td>
                        <td align="right">
                            <img alt="Eminentlabs Software Pvt Ltd" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                        </td>
                    </tr>

                </table>

                <table width="100%" border="0" bgcolor="#E8EEF7" cellspacing="2"
                       cellpadding="2" align="center">

                    <tr>
                        <td colspan="4">
                            <div align="left"></div>
                            <font size="2" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;
                            </font>
                            <table width="100%" border="0" cellspacing="2" cellpadding="2">

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
                                        %> <select name="module" id="module" size="1"  onChange="javascript:callduedate();">
                                            <option selected>--Select One--</option>
                                            <%			if (rs6 != null) {
                                                    while (rs6.next()) {
                                                        String module = rs6.getString("module");
                                                        if (module.equalsIgnoreCase(moduleName)) {
                                            %>
                                            <option value="<%=module%>" selected><%=module%></option>
                                            <%
                                            } else {

                                            %>
                                            <option value="<%=module%>"><%=module%></option>
                                            <%
                                                        }
                                                    }
                                                }

                                            %>
                                        </select></td>
                                    <td height="21" width="20%">
                                        <%                                            String type1 = "New Task";
                                            String type2 = "Enhancement";
                                            String type3 = "Bug";
                                            String type = "";
                                        %> <select name="type" size="1">
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
                                            <option selected VALUE="<%=severity3%>">S3- Important</option>
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
                                            <option SELECTED VALUE="<%=priority3%>">P3-Medium</option>
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
                                                                       maxlength="10" size="14" readonly /><a
                                                                       href="javascript:NewCal('date','ddmmyyyy')"> <img
                                                src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                                                width="16" height="16" alt="Pick a date"></a></td>
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
                                        if (subject == null) {
                                            subject = "";
                                        }
                                    %>
                                    <td height="21"><input type="text" name="subject" size="91"
                                                           maxlength="100" value="<%=subject%>" style="height: 25px;"></td>

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
                                        if (description == null) {
                                            description = "Found in build:<br>                                                             " + "Detailed Issue Description:<br>                                                        " + "Related issue:";
                                        }
                                    %>
                                    <td height="21" width="80%"><font size="2"
                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                name="descriptions" wrap="physical" cols="84" rows="4"
                                                onKeyDown="textCounter(document.theForm.descriptions, document.theForm.remLen1, 4000)"
                                                onKeyUp="textCounter(document.theForm.descriptions, document.theForm.remLen1, 4000)"><%=description%></textarea></font>
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
                                    </td>
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
                                        //	String rootCause = request.getParameter("rootCause");
                                        if (rootCause == null) {
                                            rootCause = "If you know the root cause  type in";
                                        }
                                    %>
                                    <td height="21" width="80%"><input type="text" name="rootCause"
                                                                       size="91" maxlength="110" value="<%= rootCause%>" style="height: 25px;"></td>
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
                                        if (expectedResult == null) {
                                            expectedResult = "";
                                        }
                                    %>

                                    <td height="21" width="80%"><font size="2"
                                                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                name="expectedResult" wrap="physical" cols="84" rows="2"
                                                onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000)"
                                                onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000)"><%= expectedResult%></textarea></font>

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
                    </tr>
                    <tr>

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

                </table>
            </div> 
            <div  id="creatissueforma">
                <table  width="100%"  bgcolor="#E8EEF7" >
                    <tr>
                        <td align="center"><input type="submit" id="submit" name="submit"
                                                  value="Submit"/> </td>
                    </tr>
                </table>
            </div>
            <script type="text/javascript">
                callduedate();
            </script>
            <br>
            <TABLE bgColor="#C3D9FF" border=0 width="100%">
                <tbody>
                    <TR>
                        <TD align=center noWrap vAlign=top width="50%" height="150%">
                            <font face="Verdana" size="4" color="#666666">
                                KPI Tracker&#153;, ERPDS&#153;, EWE&#153;, eTracker&#153;, eOutsource&#153;, Rightshore&#153; are registered trademarks of Eminentlabs&#153; Software Private Limited
                            </font>
                        </TD>

                    </TR>
                </TBODY>
            </TABLE>

        </FORM>
    </body>
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

    </script>
</html>
