



<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.util.HashMap"%>
<%

    //Configuring log4j properties
    Logger logger = Logger.getLogger("displayForAdmin");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="/warnUser.jsp" />
<%
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
    </HEAD>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script><script type="text/javascript" >
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
    </script>

    <BODY>
        <FORM name="theForm" onSubmit='return fun(this)'
              action="<%= request.getContextPath()%>/admin/dashboard/modifyIssueForAdmin.jsp"
              method="post"><%@ page import="java.sql.*"%>
            <%@ page import="java.text.*"%> <%@ page
                import="java.sql.Date"%> <%@ page
                    import="com.pack.*"%> <%@ page
                        import="pack.eminent.encryption.*"%> <%@ page
                            language="java"%> <jsp:include page="/header.jsp" />
                            <div align="center">
                                <center>

                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr border="2" bgcolor="#C3D9FF">
                                            <td border="1" align="left" width="100%"><font size="4"
                                                                                           COLOR="#0000FF"><b>Issue Description </b></font><FONT SIZE="3"
                                                                                                      COLOR="#0000FF"> </FONT></td>

                                            <%
                                                if (request.getParameter("updatestatus") != null) {
                                            %>
                                            <td colspan="3" align="CENTER" height="21"><font face="Tahoma"
                                                                                             size="3" color="red"><%= "Updated Successfully"%></font></td>
                                                    <%
                                                        }
                                                    %>

                                        </tr>
                                    </table>
                                    <%
                                        String no = (String) request.getParameter("issueNo");
                                        session.setAttribute("theissu", no);

                                    %> <br>

                                    <table align=left width="100%" bgcolor="#C3D9FF">
                                        <tr>
                                            <td><b>Issue Number <font color="#0000FF"><%= session.getAttribute("theissu")%></font></b></td>
                                            <td align="right"><a
                                                    href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= session.getAttribute("theissu")%>"
                                                    target="_blank">Print this Issue</a></td>
                                        </tr>
                                    </table>
                                    <br>
                                    <BR>

                                    <table width="100%" bgcolor="#E8EEF7">
                                        <jsp:useBean id="UpdateIssue" class="com.pack.UpdateIssueBean" />
                                        <%!
                                            HashMap hm;
                                                                                                                                %>
                                        <%
                                            Connection connection = null;
                                            Statement state = null, stmt1 = null, st5 = null;

                                            //session.setAttribute("dashBoard","project");    
                                            ResultSet resultset = null,  rs2 = null, rs3 = null, rs4 = null, rs5 = null, resultset1 = null;
                                            PreparedStatement pt2 = null, pt1 = null, pt4 = null;
                                            try {
                                                connection = MakeConnection.getConnection();

                                                String theissu = (String) session.getAttribute("theissu");
                                                state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                resultset = state.executeQuery("SELECT CUSTOMER, PNAME AS PROJECT,amanager, dmanager, pmanager, found_version, VERSION AS FIX_VERSION, MODULE, PLATFORM,SEVERITY,PRIORITY,TYPE,createdby,assignedto,createdon,modifiedon, due_date, subject,description,comment1,rootcause,expected_result,estimated_time,SAP_ISSUE_TYPE FROM ISSUE I, PROJECT P, MODULES M WHERE I.PID = P.PID  AND MODULEID = MODULE_ID AND ISSUEID='" + theissu + "'");//CHANGED
                                                if (resultset != null) {
                                                    while (resultset.next()) {
                                                        String cus = resultset.getString("customer");
                                                        String pro = resultset.getString("project");
                                                        String ver = resultset.getString("found_version");
                                                        String fix = resultset.getString("fix_version");
                                                        String mod = resultset.getString("module");
                                                        String pla = resultset.getString("platform");
                                                        String sev = resultset.getString("severity");
                                                        String pri = resultset.getString("priority");
                                                        String typ = resultset.getString("type");
                                                        int creby = resultset.getInt("createdby");

                                                        if (hm == null) {
                                                            hm = UpdateIssue.showUsers(connection);
                                                        }

                                                        String createdBy = (String) hm.get(creby);

                                                        Date creon = resultset.getDate("createdon");
                                                        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yy");
                                                        String dateString = sdf.format(creon);

                                                        SimpleDateFormat df = new SimpleDateFormat("dd MMM yy");
                                                        String createdOn = df.format(creon);

                                                        session.setAttribute("createdOn", createdOn);
                                                        session.setAttribute("foundVersion", ver);

                                                        Date mdion = resultset.getDate("modifiedon");
                                                        SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yy");
                                                        String dateString1 = sdf1.format(mdion);

                                                        SimpleDateFormat dfm = new SimpleDateFormat("d-M-yyyy");

                                                        Date due = resultset.getDate("due_date");
                                                        String dueDate = "NA";
                                                        if (due != null) {
                                                            dueDate = dfm.format(due);
                                                        }
                                                        String sub = resultset.getString("subject");
                                                        String des = resultset.getString("description");
                                                        String com1 = resultset.getString("comment1");
                                                        String root_cau = resultset.getString("rootcause");
                                                        String exp_res = resultset.getString("expected_result");
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
                                        %>
                                        <tr height="21">
                                            <td width="15%"><B>Customer </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%" align="left" color="#bbbbbb"><%= cus%></td>
                                            <td width="15%"><B>Product </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= pro%></td>
                                            <td width="15%"><B>FoundVersion </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= ver%></td>
                                        </tr>
                                        <tr height="21">
                                            <td width="15%"><B>Type </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= typ%></td>
                                            <td width="15%"><B>Module </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= mod%></td>
                                            <td width="15%"><B>Platform</B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= pla%></td>
                                        </tr>
                                        <tr height="21">
                                            <td width="15%"><B>Severity </B></td>
                                            <td width="3%"><B></B></td>
                                            <td width="25%"><select name="severity">

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
                                                </select></td>
                                            <td width="15%"><B>Priority</B></td>
                                            <td width="3%"><B></B></td>
                                            <td width="25%"><select name="priority">
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
                                                </select></td>
                                            <td height="21" width="10%"><B>IssueStatus</B>
                                            <td height="21" width="3%"><B></B></td>
                                                    <%
                                                        String sql1 = "select status from issuestatus where issueid='" + theissu + "' ";
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

                                                        String issuestatus1 = "Unconfirmed";
                                                        String issuestatus2 = "Confirmed";
                                                        String issuestatus3 = "Investigation";
                                                        String issuestatus4 = "Workinprogress";
                                                        String issuestatus5 = "ReadytoBuild";
                                                        String issuestatus6 = "Verified";
                                                        String issuestatus7 = "Closed";
                                                        String issuestatus8 = "Reopen";
                                                        String issuestatus9 = "Duplicate";
                                                        String issuestatus10 = "Rejected";
                                                        String issuestatus11 = "Development";
                                                        String issuestatus12 = "QA";
                                                        String issuestatus13 = "Documentation";
                                                        String issuestatus = "";

                                                        /*				
                                                         String issuestatus1		= "Unconfirmed";
                                                         String issuestatus2		= "Confirmed";
                                                         String issuestatus3		= "Rejected";
                                                         String issuestatus4		= "Investigation";
                                                         String issuestatus5		= "Duplicate";
                                                         String issuestatus6 	        = "Info Required";
                                                         String issuestatus7		= "Workinprogress";
                                                         String issuestatus8		= "Fixed";
                                                         String issuestatus9		= "ReadytoBuild";
                                                         String issuestatus10		= "Verify";
                                                         String issuestatus11		= "Verification Passed";
                                                         String issuestatus12		= "Verification Failed";
				
				
                                                         String issuestatus13	= "Reopen";
                                                         String issuestatus14	= "Originator Verification";
                                                         String issuestatus15	= "Closed";
                                                         String issuestatus	= "";
				
                                                         */
                                                        int role = (Integer) session.getAttribute("Role");
                                                    %>
                                            <td align="left" width="25%"><SELECT NAME="issuestatus" size="1">
                                                    <%
                                                        if (issuestatus1.equals(sta)) {
                                                            issuestatus = issuestatus1;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus1;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus2.equals(sta)) {
                                                            issuestatus = issuestatus2;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus2;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus3.equals(sta)) {
                                                            issuestatus = issuestatus3;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus3;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus4.equals(sta)) {
                                                            issuestatus = issuestatus4;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus4;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }

                                                        if (issuestatus5.equals(sta)) {
                                                            issuestatus = issuestatus5;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus5;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus6.equals(sta)) {
                                                            issuestatus = issuestatus6;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus6;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }

                                                        if (role == 1) {

                                                            if (issuestatus7.equals(sta)) {
                                                                issuestatus = issuestatus7;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus7;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                            }
                                                        }
                                                        if (issuestatus8.equals(sta)) {
                                                            issuestatus = issuestatus8;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus8;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus9.equals(sta)) {
                                                            issuestatus = issuestatus9;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus9;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }

                                                        if (issuestatus10.equals(sta)) {
                                                            issuestatus = issuestatus10;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus10;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus11.equals(sta)) {
                                                            issuestatus = issuestatus11;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus11;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus12.equals(sta)) {
                                                            issuestatus = issuestatus12;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus12;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }
                                                        if (issuestatus13.equals(sta)) {
                                                            issuestatus = issuestatus13;
                                                    %>
                                                    <option value="<%=issuestatus%>" selected><%=issuestatus%></option>
                                                    <%
                                                    } else {
                                                        issuestatus = issuestatus13;
                                                    %>
                                                    <option value="<%=issuestatus%>"><%=issuestatus%></option>
                                                    <%
                                                        }

                                                    %>
                                                </SELECT></td>
                                        </tr>
                                        <tr height="21">
                                            <td width="15%"><B>DateCreated </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= dateString%></td>
                                            <td width="15%"><B>DateModified </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= dateString1%></td>
                                            <td width="15%"><B>CreatedBy </B></td>
                                            <td width="3%"><B></B></td>
                                            <td height="21" width="25%"><%= createdBy%></td>
                                        </tr>
                                        <tr height="21">
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
                                                if (rs4 != null) {
                                                    rs4.close();
                                                }
                                                if (pt4 != null) {
                                                    pt4.close();
                                                }
                                            %>
                                            <td height="21" width="10%"><B>AssignedTo</B></td>
                                            <td><B></B></td>
                                                    <%
                                                        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                        resultset1 = stmt1.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME  FROM USERS  where roleid>0 ORDER BY FIRSTNAME ASC ");
                                                    %>
                                            <td width="25%"><select name="assignedto" size="1">

                                                    <%
                                                        int assigned = 0;
                                                        if (resultset1 != null) {
                                                            while (resultset1.next()) {
                                                                int useridassi = resultset1.getInt("userid");
                                                                String firstname = resultset1.getString(2);
                                                                String lastname = resultset1.getString(3);
                                                                if (useridassi == assi) {
                                                                    assigned = useridassi;
                                                    %>
                                                    <option value="<%=assigned%>" selected><%=firstname%> <%=lastname%></option>
                                                    <%
                                                    } else {
                                                        assigned = useridassi;
                                                    %>
                                                    <option value="<%=assigned%>"><%=firstname%> <%=lastname%></option>
                                                    <%
                                                        }
                                                    %>
                                                    <%					}
                                                        }
                                                        if (resultset1 != null) {
                                                            resultset1.close();
                                                        }
                                                        if (stmt1 != null) {
                                                            stmt1.close();
                                                        }
                                                    %>
                                                </select></td>


                                            <td width="15%" colspan="2"><B>
                                                    Files Attached </B></td>


                                            <%
                                                int count1 = 1;
                                                String sql3 = "select fileid,filename from fileattach where issueid='" + theissu + "' ";
                                                pt2 = connection.prepareStatement(sql3);
                                                rs3 = pt2.executeQuery();
                                                if (rs3 != null) {
                                                    if (rs3.next()) {
                                                        count1++;
                                                        logger.debug("count1" + count1);
                                            %>
                                            <td width="8%" id="filesIssue"><A
                                                    onclick="viewFileAttachForIssue('<%=theissu%>');" href="#">ViewFiles</A></td>
                                                    <%					}
                                                        }
                                                        if (rs3 != null) {
                                                            rs3.close();
                                                        }
                                                        if (pt2 != null) {
                                                            pt2.close();
                                                        }
                                                        if (count1 == 1) {
                                                    %>
                                            <td width="8%" id="filesIssue"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                 size="1" color="#000000">No Files</font></td>
                                                    <%
                                                        }
                                                    %>

                                            <td width="15%"><B>Fix Version</B></td>
                                            <td><B></B></td>
                                                    <%
                                                        st5 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                        rs5 = st5.executeQuery("SELECT version FROM project WHERE pname='" + pro + "' order by version");//CHANGED
                                                        String modifiedVer = com.pack.StringUtil.convertToFloatString(ver);
                                                        String modifiedFix = com.pack.StringUtil.convertToFloatString(fix);
                                                        float found = Float.valueOf(modifiedVer).floatValue();
                                                        float fixVersion = Float.valueOf(modifiedFix).floatValue();
                                                        //		System.out.println("Fix Version");
                                                        rs5.last();
                                                        int cnt = rs5.getRow();
                                                        rs5.beforeFirst();

                                                        if (cnt == 1) {
                                                            logger.info("Inside Fix Version" + ver);
                                                    %>
                                            <td width="15%"><input type="text" name="fix_version"
                                                                   value="<%=fix%>" size="5"></td>
                                                <%
                                                } else {

                                                %>
                                            <td width="15%"><select name="fix_version" size="1">
                                                    <%                            if (rs5 != null) {
                                                            while (rs5.next()) {

                                                                String fix_ver = rs5.getString(1);
                                                                //            logger.info("Found Version"+ver+"Fix Version"+fix_ver);

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
                                                            if (rs5 != null) {
                                                                rs5.close();
                                                            }
                                                            if (st5 != null) {
                                                                st5.close();
                                                            }
                                                        }
                                                    %>

                                        </tr>
                                    </table>
                                    <table width="100%" border="0" bgcolor="E8EEF7" cellpadding="2">
                                        <tr height="21">
                                            <td width="12%"><b>Subject</b></td>
                                            <td width="100%" align="left"><B></B><%=sub%></td>
                                        </tr>

                                        <tr height="21">
                                            <td width="12%"><b>Description</b></td>
                                            <td width="100%" align="left"><B></B><%=des1%></td>
                                        </tr>

                                        <tr height="21">
                                            <td width="12%"><b>Root Cause</b></td>
                                            <td width="100%" align="left"><B></B><%=root_cau%></td>
                                        </tr>

                                        <tr height="21">
                                            <td width="12%"><b>Expected result</b></td>
                                            <td width="100%" align="left"><B></B><%=exp_res1%></td>
                                        </tr>
                                    </table>

                                    <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2">
                                        <tr>
                                            <td width="100%" class="textdisplay" align="center">
                                                <p class="textdisplay">Comments</p>

                                            </td>
                                        </tr>

                                        <tr>

                                            <td><input type=hidden name="customer" value="<%=cus%>" /></td>
                                            <td><input type=hidden name="project" value="<%=pro%>" /></td>
                                            <td><input type=hidden name="version" value="<%=ver%>" /></td>
                                            <td><input type="hidden" name="oldfixversion" value="<%=fix%>" /></td>
                                            <td><input type=hidden name="module" value="<%=mod%>" /></td>
                                            <td><input type=hidden name="platform" value="<%=pla%>" /></td>
                                            <td><input type=hidden name="type" value="<%=typ%>" /></td>
                                            <td><input type=hidden name="rootcause"
                                                       value="<%=StringUtil.encodeHtmlTag(root_cau)%>" /></td>
                                            <td><input type=hidden name="expected_result" value="<%=exp_res%>" /></td>
                                            <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                                            <td><input type="hidden" name="pri" value="<%=pri%>" /></td>
                                            <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                                            <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                                            <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                                            <td><input type="hidden" name="sub"
                                                       value="<%=StringUtil.encodeHtmlTag(sub)%>" /></td>
                                            <td><input type="hidden" name="des" value="<%=des%>" /></td>
                                            <td><input type="hidden" name="com1" value="<%=StringUtil.encodeHtmlTag(com1)%>" /></td>
                                            <td><input type="hidden" name="issu" value="<%=theissu%>" /></td>
                                        <tr bgcolor="#E8EEF7">
                                            <td width="23%" align="center"><font size="2"
                                                                                 face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                                        rows="3" cols="68" name="comments" maxlength="2000"
                                                        onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"
                                                        onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000)"></textarea></font>
                                            </td>
                                            <td align="center"><input readonly type="text" name="remLen1"
                                                                      size="3" maxlength="3" value="2000">Chars Left</td>
                                        </tr>
                                    </table>
                                    <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="2"
                                           align="center">
                                        <tr align="center">
                                            <TD>&nbsp;</TD>
                                            <TD><INPUT type=submit value=Update name=submit>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
                                                    type=reset value=" Reset "></TD>
                                        </tr>
                                    </table>
                                    <iframe
                                        src="<%= request.getContextPath()%>/comments.jsp?issueid=<%= session.getAttribute("theissu")%>"
                                        scrolling="auto" frameborder="2" height="20%" width="100%"></iframe></center>
                            </div>
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
                                if (connection != null && !connection.isClosed()) {
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
                        <div id="MDApopup" class="popup" style="height: 200px;">
                            <form id="file-mod-form" name="file-mod-form"  method="POST">
                                <h3 class="popupHeadinga">Upload document for <%= session.getAttribute("theissu")%></h3>
                                <div style="color:red;display: none;" id="mdaterrormsg"></div>
                                <div style="margin-bottom: 10px;">
                                    <table >
                                        <tr style="height:40px;">
                                            <td><label style="margin-left: 0px;">Choose File(s) to upload</label></td>
                                            <td >
                                                <label for="pswd"><input type="file" id="file-mod-select" name="photos[]" multiple/></label> 
                                            </td>
                                        </tr>
                                        <tr style="height:40px;">
                                            <td>
                                                <input type="hidden" name="issueId" id='issueId' value="<%= session.getAttribute("theissu")%>"/>
                                                <input type="button" id="mod-upload-button" value="Upload Document" onclick="javascript:createFileAttach();"/>
                                                <input type="button" id="mod-upload-cancel"value="Cancel" onclick="javascript:closeFileAttach();"/>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </BODY>
                </HTML>
