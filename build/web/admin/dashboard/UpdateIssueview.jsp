<%@page import="com.eminent.issue.dao.IssueDAO"%>
<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="com.eminent.issue.controller.ApmComponentController"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.issue.Modules"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.Map"%>
<%@ page import="java.sql.*,com.eminent.tqm.IssueTestCaseUtil,com.eminent.tqm.TqmIssuetestcases,com.eminent.tqm.StatusFlow,java.text.*,java.util.List,java.util.HashMap,java.util.LinkedHashMap,com.pack.*,pack.eminent.encryption.*,org.apache.log4j.*,com.eminent.util.*,java.util.Collection, java.util.ArrayList, java.util.Iterator" buffer="1024kb" autoFlush="false"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">-->
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>

        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
            <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=180720161121"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/testCases.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/feedbackSelect.js"></script>
            <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
            <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">
                    <LINK title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css" type="text/css" rel="STYLESHEET"/>
                    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
                    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/prevnext.js?test=3543251"></script>
                    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
                    <SCRIPT type="text/javascript" language="JavaScript">
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
                function trim(str) {
                    while (str.charAt(str.length - 1) === " ")
                        str = str.substring(0, str.length - 1);
                    while (str.charAt(0) === " ")
                        str = str.substring(1, str.length);
                    return str;
                }
                function createRequest() {
                    var reqObj = null;
                    try {
                        reqObj = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (err) {
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
                        xmlhttp.open("GET", "moduleCheck.jsp?version=" + version + "&rand=" + Math.random(1, 10), true);
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
                function printpost(post)
                {
                    pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                    pp.focus();
                }

                function fun(theForm)
                {
                    var fromPage = document.getElementById("issuestatus").value;
                    var status = "Unconfirmed";
                    if (status === fromPage) {

                        pmunconfirm();
                    }


                    if (document.getElementById('dateChange').value !== document.getElementById('duedate').value) {

                        var str = document.theForm.duedate.value;
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
                    if (!(document.getElementById('timeestimation') === null)) {
                        if (document.getElementById('timeestimation').value === '') {
                            alert("Please enter the Estimated time for this Issue");
                            document.getElementById('timeestimation').value = '';
                            document.getElementById('timeestimation').focus();
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
//                            if (document.getElementById("issues").value === '') {
//                                alert('Please select at least one component');
//                                document.getElementById('issues').value = '';
//                                $('.ms-choice').focus();
//                                return false;
//                            }
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
                        if (document.getElementById('nock') === null) {
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
                        } else {
                            if (trim(document.getElementById('comments').value) === "") {
                                alert("Please Enter the Comments");
                                document.theForm.comments.focus();
                                return false;
                            }
                            if (document.getElementById('comments').value.length > 2000) {
                                alert(" Comments exceeds 2000 character");
                                document.theForm.comments.focus();
                                return false;
                            }
                        }
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
                    </SCRIPT>
                    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
                    </HEAD>
                    <BODY>
                        <%@ include file="/header.jsp"%>
                        <jsp:useBean id="mu" class="com.eminent.util.ModuleUtil"/>
                        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
                        <% String userin = request.getParameter("userin");
                            List<Modules> modules = new ArrayList<Modules>();
                        %>
                        <FORM name="theForm" onSubmit='return fun(this);'
                              action="<%= request.getContextPath()%>/admin/dashboard/modifyIssueForAdmin.jsp"
                              method="post">
                            <div align="center">
                                <center>
                                    <div class="addTargetCount " style="display: none;">
                                        <div>
                                        </div>
                                    </div>
                                    <div class="esclQues " style="display: none;">
                                        <div>
                                        </div>
                                    </div>
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
                                    <%String mail = (String) session.getAttribute("theName");
                                        String url = null;
                                        if (mail != null) {
                                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                        }
                                        String no = request.getParameter("issueNo");
                                        String message = request.getParameter("message");
                                        session.setAttribute("theissu", no);
                                        int count = 0;
                                        if (url.equals("eminentlabs.net")) {
                                            count = IssueDetails.eTrackerIssueSearchCount(null, no);
                                        }
                                    %> <br>
                                        <table width="100%" bgcolor="#C3D9FF">
                                            <tr align="left">
                                                <td><b>Issue Number <font color="#0000FF"><%= session.getAttribute("theissu")%></font></b>
                                                    <input type="hidden"  id="message" value="<%= message%>" /></td>
                                                <td align="right"><%if (url.equals("eminentlabs.net")) {%>
                                                    <span class="refer" style="color: blue;cursor: pointer;margin-right: 20px;">Reference<%if (count > 0) {%>
                                                        (<%=count%>)
                                                        <%}%></span>
                                                        <%}%>
                                                    <a
                                                        href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= session.getAttribute("theissu")%>"
                                                        target="_blank">Print this Issue</a></td>
                                            </tr>
                                        </table>
                                        <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" /> <%!    HashMap hm;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        %> <%List<IssueSearchFormBean> refIssues = new ArrayList<IssueSearchFormBean>();
                                            String sorton = request.getParameter("sorton");
                                            String sort_method = request.getParameter("sort_method");
                                            IssueDAO issueDAO = new IssueDAOImpl();
                                            String status = request.getParameter("status");
                                            String fix = "", pro = "", pri = "", sta = "", mainIssue = "";
                                            Connection connection = null;
                                            Statement state = null, stmt = null, stmt1 = null, stmt5 = null;
                                            ResultSet resultset = null, result = null, result1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
                                            PreparedStatement pt2 = null, pt1 = null, pt4 = null;
                                            int role = 0, uid = 0, pmanager = 0, dmanager = 0, amanager = 0;

                                            try {
                                                connection = MakeConnection.getConnection();
                                                String theissu = (String) session.getAttribute("theissu");
                                                mainIssue = issueDAO.getMainIssue(theissu);
                                                state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                resultset = state.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE,ESCALATION FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
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
                                                        pro = resultset.getString("project");
                                                        String ver = resultset.getString("found_version");
                                                        fix = resultset.getString("fix_version");
                                                        String pid = ProjectFinder.getProjectId(pro, fix);
                                                        modules = mu.findModulesByPid(new BigDecimal(pid));
                                                        String mod = resultset.getString("module");
                                                        session.setAttribute("projectName", pro);
                                                        session.setAttribute("versionValue", fix);
                                                        session.setAttribute("moduleName", mod);
                                                        String pla = resultset.getString("platform");
                                                        String sev = resultset.getString("severity");
                                                        pri = resultset.getString("priority");
                                                        String typ = resultset.getString("type");
                                                        session.setAttribute("typeName", typ);
                                                        int creby = resultset.getInt("createdby");
                                                        int assign = resultset.getInt("assignedto");
                                                        int roleid = ((Integer) session.getAttribute("Role")).intValue();
                                                        String currentuser = ((Integer) session.getAttribute("userid_curr")).toString();
                                                        HashMap<String, String> userDetail = GetProjectMembers.getMembers(pro, fix, ((Integer) creby).toString(), String.valueOf(assign));
                                                        if (userDetail.get(currentuser) != null || roleid == 1) {
                                                            Date creon = resultset.getDate("createdon");
                                                            Date mdion = resultset.getDate("modifiedon");
                                                            SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");

                                                            Date due = resultset.getDate("due_date");
                                                            String dueDate = "NA";
                                                            if (due != null) {
                                                                dueDate = dfm.format(due);
                                                            }
                                                            String estimated_time = resultset.getString("estimated_time");

                                                            String sapIssueType = resultset.getString("SAP_ISSUE_TYPE");

                                                            String sub = resultset.getString("subject");
                                                            String des = resultset.getString("description");
                                                            String com1 = resultset.getString("comment1");

                                                            String root_cau = resultset.getString("rootcause");
                                                            String exp_res = resultset.getString("expected_result");

                                                            pmanager = Integer.parseInt(GetProjectManager.getManager(pro, fix));
                                                            dmanager = resultset.getInt("dmanager");
                                                            amanager = resultset.getInt("amanager");
                                                            String escalation = resultset.getString("ESCALATION");

                                                            logger.info("Role" + role);
                                                            logger.info("uid" + uid);
                                                            logger.info("pmanager" + pmanager);
                                                            if (url.equals("eminentlabs.net")) {
                                                                refIssues = IssueDetails.eTrackerIssueSearch(sub, theissu);
                                                            }
                                                            if (hm == null) {
                                                                hm = UpdateIssue.showUsers(connection);
                                                            }
                                                            String createdBy = (String) hm.get(creby);
                                                            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");

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

                                                            String viewDueDate = df.format(due);

                                                            int len = des.length();
                                                            int index = 0;
                                                            String des1 = null, nextline = "\n", substr = null;
                                                            if (len >= 130) {
                                                                des1 = des.substring(index, index + 130);
                                                                len = len - 130;
                                                                while ((len / 130) >= 1) {
                                                                    des1 = des1.concat(nextline);
                                                                    index = index + 130;
                                                                    substr = des.substring(index, index + 130);
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
                                                            String sql1 = "select status from issuestatus where issueid='" + theissu + "' ";
                                                            pt1 = connection.prepareStatement(sql1, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                            rs2 = pt1.executeQuery();

                                                            if (rs2 != null) {
                                                                while (rs2.next()) {
                                                                    sta = rs2.getString("status");
                                                                }
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
                                                                String query = "select phase,subphase,subsubphase,subsubsubphase from " + issuephase + " where issueid ='" + theissu + "'";
                                                                result1 = stmt1.executeQuery(query);
                                                                while (result1.next()) {
                                                                    phase = result1.getString("phase");
                                                                    subphase = result1.getString("subphase");
                                                                    subsubphase = result1.getString("subsubphase");
                                                                    subsubsubphase = result1.getString("subsubsubphase");
                                                                }
                                        %> <jsp:forward page="/admin/dashboard/MyAssignmentPhase.jsp">
                                            <jsp:param name="issueid" value="<%=theissu%>" />
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
                                            <jsp:param name="dueDate" value="<%= dueDate%>" />
                                            <jsp:param name="viewDueDate" value="<%= viewDueDate%>" />
                                            <jsp:param name="projecttype" value="<%=projecttype%>" />
                                            <jsp:param name="phase" value="<%=phase%>" />
                                            <jsp:param name="subphase" value="<%=subphase%>" />
                                            <jsp:param name="subsubphase" value="<%=subsubphase%>" />
                                            <jsp:param name="subsubsubphase" value="<%=subsubsubphase%>" />
                                            <jsp:param name="subject" value="<%=sub%>" />
                                            <jsp:param name="description" value="<%=des1%>" />
                                            <jsp:param name="rootcause" value="<%=root_cau%>" />
                                            <jsp:param name="expected_result" value="<%=exp_res1%>" />
                                            <jsp:param name="timeestimation" value="<%=estimated_time%>" />
                                            <jsp:param name="sapIssueType" value="<%=sapIssueType%>" />
                                            <jsp:param name="pid" value="<%=pid%>" />
                                            <jsp:param name="flag" value="true" />
                                            <jsp:param name="escalation" value="<%=escalation%>" />
                                            <jsp:param name="mainIssue" value="<%=mainIssue%>" />

                                        </jsp:forward> <%
                                            }

                                            // Selecting Test Cases for this issue
                                            List testcaseobjects = IssueTestCaseUtil.viewIssueTestCase(theissu);
                                            int noOfTestCases = testcaseobjects.size();
                                            logger.info("No Of Test Cases" + noOfTestCases);


                                        %>

                                        <table width="100%" border="0" bgcolor="E8EEF7" cellpadding="0">
                                            <tbody id="mainBody">
                                                <tr height="21" align="left">
                                                    <td width="12%"><B>Customer</B></td>
                                                    <td width="24%"><%= cus%></td>
                                                    <td width="11%"><B>Product </B></td>
                                                    <td width="22%"><%= pro%><%=" v"%><%= ver%></td>

                                                    <td width="11%"><B>Fix Version</B></td>

                                                    <%
                                                        stmt5 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                        rs5 = stmt5.executeQuery("SELECT version FROM project WHERE pname='" + pro + "' order by version");
                                                        String modifiedVer = com.pack.StringUtil.convertToFloatString(ver);
                                                        String modifiedFix = com.pack.StringUtil.convertToFloatString(fix);

                                                        float found = Float.valueOf(modifiedVer).floatValue();
                                                        float fixVersion = Float.valueOf(modifiedFix).floatValue();
                                                        rs5.last();
                                                        int cnt = rs5.getRow();
                                                        rs5.beforeFirst();
                                                        if (cnt == 1) {
                                                            logger.info("Inside Fix Version" + ver);
                                                    %>

                                                    <td width="20%"><input type="text" name="fix_version"
                                                                           value="<%=fix%>" size="4" readonly="true"></td>
                                                        <%
                                                        } else {
                                                        %>
                                                    <td width="20%"><select name="fix_version" size="1" onchange="javascript:isModuleExist();">
                                                            <%
                                                                if (rs5 != null) {
                                                                    while (rs5.next()) {
                                                                        String fix_ver = rs5.getString(1);
                                                                        String modifiedFixVer = com.pack.StringUtil.convertToFloatString(fix_ver);
                                                                        float fixver = Float.valueOf(modifiedFixVer).floatValue();
                                                                        logger.info("Found Version" + found + "Fix Version" + fixver);
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

                                                                }
                                                            %>
                                                    </td>
                                                </tr>
                                                <tr height="21" align="left">
                                                    <td width="12%"><B>Type </B></td>
                                                    <td width="24%"><%if (pmanager == uid || dmanager == uid) {
                                                            String[] types = {"New Task", "Enhancement", "Bug"};
                                                        %>
                                                        <select name="newType">
                                                            <%
                                                                for (int m = 0; m < types.length; m++) {
                                                            %>
                                                            <option value="<%= types[m]%>" <% if (typ.equals(types[m])) {%> selected <%}%> ><%= types[m]%></option>                                                      
                                                            <% }%>
                                                        </select> 
                                                        <%} else {%>
                                                        <%=typ%>
                                                        <%}%>      </td>
                                                    <td width="11%"><B>Module </B></td>
                                                    <td width="22%"><%if (pmanager == uid || dmanager == uid) {%>
                                                        <select name="newModule" id="newModule" >
                                                            <%for (Modules modu : modules) {
                                                                    if (modu.getModule().equalsIgnoreCase(mod)) {
                                                            %>
                                                            <option value="<%=modu.getModuleid()%>" selected><%=modu.getModule()%></option>
                                                            <%} else {%>
                                                            <option value="<%=modu.getModuleid()%>" ><%=modu.getModule()%></option>
                                                            <%}
                                                                }%>
                                                        </select>

                                                        <%} else {%>
                                                        <%=mod%>
                                                        <%}%></td>
                                                    <td width="11%"><B>Platform</B></td>
                                                    <td width="20%"><%= pla%></td>
                                                </tr>
                                                <tr height="21" align="left">
                                                    <td width="12%"><B>Severity </B></td>
                                                    <td width="24%">
                                                        <%
                                                            if ((role == 1) || pmanager == uid) {
                                                        %> <select name="severity">
                                                            <%
                                                                if (sev.equalsIgnoreCase("S1- Fatal")) {
                                                            %>
                                                            <option value="S1- Fatal" selected="selected">S1- Fatal</option>
                                                            <option value="S2- Critical">S2- Critical</option>
                                                            <option value="S3- Important">S3- Important</option>
                                                            <option value="S4- Minor">S4- Minor</option>
                                                            <%                        } else if (sev.equalsIgnoreCase("S2- Critical")) {
                                                            %>
                                                            <option value="S1- Fatal">S1- Fatal</option>
                                                            <option value="S2- Critical" selected="selected">S2-
                                                                Critical</option>
                                                            <option value="S3- Important">S3- Important</option>
                                                            <option value="S4- Minor">S4- Minor</option>
                                                            <%                        } else if (sev.equalsIgnoreCase("S3- Important")) {
                                                            %>
                                                            <option value="S1- Fatal">S1- Fatal</option>
                                                            <option value="S2- Critical">S2- Critical</option>
                                                            <option value="S3- Important" selected="selected">S3-
                                                                Important</option>
                                                            <option value="S4- Minor">S4- Minor</option>
                                                            <%                        } else {
                                                            %>
                                                            <option value="S1- Fatal">S1- Fatal</option>
                                                            <option value="S2- Critical">S2- Critical</option>
                                                            <option value="S3- Important">S3- Important</option>
                                                            <option value="S4- Minor" selected="selected">S4- Minor</option>
                                                            <%                            }
                                                            %>
                                                        </select> <script type="text/javascript">
                                                            function pmunconfirm() {
                                                                var fromPage = document.getElementById("issuestatus").value;
                                                                var status = "Unconfirmed";
                                                                var flag = true;
                                                                if (status === fromPage)
                                                                {
                                                                    alert('Change the status before update');
                                                                    theForm.issuestatus.focus();
                                                                    flag = false;
                                                                }
                                                                return flag;
                                                            }</script><%
                                                            } else {

                                                                if (sev.equalsIgnoreCase("S1- Fatal")) {
                                                            %> <input type=text size="11" name="severity" value="S1- Fatal" readonly="true" />

                                                        <%                } else if (sev.equalsIgnoreCase("S2- Critical")) {
                                                        %> <input type=text size="11" name="severity" value="S2- Critical" readonly="true" />
                                                        <%                } else if (sev.equalsIgnoreCase("S3- Important")) {
                                                        %> <input type=text size="11" name="severity" value="S3- Important"
                                                               readonly="true" /> <%                        } else {
                                                        %> <input type=text size="11" name="severity" value="S4- Minor" readonly="true" />
                                                        <%                        }%>
                                                        <script type="text/javascript">
                                                            function pmunconfirm() {
                                                                return false;
                                                            }</script>

                                                        <% }
                                                        %>
                                                    </td>
                                                    <td width="11%"><B>Priority</B></td>
                                                    <td width="22%">
                                                        <%
                                                            if ((role == 1) || pmanager == uid) {
                                                        %> <select name="priority">
                                                            <%
                                                                if (pri.equalsIgnoreCase("P1-Now")) {
                                                            %>
                                                            <option value="P1-Now" selected="selected">P1-Now</option>
                                                            <option value="P2-High">P2-High</option>
                                                            <option value="P3-Medium">P3-Medium</option>
                                                            <option value="P4-Low">P4-Low</option>

                                                            <%                        } else if (pri.equalsIgnoreCase("P2-High")) {
                                                            %>
                                                            <option value="P1-Now">P1-Now</option>
                                                            <option value="P2-High" selected="selected">P2-High</option>
                                                            <option value="P3-Medium">P3-Medium</option>
                                                            <option value="P4-Low">P4-Low</option>
                                                            <%                        } else if (pri.equalsIgnoreCase("P3-Medium")) {
                                                            %>
                                                            <option value="P1-Now">P1-Now</option>
                                                            <option value="P2-High">P2-High</option>
                                                            <option value="P3-Medium" selected="selected">P3-Medium</option>
                                                            <option value="P4-Low">P4-Low</option>
                                                            <%                        } else {
                                                            %>
                                                            <option value="P1-Now">P1-Now</option>
                                                            <option value="P2-High">P2-High</option>
                                                            <option value="P3-Medium">P3-Medium</option>
                                                            <option value="P4-Low" selected="selected">P4-Low</option>
                                                            <%                            }
                                                            %>
                                                        </select> <%
                                                        } else {
                                                            if (pri.equalsIgnoreCase("P1-Now")) {
                                                        %> <input type=text size="10" name="priority" value="P1-Now" readonly="true" /> <%} else if (pri.equalsIgnoreCase("P2-High")) {
                                                        %> <input type=text size="10" name="priority" value="P2-High" readonly="true" /> <%} else if (pri.equalsIgnoreCase("P3-Medium")) {
                                                        %> <input type=text size="10" name="priority" value="P3-Medium" readonly="true" />
                                                        <%                } else {
                                                        %> <input type=text size="10" name="priority" value="P4-Low" readonly="true" /> <%        }

                                                            }
                                                        %>
                                                    </td>
                                                    <td width="11%"><B>IssueStatus</B>
                                                            <%
                                                                ArrayList<String> issueStatus = StatusSelector.getStatusList(sta);
                                                                if (role == 1 || pmanager == uid && !(sta.equalsIgnoreCase("QA-BTC")) && !(sta.equalsIgnoreCase("QA-TCE"))) {
                                                            %>
                                                        <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" onChange="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
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
                                                                                        } else if (sta.equalsIgnoreCase("Unconfirmed") && (!(pmanager == uid || dmanager == uid) || !(role == 1))) {

                                                                                            //          logger.info("Status for ordinory users"+sta);
                                                                                        %>
                                                        <td width="20%"><B></B> <%= sta%><input type="hidden" id="issuestatus"
                                                                                                    name="issuestatus" value="<%= sta%>" /></td>




                                                        <%
                                                        } else if (sta.equalsIgnoreCase("QA-BTC") && ((noOfTestCases < 1))) {

                                                            //          logger.info("Status for ordinory users"+sta);
                                                        %>
                                                        <td width="20%"><B></B> <%= sta%><input type="hidden" id="issuestatus"
                                                                                                    name="issuestatus" value="<%= sta%>" /></td>




                                                        <%
                                                        } else if (sta.equalsIgnoreCase("QA-TCE")) {
                                                            boolean flag = StatusFlow.getFlow(theissu);
                                                            logger.info("Status flag" + flag);
                                                            if (!flag) {
                                                                issueStatus.remove("Verified");
                                                                issueStatus.remove("Performance Testing");
                                                            }
                                                        %>
                                                        <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" onChange="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
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
                                                                                        } else {
                                                                                        %>
                                                        <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" onChange="javascript:assignedusers();
                                                                javascript:originalRowCount();
                                                                javascript:newRow();">
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


                                                <tr height="21" align="left">
                                                    <td width="12%"><B>DateCreated </B></td>
                                                    <td width="24%"><%= dateString%></td>

                                                    <td width="11%"><B>DateModified </B></td>
                                                    <td width="22%"><%= dateString1%></td>

                                                    <td width="11%"><B>CreatedBy </B></td>
                                                    <td width="20%"><%= createdBy%></td>
                                                </tr>
                                                <tr align="left">
                                                    <%
                                                        String sql2 = "select assignedto from issue where issueid='" + theissu + "' ";
                                                        pt4 = connection.prepareStatement(sql2);
                                                        rs4 = pt4.executeQuery();
                                                        int assi = 0;
                                                        if (rs4 != null) {
                                                            while (rs4.next()) {
                                                                assi = rs4.getInt("assignedto");
                                                            }
                                                        }

                                                    %>
                                                    <td width="12%"><B>AssignedTo</B></td>

                                                    <td width="24%"><select name="assignedto" id="assignedto" size="1">
                                                            <%                                                                HashMap assignedUsers;
                                                                assignedUsers = GetProjectMembers.getMembers(pro, fix, Integer.toString(creby), Integer.toString(assign));
                                                                LinkedHashMap al = GetProjectMembers.sortHashMapByValues(assignedUsers, true);
                                                                Collection set = al.keySet();
                                                                Iterator iter = set.iterator();
                                                                int assigned = 0;
                                                                int useridassi = 0;

                                                                while (iter.hasNext()) {

                                                                    String key = (String) iter.next();
                                                                    String nameofuser = (String) al.get(key);
                                                                    logger.info("Userid" + key);
                                                                    logger.info("Name" + nameofuser);
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
                                                        </select></td>
                                                    <td width="11%"><B>Files Attached </B><img  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showFileAttach()"></img></td>
                                                            <%                                        int count1 = 1;
                                                                String sql3 = "select count(*) from fileattach where issueid='" + theissu + "' ";
                                                                pt2 = connection.prepareStatement(sql3);
                                                                rs3 = pt2.executeQuery();
                                                                if (rs3 != null) {
                                                                    if (rs3.next()) {
                                                                        count1 = rs3.getInt(1);
                                                                        logger.debug("count1" + count1);
                                                                    }
                                                                }

                                                                if (count1 > 0) {

                                                            %>
                                                    <td id="filesIssue"> <A	onclick="viewFileAttachForIssue('<%=theissu%>');" href="#">ViewFiles(<%=count1%>)</A></td>

                                                    <%
                                                    } else {
                                                    %>
                                                    <td id="filesIssue"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                                            <%                            }
                                                            %>



                                                    <td width="11%"><B>Due Date </B></td>
                                                            <%
                                                                if ((role == 1) || pmanager == uid || dmanager == uid) {
                                                            %>
                                                    <td width="24%"><input type="text" id="duedate" name="duedate" maxlength="10" size="10"
                                                                           value="<%= dueDate%>" readonly /></td>
                                                        <%
                                                        } else {
                                                        %>
                                                    <td width="24%"><%= dueDisplay%></td>
                                                    <td><input type="hidden" id="duedate" name="duedate" value="<%= dueDate%>" /></td>
                                                    <%
                                                        }
                                                    %>
                                                </tr>
                                                <%
                                                    if (url.equals("eminentlabs.net")) {
                                                        logger.info("Estimated Time" + estimated_time);
                                                        if ((pmanager == uid || dmanager == uid) && (sta.equalsIgnoreCase("Unconfirmed"))) {
                                                %>
                                                <tr  align="left">
                                                    <td width="13%"><b>
                                                            Time Estimation
                                                        </b></td>
                                                    <td colspan="5">
                                                        <input type="number" id="timeestimation" name="timeestimation" min="0" /> in Hrs
                                                    </td>
                                                </tr>
                                                <% } else if (!(estimated_time == null)) {
                                                %>
                                                <tr  align="left">
                                                    <td width="13%"><b>
                                                            Time Estimation
                                                        </b></td>
                                                    <td colspan="5">
                                                        <%=estimated_time%> Hrs
                                                        <input type="hidden" id="timeestimation" name="timeestimation" value="<%=estimated_time%>" />
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %><%//edited by sowjnaya
                                                    if (pmanager == uid || dmanager == uid) {%>
                                                <tr>     
                                                    <td width="12%"><B>Components</B></td>
                                                    <td width="30%"><div id="issuecomponent"> 
                                                            <select multiple="multiple" name="issues" id="issues" size="1">
                                                                <%  HashMap c1;
                                                                    c1 = ApmComponentController.getComponents();
                                                                    List<BigDecimal> values = atc.findcomponentsByIssueId(no);
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
                                                    <%if (url.equals("eminentlabs.net")) {%>
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
                                                    </td>    <%}%>

                                                </tr>
                                                <%} else {

                                                %>   <tr height="21">
                                                    <td width="12%"><b>Components </b></td>
                                                    <%                                String cs = "", sc = "";
                                                        List<ApmComponentIssues> listc = atc.findByIssueId(no);
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
                                                                sql1 = "select amanager from ISSUE I, PROJECT P WHERE ISSUEID='" + no + "' AND I.PID = P.PID ";
                                                                pt1 = connection.prepareStatement(sql1);
                                                                rs2 = pt1.executeQuery();
                                                                if (rs2 != null) {
                                                                    if (rs2.next()) {
                                                                        amanager = rs2.getInt(1);
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
                                                        <!--                                                        <input type="checkbox" name="escalation"  disabled="disabled"/>-->
                                                    </td>

                                                </tr>  <%}//edited by sowjanya
                                                %>                        
                                                <tr height="21" align="left">
                                                    <td width="12%"><b>Subject</b></td>
                                                    <td colspan="5" align="left"><%if (dmanager == uid && sta.equalsIgnoreCase("Unconfirmed")) {%>
                                                        <input type="text" name="usub" id="usub" size="91" maxlength="100" value="<%=sub%>"/>
                                                        <%} else {%>
                                                        <%=sub%>
                                                        <%}%>

                                                        <%if (pmanager == uid || dmanager == uid) {%>
                                                        <span><img style="position: realtive;cursor:pointer; height:12px;margin-left:10px;" src="/eTracker/images/link.png" title='View Issues'  id="mainIssues"></span>
                                                        <input type="hidden" name="mainIssue" id="mainIssue" value="<%=mainIssue%>"/>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <tr height="21" align="left">
                                                    <td width="12%"><b>Description</b></td>
                                                    <%if (dmanager == uid && sta.equalsIgnoreCase("Unconfirmed")) {%>
                                                    <td colspan="5" align="left"><textarea
                                                            name="udes" id="udes" wrap="physical" cols="84" rows="4"
                                                            onKeyDown="textCounter(document.theForm.udes, document.theForm.remLenDesc, 4000);"
                                                            onKeyUp="textCounter(document.theForm.udes, document.theForm.remLenDesc, 4000);"><%=des%></textarea>
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
                                                    <td colspan="5" align="left"><%=des%></td>
                                                    <%}%>
                                                </tr>
                                                <tr height="21" align="left">
                                                    <td width="12%"><b>Root Cause</b></td>
                                                    <td colspan="5" align="left"><B></B><%=root_cau%></td>
                                                </tr>
                                                <tr height="21" align="left">
                                                    <td width="12%"><b>Expected Result</b></td>
                                                    <%if (dmanager == uid && sta.equalsIgnoreCase("Unconfirmed")) {%>
                                                    <td colspan="5" align="left"><textarea
                                                            name="uexpected_result" id="uexpected_result" wrap="physical" cols="84" rows="2"
                                                            onKeyDown="textCounter(document.theForm.uexpected_result, document.theForm.remLen2, 2000);"
                                                            onKeyUp="textCounter(document.theForm.uexpected_result, document.theForm.remLen2, 2000);"><%=exp_res1%></textarea>

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
                                                    <td colspan="5" align="left"><%=exp_res1%></td>
                                                    <%}%>
                                                </tr>

                                                <%
                                                    try {

                                                %>
                                                <tr><td colspan="6">
                                                        <table width="100%">
                                                            <tbody>
                                                                <%                                                    if (noOfTestCases > 0) {
                                                                        if (sta.equalsIgnoreCase("QA-TCE")) {
                                                                %>
                                                                <tr bgcolor="#C3D9FF" width="100%">
                                                                    <td width="20%"><b>Functionality</b></td>
                                                                    <td width="22%"><b>Description</b></td>
                                                                    <td width="20%"><b>Expected Result</b></td>
                                                                    <td width="10%"><b>Status</b></td>
                                                                </tr>
                                                                <%    } else {
                                                                %>

                                                                <tr bgcolor="#C3D9FF" width="100%">
                                                                    <td width="8%"><b>TestCaseId</b></td>
                                                                    <td width="20%"><b>Functionality</b></td>
                                                                    <td width="22%"><b>Description</b></td>
                                                                    <td width="20%"><b>Expected Result</b></td>
                                                                    <td width="10%"><b>Createdby</b></td>
                                                                </tr>
                                                                <%        }
                                                                    int k = 1;
                                                                    TqmIssuetestcases testcases = null;
                                                                    String ptcid = null, func = null, desc = null, reslt = null, project = null, created = null;
                                                                    String link = null, tcStatus = null;
                                                                    int statusid = 1;
                                                                    String[] testCaseStatus = {"Yet to Test", "Not Applicable", "Not Run", "Failed", "Passed"};
                                                                    if (sta.equalsIgnoreCase("QA-TCE")) {
                                                                        link = request.getContextPath() + "/MyAssignment/commentTestCase.jsp?ptcID=";
                                                                    } else {
                                                                        link = request.getContextPath() + "/admin/tqm/issuePTC.jsp?ptcID=";
                                                                    }
                                                                    for (Iterator itera = testcaseobjects.iterator(); itera.hasNext(); k++) {
                                                                        tcStatus = null;
                                                                        testcases = (TqmIssuetestcases) itera.next();

                                                                        ptcid = testcases.getTqmPtcm().getPtcid();
                                                                        func = testcases.getTqmPtcm().getFunctionality();
                                                                        desc = testcases.getTqmPtcm().getDescription();
                                                                        reslt = testcases.getTqmPtcm().getExpectedresult();
                                                                        project = GetProjects.getProjectName(((Integer) testcases.getTqmPtcm().getPid()).toString());
                                                                        created = GetProjectManager.getUserName(testcases.getTqmPtcm().getCreatedby());
                                                                        statusid = testcases.getTqmtestcasestatus().getStatusid();
                                                                        tcStatus = testcases.getTqmtestcasestatus().getStatus();
                                                                        logger.info("Test Case ID--->" + statusid + "Status--->" + tcStatus);

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
                                                                <%                                                    if ((k % 2) != 0) {
                                                                %>
                                                                <tr bgcolor="white" height="22" align="left">
                                                                    <%                } else {
                                                                    %>

                                                                    <tr bgcolor="#E8EEF7" height="22" align="left">
                                                                        <%                    }
                                                                            if (sta.equalsIgnoreCase("QA-TCE")) {
                                                                                //                   logger.info("In TCE Status");
                                                                        %>
                                                                        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><a href="<%=link%><%=ptcid%>&statusid=<%=statusid%>&issueid=<%= theissu%>"><%=StringUtil.encodeHtmlTag(func)%></a></td>
                                                                        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                                                                        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                                                                        <td>

                                                                            <%=tcStatus%>
                                                                            <input type="hidden" name="ptcid" id="ptcid" value="<%=ptcid%>"/>
                                                                        </td>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <td><a href="<%=link%><%=ptcid%>&statusid=<%=statusid%>&issueid=<%=theissu%>"><%=ptcid%></a></td>

                                                                        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
                                                                        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                                                                        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                                                                        <td><%=created%></td>
                                                                    </tr>



                                                                    <%
                                                                                    }
                                                                                }
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
                                                <tr height="21" id="commentsid" align="left">
                                                    <td width="12%" align="left">
                                                        <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>
                                                    </td>

                                                    <td colspan="5" align="left"><font size="2"
                                                                                       face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                                rows="3" cols="68" name="comments" maxlength="2000"
                                                                onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);"
                                                                onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);"></textarea></font>
                                                        <input readonly type="text" name="remLen1"
                                                               size="3" maxlength="4" value="2000">
                                                            <input type="hidden" name="testcaseindev" id="testcaseindev" value="notestcasesadded">
                                                                </td>
                                                                </tr>
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
                                                                <%} else if (noOfTestCases < 1) {
                                                                %>

                                                                <tr id="addMoreTestCases"><td><input type="hidden" id="comments" name="comments" value="Adding Test Cases"><input type="hidden" name="testcaseindev" id="testcaseindev" value="notestcasesadded"></td></tr>
                                                                                <table width="100%" border="0" id="testcases" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">

                                                                                    <tr id="header"><td><b>S No</b></td><td align="center"><b>Functionality</b></td><td align="center"><b>Description</b></td><td align="center"><b>Expected Result</b></td></tr>
                                                                                    <tr id="id1"><td id="cellid1">1</td><td align="center"><textarea name="functionality" id="functionality" rows="3" cols="25"></textarea></td>
                                                                                        <td align="center"><textarea name="description" id="description" rows="3" cols="25"></textarea></td>
                                                                                        <td align="left"><textarea name="expectedresult" id="expectedresult" rows="3" cols="25"></textarea></td></tr>
                                                                                    <tr><td colspan="4" align="right"><a id="add" href="javascript: void(0);" onclick="addRow('testcases');">Add New Test Case</a></td></tr>


                                                                                </table>

                                                                                <%         } else {
                                                                                %>

                                                                                <table width="100%" border="0" id="testcasesavailable" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">

                                                                                    <tr><td colspan="8" align="right"><a id="add" href="javascript: void(0);" onclick="javascript:addMoreTestCases();">Add New Test Case</a></td></tr>

                                                                                    <tr align="left">
                                                                                        <td width="12%" align="left">
                                                                                            <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>
                                                                                        </td>

                                                                                        <td colspan="5" align="left"><font size="2"
                                                                                                                           face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                                                                    rows="3" cols="68" name="comments" maxlength="2000"
                                                                                                    onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);"
                                                                                                    onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);"></textarea></font>
                                                                                            <input readonly type="text" name="remLen1"
                                                                                                   size="3" maxlength="4" value="2000">
                                                                                        </td>
                                                                                    </tr>
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
                                                                                </table>


                                                                                <input type="hidden" name="testcaseindev" id="testcaseindev" value="testcaseindev">

                                                                                    <%             }

                                                                                    %>
                                                                                    <tr>
                                                                                        <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                                                                                        <td><input type="hidden" name="project" id="project" value="<%=pro%>" /></td>
                                                                                        <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                                                                                        <td><input type="hidden" name="oldfixversion" id="fversion" value="<%=fix%>" /></td>
                                                                                        <td><input type="hidden" name="module" value="<%=mod%>" /></td>
                                                                                        <td><input type="hidden" name="platform" value="<%=pla%>" /></td>
                                                                                        <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                                                                                        <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                                                                                        <td><input type="hidden" name="pri" value="<%=pri%>" /></td>
                                                                                        <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                                                                                        <td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td>
                                                                                        <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                                                                                        <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                                                                                        <td><input type="hidden" name="sub" id="sub" value="<%=sub%>" /></td>
                                                                                        <td><input type="hidden" name="rootcause" value="<%=root_cau%>" /></td>
                                                                                        <td><input type=hidden name="des" value='<%=StringUtil.encodeHtmlTag(des)%>' /></td>
                                                                                        <td><input type=hidden name="expected_result" value='<%=StringUtil.encodeHtmlTag(exp_res)%>' /></td>
                                                                                        <td><input type=hidden name="sapIssueType" value='<%=sapIssueType%>' /></td>
                                                                                        <td><input type="hidden" name="issu" id="issu" value="<%=theissu%>" /></td>
                                                                                        <td><input type="hidden" name="status" id="status" value="<%=sta%>"/>
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
                                                                                                            <TD><INPUT type='submit' ID='submit' value='Update' name='submit'>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
                                                                                                                        type='reset' ID="reset" value="Reset"></TD>
                                                                                                                        </tr>
                                                                                                                        </table>
                                                                                                                        <iframe
                                                                                                                            src="<%= request.getContextPath()%>/comments.jsp?issueId=<%= session.getAttribute("theissu")%>"
                                                                                                                            scrolling="auto" frameborder="0" height="20%" width="100%"></iframe></center>
                                                                                                                        </div>
                                                                                                                        <table>
                                                                                                                            <tr><td><input type="hidden" name="dateChange" id="dateChange" value="<%=dueDate%>"/></td></tr>
                                                                                                                        </table>
                                                                                                                        </FORM>
                                                                                                                        <%
                                                                                                                        } else {%>
                                                                                                                        <jsp:forward page="/Issuesummaryview.jsp"><jsp:param name="issueid" value="<%= session.getAttribute("theissu")%>"></jsp:param></jsp:forward>    

                                                                                                                        <%}
                                                                                                                                    }
                                                                                                                                }

                                                                                                                            } catch (Exception e) {
                                                                                                                                logger.error(e.getMessage());
                                                                                                                            } finally {
                                                                                                                                if (resultset != null) {
                                                                                                                                    resultset.close();
                                                                                                                                }
                                                                                                                                if (rs3 != null) {
                                                                                                                                    rs3.close();
                                                                                                                                }
                                                                                                                                if (rs4 != null) {
                                                                                                                                    rs4.close();
                                                                                                                                }
                                                                                                                                if (rs5 != null) {
                                                                                                                                    rs5.close();
                                                                                                                                }
                                                                                                                                if (rs2 != null) {
                                                                                                                                    rs2.close();
                                                                                                                                }
                                                                                                                                if (pt4 != null) {
                                                                                                                                    pt4.close();
                                                                                                                                }
                                                                                                                                if (pt2 != null) {
                                                                                                                                    pt2.close();
                                                                                                                                }
                                                                                                                                if (pt1 != null) {
                                                                                                                                    pt1.close();
                                                                                                                                }

                                                                                                                                if (stmt5 != null) {
                                                                                                                                    stmt5.close();
                                                                                                                                }
                                                                                                                                if (stmt != null) {
                                                                                                                                    stmt.close();
                                                                                                                                }

                                                                                                                                if (stmt1 != null) {
                                                                                                                                    stmt1.close();
                                                                                                                                }
                                                                                                                                if (state != null) {
                                                                                                                                    state.close();
                                                                                                                                }

                                                                                                                                if (connection != null && !connection.isClosed()) {
                                                                                                                                    connection.close();
                                                                                                                                }
                                                                                                                            }

                                                                                                                        %>
                                                                                                                        <div class="refissuepopupa chartarea" style="display: none;">
                                                                                                                            <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 20% auto;"/>
                                                                                                                            <div>

                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                        <div id="overlay"></div>
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
                                                                                                                                <h3 class="popupHeadinga">Upload document for <%= session.getAttribute("theissu")%></h3>
                                                                                                                                <div style="color:red;display: none;" id="mdaterrormsg"></div>
                                                                                                                                <div style="margin-bottom: 10px;">
                                                                                                                                    <table >
                                                                                                                                        <tr>
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
                                                                                                                                                <input type="hidden" name="issueId" id='issueId' value="<%= session.getAttribute("theissu")%>"/>
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
                                                                                                                                <h3 class="popupHeadinga">Upload images for <%= session.getAttribute("theissu")%></h3>
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
                                                                                                                                                <input type="hidden" name="issueId" id='issueIda' value="<%= session.getAttribute("theissu")%>"/>
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

                                                                                                                        </BODY>
                                                                                                                        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                                                                                                                        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
                                                                                                                        <script src="<%= request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

                                                                                                                        <script type="text/javascript">
                                                                                                                                    $('#issues').multipleSelect({
                                                                                                                                        filter: true,
                                                                                                                                        maxHeight: 150,
                                                                                                                                        width: 200
                                                                                                                                    });</script>




                                                                                                                        <%String test = "true";
                                                                                                                            if (refIssues.isEmpty()) {
                                                                                                                                test = "false";
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
                                                                                                                            //Edit by sowjanya
                                                                                                                            $('#prev').click(function() {

                                                                                                                                var userin = "<%=userin%>";


                                                                                                                                var prev = "";
                                                                                                                                var clickb = "prev";



                                                                                                                                prev = callfunc(clickb);


                                                                                                                                var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + prev + "&project=" + "<%=pro%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + "<%=fix%>" + "&status=" + "<%=sta%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                                                window.location = text;


                                                                                                                            });


                                                                                                                            $('#next').click(function() {


                                                                                                                                var next = "";
                                                                                                                                var clickb = "next";

                                                                                                                                var userin = "<%=userin%>";





                                                                                                                                next = callfunc(clickb);



                                                                                                                                var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + next + "&project=" + "<%=pro%>" + "&priority=" + "<%=pri%>" + "&userin=" + userin + "&version=" + "<%=fix%>" + "&status=" + "<%=sta%>" + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>";
                                                                                                                                window.location = text;
                                                                                                                            });
                                                                                                                            $(document).ready(function() {



                                                                                                                                var userin = "<%=userin%>";


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
                                                                                                                                var pname = "<%=pro%>";
                                                                                                                                var ver = "<%=fix%>";
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
                                                                                                                            $("#escshow").click(function() {
                                                                                                                                var issueId = $.trim($("#issu").val());
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
