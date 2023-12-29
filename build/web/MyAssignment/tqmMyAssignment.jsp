<%-- 
    Document   : tqmMyAssignment
    Created on : Dec 7, 2009, 2:58:31 PM
    Author     : Administrator
--%>

<%@ page import="com.eminent.issue.*,java.util.List,com.eminent.tqm.IssueTestCaseUtil, com.eminent.tqm.*, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.sql.*,java.text.*,java.util.HashMap,java.util.LinkedHashMap,com.pack.*,pack.eminent.encryption.*,org.apache.log4j.*,com.eminent.util.*,java.util.Collection, java.util.ArrayList, java.util.Iterator" buffer="1024kb" autoFlush="false"%>
<%@ page language="java"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    Logger logger = Logger.getLogger("UpdateIssueView");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <script language=javascript
                src="<%= request.getContextPath()%>/javaScript/checkSubmit.js">
        </script>

        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>    <script language=javascript
        src="<%= request.getContextPath()%>/javaScript/feedbackSelect.js"></script>

        <script type="text/javascript" language="JavaScript">
                    function trim(str) {
                        while (str.charAt(str.length - 1) == " ")
                            str = str.substring(0, str.length - 1);
                        while (str.charAt(0) == " ")
                            str = str.substring(1, str.length);
                        return str;
                    }
                    function createRequest() {
                        var reqObj = null;
                        try {
                            reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                        }
                        catch (err) {
                            try {
                                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                            }
                            catch (err2) {
                                try {
                                    reqObj = new XMLHttpRequest();
                                }
                                catch (err3) {
                                    reqObj = null;
                                }
                            }
                        }
                        return reqObj;
                    }
                    function assignedusers() {
                        xmlhttp = createRequest();

                        if (xmlhttp != null) {
                            var issueid = document.getElementById("issueId").value;
                            var status = document.getElementById("issuestatus").value;
                            xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/MyIssues/assignedToDetails.jsp?issueid=" + issueid + "&status=" + status + "&rand=" + Math.random(1, 10), false);

                            xmlhttp.onreadystatechange = callassignedto;
                            xmlhttp.send(null);
                        }
                    }
                    function callassignedto()
                    {
                        var results = "";
                        if (xmlhttp.readyState == 4)
                        {
                            if (xmlhttp.status == 200)
                            {
                                var results = "";
                                var result = xmlhttp.responseText.split(";");
                                //            alert("Result:"+result);
                                var results = result[1].split(",");
                                //         alert("Result:"+results);
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
                                    if (assigned == id) {
                                        objLinkList[i].selected = true;
                                    }

                                }
                                var results = "";
                                var result = "";
                            }
                        }
                    }



                    function isModuleExist() {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp != null) {

                            var version = theForm.fix_version.value;
                            xmlhttp.open("GET", "moduleCheck.jsp?version=" + version + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = userAlert;
                            xmlhttp.send(null);
                        }
                    }


                    function userAlert() {
                        if (xmlhttp.readyState == 4) {
                            if (xmlhttp.status == 200) {

                                var module = xmlhttp.responseText.split(",");
                                var flag = module[1];

                                if (flag == 'no') {

                                    alert("This module is not present in the selected version. Please contact your Project Manager");
                                    document.theForm.fix_version.value = module[2];
                                    theForm.fix_version.focus();
                                }

                            }
                        }
                    }

                    function isDuedateCorrect() {
                        xmlhttp = createRequest();
                        if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                            xmlhttp = new XMLHttpRequest();
                        }
                        if (xmlhttp != null) {

                            var dueDate = theForm.date.value;
                            xmlhttp.open("GET", "dueDateCheck.jsp?dueDate=" + dueDate + "&rand=" + Math.random(1, 10), true);
                            xmlhttp.onreadystatechange = dueDateAlert;
                            xmlhttp.send(null);
                        }
                    }


                    function dueDateAlert() {
                        if (xmlhttp.readyState == 4) {
                            if (xmlhttp.status == 200) {

                                var due = xmlhttp.responseText.split(",");
                                var flag = due[1];

                                if (flag != 'correct') {

                                    alert("Due Date should be less than Project End Date (" + flag + ").Please contact your Project Manager");

                                    theForm.date.value = "";


                                }

                            }
                        }
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
                        }
                        else
                            cntfield.value = maxlimit - field.value.length;
                    }
                    function printpost(post)
                    {
                        pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                        pp.focus();
                    }

                    function fun(theForm)
                    {
                        var fromPage = document.getElementById("issuestatus").value;
                        alert(fromPage);
                        var status = "Unconfirmed";

                        if (status == fromPage)
                        {
                            alert('Change the status before update');
                            theForm.issuestatus.focus();
                            return false;
                        }


                        if (theForm.date.value == '')
                        {
                            alert('Please enter the Due Date');
                            theForm.date.focus();
                            return false;
                        }
                        alert(document.getElementById('date').value);
                        if (document.getElementById('dateChange').value != document.getElementById('date').value) {

                            var str = document.theForm.date.value;
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
                                theForm.date.focus();
                                return false;
                            }
                            if (form_date.getYear() == current_date.getYear())
                            {
                                if (form_date.getMonth() < current_date.getMonth())
                                {
                                    window.alert("Enter the valid Due Date");
                                    theForm.date.focus();
                                    return false;
                                }
                                if (form_date.getMonth() == current_date.getMonth())
                                {
                                    if (form_date.getDate() < current_date.getDate())
                                    {
                                        window.alert("Enter the valid Due Date");
                                        theForm.date.focus();
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
                            return false;
                        } else {
                            alert('Not Changed');
                        }
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

                        if (document.getElementById('issuestatus').value == 'Closed') {
                            if ($('#lastRow').length) {
                            } else {
                                newRow();
                            }
                            var check = document.getElementById('feedback').value;
                            if (check == 'Select') {
                                alert('Your feedback is valuable for us');
                                document.getElementById('feedback').focus();
                                return false;
                            }

                        }

                        if (document.getElementById('issuestatus').value == 'Closed' && document.getElementById('feedback').value == 'Need Improvement') {

                            if (document.getElementById('feedbackString').value == '') {
                                alert('Your feedback is valuable for us');
                                document.getElementById('feedbackString').focus();
                                return false;
                            }

                        }
                        //           alert(fromPage);
                        if (fromPage == "QA-Build Test Cases") {
                            //              alert('Inside Test Case Validation');
                            var func = document.getElementsByName("functionality");
                            var desc = document.getElementsByName("description");
                            var rslt = document.getElementsByName("expectedresult");
                            alert(func.length);
                            for (var i = 0; i < func.length; i++) {

                                if (trim(func[i].value) == '') {
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
                                if (trim(desc[i].value) == '') {
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
                                if (trim(rslt[i].value) == '') {
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
                        }


                        monitorSubmit();

                    }
                    function addRow(tablename) {
                        //                      alert("Name of the table"+tablename);
                        var table = document.getElementById(tablename);
                        var rowCount = table.rows.length;
                        //                      alert("No of Rows"+rowCount);
                        var row1 = table.insertRow(rowCount - 1);
                        if (rowCount == 7) {
                            if (tablename == "testcases") {
                                table.deleteRow(7);
                                //                        alert('Removing last row');
                            } else {
                                table.rows[7].cells[3].innerHTML = '';
                            }
                        }
                        var idno = rowCount - 1;
                        rowCount = rowCount - 1;
                        row1.id = "id" + idno;
                        var cell1 = document.createElement('td');
                        cell1.id = "cellid" + idno;

                        var lable1 = document.createTextNode(idno);


                        cell1.appendChild(lable1);

                        var cell2 = document.createElement('td');
                        cell2.align = "center";
                        var appre = document.createElement("textarea");
                        appre.name = "functionality";
                        appre.id = "functionality";
                        appre.cols = "25";
                        appre.rows = "3";

                        cell2.appendChild(appre);

                        var cell3 = document.createElement('td');
                        cell3.align = "center";
                        var desc = document.createElement("textarea");
                        desc.name = "description";
                        desc.id = "description";
                        desc.cols = "25";
                        desc.rows = "3";
                        cell3.appendChild(desc);

                        var cell4 = document.createElement('td');
                        cell4.align = "left";
                        var result = document.createElement("textarea");
                        result.name = "expectedresult";
                        result.id = "expectedresult";
                        result.cols = "25";
                        result.rows = "3";

                        var sub = document.createElement("img");
                        sub.src = "bullet.jpg";

                        sub.id = "remove";
                        sub.alt = "Remove";
                        sub.onclick = new Function("javascript:removeRow('" + tablename + "','id" + rowCount + "');");


                        cell4.appendChild(result);
                        cell4.appendChild(sub);

                        row1.appendChild(cell1);
                        row1.appendChild(cell2);
                        row1.appendChild(cell3);
                        row1.appendChild(cell4);

                    }
                    function removeRow(tablename, rowCount) {
                        var tables = document.getElementById(tablename);
                        var rows = tables.rows.length;

                        var row = rows - 1;
                        if (document.getElementById('add') == null) {
                            row = rows;
                        }
                        try {
                            var removed = 'false';
                            for (var i = 0; i < row; i++) {

                                if (tables.rows[i].id == rowCount)
                                {
                                    tables.deleteRow(i);
                                    i--;
                                    removed = true;
                                }
                                if (removed == true) {

                                    if (i < row - 2) {
                                        tables.rows[i + 1].cells[0].innerHTML = i + 1;
                                    }

                                }


                            }

                        } catch (e) {
                            //		alert(e);
                        }

                    }
                    function addMoreTestCases() {
                        var tables = document.getElementById("testcasesavailable");
                        var rows = tables.rows.length;
                        //                   alert("No of Rows"+rows);
                        try {
                            for (var i = 0; i < rows; i++) {


                                tables.deleteRow(0);
                            }
                            var row1 = tables.insertRow(0);
                            var theBoldBit1 = document.createElement('b');

                            var cell1 = document.createElement('td');
                            cell1.align = 'center';
                            var lable1 = document.createTextNode('S No');
                            theBoldBit1.appendChild(lable1);
                            cell1.appendChild(theBoldBit1);

                            var cell2 = document.createElement('td');
                            var theBoldBit2 = document.createElement('b');
                            cell2.align = 'center';
                            var lable2 = document.createTextNode('Functionality');
                            theBoldBit2.appendChild(lable2);
                            cell2.appendChild(theBoldBit2);

                            var cell3 = document.createElement('td');
                            var theBoldBit3 = document.createElement('b');
                            cell3.align = 'center';
                            var lable3 = document.createTextNode('Description');
                            theBoldBit3.appendChild(lable3);
                            cell3.appendChild(theBoldBit3);

                            var cell4 = document.createElement('td');
                            var theBoldBit4 = document.createElement('b');
                            cell4.align = 'center';
                            var lable4 = document.createTextNode('Expected Result');
                            theBoldBit4.appendChild(lable4);
                            cell4.appendChild(theBoldBit4);

                            row1.appendChild(cell1);
                            row1.appendChild(cell2);
                            row1.appendChild(cell3);
                            row1.appendChild(cell4);

                            var row2 = tables.insertRow(1);

                            var cell21 = document.createElement('td');
                            cell21.id = "id1";

                            var lable21 = document.createTextNode("1");


                            cell21.appendChild(lable21);

                            var cell22 = document.createElement('td');
                            cell22.align = "center";
                            var appre = document.createElement("textarea");
                            appre.name = "functionality";
                            appre.id = "functionality";
                            appre.cols = "25";
                            appre.rows = "3";

                            cell22.appendChild(appre);

                            var cell23 = document.createElement('td');
                            cell23.align = "center";
                            var desc = document.createElement("textarea");
                            desc.name = "description";
                            desc.id = "description";
                            desc.cols = "25";
                            desc.rows = "3";
                            cell23.appendChild(desc);

                            var cell24 = document.createElement('td');
                            cell24.align = "left";
                            var result = document.createElement("textarea");
                            result.name = "expectedresult";
                            result.id = "expectedresult";
                            result.cols = "25";
                            result.rows = "3";



                            cell24.appendChild(result);


                            row2.appendChild(cell21);
                            row2.appendChild(cell22);
                            row2.appendChild(cell23);
                            row2.appendChild(cell24);

                            var row3 = tables.insertRow(2);
                            row3.id = "add";
                            var cell34 = document.createElement('td');
                            var link2 = document.createElement('a');
                            link2.href = "javascript:void(0);"
                            var text2 = document.createTextNode('Remove All Test Cases');
                            link2.appendChild(text2);
                            link2.onclick = new Function("javascript:addComments('testcasesavailable');");
                            cell34.appendChild(link2);

                            var cell31 = document.createElement('td');
                            var comments = document.createElement('input');
                            comments.id = "comments";
                            comments.name = "comments";
                            comments.type = "hidden";
                            comments.value = "Adding Test Cases";

                            var cell33 = document.createElement('td');
                            var cell32 = document.createElement('td');
                            cell32.appendChild(comments);
                            cell31.align = 'right';
                            cell31.colspan = '4';
                            var link = document.createElement('a');
                            link.href = "javascript:void(0);"
                            var text = document.createTextNode('Add Test Case');
                            link.onclick = new Function("javascript:addRow('testcasesavailable');");
                            link.appendChild(text);
                            cell31.appendChild(link);

                            row3.appendChild(cell32);
                            row3.appendChild(cell33);
                            row3.appendChild(cell34);
                            row3.appendChild(cell31);

                        } catch (e) {
                            //                    alert(e);
                        }
                    }
                    function addComments() {
                        var tables = document.getElementById("testcasesavailable");
                        var rows = tables.rows.length;
                        //                 alert("No of Rows"+rows);
                        try {
                            for (var i = 0; i < rows; i++) {


                                tables.deleteRow(0);
                            }
                            var row3 = tables.insertRow(0);
                            row3.id = "add";
                            var cell34 = document.createElement('td');

                            var cell31 = document.createElement('td');

                            cell31.align = 'right';
                            cell31.colspan = '4';
                            var link = document.createElement('a');
                            link.href = "javascript:void(0);"
                            var text = document.createTextNode('Add New Test Case');
                            link.onclick = new Function("javascript:addMoreTestCases('testcasesavailable');");
                            link.appendChild(text);
                            cell31.appendChild(link);



                            row3.appendChild(cell34);
                            row3.appendChild(cell31);
                            var row1 = tables.insertRow(1);
                            var theBoldBit1 = document.createElement('b');

                            var cell1 = document.createElement('td');
                            cell1.align = 'center';
                            var lable1 = document.createTextNode('Comments');
                            theBoldBit1.appendChild(lable1);
                            cell1.appendChild(theBoldBit1);

                            var cell2 = document.createElement('td');
                            cell2.align = "center";
                            var appre = document.createElement("textarea");
                            appre.name = "comments";
                            appre.id = "comments";
                            appre.cols = "75";
                            appre.rows = "3";
                            cell2.appendChild(appre);
                            row1.appendChild(cell1);
                            row1.appendChild(cell2);


                        }
                        catch (e) {
                            //                   alert(e);
                        }
                    }
        </script>
        <script language="javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    </head>
    <BODY>
        <FORM name="theForm" onSubmit='return fun(this)'
              action="<%=request.getContextPath()%>/MyAssignment/modifyIssue.jsp"
              method="post"><%@ include file="../header.jsp"%>
            <div align="center">
                <center>

                    <%
                        String issueId = request.getParameter("issueid");

                    %>
                    <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" /> <%!
                        HashMap hm;
                                                                    %> <%    Connection connection = null;
                                                Statement state = null, stmt = null, stmt1 = null, stmt7 = null;
                                                ResultSet resultset = null, result = null, result1 = null, rs2 = null, rs3 = null, rs4 = null, resultset1 = null, prj_count = null, rs5 = null;
                                                PreparedStatement pt2 = null, pt1 = null, pt4 = null;
                                                int role = 0, uid = 0, pmanager = 0;

                                                try {
                                                    connection = MakeConnection.getConnection();
                                                    state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                    resultset = state.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + issueId + "'");//CHANGED
                                                    ResultSetMetaData rsmd = resultset.getMetaData();
                                                    int NoofColumns = rsmd.getColumnCount();
                                                    int i = 0;
                                                    while (i <= NoofColumns) {
                                                        i++;
                                                    }

                                                    role = (Integer) session.getAttribute("Role");
                                                    uid = (Integer) session.getAttribute("userid_curr");

                                                    if (resultset != null) {
                                                        while (resultset.next()) {
                                                            String cus = resultset.getString("customer");
                                                            String pro = resultset.getString("project");
                                                            String ver = resultset.getString("found_version");
                                                            String fix = resultset.getString("fix_version");
                                                            String mod = resultset.getString("module");
                                                            session.setAttribute("projectName", pro);
                                                            session.setAttribute("versionValue", fix);
                                                            session.setAttribute("moduleName", mod);
                                                            String pla = resultset.getString("platform");
                                                            String sev = resultset.getString("severity");
                                                            String pri = resultset.getString("priority");
                                                            String typ = resultset.getString("type");
                                                            int creby = resultset.getInt("createdby");
                                                            session.setAttribute("creBy", creby);
                                                            int assign = resultset.getInt("assignedto");
                                                            Date creon = resultset.getDate("createdon");
                                                            Date mdion = resultset.getDate("modifiedon");
                                                            SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                                                            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                            SimpleDateFormat formatDate = new SimpleDateFormat("dd-MMM-yy");
                                                            Date due = resultset.getDate("due_date");
                                                            String viewDueDate = formatDate.format(due);

                                                            String dueDate = "NA";
                                                            if (due != null) {
                                                                dueDate = dfm.format(due);
                                                            }

                                                            String sub = resultset.getString("subject");
                                                            String des = resultset.getString("description");
                                                            String com1 = resultset.getString("comment1");

                                                            String root_cau = resultset.getString("rootcause");
                                                            String exp_res = resultset.getString("expected_result");

                                                            pmanager = Integer.parseInt(GetProjectManager.getManager(pro, fix));

                                                            if (hm == null) {
                                                                hm = UpdateIssue.showUsers(connection);
                                                            }
                                                            String createdBy = (String) hm.get(creby);

                                                            String dateString = sdf.format(creon);
                                                            String dueDisplay = "NA";
                                                            if (due != null) {
                                                                dueDisplay = sdf.format(due);
                                                                session.setAttribute("dueDisplay", dueDisplay);
                                                            }

                                                            SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yy");
                                                            String dateString1 = sdf1.format(mdion);

                                                            SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yy");
                                                            String createdOn = df.format(creon);
                                                            session.setAttribute("createdOn", createdOn);
                                                            session.setAttribute("foundVersion", ver);

                                                            int len = des.length();
                                                            int index = 0;
                                                            String des1 = null, nextline = "\n", substr = null;
                                                            if (len >= 130) {
                                                                des1 = des.substring(index, index + 130);
                                                                len = len - 130;
                                                                while ((len / 130) >= 1) {
                                                                    des1 = des1.concat(nextline);
                                                                    index = index + 130;
                                                                    substr = des.substring(index, index + 129);
                                                                    des1 = des1.concat(substr);
                                                                    len = len - 130;
                                                                }
                                                                index = index + 130;
                                                                des1 = des1.concat(nextline);
                                                                des1 = des1.concat(des.substring(index));
                                                            } else {
                                                                des1 = des.substring(index);
                                                            }
                                                            len = exp_res.length();
                                                            index = 0;
                                                            String exp_res1 = null;
                                                            if (len >= 130) {
                                                                exp_res1 = exp_res.substring(index, index + 130);
                                                                len = len - 130;
                                                                while ((len / 130) >= 1) {
                                                                    exp_res1 = exp_res1.concat(nextline);
                                                                    index = index + 130;
                                                                    substr = exp_res.substring(index, index + 129);
                                                                    exp_res1 = exp_res1.concat(substr);
                                                                    len = len - 130;
                                                                }
                                                                index = index + 130;
                                                                exp_res1 = exp_res1.concat(nextline);
                                                                exp_res1 = exp_res1.concat(exp_res.substring(index));
                                                            } else {
                                                                exp_res1 = exp_res.substring(index);
                                                            }
                                                            String sql1 = "select status from issuestatus where issueid='" + issueId + "' ";
                                                            pt1 = connection.prepareStatement(sql1, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                            rs2 = pt1.executeQuery();
                                                            String sta = "";
                                                            if (rs2 != null) {
                                                                while (rs2.next()) {
                                                                    sta = rs2.getString("status");
                                                                }
                                                            }

                                                            if (rs2 != null) {
                                                                rs2.close();
                                                            }
                                                            if (pt1 != null) {
                                                                pt1.close();
                                                            }
                                                            stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                            result = stmt.executeQuery("select type from project,project_type where project.pid=project_type.pid and pname='" + pro + "' and version='" + fix + "'");
                                                            String projecttype = null, phase = "", subphase = "", subsubphase = "", subsubsubphase = "";
                                                            while (result.next()) {
                                                                projecttype = result.getString("type");
                                                            }
                                                            String projecttypename = "";
                                                            if (projecttype != null) {
                                                                stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                String issuephase = "issue_" + projecttype.toLowerCase();
                                                                String query = "select phase,subphase,subsubphase,subsubsubphase from " + issuephase + " where issueid ='" + issueId + "'";
                                                                result1 = stmt1.executeQuery(query);
                                                                while (result1.next()) {
                                                                    phase = result1.getString("phase");
                                                                    subphase = result1.getString("subphase");
                                                                    subsubphase = result1.getString("subsubphase");
                                                                    subsubsubphase = result1.getString("subsubsubphase");
                                                                }

                    %> <jsp:forward page="../MyAssignment/MyAssignmentPhase.jsp">
                        <jsp:param name="issueId" value="<%=issueId%>" />
                        <jsp:param name="product" value="<%=pro%>" />
                        <jsp:param name="customer" value="<%=cus%>" />
                        <jsp:param name="foundversion" value="<%=ver%>" />
                        <jsp:param name="fixversion" value="<%=fix%>" />
                        <jsp:param name="platform" value="<%=pla%>" />
                        <jsp:param name="module" value="<%=mod%>" />
                        <jsp:param name="priority" value="<%=pri%>" />
                        <jsp:param name="severity" value="<%=sev%>" />
                        <jsp:param name="issuestatus" value="<%=sta%>" />
                        <jsp:param name="type" value="<%=typ%>" />
                        <jsp:param name="createdon" value="<%=createdOn%>" />
                        <jsp:param name="createdby" value="<%=creby%>" />
                        <jsp:param name="assignedto" value="<%=assign%>" />
                        <jsp:param name="modifiedon" value="<%=dateString1%>" />
                        <jsp:param name="viewDueDate" value="<%= viewDueDate%>" />
                        <jsp:param name="dueDate" value="<%= dueDate%>" />
                        <jsp:param name="projecttype" value="<%=projecttype%>" />
                        <jsp:param name="phase" value="<%=phase%>" />
                        <jsp:param name="subphase" value="<%=subphase%>" />
                        <jsp:param name="subsubphase" value="<%=subsubphase%>" />
                        <jsp:param name="subsubsubphase" value="<%=subsubsubphase%>" />
                        <jsp:param name="subject" value="<%=sub%>" />
                        <jsp:param name="description" value="<%=StringUtil.encodeHtmlTag(des1)%>" />
                        <jsp:param name="rootcause" value="<%=StringUtil.encodeHtmlTag(root_cau)%>" />
                        <jsp:param name="expected_result" value="<%=StringUtil.encodeHtmlTag(exp_res1)%>" />
                        <jsp:param name="comment" value="<%=StringUtil.encodeHtmlTag(com1)%>" />
                        <jsp:param name="flag" value="true" />
                    </jsp:forward>
                    <%
                        }
                        // Selecting Test Cases for this issue
                        List testcaseobjects = IssueTestCaseUtil.viewIssueTestCase(issueId);
                        int noOfTestCases = testcaseobjects.size();
                        logger.info("No Of Test Cases" + noOfTestCases);
                    %>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr border="2" bgcolor="#C3D9FF">
                            <td border="1" align="left" width="70%"><font size="4"
                                                                          COLOR="#0000FF"><b>My Assignments</b></font><FONT SIZE="3"
                                                                                  COLOR="#0000FF"> </FONT></td>

                        </tr>
                    </table>
                    <br>
                    <table width="100%" bgcolor="#C3D9FF">
                        <tr>
                            <td><b>Issue Number <font color="#0000FF"><%= issueId%></font></b></td>
                            <td align="right"><a
                                    href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= issueId%>"
                                    target="_blank">Print this Issue</a></td>
                        </tr>
                    </table>
                    <table width="100%" border="0" bgcolor="E8EEF7" cellpadding="0">
                        <tbody id="mainBody">
                            <tr height="21">
                                <td width="12%"><B>Customer </B></td>
                                <td width="24%"><%= cus%></td>
                                <td width="11%"><B>Product </B></td>
                                <td width="22%"><%= pro%></td>
                                <td width="11%"><B>FoundVersion </B></td>
                                <td width="20%"><%= ver%></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><B>Type </B></td>
                                <td width="24%"><%= typ%></td>
                                <td width="11%"><B>Module </B></td>
                                <td width="22%"><%= mod%></td>
                                <td width="11%"><B>Platform</B></td>
                                <td width="20%"><%= pla%></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><B>Severity </B></td>
                                <td width="24%">
                                    <%
                                        String severity[] = {"S1- Fatal", "S2- Critical", "S1- Fatal", "S3- Important", "S4- Minor"};
                                        if ((role == 1) || pmanager == uid) {
                                    %> <select name="severity">
                                        <%
                                            for (int s = 0; s < severity.length; s++) {
                                                if (severity[s].equalsIgnoreCase(sev)) {

                                        %>
                                        <option value="<%=severity[s]%>" selected><%=severity[s]%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=severity[s]%>"><%=severity[s]%></option>
                                        <%
                                                }

                                            }
                                        %>
                                    </select> <%
                                    } else {

                                        for (int s = 0; s < severity.length; s++) {
                                            if (severity[s].equalsIgnoreCase(sev)) {
                                    %> <input type=text size="11" name="severity" value="<%=severity[s]%>" readonly="true" />

                                    <%
                                                }

                                            }

                                        }
                                    %>
                                </td>
                                <td width="11%"><B>Priority</B></td>
                                <td width="24%">
                                    <!--   If User is Project Manager we should give Drop Down box to change Severity and Priority else just a Non Editable text box-->
                                    <%
                                        String priority[] = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};
                                        if ((role == 1) || pmanager == uid) {
                                    %> <select name="priority">
                                        <%
                                            for (int s = 0; s < priority.length; s++) {
                                                if (priority[s].equalsIgnoreCase(pri)) {

                                        %>
                                        <option value="<%=priority[s]%>" selected><%=priority[s]%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=priority[s]%>"><%=priority[s]%></option>
                                        <%
                                                }

                                            }
                                        %>
                                    </select> <%
                                    } else {

                                        for (int s = 0; s < priority.length; s++) {
                                            if (priority[s].equalsIgnoreCase(pri)) {
                                    %> <input type=text size="11" name="priority" value="<%=priority[s]%>" readonly="true" />

                                    <%
                                                }

                                            }

                                        }
                                    %>
                                </td>
                                <td width="11%"><B>IssueStatus</B>

                                    <%
                                        ArrayList<String> issueStatus = StatusSelector.getStatusList(sta);
                                        if (role == 1 || pmanager == uid) {
                                    %>
                                <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript: assignedusers();
                                        javascript:originalRowCount();
                                        javascript:newRow()">
                                                                    <option value="<%= sta%>" selected><%= sta%></option>
                                                                    <%

                                                                        for (String stat : issueStatus) {

                                                                    %>
                                                                    <option value="<%= stat%>"><%= stat%></option>
                                                                    <%

                                                                        }
                                                                    %>

                                                                </SELECT></td>
                                                                <%
                                                                } else if (sta.equalsIgnoreCase("Unconfirmed") && (!(pmanager == uid) || !(role == 1))) {

                                                              //          logger.info("Status for ordinory users"+sta);
                                                                %>
                                <td width="20%"><B></B> <%= sta%><input type="hidden" id="issuestatus"
                                                                            name="issuestatus" value="<%= sta%>" /></td>




                                <%
                                } else if (sta.equalsIgnoreCase("QA-Build Test Cases") && (!(pmanager == uid) || !(role == 1)) && (noOfTestCases < 1)) {

                              //          logger.info("Status for ordinory users"+sta);
                                %>
                                <td width="20%"><B></B> <%= sta%><input type="hidden" id="issuestatus"
                                                                            name="issuestatus" value="<%= sta%>" /></td>




                                <%
                                } else {
                                %>
                                <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript: assignedusers();
                                        javascript:originalRowCount();
                                        javascript:newRow()">
                                                                    <option value="<%= sta%>" selected><%= sta%></option>
                                                                    <%

                                                                        for (String stat : issueStatus) {
                                                                            if (!stat.equalsIgnoreCase("Closed")) {
                                                                    %>
                                                                    <option value="<%= stat%>"><%= stat%></option>
                                                                    <%
                                                                    } else {
                                                                        if (uid == creby) {
                                                                    %>
                                                                    <option value="<%= stat%>"><%= stat%></option>
                                                                    <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    %>
                                                                </SELECT></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><B>DateCreated </B></td>
                                <td width="24%"><%= dateString%></td>

                                <td width="11%"><B>DateModified </B></td>
                                <td width="22%"><%= dateString1%></td>

                                <td width="11%"><B>CreatedBy </B></td>
                                <td width="20%"><%= createdBy%></td>
                            </tr>
                            <tr>
                                <%
                                    String sql2 = "select assignedto from issue where issueid='" + issueId + "' ";
                                    pt4 = connection.prepareStatement(sql2);
                                    rs4 = pt4.executeQuery();
                                    int assi = 0;
                                    if (rs4 != null) {
                                        while (rs4.next()) {
                                            assi = rs4.getInt("assignedto");
                                        }
                                    }
                                    if (rs4 != null) {
                                        rs4.close();
                                    }
                                    if (pt4 != null) {
                                        pt4.close();
                                    }
                                %>
                                <td width="12%"><B>AssignedTo</B></td>

                                <td width="24%"><div id="solution"> <select name="assignedto" size="1">
                                            <%
                                                HashMap al;
                                                al = GetProjectMembers.getMembers(pro, fix, Integer.toString(creby), Integer.toString(assign));
                                                Collection set = al.keySet();
                                                Iterator ite = set.iterator();
                                                int assigned = 0;
                                                int useridassi = 0;

                                                LinkedHashMap lhp = GetProjectMembers.sortHashMapByValues(al, true);

                                                //       logger.info("Assigned to Users"+lhp);
                                                Collection se = lhp.keySet();
                                                Iterator iter = se.iterator();
                                                while (iter.hasNext()) {

                                                    String key = (String) iter.next();
                                                    String nameofuser = (String) lhp.get(key);
                                                    //      logger.info("Userid"+key);
                                                    //      logger.info("Name"+nameofuser);
                                                    useridassi = Integer.parseInt(key);
                                                    if (useridassi == assi) {
                                                        assigned = useridassi;
                                            %>
                                            <option value="<%=assigned%>" selected><%=nameofuser%></option>
                                            <%
                                            } else {
                                                assigned = useridassi;
                                            %>
                                            <option value="<%=assigned%>"><%=nameofuser%></option>
                                            <%
                                                    }

                                                }

                                            %>
                                        </select></div></td>
                                <td width="11%"><B>Files Attached </B></td>
                                        <%                    int count1 = 1;
                                            String sql3 = "select fileid,filename from fileattach where issueid='" + issueId + "' ";
                                            pt2 = connection.prepareStatement(sql3);
                                            rs3 = pt2.executeQuery();
                                            if (rs3 != null) {
                                                if (rs3.next()) {
                                                    count1++;
                                                    logger.debug("count1" + count1);
                                        %>
                                <td width="22%" id="filesIssue"><A
                                        onclick="viewFileAttachForIssue('<%=issueId%>');" href="#"
                                        >ViewFiles</A></td>
                                        <%                                  }
                                            }
                                            if (rs3 != null) {
                                                rs3.close();
                                            }
                                            if (pt2 != null) {
                                                pt2.close();
                                            }
                                            if (count1 == 1) {
                                        %>
                                <td width="22%" bgcolor="#E8EEF7" id="filesIssue"><font
                                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No
                                        Files</font></td>
                                        <%
                                            }
                                        %>

                                <td width="11%"><B>Fix Version</B></td>

                                <%
                                    stmt7 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    rs5 = stmt7.executeQuery("SELECT version FROM project WHERE pname='" + pro + "' order by version");//CHANGED
                                    String modifiedVer = com.pack.StringUtil.convertToFloatString(ver);
                                    String modifiedFix = com.pack.StringUtil.convertToFloatString(fix);

                                    float found = Float.valueOf(modifiedVer).floatValue();
                                    float fixVersion = Float.valueOf(modifiedFix).floatValue();
                                    rs5.last();
                                    int cnt = rs5.getRow();
                                    rs5.beforeFirst();
                                    if (cnt == 1) {
                                        //                   logger.info("Inside Fix Version"+ver);
                                %>

                                <td width="20%"><input type="text" name="fix_version"
                                                       value="<%=fix%>" size="4" readonly="true"></td>
                                    <%
                                    } else {
                                    %>
                                <td width="20%"><select name="fix_version" size="1" onchange="javascript:isModuleExist()">
                                        <%
                                            if (rs5 != null) {
                                                while (rs5.next()) {
                                                    String fix_ver = rs5.getString(1);
                                                    String modifiedFixVer = com.pack.StringUtil.convertToFloatString(fix_ver);
                                                    float fixver = Float.valueOf(modifiedFixVer).floatValue();
                                                    //                                  logger.info("Found Version"+found+"Fix Version"+fixver);
                                                    if (fixver >= found) {
                                                        if (fixver == fixVersion) {
                                        %>
                                        <option value="<%= fix%>" selected><%= fix%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=fix_ver%>"><%=fix_ver%></option>
                                        <%
                                                            }
                                                        }
                                                    }
                                                }
                                                if (rs5 != null) {
                                                    rs5.close();
                                                }
                                                if (stmt7 != null) {
                                                    stmt7.close();
                                                }
                                            }
                                        %>
                                </td>
                            </tr>
                            <tr height="21">
                                <td width="11%"><B>Due Date </B></td>
                                        <%
                                            if ((role == 1) || pmanager == uid) {
                                        %>
                                <td width="24%"><input type="text" id="date" name="date" maxlength="10" size="10"
                                                       value="<%= dueDate%>" readonly /><a
                                                       href="javascript:NewCal('date','ddmmyyyy')"> <img
                                            src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                                            width="16" height="16" alt="Pick a date"></a></td>
                                        <%
                                        } else {
                                        %>
                                <td width="24%"><%= dueDisplay%></td>
                                <td><input type="hidden" name="date" id="date" value="<%= dueDate%>" /></td>
                                    <%
                                        }
                                    %>
                            </tr>

                            <tr height="21">
                                <td width="12%"><b>Subject</b></td>
                                <td colspan="5" align="left"><B></B><%=sub%></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><b>Description</b></td>
                                <td colspan="5" align="left"><B></B><%=des1%></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><b>Root Cause</b></td>
                                <td colspan="5" align="left"><B></B><%=root_cau%></td>
                            </tr>
                            <tr height="21">
                                <td width="12%"><b>Expected Result</b></td>
                                <td colspan="5" align="left"><B></B><%=exp_res1%></td>
                            </tr>
                            <!--
                                     <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr border="0" bgcolor="#C3D9FF">
                                            <td align="left"><b> Issue Test Cases</b></td>
                            
                                    </tr>
                            
                                    </table>
                            -->
                            <%
                                try {

                            %>
                            <tr><td colspan="6">
                                    <table width="100%">
                                        <tbody>
                                            <%        if (noOfTestCases > 0) {
                                            %>
                                            <tr bgcolor="#C3D9FF" width="100%">
                                                <td width="8%"><b>TestCaseId</b></td>
                                                <td width="20%"><b>Functionality</b></td>
                                                <td width="22%"><b>Description</b></td>
                                                <td width="20%"><b>Expected Result</b></td>
                                                <td width="10%"><b>Createdby</b></td>
                                            </tr>
                                            <%
                                                }
                                                int k = 1;
                                                TqmIssuetestcases testcases;
                                                String ptcid = null, func = null, desc = null, reslt = null, project = null, created = null;
                                                for (Iterator itera = testcaseobjects.iterator(); itera.hasNext(); k++) {
                                                    testcases = (TqmIssuetestcases) itera.next();

                                                    ptcid = testcases.getTqmPtcm().getPtcid();
                                                    func = testcases.getTqmPtcm().getFunctionality();
                                                    desc = testcases.getTqmPtcm().getDescription();
                                                    reslt = testcases.getTqmPtcm().getExpectedresult();
                                                    project = GetProjects.getProjectName(((Integer) testcases.getTqmPtcm().getPid()).toString());
                                                    created = GetProjectManager.getUserName(testcases.getTqmPtcm().getCreatedby());

                                                    java.util.Date date = testcases.getTqmPtcm().getCreatedon();

                                                    project = project.replace(":", " v");
                                                    String funcTitle = func;
                                                    String descTitle = desc;
                                                    String rsltTitle = reslt;
                                                    if (func.length() > 30) {
                                                        func = func.substring(0, 30) + "...";
                                                    }
                                                    if (desc.length() > 30) {
                                                        desc = desc.substring(0, 30) + "...";
                                                    }
                                                    if (reslt.length() > 30) {
                                                        reslt = reslt.substring(0, 30) + "...";
                                                    }


                                            %>
                                            <%       if ((k % 2) != 0) {
                                            %>
                                            <tr bgcolor="white" height="22">
                                                <%
                                                } else {
                                                %>

                                            <tr bgcolor="#E8EEF7" height="22">
                                                <%
                                                    }
                                                %>
                                                <td><a href="<%=request.getContextPath()%>/admin/tqm/viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>

                                                <td title="<%=funcTitle%>"><%=func%></td>
                                                <td title="<%=descTitle%>"><%=desc%></td>
                                                <td title="<%=rsltTitle%>"><%=reslt%></td>
                                                <td><%=created%></td>
                                            </tr>



                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    logger.error(e.getMessage());
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <%
                                if (!sta.equalsIgnoreCase("QA-BTC")) {
                            %>
                            <tr height="21" id="commentsid">
                                <td width="12%" align="left">
                                    <b>Comments</b>
                                </td>

                                <td colspan="5" align="left"><font size="2"
                                                                   face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                            rows="3" cols="68" name="comments" maxlength="2000"
                                            onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"
                                            onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"></textarea></font>
                                    <input readonly type="text" name="remLen1"
                                           size="3" maxlength="4" value="2000">
                                </td>
                            </tr>

                            <%} else if (noOfTestCases < 1) {
                            %>
                        <div id="addMoreTestCases">
                            <tr id="addMoreTestCases"><td><input type="hidden" id="comments" name="comments" value="Adding Test Cases"></td></tr>
                            <table width="100%" border="0" id="testcases" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">

                                <tr id="header"><td><b>S No</b></td><td align="center"><b>Functionality</b></td><td align="center"><b>Description</b></td><td align="center"><b>Expected Result</b></td></tr>
                                <tr id="id1"><td id="cellid1">1</td><td align="center"><textarea name="functionality" id="functionality" rows="3" cols="25"></textarea></td>
                                    <td align="center"><textarea name="description" id="description" rows="3" cols="25"></textarea></td>
                                    <td align="left"><textarea name="expectedresult" id="expectedresult" rows="3" cols="25"></textarea></td></tr>
                                <tr><td colspan="4" align="right"><a id="add" href="javascript: void(0);" onclick="addRow('testcases')">Add New Test Case</a></td></tr>


                            </table>
                        </div>
                        <%
                        } else {
                        %>
                        <div id="testcaseavailable">
                            <table width="100%" border="1" id="testcasesavailable" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">

                                <tr><td colspan="8" align="right"><a id="add" href="javascript: void(0);" onclick="addMoreTestCases()">Add New Test Case</a></td></tr>

                                <tr>
                                    <td width="12%" align="left">
                                        <b>Comments</b>
                                    </td>

                                    <td colspan="5" align="left"><font size="2"
                                                                       face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                rows="3" cols="68" name="comments" maxlength="2000"
                                                onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"
                                                onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"></textarea></font>
                                        <input readonly type="text" name="remLen1"
                                               size="3" maxlength="4" value="2000">
                                    </td>
                                </tr>

                            </table>

                        </div>


                        <%
                            }
                        %>

                        <tr>
                            <td><input type="hidden" name="issueId" id="issueId" value="<%= issueId%>" /></td>
                            <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                            <td><input type="hidden" name="project" value="<%=pro%>" /></td>
                            <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                            <td><input type="hidden" name="oldfixversion" value="<%=fix%>" /></td>
                            <td><input type="hidden" name="module" value="<%=mod%>" /></td>
                            <td><input type="hidden" name="platform" value="<%=pla%>" /></td>
                            <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                            <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                            <td><input type="hidden" name="pri" value="<%=pri%>" /></td>
                            <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                            <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                            <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                            <td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td>
                            <td><input type="hidden" name="sub"
                                       value="<%=StringUtil.encodeHtmlTag(sub)%>" /></td>
                            <td><input type="hidden" name="des"
                                       value="<%=StringUtil.encodeHtmlTag(des1)%>" /></td>
                            <td><input type="hidden" name="com1"
                                       value="<%=StringUtil.encodeHtmlTag(com1)%>" /></td>
                            <td><input type=hidden name="rootcause"
                                       value="<%=StringUtil.encodeHtmlTag(root_cau)%>" /></td>
                            <td><input type=hidden name="expected_result"
                                       value="<%=StringUtil.encodeHtmlTag(exp_res1)%>" /></td>
                        </tr>
                        </tbody>
                    </table>
                    <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2"
                           align="center">
                        <tr align="center">
                            <TD>&nbsp;</TD>
                            <TD><INPUT type=submit value=Update ID=submit>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
                                    type=reset value="Reset" ID="reset"></TD>
                        </tr>
                    </table>
                    <iframe
                        src="<%=request.getContextPath()%>/comments.jsp?issueId=<%= issueId%>"
                        scrolling="auto" frameborder="2" height="20%" width="100%"></iframe></center>
            </div>
            <table>
                <tr><td><input type="hidden" name="dateChange" id="dateChange" value="<%=dueDate%>"/></td></tr>
            </table>
        </FORM>
        <%

                    }
                }
                if (resultset != null) {
                    resultset.close();
                }
                if (state != null) {
                    state.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            } finally {
                if (connection != null) {
                    connection.close();
                }
            }


        %>

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
    </BODY>
</HTML>
