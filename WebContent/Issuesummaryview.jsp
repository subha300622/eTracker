<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="com.eminent.issue.formbean.IssueSearchFormBean"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.String"%>
<%@ page import="com.eminent.util.*"%>
<%@ page buffer="10240kb" autoFlush="false" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("Issuesummaryview");

    String logoutcheck = (String) session.getAttribute("Name");

    if (logoutcheck == null) {
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">-->
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
                            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=150720161321"></script>          
                            <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
                            <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">    CKEDITOR.timestamp = '21072016';</script>
                            <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
                            <script src="<%=request.getContextPath()%>/javaScript/cr.js?test=22042020" type="text/javascript"></script>
                            <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
                                <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                                <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
                                <script src="<%=request.getContextPath()%>/javaScript/prevnext.js?test=189345412" type="text/javascript"></script>
                                <LINK title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css" type="text/css" rel="STYLESHEET"/>

                                <script type="text/javascript" >
                                $(document).ready(function () {

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

                                        if (maxlimit == 2000)
                                            alert('Comments size is exceeding 2000 characters');
                                        else
                                            alert('Comments size is exceeding 2000 characters');
                                    } else
                                        cntfield.value = maxlimit - field;
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
                                function trim(str)
                                {
                                    while (str.charAt(str.length - 1) == " ")
                                        str = str.substring(0, str.length - 1);
                                    while (str.charAt(0) == " ")
                                        str = str.substring(1, str.length);
                                    return str;
                                }
                                function fun(theForm)
                                {
                                    if (trim(CKEDITOR.instances.comments.getData()) == "")
                                    {
                                        CKEDITOR.instances.comments.getData()
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

                                }
                                function deleteCrid(sno) {
                                    var issueid = document.getElementById('issueId').value;
                                    if (xmlhttp !== null) {

                                        xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/deleteCrId.jsp?sno=" + encodeURIComponent(sno) + "&issueIdForCr=" + issueid + "&random=" + Math.random(1, 10), false);
                                        xmlhttp.onreadystatechange = function () {
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
                                </script>
                                </HEAD>
                                <BODY>
                                    <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmComponentIssueController"/>
                                    <jsp:useBean id="mai" class="com.eminent.issue.formbean.MyAsignmentIssues"/>
                                    <FORM name="theForm" onSubmit='return fun(this)' action="<%=request.getContextPath()%>/updateComments.jsp" method="post">
                                        <%@ page import="java.sql.*"%>
                                        <%@ page import="java.text.*"%>
                                        <%@ page import="java.sql.Date"%>
                                        <%@ page import="com.pack.*"%>
                                        <%@ page import="pack.eminent.encryption.*"%>
                                        <%@ page language="java"%>
                                        <%@ include file="header.jsp"%>
                                        <% String userin = request.getParameter("userin");
                                        %>
                                        <div class="esclQues " style="display: none;">
                                            <div>
                                            </div>
                                        </div>
                                        <div align="center">
                                            <center>
                                                <table align="center" width="100%" cellpadding="0" cellspacing="0">
                                                    <tr bgcolor="C3D9FF">
                                                        <td><font size="4" COLOR="#0000FF"><b>Issue Details</b></font></td>
                                                                <%if (userin != null) {
                                                                        if ((userin.equalsIgnoreCase("MyAssignment")) || (userin.equalsIgnoreCase("MyIssues")) || (userin.equalsIgnoreCase("statusWise")) || (userin.equalsIgnoreCase("MyDashboard")) || (userin.equalsIgnoreCase("MySearches")) || (userin.equalsIgnoreCase("MyViews"))) {%>
                                                        <td class="previous" align="right"><img id="prev"  class="prevBtn" src="<%=request.getContextPath()%>/images/prev.png"  style="cursor: pointer;" ></img>Prev Next<img id="next" class="nextBtn" src="<%=request.getContextPath()%>/images/next.png"  style="cursor: pointer;" ></img></td><%}
                                                            }%>
                                                    </tr>
                                                </table>
                                                <%   int roleid = 0;
                                                    String priorityIssue = "";
                                                    String sorton = request.getParameter("sorton");
                                                    String sort_method = request.getParameter("sort_method");

                                                    String issueId = request.getParameter("issueid");
                                                    String project = request.getParameter("project");
                                                    String version = request.getParameter("version");
                                                    String priority = request.getParameter("priority");
                                                    // String status=request.getParameter("status")
                                                    String planSeq = request.getParameter("planSeq");
                                                    String message = request.getParameter("message");
                                                    HashMap<Integer, String> member = GetProjectMembers.showUsers();
                                                    String operation = "Closed";
                                                    int uid = ((Integer) session.getAttribute("uid")).intValue();
                                                    String team = (String) session.getAttribute("team");
                                                     String mail = (String) session.getAttribute("theName");
                                                        String url = null;
                                                        if (mail != null) {
                                                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                                                        }
                                                    Calendar cal = Calendar.getInstance();
                                                    if (planSeq == null) {
                                                        planSeq = "no";
                                                    }
                                                    if (url.equals("eminentlabs.net") && planSeq.equalsIgnoreCase("no")) {
                                                        if (cal.getTime().getHours() > 8 && cal.getTime().getHours() < 18) {
                                                            priorityIssue = mai.checkPlannedIssues(request);
                                                        }
                                                    }
                                                %> <br>

                                                    <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" />
                                                    <%!
                                                        HashMap hm;
                                                                                                            %>
                                                    <% String status = request.getParameter("status");

                                                        Connection connection = null;
                                                        Statement stmt5 = null, stmt6 = null, stmt7 = null, st = null;
                                                        ResultSet resultset = null, rs2 = null, rs3 = null, rs8 = null, rs6 = null, rs7 = null;
                                                        PreparedStatement pt2 = null, pt1 = null;
                                                        String sta = "", pro = "", fix = "", pri = "";

                                                        String pmanager = "";
                                                        String name = null;
                                                        String phase = null;
                                                        String subphase = null;
                                                        String subsubphase = null;
                                                        String subsubsubphase = null;
                                                        String projecttype = null;
                                                        String category = null;
                                                        String viewDueDate = "NA";
                                                       
                                                        try {
                                                            if (priorityIssue.equalsIgnoreCase("")) {
                                                                connection = MakeConnection.getConnection();
                                                                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                resultset = st.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE,ESCALATION FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + issueId + "'");//CHANGED

                                                                if (resultset != null) {
                                                                    if (resultset.next()) {

                                                                        pro = resultset.getString("project");
                                                                        String ver = resultset.getString("found_version");
                                                                        fix = resultset.getString("fix_version");
                                                                        session.setAttribute("fixVersion", fix);
                                                                        String pid = ProjectFinder.getProjectId(pro, fix);
                                                                        int creby = resultset.getInt("createdby");
                                                                        String assi = resultset.getString("assignedto");
                                                                        pmanager = resultset.getString("pmanager");
                                                                        String dmanager = resultset.getString("dmanager");
                                                                        String amanager = resultset.getString("amanager");
                                                                        String currentuser = ((Integer) session.getAttribute("userid_curr")).toString();
                                                                        roleid = ((Integer) session.getAttribute("Role")).intValue();
                                                                        logger.info("roleid" + roleid);

                                                                        HashMap<String, String> userDetail = GetProjectMembers.getMembers(pro, fix, ((Integer) creby).toString(), assi);
                                                                        if (userDetail.get(currentuser) != null || roleid == 1) {

                                                                            String cus = resultset.getString("customer");
                                                                            String mod = resultset.getString("module");
                                                                            String pla = resultset.getString("platform");
                                                                            String sev = resultset.getString("severity");
                                                                            pri = resultset.getString("priority");
                                                                            String typ = resultset.getString("type");

                                                                            Date due = resultset.getDate("due_date");

                                                                            SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");
                                                                            SimpleDateFormat format = new SimpleDateFormat("dd-MMM-yy");

                                                                            if (due != null) {
                                                                                viewDueDate = format.format(due);
                                                                            }

                                                                            String dueDate = "NA";
                                                                            if (due != null) {
                                                                                dueDate = dfm.format(due);
                                                                            }

                                                                            if (hm == null) {
                                                                                hm = UpdateIssue.showUsers(connection);
                                                                            }

                                                                            String createdBy = (String) hm.get(creby);

                                                                            Date creon = resultset.getDate("createdon");
                                                                            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                                            String dateString = sdf.format(creon);
                                                                            session.setAttribute("createdOn", dateString);
                                                                            Date mdion = resultset.getDate("modifiedon");
                                                                            SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yy");
                                                                            String dateString1 = sdf1.format(mdion);
                                                                            String sub = resultset.getString("subject");
                                                                            int count = 0;
                                                                            if (url.equals("eminentlabs.net")) {
                                                                                count = IssueDetails.eTrackerIssueSearchCount(sub, issueId);
                                                                            }
                                                                            String des = resultset.getString("description");
                                                                            String com1 = resultset.getString("comment1");
                                                                            String root_cau = resultset.getString("rootcause");
                                                                            String exp_res = resultset.getString("expected_result");
                                                                            String escalation = resultset.getString("ESCALATION");

                                                                            name = GetProjectMembers.getUserName(assi);

                                                                            String sql1 = "select status from issuestatus where issueid='" + issueId + "' ";
                                                                            pt1 = connection.prepareStatement(sql1, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                                            rs2 = pt1.executeQuery();

                                                                            if (rs2 != null) {
                                                                                while (rs2.next()) {
                                                                                    sta = rs2.getString("status");
                                                                                }
                                                                            }

                                                                            //				int role	= (Integer)session.getAttribute("Role");
                                                                            if (!operation.equals(sta)) {

                                                                                if (uid == creby && sta.equals("Verified")) {
                                                                                    logger.info("Forwarding to MyIssue");
                                                    %> 
                                                    <jsp:forward page="/MyIssues/MyIssueview.jsp">
                                                        <jsp:param name="issueid" value="<%=issueId%>" />
                                                    </jsp:forward> 
                                                    <%
                                                        }
                                                        if (uid == Integer.parseInt(assi)) {
                                                            logger.info("forwarding to My Assignment");
                                                    %> <jsp:forward page="/MyAssignment/UpdateIssueview.jsp">
                                                        <jsp:param name="issueid" value="<%=issueId%>" />

                                                    </jsp:forward> 
                                                    <%
                                                        }
                                                        if (uid == creby) {
                                                            logger.info("Forwarding to MyIssue");
                                                    %> <jsp:forward page="/MyIssues/MyIssueview.jsp">
                                                        <jsp:param name="issueid" value="<%=issueId%>" />
                                                    </jsp:forward>
                                                    <%
                                                        }
                                                        if (pmanager != null) {
                                                            if (uid == Integer.parseInt(pmanager) || uid == Integer.parseInt(dmanager)) {
                                                                logger.info("Forwarding to updateIssueView------------");
                                                    %> <jsp:forward page="/admin/dashboard/UpdateIssueview.jsp">
                                                        <jsp:param name="issueNo" value="<%=issueId%>" />
                                                        <jsp:param name="status" value="<%=status%>"/>
                                                    </jsp:forward>
                                                    <%
                                                            }
                                                        }
                                                        if (dmanager != null) {
                                                            if (uid == Integer.parseInt(dmanager)) {
                                                                logger.info("Forwarding to Admin Dashboard");
                                                    %> <jsp:forward page="/admin/dashboard/UpdateIssueview.jsp">
                                                        <jsp:param name="issueNo" value="<%=issueId%>" />
                                                        <jsp:param name="status" value="<%=status%>"/>
                                                    </jsp:forward>
                                                    <%
                                                            }
                                                        }
                                                        if (amanager != null) {
                                                            if (uid == Integer.parseInt(amanager)) {
                                                                logger.info("Forwarding to Admin Dashboard");
                                                    %> <jsp:forward page="/admin/dashboard/UpdateIssueview.jsp">
                                                        <jsp:param name="issueNo" value="<%=issueId%>" />
                                                        <jsp:param name="status" value="<%=status%>"/>
                                                    </jsp:forward>
                                                    <%
                                                            }
                                                        }

                                                    } else {

                                                        logger.info("Forwarding Non editable page which is inside user folder");
                                                    %>
                                                    <jsp:forward page="/admin/user/WorkedIssueDetails.jsp">
                                                        <jsp:param name="issueno" value="<%=issueId%>" />
                                                    </jsp:forward>
                                                    <%

                                                        }

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

                                                        stmt5 = connection.createStatement();
                                                        rs8 = stmt5.executeQuery("SELECT category from project where pname = '" + pro + "'");//CORRECT
                                                        if (rs8 != null) {
                                                            if (rs8.next()) {

                                                                category = rs8.getString(1);
                                                            }
                                                        }

                                                        if (category.equalsIgnoreCase("SAP Project")) {
                                                            stmt6 = connection.createStatement();

                                                            rs6 = stmt6.executeQuery("SELECT type from project_type,project where project.pid=project_type.pid and project.pname='" + pro + "' and category='" + category + "'");//CORRECT
                                                            if (rs6 != null) {
                                                                if (rs6.next()) {

                                                                    projecttype = rs6.getString(1);
                                                                }
                                                            }

                                                            stmt7 = connection.createStatement();
                                                            String tablename = "issue_" + projecttype.toLowerCase();

                                                            rs7 = stmt7.executeQuery("SELECT phase,subphase,subsubphase,subsubsubphase from " + tablename + " where issueid='" + issueId + "'");//CORRECT
                                                            if (rs7 != null) {
                                                                if (rs7.next()) {

                                                                    phase = rs7.getString(1);
                                                                    subphase = rs7.getString(2);
                                                                    subsubphase = rs7.getString(3);
                                                                    subsubsubphase = rs7.getString(4);

                                                                }
                                                            }
                                                        }

                                                    %>
                                                    <table align=left width="100%" bgcolor="C3D9FF">
                                                        <tr align="left">
                                                            <td><b>Issue Number <font color="#0000FF"><%= issueId%></font></b>
                                                                <input type="hidden"  id="message" value="<%= message%>" /></td>
                                                            <td align="right"><%if (url.equals("eminentlabs.net")) {%>
                                                                <span class="refer" style="color: blue;cursor: pointer;margin-right: 20px;">Reference
                                                                    <%if (count > 0) {%>
                                                                    (<%=count%>)
                                                                    <%}%></span>
                                                                    <%}%>
                                                                    <%if (!pid.equals("10139")) {%>
                                                                <a href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= issueId%>" target="_blank">Print this Issue</a></td>
                                                                <%}%>
                                                        </tr>
                                                    </table>
                                                    <br>
                                                        <BR>


                                                            <table width="100%" bgcolor="E8EEF7">
                                                                <tr height="21" align="left">
                                                                    <td width="12%"><B>Customer </B></td>
                                                                    <td width="24%" align="left" color="#bbbbbb"><%= cus%></td>

                                                                    <td width="11%"><B>Product </B></td>
                                                                    <td width="22%"><%= pro%></td>

                                                                    <td width="10%"><B>FoundVersion </B></td>
                                                                    <td width="21%"><%= ver%></td>
                                                                </tr>
                                                                <tr height="21" align="left">
                                                                    <td width="12%"><B>type </B></td>
                                                                    <td width="24%"><%= typ%></td>

                                                                    <td width="11%"><B>Module </B></td>
                                                                    <td width="22%"><%= mod%></td>

                                                                    <td width="10%"><B>Platform</B></td>
                                                                    <td width="21%"><%= pla%></td>
                                                                </tr>
                                                                <tr height="21" align="left">
                                                                    <td width="12%"><B>Severity </B></td>
                                                                    <td width="24%"><%=sev%></td>

                                                                    <td width="11%"><B>Priority</B></td>
                                                                    <td width="22%"><%=pri%></td>

                                                                    <td width="10%"><B>IssueStatus</B></td>
                                                                    <td width="21%"><%= sta%></td>
                                                                </tr>
                                                                <tr height="21" align="left">
                                                                    <td width="12%"><B>DateCreated </B></td>
                                                                    <td width="24%"><%= dateString%></td>

                                                                    <td width="11%"><B>DateModified </B></td>
                                                                    <td width="22%"><%= dateString1%></td>

                                                                    <td width="10%"><B>CreatedBy </B></td>
                                                                    <td width="21%"><%= createdBy%></td>
                                                                </tr>
                                                                <tr height="21" align="left">

                                                                    <td width="12%"><B><img  title="Add CrId" src="/eTracker/images/plus.gif" style="height: 10px;" onclick="showcrid()"></img>AssignedTo</B></td>
                                                                    <td width="24%"><%= name%></td>

                                                                    <td width="11%"><B>Files Attached </B><img  id="fileUpload" title="Upload Document" src="/eTracker/images/attachment.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showFileAttach()"></img></td>


                                                                    <%
                                                                        int count1 = 1;
                                                                        String sql3 = "select count(*) from fileattach where issueid='" + issueId + "' ";
                                                                        pt2 = connection.prepareStatement(sql3);
                                                                        rs3 = pt2.executeQuery();
                                                                        if (rs3 != null) {
                                                                            if (rs3.next()) {
                                                                                count1 = rs3.getInt(1);;
                                                                                logger.debug("count1" + count1);

                                                                            }
                                                                        }

                                                                        if (count1 > 0) {

                                                                            if (!url.equals("continental-corporation.com")) {
                                                                    %>
                                                                    <td id="filesIssue"> <A onclick="viewFileAttachForIssue('<%=issueId%>');" href="#"
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

                                                                    <td width="10%"><B>Fix Version</B></td>
                                                                    <td width="21%"><%= fix%></td>
                                                                </tr>
                                                                <%
                                                                    String[][] crIdDetails = IssueDetails.getCRIDS(issueId);
                                                                    if (crIdDetails.length == 0) {%>
                                                                <tr  style="font-weight: bold;text-align: left;" id="crrow"  ></tr> 
                                                                <%  } else {%>
                                                                <tr  style="font-weight: bold;text-align: left;" id="crrow"  ><td>CR ID</td><td class="crnormal" onclick="openEdit();" style="cursor: pointer;color:  #3333cc;" title="Expand All">View CRID(<%=crIdDetails.length%>)</td><td  class="credit" colspan="2" onclick="openNormal();" title="Collapse All" style="cursor: pointer;">CR ID Description</td><td  class="credit" >Created On</td><td  class="credit" >Status</td><td  class="credit" >Created By</td></tr>
                                                                <%
                                                                    for (int i = 0; i < crIdDetails.length; i++) {
                                                                        if (crIdDetails[i][0] != null) {
                                                                            String key = crIdDetails[i][0].trim();
                                                                            String desc = crIdDetails[i][1].trim();
                                                                            String sno = crIdDetails[i][2].trim();
                                                                            String createBy = crIdDetails[i][3].trim();
                                                                            String createdOn = crIdDetails[i][4].trim();
                                                                            String crstatus = crIdDetails[i][5].trim();
                                                                            if (i % 2 == 0) {%>
                                                                <tr class="credit"  style="background-color:#FFFFFF;text-align: left;"  >  
                                                                    <%} else {%>
                                                                    <tr class="credit" style="background-color:#C3D9FE;text-align: left;" >
                                                                        <%}%>

                                                                        <td class="key<%=sno%>"><img  src='/eTracker/images/edit.png' onclick="editcrid('<%=sno%>', '<%=key%>', '<%=desc%>');" style="cursor: pointer;" ></img><%=key%></td>
                                                                        <td class="desc<%=sno%>" colspan="2"><%=desc%></td>
                                                                        <td ><%=createdOn%></td>
                                                                        <td ><%=crstatus%></td>
                                                                        <td >
                                                                            <%if (!createBy.equalsIgnoreCase("Nil")) {%>
                                                                            <%=member.get(Integer.valueOf(createBy))%>
                                                                            <%} else {%>
                                                                            Nil
                                                                            <% }%><img src="<%=request.getContextPath()%>/images/remove.gif" alt="Remove CrId" style="cursor: pointer;" onclick="javascript :deleteCrid('<%=sno%>');"/></td>
                                                                    </tr>

                                                                    <% }
                                                                            }
                                                                        }
                                                                        if (category.equalsIgnoreCase("SAP Project")) {
                                                                    %>

                                                                    <%
                                                                        if (phase != null) {
                                                                    %>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Phase</b></td>
                                                                        <td colspan="5" align="left"><B></B><%=phase%></td>
                                                                    </tr>
                                                                    <%
                                                                        }
                                                                        if (subphase != null) {
                                                                    %>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Sub Phase</b></td>
                                                                        <td colspan="5" align="left"><B></B><%=subphase%></td>
                                                                    </tr>
                                                                    <%
                                                                        }
                                                                        if (subsubphase != null) {
                                                                    %>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Sub Sub Phase</b></td>
                                                                        <td colspan="5" align="left"><B></B><%=subsubphase%></td>
                                                                    </tr>
                                                                    <%
                                                                        }
                                                                        if (subsubsubphase != null) {
                                                                    %>
                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Sub Sub Sub Phase</b></td>
                                                                        <td colspan="5" align="left"><B></B><%=subsubsubphase%></td>
                                                                    </tr>
                                                                    <%
                                                                            }

                                                                        }
                                                                    %>
                                                                    <tr height="21">
                                                                        <td width="12%"><b>Components</b></td>
                                                                        <%
                                                                            String cs = "", sc = "";
                                                                            List<ApmComponentIssues> listc = atc.findByIssueId(issueId);
                                                                            for (ApmComponentIssues listl : listc) {
                                                                                cs = listl.getComponentId().getComponentName();

                                                                                sc = sc + cs + ',';
                                                                            }
                                                                            if ((sc.length() > 2) && (sc.charAt(sc.length() - 1) == ',')) {
                                                                                sc = sc.substring(0, (sc.length() - 1));
                                                                            }

                                                                        %>

                                                                        <td  align="left"><b></b><%=sc%></td>
                                                                                <%if (url.equals("eminentlabs.net")) {%>
                                                                        <td  width="12%"><B>
                                                                                <%if (escalation != null && escalation.equalsIgnoreCase("yes") && roleid == 1 | uid == Integer.parseInt(pmanager) || uid == Integer.parseInt(dmanager) || uid == Integer.parseInt(amanager)) {%>
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
                                                                        </td><%}%>
                                                                    </tr>

                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Subject</b></td>
                                                                        <td colspan="5" align="left"><%=sub%></td>
                                                                    </tr>

                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Description</b></td>
                                                                        <td colspan="5" align="left"><%=des1%></td>
                                                                    </tr>

                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Root Cause</b></td>
                                                                        <td colspan="5" align="left"><%=root_cau%></td>
                                                                    </tr>

                                                                    <tr height="21" align="left">
                                                                        <td width="12%"><b>Expected Result</b></td>
                                                                        <td colspan="5" align="left"><%=exp_res1%></td>
                                                                    </tr>


                                                                    <%
                                                                        if (!operation.equals(sta)) {

                                                                    %>

                                                                    <tr height="21" align="left">
                                                                        <td width="12%" class="textdisplay" align="left">
                                                                            <b>Comments</b><img  id="imgUpload" title="Upload Images" src="/eTracker/images/imgAttach.png" style="height: 20px;width:  20px;cursor: pointer;vertical-align: middle; " onclick="showImgAttach()"/>
                                                                        </td>

                                                                        <td colspan="5" align="left"><font size="2"
                                                                                                           face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                                                    rows="3" cols="68" name="comments" maxlength="2000"
                                                                                    onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"
                                                                                    onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"></textarea></font>

                                                                            <input readonly type="text" name="remLen1" size="3" maxlength="3"
                                                                                   value="2000"></td>
                                                                        <script type="text/javascript">
                                                                            CKEDITOR.replace('comments', {height: 100});
                                                                            var editor_data = CKEDITOR.instances.comments.getData();
                                                                            CKEDITOR.instances["comments"].on("instanceReady", function ()
                                                                            {

                                                                                //set keyup event
                                                                                this.document.on("keyup", updateComments);
                                                                                //and paste event
                                                                                this.document.on("paste", updateComments);

                                                                            });
                                                                            CKEDITOR.instances["comments"].on("change", function ()
                                                                            {
                                                                                updateComments();
                                                                            });
                                                                            function updateComments()
                                                                            {
                                                                                CKEDITOR.tools.setTimeout(function ()
                                                                                {
                                                                                    var desc = CKEDITOR.instances.comments.getData();
                                                                                    var leng = desc.length;
                                                                                    editorTextCounter(leng, document.theForm.remLen1, 2000);

                                                                                }, 0);
                                                                            }
                                                                        </script>
                                                                    </tr>
                                                            </table>
                                                            <table width="100%" border="0" bgcolor="#e8eef7" cellpadding="2">
                                                                <tr>
                                                                    <TD WIDTH="50%" align="right"><INPUT type='submit' value='Update' name='submit' ID="submit"></TD>
                                                                    <td WIDTH="50%" align="left"><INPUT type='reset' value='Reset' name='reset' ID="reset"></td>
                                                                </tr>
                                                            </table>
                                                            <%    }

                                                            %>
                                                            <table width="100%" bgcolor="E8EEF7">

                                                                <tr>
                                                                    <td><input type="hidden" name="issueId" id="issueId" value="<%= issueId%>" /></td>
                                                                    <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                                                                    <td><input type="hidden" name="project"  id="project" value="<%=pro%>" /></td>
                                                                    <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                                                                    <td><input type="hidden" name="module" value="<%=mod%>" /></td>
                                                                    <td><input type="hidden" name="platform" value="<%=pla%>" /></td>
                                                                    <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                                                                    <td><input type="hidden" name="severity" value="<%=sev%>" /></td>
                                                                    <td><input type="hidden" name="priority" id="priority" value="<%=pri%>" /></td>
                                                                    <td><input type="hidden" name="viewDueDate" value="<%=viewDueDate%>" /></td>
                                                                    <td><input type="hidden" name="issuestatus" id="issuestatus" value="<%=sta%>" /></td>
                                                                    <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                                                                    <td><input type="hidden" name="assignedto" value="<%=assi%>" /></td>
                                                                    <td><input type="hidden" name="duedate" value="<%=dueDate%>" /></td>
                                                                    <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                                                                    <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                                                                    <td><input type="hidden" name="sub" id="sub" value="<%=sub%>" /></td>
                                                                    <td><input type="hidden" name="rootcause" value="<%=root_cau%>" /></td>
                                                                    <td><input type="hidden" name="des" value="<%=StringUtil.encodeHtmlTag(des1)%>" /></td>
                                                                    <td><input type="hidden" name="expected_result" value='<%=StringUtil.encodeHtmlTag(exp_res)%>' /></td>
                                                                    <td><input type="hidden" name="status" id="status" value="<%=sta%>"/>

                                                                        <td><input type="hidden" name="sorton" id="sorton" value="<%=sorton%>" /></td>
                                                                        <td><input type="hidden" name="sort_method" id="sort_method" value="<%=sort_method%>" /></td>
                                                                        <td><input type="hidden" name="userin" id="userin" value="<%=userin%>" /></td>
                                                                        <td><input type="hidden" name="fixversion" id="fversion" value="<%=fix%>" /></td>

                                                                </tr>
                                                            </table>

                                                            <!--
                                                            <iframe
                                                                    src="comments.jsp?issueId=<%= issueId%>"
                                                                    scrolling="auto" frameborder="2" height="45%" width="100%"></iframe>
                                                            -->
                                                            <%

                                                                if (!url.equals("continental-corporation.com")) {
                                                            %>
                                                            <iframe
                                                                src="<%=request.getContextPath()%>/comments.jsp?issueId=<%= issueId%>"
                                                                scrolling="auto" frameborder="0" height="20%" width="100%"></iframe>
                                                                <%
                                                                    }
                                                                %>

                                                            </center>
                                                            </div>
                                                            </FORM>
                                                            <div id="overlay"></div>

                                                            <div id="cridpopup" class="popup" style="width: 600px;height:450px;overflow: auto;top: 15%;left: 20%;">
                                                                <h3 class="popupHeading">Add CR Id</h3>
                                                                <div >
                                                                    <div style="color:red;display: none;" id="errormsg"></div>
                                                                    <p><input type="button"  id="addissue" value="Add Cr Id" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:incrCrId();"> &nbsp;&nbsp;&nbsp;</p>
                                                                    <hr />
                                                                    <!-- Update form action -->

                                                                    <table style="margin: 20px; ">
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
                                                                        <input type="hidden" name="issueIdForCr" id='issueIdForCr' value="<%=issueId%>" />
                                                                        <input type="hidden" name="statusForCR" id='statusForCR' value="<%=sta%>"/>

                                                                        <input type="submit" value="Add CR ID" onclick='return createcrid("<%=pid%>");'/>

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
                                                                                <input type="hidden" name="issueIdForCr" id='issueIdForCr' value="<%=issueId%>" />
                                                                                <input type="submit" value="Update CR ID" onclick='return updatecrid("<%=pid%>");'/>

                                                                                <input type="button" value="Cancel" onclick="javascript:closeeditcrid();"  />
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                </div>
                                                            </div>
                                                            <%
                                                            } else {
                                                            %>
                                                            <table align=left width="100%" bgcolor="C3D9FF">
                                                                <tr>
                                                                    <td><b>Issue Number <font color="#0000FF"><%= issueId%></font></b></td>

                                                                </tr>
                                                            </table>
                                                            <br>
                                                                <BR>
                                                                    <table>
                                                                        <tr align="center" ><td><font color="red">You are not authorised to access this issue.</font></td></tr>
                                                                    </table>
                                                                    <%
                                                                        }
                                                                    } else {
                                                                    %>

                                                                    <tr align="center" ><td><font color="red">The Issue no you are searching is not available</font></td></tr>
                                                                                <%
                                                                                        }
                                                                                    }

                                                                                %>
                                                                                <%} else {%>

                                                                    <jsp:forward page="viewIssueDetails.jsp"><jsp:param name="issueid" value="<%=issueId%>" /> </jsp:forward>         
                                                                    <%}%>
                                                                    <%  } catch (Exception e) {
                                                                            logger.error(e.getMessage());
                                                                        } finally {

                                                                            if (resultset != null) {
                                                                                resultset.close();
                                                                            }
                                                                            if (rs2 != null) {
                                                                                rs2.close();
                                                                            }

                                                                            if (rs3 != null) {
                                                                                rs3.close();
                                                                            }

                                                                            if (rs8 != null) {
                                                                                rs8.close();
                                                                            }
                                                                            if (rs6 != null) {
                                                                                rs6.close();
                                                                            }
                                                                            if (rs7 != null) {
                                                                                rs7.close();
                                                                            }
                                                                            if (st != null) {
                                                                                st.close();
                                                                            }
                                                                            if (pt1 != null) {
                                                                                pt1.close();
                                                                            }
                                                                            if (pt2 != null) {
                                                                                pt2.close();
                                                                            }
                                                                            if (stmt5 != null) {
                                                                                stmt5.close();
                                                                            }
                                                                            if (stmt6 != null) {
                                                                                stmt6.close();
                                                                            }
                                                                            if (stmt7 != null) {
                                                                                stmt7.close();
                                                                            }
                                                                            if (connection != null) {
                                                                                connection.close();
                                                                            }
                                                                        }

                                                                    %>
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
                                                                            <h3 class="popupHeadinga">Upload document for <%=issueId%></h3>
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
                                                                                            <input type="hidden" name="issueId" id='issueId' value="<%=issueId%>"/>
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
                                                                    <script type="text/javascript">
                                                                        $('.refer').click(function (e) {
                                                                            $('.refissuepopupa').dialog("open");
                                                                            $(".refissuepopupa").dialog({position: {my: "right center", at: "right bottom"}
                                                                            });
                                                                        });

                                                                        $(function () {
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
                                                                        $(".refer").click(function (e) {
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
                                                                                success: function (responseText, statusTxt, xhr) {
                                                                                    if (statusTxt === "success") {
                                                                                        var result = $.trim(responseText);
                                                                                        $(".refissuepopupa > div").html(result);
                                                                                        $(".refissuepopupa > img").hide();
                                                                                    }
                                                                                }});
                                                                        });
                                                                        <%if (uid == 212) {%>
                                                                        $(document).ready(function () {
                                                                            $('.refer').trigger('click');
                                                                        });
                                                                        <%}%>

                                                                        $(document).ready(function () {
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
                                                                        $('#file-mod-select').bind('change', function () {
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

                                                                        $('#img-mod-select').bind('change', function () {
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
                                                                        $('#prev').click(function () {

                                                                            var userin = "<%=userin%>";
                                                                            var clickb = "prev";

                                                                            var roleId = "<%=roleid%>";
                                                                            var uid = "<%=uid%>";
                                                                            var pmanager = "<%=pmanager%>";

                                                                            var prev;
                                                                            if (userin == "statusWise") {

                                                                                prev = callfunc(clickb);
                                                                                if (roleId == 1 || (uid == pmanager)) {
                                                                                    var text = "<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=" + prev + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                                    window.location = text;
                                                                                } else {
                                                                                    var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + prev + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                                    window.location = text;
                                                                                }


                                                                            } else {
                                                                                prev = callfunc(clickb);

                                                                            }
                                                                            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + trim(prev) + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                            window.location = text;

                                                                        });


                                                                        $('#next').click(function () {

                                                                            var userin = "<%=userin%>";
                                                                            var clickb = "next";

                                                                            var roleId = "<%=roleid%>";
                                                                            var uid = "<%=uid%>";
                                                                            var pmanager = "<%=pmanager%>";

                                                                            var next;

                                                                            if (userin == "statusWise") {
                                                                                next = callfunc(clickb);
                                                                                if (roleId == 1 || (uid == pmanager)) {
                                                                                    var text = "<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=" + next + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                                    window.location = text;
                                                                                } else {
                                                                                    var text = "<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + next + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                                    window.location = text;
                                                                                }


                                                                            } else {
                                                                                next = callfunc(clickb);
//                                                                            
                                                                            }
                                                                            var text = "<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=" + trim(next) + "&sorton=" + "<%=sorton%>" + "&sort_method=" + "<%=sort_method%>" + "&userin=" + "<%=userin%>" + "&project=" + "<%=pro%>" + "&version=" + "<%=fix%>" + "&priority=" + "<%=pri%>" + "&status=" + "<%=sta%>";
                                                                            window.location = text;
                                                                        });
                                                                        $(document).ready(function () {

                                                                            var project = "<%=pro%>";

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
                                                                        $(document).ready(function () {
                                                                            $("#prev").one('click', function (e) {
                                                                                e.preventDefault();
                                                                                e.stopPropagation();

                                                                                $(this).prop('disabled', true);
                                                                            });
                                                                            $("#next").one('click', function (e) {
                                                                                e.preventDefault();
                                                                                e.stopPropagation();

                                                                                $(this).prop('disabled', true);
                                                                            });

                                                                        });
                                                                        $('[name="escalation"]').change(function () {
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
                                                                                    success: function (responseText, statusTxt, xhr) {
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

                                                                        $("#escshow").click(function () {
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
                                                                            $(".esclQues > img").show();
                                                                            $(".esclQues > div").html("");
                                                                            $(".esclQues").dialog("open");
                                                                            $.ajax({url: '<%=request.getContextPath()%>/escalationAnswers.jsp',
                                                                                data: {issueId: issueId, random: Math.random(1, 10)},
                                                                                async: true,
                                                                                type: 'GET',
                                                                                success: function (responseText, statusTxt, xhr) {
                                                                                    if (statusTxt === "success") {
                                                                                        var result = $.trim(responseText);
                                                                                        $(".esclQues > div").html(result);
                                                                                    }
                                                                                }});
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
                                                                    <%-- Edit end by sowjanya--%>

                                                                    </HTML>
