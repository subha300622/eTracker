<%@page import="com.eminent.issue.dao.IssueDAOImpl"%>
<%@page import="com.eminent.issue.dao.IssueDAO"%>
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="com.eminent.issue.controller.ApmComponentController"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminent.issue.Modules"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@page import="java.util.Map"%>
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="org.apache.log4j.*,com.eminent.tqm.*"%>
<%@ page import="java.util.HashMap,java.util.List,java.util.LinkedHashMap"%>
<%@ page
    import="java.lang.String,com.eminent.util.*,java.util.Collection, java.util.ArrayList, java.util.Iterator" buffer="1024kb" autoFlush="false"%>
    <%
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma", "no-cache");

        //Configuring log4j properties
        Logger logger = Logger.getLogger("MyIssueView");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }

    %>
    <%@ include file="../header.jsp"%>
    <HTML>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
            <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
                Solution</TITLE>
            <META NAME="Generator" CONTENT="EditPlus">
                <META NAME="Author" CONTENT="">
                    <META NAME="Keywords" CONTENT="">
                        <META NAME="Description" CONTENT="">
                            <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
                                <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=180720161121"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/feedbackSelect.js"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/testCases.js"></script>
                                <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>

                                <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
                                <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>
                                <script type="text/javascript">    CKEDITOR.timestamp = '123';</script>
                                <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                                    <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">
                                        <LINK title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css" type="text/css" rel="STYLESHEET"/>
                                        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                                        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
                                        <script src="<%=request.getContextPath()%>/javaScript/prevnext.js?test=123454" type="text/javascript"></script>
                                        <script type="text/javascript">
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

                                    function textCounter(field, cntfield, maxlimit)
                                    {
                                        if (field.value.length > maxlimit)
                                        {
                                            field.value = field.value.substring(0, maxlimit);
                                            alert('Comments size is exceeding 2000 characters');
                                        } else
                                            cntfield.value = maxlimit - field.value.length;
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

                                    function assignedusers() {
                                        xmlhttp = createRequest();

                                        if (xmlhttp !== null) {
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
                                        if (xmlhttp.readyState === 4)
                                        {
                                            if (xmlhttp.status === 200)
                                            {
                                                var results = "";
                                                var result = xmlhttp.responseText.split(";");
                                                var results = result[1].split(",");
                                                objLinkList = eval("document.getElementById('assignedto')");
                                                var presentUser = document.getElementById('assignedto').value;
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

                                    /*
                                     * To change this template, choose Tools | Templates
                                     * and open the template in the editor.
                                     */

                                    function call(theForm)
                                    {

                                        if (document.getElementById('dateChange').value !== document.getElementById('date').value) {

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
                                                window.alert("Enter the valid Due Date 1");
                                                theForm.date.focus();
                                                return false;
                                            }
                                            if (form_date.getYear() === current_date.getYear())
                                            {
                                                if (form_date.getMonth() < current_date.getMonth())
                                                {
                                                    window.alert("Enter the valid Due Date 2");
                                                    theForm.date.focus();
                                                    return false;
                                                }
                                                if (form_date.getMonth() === current_date.getMonth())
                                                {
                                                    if (form_date.getDate() < current_date.getDate())
                                                    {
                                                        window.alert("Enter the valid Due Date 3");
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

                                        }

                                        var escalation = document.getElementById("escalation").value;
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
                                                    //        document.theForm.description.value == "";
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

                                        monitorSubmit();
                                    }

                                    //window.onload = pageloadingtime;
                                        </script>
                                        </HEAD>
                                        <BODY>
                                            <jsp:useBean id="mu" class="com.eminent.util.ModuleUtil"/>
                                            <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
                                            <%
                                                String sorton = request.getParameter("sorton");
                                                String sort_method = request.getParameter("sort_method");
                                                String userin = request.getParameter("userin");
                                                List<Modules> modules = new ArrayList<Modules>();
                                            %>
                                            <FORM name="theForm" METHOD=POST ACTION="<%=request.getContextPath()%>/MyIssues/updateMyIssue.jsp" onsubmit="return call(this);">
                                                <%@ page import="java.sql.*"%>
                                                <%@ page import="java.text.*"%>
                                                <%@ page import="java.sql.Date"%>
                                                <%@ page import="com.pack.*"%>
                                                <%@ page import="pack.eminent.encryption.*"%>
                                                <%@ page language="java"%>
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
                                                                <td align="left"><font size="4" COLOR="#0000FF"><b>
                                                                            My Issues </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td> <%if (userin != null) {
                                                                                    if ((userin.equalsIgnoreCase("MyAssignment")) || (userin.equalsIgnoreCase("MyIssues")) || (userin.equalsIgnoreCase("statusWise")) || (userin.equalsIgnoreCase("MyDashboard")) || (userin.equalsIgnoreCase("MySearches")) || (userin.equalsIgnoreCase("MyViews"))) {%><td class="previous" align="right"><img id="prev"  class="prevBtn" src="<%=request.getContextPath()%>/images/prev.png"  style="cursor: pointer;" ></img>Prev Next<img id="next" class="nextBtn" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></img></td><%}
                                                                                        }%><%--<input type="image" id="prev" src="<%=request.getContextPath()%>/images/prev.png"   style="cursor: pointer;" ></input>Prev Next<input type="image" id="next" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></input></td>--%>
                                                                <td align="right"><div id="loadingtime"></div></td>
                                                            </tr>
                                                        </table>

                                                        <br>


                                                            <%
                                                                String mail = (String) session.getAttribute("theName");
                                                                String url = null;
                                                                HashMap<Integer, String> member = GetProjectMembers.showUsers();
                                                                if (mail != null) {
                                                                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                                                }
                                                                //session.removeAttribute("theissu");
                                                                String issueId = request.getParameter("issueid");
                                                                String message = request.getParameter("message");
                                                                logger.debug("issueidinmyissueview:" + issueId);
                                                                String operation = "Closed";
                                                            %>

                                                            <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean"></jsp:useBean> <%!
                                                                HashMap hm;
                                                                Connection connection = null;
                                                                Statement stmt = null, stmt1 = null;
                                                                PreparedStatement ps = null, pt2 = null, pt3 = null;
                                                                ResultSet resultset, result = null, result1 = null, rs3 = null, rs1 = null;
                                                                String firstname, lastname, pri, status, pro, fver;
                                                                int role = 0, uid = 0, pmanager = 0, dmanager = 0, amanager = 0;
                                                                String dueDate = null, mainIssue = "";
                                                                IssueDAO issueDAO = new IssueDAOImpl();
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                %> 
                                                            <%
                                                                try {
                                                                    mainIssue = issueDAO.getMainIssue(issueId);

                                                                    connection = MakeConnection.getConnection();

                                                                    if (hm == null) {
                                                                        hm = MyIssue.getUser(connection);
                                                                        logger.info("SIZE:" + hm.size());
                                                                    }

                                                                    if (connection != null) {

                                                                        ps = connection.prepareStatement("select i.issueid, customer, pname as project, due_date, found_version, version as fix_version, due_date, module, platform, severity, priority, type, createdby, createdon, modifiedon, subject, description, assignedto, comment1, rootcause, expected_result, s.status,ESCALATION from issue i, issuestatus s, project p, modules m where i.issueid = s.issueid and i.issueid = ? and i.pid = p.pid and module_id = moduleid ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                        ps.setString(1, issueId);
                                                                        resultset = ps.executeQuery();
                                                                        role = (Integer) session.getAttribute("Role");
                                                                        uid = (Integer) session.getAttribute("userid_curr");

                                                                        while (resultset.next()) {
                                                                            String cus = resultset.getString("customer");
                                                                            pro = resultset.getString("project");
                                                                            String ver = resultset.getString("found_version");
                                                                            fver = resultset.getString("fix_version");
                                                                            String pid = ProjectFinder.getProjectId(pro, fver);
                                                                            modules = mu.findModulesByPid(new BigDecimal(pid));
                                                                            String mod = resultset.getString("module");
                                                                            String pla = resultset.getString("platform");
                                                                            String sev = resultset.getString("severity");
                                                                            pri = resultset.getString("priority");
                                                                            String typ = resultset.getString("type");
                                                                            int creby = resultset.getInt("createdby");
                                                                            status = resultset.getString("status");

                                                                            pmanager = Integer.parseInt(GetProjectManager.getManager(pro, fver));
                                                                            dmanager = Integer.parseInt(GetProjectManager.getDManager(pro, fver));

                                                                            if (!operation.equals(status)) {

                                                                                if (uid == creby) {
                                                                                    //String createdBy = (String)hm.get(creby);

                                                                                    Date creon = resultset.getDate("createdon");
                                                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                                                    String dateString = sdf.format(creon);

                                                                                    SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yy");
                                                                                    String createdOn = df.format(creon);

                                                                                    session.setAttribute("createdOn", createdOn);
                                                                                    session.setAttribute("foundVersion", ver);
                                                                                    session.setAttribute("fixVersion", fver);

                                                                                    SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                                                                                    Date mdion = resultset.getDate("modifiedon");
                                                                                    String dateString1 = sdf.format(mdion);
                                                                                    Date due = resultset.getDate("due_date");
                                                                                    String viewDueDate = df.format(due);
                                                                                    dueDate = "NA";
                                                                                    if (due != null) {
                                                                                        dueDate = dfm.format(due);
                                                                                    }
                                                                                    String sub = resultset.getString("subject");
                                                                                    String subject = request.getParameter("subject");
                                                                                    int count = 0;
                                                                                    if (url.equals("eminentlabs.net")) {
                                                                                        count = IssueDetails.eTrackerIssueSearchCount(subject, issueId);
                                                                                    }
                                                                                    String des = resultset.getString("description");
                                                                                    String root_cau = resultset.getString("rootcause");
                                                                                    String exp_res = resultset.getString("expected_result");
                                                                                    int assi = resultset.getInt("assignedto");
                                                                                    String escalation = resultset.getString("ESCALATION");

                                                                                    //String assignedfor 		= resultset.getString("assignedto");
                                                                                    //int assi 				= Integer.parseInt(assignedfor);
                                                                                    //String assignedTo = (String)hm.get(assi);
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
                                                                                    logger.info("Description:" + des1);
                                                                                    len = exp_res.length();
                                                                                    index = 0;
                                                                                    String exp_res1 = null;
                                                                                    if (len >= 130) {
                                                                                        exp_res1 = exp_res.substring(index, index + 130);
                                                                                        len = len - 130;
                                                                                        while ((len / 130) >= 1) {
                                                                                            exp_res1 = exp_res1.concat(nextline);
                                                                                            index = index + 130;
                                                                                            substr = exp_res.substring(index, index + 130);
                                                                                            exp_res1 = exp_res1.concat(substr);
                                                                                            len = len - 130;
                                                                                        }
                                                                                        index = index + 130;
                                                                                        exp_res1 = exp_res1.concat(nextline);
                                                                                        exp_res1 = exp_res1.concat(exp_res.substring(index));
                                                                                    } else {
                                                                                        exp_res1 = exp_res.substring(index);
                                                                                    }
                                                                                    logger.info("Expected Result:" + exp_res);
                                                                                    logger.info("Expected Result:" + exp_res1);
                                                                                    stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                                    result = stmt.executeQuery("select type from project,project_type where project.pid=project_type.pid and pname='" + pro + "'and version='" + fver + "'");
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
                                                            %> 
                                                            <jsp:forward page="../MyIssues/MyIssuephase.jsp">
                                                                <jsp:param name="issueId" value="<%=issueId%>" />
                                                                <jsp:param name="product" value="<%=pro%>" />
                                                                <jsp:param name="customer" value="<%=cus%>" />
                                                                <jsp:param name="foundversion" value="<%=ver%>" />
                                                                <jsp:param name="fixversion" value="<%=fver%>" />
                                                                <jsp:param name="platform" value="<%=pla%>" />
                                                                <jsp:param name="module" value="<%=mod%>" />
                                                                <jsp:param name="priority" value="<%=pri%>" />
                                                                <jsp:param name="severity" value="<%=sev%>" />
                                                                <jsp:param name="issuestatus" value="<%=status%>" />
                                                                <jsp:param name="type" value="<%=typ%>" />
                                                                <jsp:param name="createdby" value="<%=creby%>" />
                                                                <jsp:param name="assignedto" value="<%=assi%>" />
                                                                <jsp:param name="createdon" value="<%=createdOn%>" />
                                                                <jsp:param name="modifiedon" value="<%=dateString1%>" />
                                                                <jsp:param name="dueDate" value="<%= dueDate%>" />
                                                                <jsp:param name="viewDueDate" value="<%= viewDueDate%>" />
                                                                <jsp:param name="projecttype" value="<%=projecttype%>" />
                                                                <jsp:param name="phase" value="<%=phase%>" />
                                                                <jsp:param name="subphase" value="<%=subphase%>" />
                                                                <jsp:param name="subsubphase" value="<%=subsubphase%>" />
                                                                <jsp:param name="subsubsubphase" value="<%=subsubsubphase%>" />
                                                                <jsp:param name="subject" value="<%=sub%>" />
                                                                <jsp:param name="description" value='<%=des1%>' />
                                                                <jsp:param name="rootcause" value='<%=root_cau%>' />
                                                                <jsp:param name="expected_result" value='<%=exp_res1%>' />
                                                                <jsp:param name="flag" value="true" />
                                                                <jsp:param name="pid" value="<%=pid%>" />
                                                                <jsp:param name="escalation" value="<%=escalation%>" />
                                                                <jsp:param name="mainIssue" value="<%=mainIssue%>" />

                                                            </jsp:forward> <%
                                                                }
                                                                // Selecting Test Cases for this issue
                                                                List testcaseobjects = IssueTestCaseUtil.viewIssueTestCase(issueId);
                                                                int noOfTestCases = testcaseobjects.size();
                                                                logger.info("No Of Test Cases" + noOfTestCases);


                                                            %>
                                                            <table align="center" width="100%" bgcolor="C3D9FF">
                                                                <tr align="left">
                                                                    <td><font size="4" COLOR="#0000FF"><b>Issue Number <font
                                                                                    color="#0000FF"><%= issueId%></font></b>
                                                                            <input type="hidden"  id="message" value="<%= message%>" />
                                                                    </td>
                                                                    <td align="right"><%if (url.equals("eminentlabs.net")) {%>
                                                                        <span class="refer" style="color: blue;cursor: pointer;margin-right: 20px;">Reference<%if (count > 0) {%>
                                                                            (<%=count%>)
                                                                            <%}%></span>
                                                                            <%}%>
                                                                        <a
                                                                            href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= issueId%>"
                                                                            target="_blank">Print this Issue</a></td>
                                                                </tr>
                                                            </table>
                                                            <table>
                                                                <tr>
                                                                    <td><input type="hidden" id="issueId" name="issueId" value="<%= issueId%>" /></td>
                                                                    <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                                                                    <td><input type="hidden" name="project" id="project" value="<%=pro%>" /></td>
                                                                    <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                                                                    <td><input type="hidden" name="fversion" id="fversion" value="<%=fver%>" /></td>
                                                                    <td><input type="hidden" name="module" value="<%=mod%>" /></td>
                                                                    <td><input type="hidden" name="platform" value="<%=pla%>" /></td>
                                                                    <td><input type="hidden" name="createdby" value="<%=creby%>" /></td>
                                                                    <td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td>
                                                                    <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                                                                    <td><input type="hidden" name="sub" id="sub"	value="<%=sub%>" /></td>
                                                                    <td><input type=hidden name="des" value='<%=StringUtil.encodeHtmlTag(des1)%>' /></td>
                                                                    <td><input type=hidden name="expected_result" value='<%=exp_res1%>' /></td>
                                                                    <td><input type=hidden name="rootcause" value='<%=root_cau%>' /></td>
                                                                    <td><input type="hidden" name="status" id="status" value="<%=status%>" /></td>
                                                                    <td> <input type="hidden" name='priority' id="priority" value="<%=pri%>" /></td>
                                                                    <td><input type="hidden" name="sorton" id="sorton" value="<%=sorton%>" /></td>
                                                                    <td><input type="hidden" name="sort_method" id="sort_method" value="<%=sort_method%>" /></td>
                                                                    <td><input type="hidden" name="userin" id="userin" value="<%=userin%>" /></td>

                                                                </tr>
                                                            </table>
                                                            <table id="mainTable" width="100%" bgcolor="E8EEF7">
                                                                <tbody id="mainBody">
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><B>Customer </B></td>
                                                                        <td width="22%"><B></B><%= cus%></td>
                                                                        <td width="11%"><B>Product </B></td>
                                                                        <td width="22%"><B></B><%= pro%></td>
                                                                        <td width="11%"><B>FoundVersion </B></td>
                                                                        <td width="22%"><B></B><%= ver%></td>
                                                                    </tr>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><B>Type </B></td>
                                                                        <td width="22%"><%if (pmanager == uid || dmanager == uid) {
                                                                                String[] types = {"New Task", "Enhancement", "Bug"};
                                                                            %>
                                                                            <select name="newType">
                                                                                <%
                                                                                    for (int i = 0; i < types.length; i++) {
                                                                                %>
                                                                                <option value="<%= types[i]%>" <% if (typ.equals(types[i])) {%> selected <%}%> ><%= types[i]%></option>                                                      
                                                                                <% }%>
                                                                            </select> 
                                                                            <%} else {%>
                                                                            <%=typ%>
                                                                            <%}%>      </td>
                                                                        <td width="11%"><B>Module </B></td>
                                                                        <td width="22%"><B></B><%if (pmanager == uid || dmanager == uid) {%>
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
                                                                        <td width="11%"><B>Platform </B></td>
                                                                        <td width="22%"><B></B><%= pla%></td>
                                                                    </tr>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><B>Severity </B></td>
                                                                        <td width="22%">
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

                                                                                <%
                                                                                } else if (sev.equalsIgnoreCase("S2- Critical")) {
                                                                                %>
                                                                                <option value="S1- Fatal">S1- Fatal</option>
                                                                                <option value="S2- Critical" selected="selected">S2-
                                                                                    Critical</option>
                                                                                <option value="S3- Important">S3- Important</option>
                                                                                <option value="S4- Minor">S4- Minor</option>
                                                                                <%
                                                                                } else if (sev.equalsIgnoreCase("S3- Important")) {
                                                                                %>
                                                                                <option value="S1- Fatal">S1- Fatal</option>
                                                                                <option value="S2- Critical">S2- Critical</option>
                                                                                <option value="S3- Important" selected="selected">S3-
                                                                                    Important</option>
                                                                                <option value="S4- Minor">S4- Minor</option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="S1- Fatal">S1- Fatal</option>
                                                                                <option value="S2- Critical">S2- Critical</option>
                                                                                <option value="S3- Important">S3- Important</option>
                                                                                <option value="S4- Minor" selected="selected">S4- Minor</option>
                                                                                <%
                                                                                    }
                                                                                %>
                                                                            </select> <%
                                                                            } else {

                                                                                if (sev.equalsIgnoreCase("S1- Fatal")) {
                                                                            %> <input type=text size="11" name="severity" value="S1- Fatal" readonly="true" />

                                                                            <%
                                                                            } else if (sev.equalsIgnoreCase("S2- Critical")) {
                                                                            %> <input type=text size="11" name="severity" value="S2- Critical"
                                                                                   readonly="true" /> <%
                                                                                   } else if (sev.equalsIgnoreCase("S3- Important")) {
                                                                            %> <input type=text size="11" name="severity" value="S3- Important"
                                                                                   readonly="true" /> <%
                                                                                   } else {
                                                                            %> <input type=text size="11" name="severity" value="S4- Minor" readonly="true" />
                                                                            <%
                                                                                    }

                                                                                }
                                                                            %>
                                                                        </td>
                                                                        <td width="11%"><b>Priority</b></td>
                                                                        <td width="22%"><B></B> <%
                                                                            if ((role == 1) || pmanager == uid) {
                                                                                %> <select name="priority">
                                                                                <%
                                                                                    if (pri.equalsIgnoreCase("P1-Now")) {
                                                                                %>
                                                                                <option value="P1-Now" selected="selected">P1-Now</option>
                                                                                <option value="P2-High">P2-High</option>
                                                                                <option value="P3-Medium">P3-Medium</option>
                                                                                <option value="P4-Low">P4-Low</option>

                                                                                <%
                                                                                } else if (pri.equalsIgnoreCase("P2-High")) {
                                                                                %>
                                                                                <option value="P1-Now">P1-Now</option>
                                                                                <option value="P2-High" selected="selected">P2-High</option>
                                                                                <option value="P3-Medium">P3-Medium</option>
                                                                                <option value="P4-Low">P4-Low</option>
                                                                                <%
                                                                                } else if (pri.equalsIgnoreCase("P3-Medium")) {
                                                                                %>
                                                                                <option value="P1-Now">P1-Now</option>
                                                                                <option value="P2-High">P2-High</option>
                                                                                <option value="P3-Medium" selected="selected">P3-Medium</option>
                                                                                <option value="P4-Low">P4-Low</option>
                                                                                <%
                                                                                } else {
                                                                                %>
                                                                                <option value="P1-Now">P1-Now</option>
                                                                                <option value="P2-High">P2-High</option>
                                                                                <option value="P3-Medium">P3-Medium</option>
                                                                                <option value="P4-Low" selected="selected">P4-Low</option>
                                                                                <%
                                                                                    }
                                                                                %>
                                                                            </select> <%
                                                                            } else {
                                                                                if (pri.equalsIgnoreCase("P1-Now")) {
                                                                            %> <input type=text size="10" name="priority" value="P1-Now" readonly="true" />

                                                                            <%
                                                                            } else if (pri.equalsIgnoreCase("P2-High")) {
                                                                            %> <input type=text size="10" name="priority" value="P2-High" readonly="true" />
                                                                            <%
                                                                            } else if (pri.equalsIgnoreCase("P3-Medium")) {
                                                                            %> <input type=text size="10" name="priority" value="P3-Medium" readonly="true" />
                                                                            <%
                                                                            } else {
                                                                            %> <input type=text size="10" name="priority" value="P4-Low" readonly="true" />
                                                                            <%
                                                                                    }

                                                                                }
                                                                            %>
                                                                        </td>
                                                                        <td width="11%"><B>IssueStatus</B></td>
                                                                                <%
                                                                                    ArrayList<String> issueStatus = StatusSelector.getStatusList(status);
                                                                                    if (role == 1 || pmanager == uid && !(status.equalsIgnoreCase("QA-BTC")) && !(status.equalsIgnoreCase("QA-TCE"))) {
                                                                                %>
                                                                        <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" onChange="javascript:assignedusers();
                                                                                javascript:originalRowCount();
                                                                                javascript:newRow();">
                                                                                                            <option value="<%= status%>" selected><%= status%></option>
                                                                                                            <%

                                                                                                                for (String stat : issueStatus) {

                                                                                                            %>
                                                                                                            <option value="<%= stat%>"><%= stat%></option>
                                                                                                            <%

                                                                                                                }
                                                                                                            %>

                                                                                                        </SELECT></td>
                                                                                                        <%
                                                                                                        } else if (status.equalsIgnoreCase("Unconfirmed") && (!(pmanager == uid) || !(role == 1))) {

                                                                                                            //          logger.info("Status for ordinory users"+sta);
%>
                                                                        <td width="20%"><B></B> <%= status%><input type="hidden" id="issuestatus"
                                                                                                                       name="issuestatus" value="<%= status%>" /></td>




                                                                        <%
                                                                        } else if (status.equalsIgnoreCase("QA-BTC") && ((noOfTestCases < 1))) {

                                                                            //          logger.info("Status for ordinory users"+sta);
%>
                                                                        <td width="20%"><B></B> <%= status%><input type="hidden" id="issuestatus"
                                                                                                                       name="issuestatus" value="<%= status%>" /></td>




                                                                        <%
                                                                        } else if (status.equalsIgnoreCase("QA-TCE")) {
                                                                            boolean flag = StatusFlow.getFlow(issueId);
                                                                            logger.info("Status flag" + flag);
                                                                            if (!flag) {
                                                                                issueStatus.remove("Verified");
                                                                                issueStatus.remove("Performance Testing");
                                                                            }
                                                                        %>
                                                                        <td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" onChange="javascript:assignedusers();
                                                                                javascript:originalRowCount();
                                                                                javascript:newRow();">
                                                                                                            <option value="<%= status%>" selected><%= status%></option>
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
                                                                                                            <option value="<%= status%>" selected><%= status%></option>
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
                                                                        <tr align="left">
                                                                            <td width="12%"><B>DateCreated </B></td>
                                                                            <td width="22%"><B></B><%= dateString%></td>
                                                                            <td width="11%"><B>DateModified </B></td>
                                                                            <td width="22%"><B></B><%= dateString1%></td>

                                                                            <td width="11%"><B>AssignedTo</B></td>

                                                                            <%

                                                                                //int assigned = 0;
                                                                                int useridassi = 0;

                                                                                HashMap hm;
                                                                                hm = GetProjectMembers.getMembers(pro, fver, Integer.toString(creby), Integer.toString(assi));
                                                                                LinkedHashMap al = GetProjectMembers.sortHashMapByValues(hm, true);
                                                                                Collection set = al.keySet();
                                                                                Iterator iter = set.iterator();
                                                                                int assigned = 0;

                                                                                if (status.equalsIgnoreCase("Unconfirmed")) {

                                                                                    while (iter.hasNext()) {

                                                                                        String key = (String) iter.next();
                                                                                        String nameofuser = (String) al.get(key);
                                                                                        logger.info("Userid" + key);
                                                                                        logger.info("Name" + nameofuser);
                                                                                        useridassi = Integer.parseInt(key);
                                                                                        if (useridassi == assi) {
                                                                            %>

                                                                            <div id="solution">
                                                                                <td width="19%">
                                                                                    <select name="assignedto" id="assignedto" size="1" maxlength="4">
                                                                                        <option value="<%=useridassi%>"><%=nameofuser%></option>
                                                                                    </select>
                                                                                </td>
                                                                            </div>

                                                                            <%
                                                                                    }

                                                                                }

                                                                            } else {
                                                                            %>
                                                                            <td width="22%"><B></B> <div id="solution"> 
                                                                                    <select id="assignedto" name="assignedto" size="1" >
                                                                                        <%
                                                                                            logger.info("Second Loop");

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
                                                                                            }

                                                                                        %>

                                                                                    </select></div></td>
                                                                        </tr>
                                                                        <tr width="100%" height="21" align="left">
                                                                            <td width="12%"><B>Files Attached </B><img  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showFileAttach()"></img></td>
                                                                                    <%                    int cnt = 1;
                                                                                        String sql4 = "select count(*) from fileattach where issueid='" + issueId + "' ";
                                                                                        pt3 = connection.prepareStatement(sql4);
                                                                                        rs1 = pt3.executeQuery();
                                                                                        if (rs1 != null) {
                                                                                            if (rs1.next()) {
                                                                                                cnt = rs1.getInt(1);
                                                                                                logger.debug("count1" + cnt);
                                                                                            }
                                                                                        }

                                                                                        if (cnt > 0) {


                                                                                    %>
                                                                            <td id="filesIssue"> <A	onclick="viewFileAttachForIssue('<%=issueId%>');" href="#">ViewFiles(<%=cnt%>)</A></td>


                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <td id="filesIssue"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                                                                    <%
                                                                                        }

                                                                                        if (fver != null) {
                                                                                    %>

                                                                            <td width="11%"><B>Fix Version </B></td>
                                                                            <td width="22%"><B></B><%=fver%></td>

                                                                            <%
                                                                                }
                                                                            %>
                                                                            <td width="11%"><B>Due Date </B></td>
                                                                            <td width="22%"><input type="text" id="date" name="date" maxlength="10"
                                                                                                   size="10" value="<%= dueDate%>" readonly /></td>
                                                                        </tr>
                                                                        <% //edited by sowjanya
                                                                            if (pmanager == uid || dmanager == uid) {%>
                                                                        <tr>     
                                                                            <td width="12%"><B>Components</B></td>
                                                                            <td width="30%"><div id="issuecomponent"> 
                                                                                    <select multiple="multiple" name="issues" id="issues" size="1">
                                                                                        <%  HashMap c1;
                                                                                            c1 = ApmComponentController.getComponents();
                                                                                            List<BigDecimal> values = atc.findcomponentsByIssueId(issueId);
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
                                                                            </td><%}%>
                                                                        </tr>
                                                                        <%} else {

                                                                        %>   <tr height="21">
                                                                            <td width="12%"><b>Components</b></td>
                                                                            <%                                String cs = "", sc = "";
                                                                                List<ApmComponentIssues> listc = atc.findByIssueId(issueId);
                                                                                for (ApmComponentIssues listl : listc) {
                                                                                    cs = listl.getComponentId().getComponentName();

                                                                                    sc = sc + cs + ',';
                                                                                }
                                                                                if ((sc.length() > 2) && (sc.charAt(sc.length() - 1) == ',')) {
                                                                                    sc = sc.substring(0, (sc.length() - 1));
                                                                                }

                                                                            %>

                                                                            <td align="left"><b></b><%=sc%></td>
                                                                            <td width="12%">                                                            
                                                                                <B>
                                                                                    <%
                                                                                        sql4 = "select amanager from ISSUE I, PROJECT P WHERE ISSUEID='" + issueId + "' AND I.PID = P.PID ";
                                                                                        pt2 = connection.prepareStatement(sql4);
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
                                                                        </tr> <%}//edited by sowjanya
                                                                        %>                               
                                                                        <tr height="21" align="left">
                                                                            <td width="12%"><b>Subject</b></td>
                                                                            <td colspan="5" align="left"><%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
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
                                                                            <%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
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
                                                                            <td width="12%"><b>Expected result</b></td>
                                                                            <%if (dmanager == uid && status.equalsIgnoreCase("Unconfirmed")) {%>
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
                                                                                        <%        if (noOfTestCases > 0) {
                                                                                                if (status.equalsIgnoreCase("QA-TCE")) {
                                                                                        %>
                                                                                        <tr bgcolor="#C3D9FF" width="100%">
                                                                                            <td width="20%"><b>Functionality</b></td>
                                                                                            <td width="22%"><b>Description</b></td>
                                                                                            <td width="20%"><b>Expected Result</b></td>
                                                                                            <td width="10%"><b>Status</b></td>
                                                                                        </tr>
                                                                                        <%
                                                                                        } else {
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
                                                                                            String link = null, tcStatus = null;
                                                                                            int statusid = 1;
                                                                                            String[] testCaseStatus = {"Yet to Test", "Not Applicable", "Not Run", "Failed", "Passed"};
                                                                                            if (status.equalsIgnoreCase("QA-TCE")) {
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
                                                                                        <%       if ((k % 2) != 0) {
                                                                                        %>
                                                                                        <tr bgcolor="white" height="22" align="left">
                                                                                            <%
                                                                                            } else {
                                                                                            %>

                                                                                            <tr bgcolor="#E8EEF7" height="22" align="left">
                                                                                                <%
                                                                                                    }
                                                                                                    if (status.equalsIgnoreCase("QA-TCE")) {
                                                                                                        //                   logger.info("In TCE Status");
%>
                                                                                                <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><a href="<%=link%><%=ptcid%>&statusid=<%=statusid%>&issueid=<%= issueId%>"><%=StringUtil.encodeHtmlTag(func)%></a></td>
                                                                                                <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                                                                                                <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                                                                                                <td>

                                                                                                    <%=tcStatus%>
                                                                                                    <input type="hidden" name="ptcid" id="ptcid" value="<%=ptcid%>"/>
                                                                                                </td>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <td><a href="<%=link%><%=ptcid%>&statusid=<%=statusid%>&issueid=<%=issueId%>"><%=ptcid%></a></td>

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
                                                                            if (!status.equalsIgnoreCase("QA-BTC")) {
                                                                        %>
                                                                        <tr height="21" id="commentsid" align="left">
                                                                            <td width="12%" align="left">
                                                                                <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>
                                                                            </td>

                                                                            <td colspan="5" align="left">
                                                                                <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
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
                                                                                            this.document.on("keyup", updateExpectedResult);
                                                                                            //and paste event
                                                                                            this.document.on("paste", updateExpectedResult);

                                                                                        });
                                                                                        CKEDITOR.instances["comments"].on("change", function()
                                                                                        {
                                                                                            updateExpectedResult();
                                                                                        });
                                                                                        function updateExpectedResult()
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
                                                                                       size="3" maxlength="4" value="2000">
                                                                                    <input type="hidden" name="testcaseindev" id="testcaseindev" value="notestcasesadded">
                                                                                        </td>
                                                                                        </tr>

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

                                                                                                        <%
                                                                                                        } else {
                                                                                                        %>

                                                                                                        <table width="100%" border="0" id="testcasesavailable" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">

                                                                                                            <tr><td colspan="8" align="right"><a id="add" href="javascript: void(0);" onclick="javascript:addMoreTestCases();">Add New Test Case</a></td></tr>

                                                                                                            <tr align="left">
                                                                                                                <td width="12%" align="left">
                                                                                                                    <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>
                                                                                                                </td>

                                                                                                                <td colspan="5" align="left">
                                                                                                                    <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
                                                                                                                        <textarea
                                                                                                                            name="comments" wrap="physical" cols="84" rows="2"
                                                                                                                            onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"
                                                                                                                            onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen1, 2000);"></textarea>
                                                                                                                        <script type="text/javascript">
                                                                                                                            CKEDITOR.replace('comments', {toolbar: 'Basic', height: 100});
                                                                                                                            var editor_data = CKEDITOR.instances.comments.getData();

                                                                                                                            CKEDITOR.instances["comments"].on("instanceReady", function()
                                                                                                                            {

                                                                                                                                //set keyup event
                                                                                                                                this.document.on("keyup", updateExpectedResult);
                                                                                                                                //and paste event
                                                                                                                                this.document.on("paste", updateExpectedResult);

                                                                                                                            });
                                                                                                                            CKEDITOR.instances["comments"].on("change", function()
                                                                                                                            {
                                                                                                                                updateExpectedResult();
                                                                                                                            });
                                                                                                                            function updateExpectedResult()
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
                                                                                                                    <input readonly type="text" name="remLen1" size="3" maxlength="4" value="2000">
                                                                                                                </td>
                                                                                                            </tr>

                                                                                                        </table>
                                                                                                        <input type="hidden" name="testcaseindev" id="testcaseindev" value="testcaseindev">



                                                                                                            <%
                                                                                                                }

                                                                                                            %>

                                                                                                            <%            int count1 = 1;
                                                                                                                String sql3 = "select fileid,filename from fileattach where issueid='" + issueId + "' ";
                                                                                                                pt2 = connection.prepareStatement(sql3, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                                                                rs3 = pt2.executeQuery();
                                                                                                                if (rs3 != null) {
                                                                                                                    if (rs3.next()) {
                                                                                                                        count1++;
                                                                                                                        //logger.debug("count1"+count1);
                                                                                                            %>


                                                                                                            <%					}
                                                                                                                }


                                                                                                            %>

                                                                                                            </tbody>
                                                                                                            </table>
                                                                                                            <table width="100%" border="0" bgcolor="#e8eef7" cellpadding="2">
                                                                                                                <tr>
                                                                                                                    <TD WIDTH="50%" align="right"><INPUT type='submit' value='Update' name='submit' id="submit"></TD>
                                                                                                                    <td WIDTH="50%" align="left"><INPUT type='reset' value='Reset' name='Reset' ID="reset"></td>
                                                                                                                </tr>
                                                                                                            </table>

                                                                                                            <iframe
                                                                                                                src="<%=request.getContextPath()%>/comments.jsp?issueId=<%= issueId%>"
                                                                                                                scrolling="auto" frameborder="0" height="20%" width="100%"></iframe> <%
                                                                                                                    if (status.equalsIgnoreCase("Unconfirmed")) {

                                                                                                                %>
                                                                                                            <table>
                                                                                                                <tr>
                                                                                                                    <td><input type="hidden" name="issuestatus" value="<%=status%>" /></td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                            <%

                                                                                                                }
                                                                                                            } else {%>
                                                                                                            <jsp:forward page="../Issuesummaryview.jsp"><jsp:param name="issueid" value="<%=issueId%>" /> </jsp:forward>         

                                                                                                            <%}
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }

                                                                                                                } finally {
                                                                                                                    if (rs3 != null) {
                                                                                                                        rs3.close();
                                                                                                                    }

                                                                                                                    if (resultset != null) {
                                                                                                                        resultset.close();
                                                                                                                    }
                                                                                                                    if (result != null) {
                                                                                                                        result.close();
                                                                                                                    }
                                                                                                                    if (result1 != null) {
                                                                                                                        result1.close();
                                                                                                                    }
                                                                                                                    if (rs1 != null) {
                                                                                                                        rs1.close();
                                                                                                                    }

                                                                                                                    if (pt2 != null) {
                                                                                                                        pt2.close();
                                                                                                                    }
                                                                                                                    if (pt3 != null) {
                                                                                                                        pt3.close();
                                                                                                                    }
                                                                                                                    if (ps != null) {
                                                                                                                        ps.close();
                                                                                                                    }

                                                                                                                    if (stmt != null) {
                                                                                                                        stmt.close();
                                                                                                                    }
                                                                                                                    if (stmt1 != null) {
                                                                                                                        stmt1.close();
                                                                                                                    }
                                                                                                                    if (connection != null) {
                                                                                                                        connection.close();
                                                                                                                    }
                                                                                                                }

                                                                                                            %>
                                                                                                            <table>
                                                                                                                <tr><td><input type="hidden" name="dateChange" id="dateChange" value="<%=dueDate%>"/></td></tr>
                                                                                                            </table>
                                                                                                            </FORM>
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
                                                                                                                    <h3 class="popupHeadinga">Upload document for <%=issueId%></h3>
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
                                                                                                                                    <input type="hidden" name="issueId" id='issueId' value="<%=issueId%>"/>
                                                                                                                                    <input type="hidden" name="url" id='url' value="<%=requestURL%>"/>
                                                                                                                                    <input type="submit" id="upload" value="Upload" />
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
                                                                                                                    <div id="msgForIE">
                                                                                                                        <p style="color: red;">This page will refresh after uploading file.So Please type the comments or changes after uploading.For better performance use other browsers.. </p>
                                                                                                                    </div>
                                                                                                                </form>
                                                                                                            </div>                                                                                                   
                                                                                                            <div id="TSApopup" class="popup" style="height: 200px;">
                                                                                                                <form id="img-mod-form" name="img-mod-form" enctype="multipart/form-data"  method="POST" action="<%=request.getContextPath()%>/fileAttachIssueIE.jsp" onsubmit="return validate(this);">
                                                                                                                    <h3 class="popupHeadinga">Upload images for <%= issueId%></h3>
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
                                                                                                                                    <input type="hidden" name="issueId" id='issueIda' value="<%= issueId%>"/>
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
                                                                                                                                        });
                                                                                                            </script>



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
                                                                                                                    var issueId = $.trim($("#issueId").val());
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

                                                                                                                $(document).ready(function() {
                                                                                                                    $('#prev').click(function() {
                                                                                                                        var userin = "<%=userin%>";


                                                                                                                        var clickb = "prev";
                                                                                                                        var prev;

                                                                                                                        prev = callfunc(clickb);


                                                                                                                        if (userin == "MyViews" || userin == "MyDashboard" || userin == "statusWise") {
                                                                                                                            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + prev + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=status%>";
                                                                                                                            window.location = text;
                                                                                                                        } else {
                                                                                                                            var text = "<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=" + prev + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=status%>";
                                                                                                                            window.location = text;
                                                                                                                        }
                                                                                                                    });
                                                                                                                });
                                                                                                                $(document).ready(function() {
                                                                                                                    $('#next').click(function() {
                                                                                                                        var userin = "<%=userin%>";

                                                                                                                        var clickb = "next";
                                                                                                                        var next;


                                                                                                                        next = callfunc(clickb);


                                                                                                                        if (userin == "MyViews" || userin == "MyDashboard" || userin == "statusWise") {
                                                                                                                            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + next + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=status%>";
                                                                                                                            window.location = text;
                                                                                                                        } else {
                                                                                                                            var text = "<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=" + next + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fver%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=status%>";
                                                                                                                            window.location = text;
                                                                                                                        }
                                                                                                                    });
                                                                                                                });

                                                                                                                $(document).ready(function() {

                                                                                                                    var position;


                                                                                                                    var clickb = "next";
                                                                                                                    var next;

                                                                                                                    position = callpos();



                                                                                                                    if (position == "middle") {
                                                                                                                        $("#nextBtn").removeClass("nextInactive");
                                                                                                                        $("#prevBtn").removeClass("prevInactive");

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
                                                                                                                });

                                                                                                                $(document).ready(function() {
                                                                                                                    $('#escalation').change(function() {
                                                                                                                        if ($(this).attr('checked')) {

                                                                                                                        } else {
                                                                                                                            $(this).prop('checked', false).removeAttr('checked');
                                                                                                                        }
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
                                                                                                                    var ver = "<%=fver%>";
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
                                                                                                                                    $("input[name='escalation']:checkbox").prop('checked', false);
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
                                                                                                                    var issueId = "<%=issueId%>";
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
                                                                                                            </style>
                                                                                                            <%--edit end by sowjanya--%>
                                                                                                            </HTML>
