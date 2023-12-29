<%-- 
    Document   : issueForEveryOne
    Created on : 24 Jun, 2015, 4:45:48 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.issue.ApmComponentIssues"%>
<%@page import="com.eminent.issue.ApmComponentIssues"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%

    Logger logger = Logger.getLogger("View Issue Details");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        response.sendRedirect(request.getContextPath() + "/SessionExpired.jsp");
    }
%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>

    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <style type="text/css">
        TH {
            font-weight:  bold;
            font-size:  11px;
            background:#000099;
            color:  white;
            font-family:  Arial, Helvetica;
            text-align:  left;
        }
    </style>
    <script type="text/javascript" >
        $(document).ready(function () {

            $('.credit').hide();
        });
        function  openEdit() {
            $('.credit').show();
            $('.crnormal').hide();
        }
        function  openNormal() {
            $('.credit').hide();
            $('.crnormal').show();
        }
        function KillBrowser()
        {
            opener.focus();
            self.close();
        }
    </script>

</HEAD>
<BODY>
    <jsp:useBean id="aci" class="com.eminent.issue.controller.ApmComponentIssueController"/>
    <FORM METHOD=POST ACTION="Updateform2.jsp">
        <%@ page import="com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmIssuetestcases,com.eminent.tqm.IssueTestCaseUtil,org.apache.log4j.*,java.sql.*,pack.eminent.encryption.*,java.text.*,com.pack.*,com.eminent.util.*,java.util.*"%>
        <%@ page language="java"%>
        <%@page import="com.eminent.issue.IssueUtil" %>

        <div align="center">
            <center>
                <table align="center" width="100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 20px;">

                        <td width="145" align="left"><a
                                href="https://www.eminentlabs.net" target="_new"><img border="0" height="28"
                                                                                 alt="Eminentlabs Software Pvt. Ltd."
                                                                                 src="<%=request.getContextPath()%>/eminentech support files/Eminentlabs.png"></a></td>
                        <td align="right">
                            <img alt="Eminentlabs Software Pvt Ltd" height="25" src="<%= request.getContextPath()%>/eminentech support files/Eminentlabs_logo.gif">
                        </td>
                    </tr>
                </table>
                <%
                    String no = (String) request.getParameter("issueid");
                    session.setAttribute("theissu", no);
                %> <br>
                <table align="center" width="100%" bgcolor="C3D9FF">
                    <tr>
                        <td><b>Details of Issue Number <font color="#0000FF"><%= session.getAttribute("theissu")%></font></b></td>
                    </tr>
                </table>
                <br>
                <%
                    String mail = (String) session.getAttribute("theName");
                    HashMap<Integer, String> member = GetProjectMembers.showUsers();
                    String url = null;
                    int role = 0;
                    if (mail != null) {
                        url = mail.substring(mail.indexOf("@") + 1, mail.length());
                    }

                    Connection c = null;
                    Statement stmt = null, stmt1 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, state = null, state1 = null;
                    PreparedStatement ps = null, pt2 = null;
                    ResultSet rs = null, rs3 = null, result = null, result1 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs_comments = null, file_rs;
                    boolean flag = true;
                    String phase = null;
                    String subphase = null;
                    String subsubphase = null;
                    String subsubsubphase = null;
                    String projecttype = null;
                    String category = null;
                    // Selecting Test Cases for this issue
                    List testcaseobjects = IssueTestCaseUtil.viewIssueTestCase(no);
                    int noOfTestCases = testcaseobjects.size();
                    logger.info("No Of Test Cases" + noOfTestCases);
                    try {
                        c = MakeConnection.getConnection();
                        stmt = c.createStatement();
                        stmt1 = c.createStatement();
                        stmt3 = c.createStatement();
                        stmt4 = c.createStatement();
                        rs = stmt.executeQuery("SELECT CUSTOMER,PNAME AS PROJECT,PLATFORM,MODULE,found_version,SEVERITY,PRIORITY,TYPE,VERSION AS FIX_VERSION, due_date,rating,feedback,ESCALATION FROM ISSUE I, PROJECT P, MODULES M WHERE ISSUEID='" + no + "' AND I.PID = P.PID AND MODULEID = MODULE_ID");//CORRECT
                        if (rs != null) {
                            while (rs.next()) {
                                String cus = rs.getString("customer");
                                String pro = rs.getString("project");
                                String mod = rs.getString("module");
                                String plat = rs.getString("platform");
                                String ver = rs.getString("found_version");
                                String sev = rs.getString("severity");
                                String pri = rs.getString("priority");
                                String typ = rs.getString("type");
                                String fver = rs.getString("fix_version");
                                String rating = rs.getString("rating");
                                String feedback = rs.getString("feedback");
                                String escalation = rs.getString("ESCALATION");

                                SimpleDateFormat formatDate = new SimpleDateFormat("dd-MMM-yy");
                                String viewDueDate = "";
                                if (rs.getDate("due_date") == null) {
                                    viewDueDate = "";
                                } else {
                                    java.util.Date due = rs.getDate("due_date");
                                    viewDueDate = formatDate.format(due);
                                }

                                ResultSet rs1 = stmt1.executeQuery("select status from issuestatus where issueid='" + no + "' ");//correct
                                if (rs1 != null) {
                                    while (rs1.next()) {

                                        String iss = (String) rs1.getString("status");
                                        rs3 = stmt3.executeQuery("select createdby,createdon,modifiedon  from issue where issueid='" + no + "' ");//correct
                                        if (rs3 != null) {
                                            while (rs3.next()) {
                                                String f2 = "";
                                                String l2 = "";
                                                String full2 = "";
                                                String creby = (String) rs3.getString("createdby");
                                                state1 = c.createStatement();
                                                result1 = state1.executeQuery("SELECT firstname,lastname FROM users where userid=" + creby);//CORRECT
                                                if (result1.next()) {
                                                    f2 = result1.getString("firstname");
                                                    l2 = result1.getString("lastname");
                                                    full2 = f2 + " " + l2;
                                                }
                                                java.util.Date creon = rs3.getDate("createdon");
                                                SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMM yyyy");
                                                String dateString1 = sdf1.format(creon);
                                                java.util.Date mdion = rs3.getDate("modifiedon");
                                                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                                                String dateString = sdf.format(mdion);
                                                rs4 = stmt4.executeQuery("select SUBJECT,DESCRIPTION,ASSIGNEDTO,COMMENT1,rootcause,expected_result FROM ISSUE where issueid='" + no + "' ");//CORRECT
                                                String f1 = "";
                                                String l1 = "";
                                                String full = "";
                                                if (rs4 != null) {
                                                    while (rs4.next()) {
                                                        String sub = (String) rs4.getString("subject");
                                                        String des = (String) rs4.getString("description");
                                                        String root_cau = rs4.getString("rootcause");
                                                        String exp_res = rs4.getString("expected_result");
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
                                                        String assi = (String) rs4.getString("assignedto");
                                                        HashMap<String, String> userDetail = GetProjectMembers.getMembers(pro, fver, creby, assi);
                                                        String currentuser = ((Integer) session.getAttribute("userid_curr")).toString();
                                                        role = (Integer) session.getAttribute("Role");
                                                        if (!url.equals("eminentlabs.net")) {
                                                            flag = false;
                %>

                <table>
                    <tr align="center" ><td><font color="red">You are not authorised to access this issue.</font></td></tr>
                    <tr align="center" ><td><input type="button" name="Close" value="Close" onclick="self.close();" /></td></tr>
                </table>
                <p style="height: 250px;"></p>


                <%} else {
                    state = c.createStatement();
                    result = state.executeQuery("SELECT firstname,lastname FROM users where userid=" + assi);//CORRECT
                    if (result.next()) {
                        f1 = result.getString("firstname");
                        l1 = result.getString("lastname");
                        full = f1 + " " + l1;
                    }
                    String comm = (String) rs4.getString("comment1");
                    stmt5 = c.createStatement();
                    rs5 = stmt5.executeQuery("SELECT category from project where pname = '" + pro + "'");//CORRECT
                    if (rs5 != null) {
                        if (rs5.next()) {

                            category = rs5.getString(1);
                        }
                    }

                    if (category.equalsIgnoreCase("SAP Project")) {
                        stmt6 = c.createStatement();

                        rs6 = stmt6.executeQuery("SELECT type from project_type,project where project.pid=project_type.pid and project.pname='" + pro + "' and category='" + category + "'");//CORRECT
                        if (rs6 != null) {
                            if (rs6.next()) {

                                projecttype = rs6.getString(1);
                            }
                        }

                        stmt7 = c.createStatement();
                        String tablename = "issue_" + projecttype.toLowerCase();

                        rs7 = stmt7.executeQuery("SELECT phase,subphase,subsubphase,subsubsubphase from " + tablename + " where issueid='" + no + "'");//CORRECT
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
                <table width="100%" bgcolor="C3D9FF">
                    <tr height="21">
                        <td width="12%"><B>Customer </B></td>
                        <td width="20%"><B></B><%= cus%></td>
                        <td width="11%"><B>Product </B></td>
                        <td width="22%"><B></B><%= pro%></td>
                        <td width="8%"><B>Version </B></td>
                        <td width="8%"><%=ver%> </td>
                        <% if (fver != null) {
                        %>
                        <td width="10%"><B>Fix Version </B></td>
                        <td width="8%"><B></B><%=fver%></td>
                                <%
                                        }%>

                    </tr>
                    <tr height="21">
                        <td width="12%"><B>Platform </B></td>
                        <td width="20%"><B></B><%= plat%></td>
                        <td width="11%"><B>Module </B></td>
                        <td width="22%"><B></B><%= mod%></td>
                        <td width="8%"><B>Priority </B></td>
                        <td width="8%"><B></B><%= pri%></td>
                        <td width="8%"><B>Severity </B></td>
                        <td width="8%"><B></B><%= sev%></td>

                    </tr>
                    <tr height="21">
                        <td width="11%"><B>Created by </B></td>
                        <td width="20%"><B></B><%= full2%></td>
                        <td width="11%"><B>Files Attached </B></td>
                                <%
                                    int count1 = IssueUtil.getAttachedFile(no);
                                    if (count1 > 0) {

                                %>
                        <td width="22%">
                            <A onclick="viewFileAttachForIssue('<%=no%>');" href="#"
                               >ViewFiles(<%=count1%>)</A>
                        </td>
                        <%
                        } else {
                        %>
                        <td width="22%">
                            No Files
                        </td>
                        <%                    }

                        %>
                        <td width="8%"><B>IssueStatus</B></td>
                        <td width="8%"><B></B><%=iss%></td>
                        <td width="10%"><B>Type </B></td>
                        <td width="21%"><B></B><%=typ%></td>

                    </tr>
                    <tr height="21">
                        <td width="12%"><B>Assigned To</B></td>
                        <td width="20%"><%= full%></td>
                        <td width="10%"><B>DateCreated </B></td>
                        <td width="21%"><B></B><%= dateString1%></td>
                        <td width="8%"><B>DateModified </B></td>
                        <td width="10%"><B></B><%= dateString%></td>
                        <td width="10%"><B>Due Date </B></td>
                        <td width="21%"><B></B><%=viewDueDate%></td>
                    </tr>
                    <tr height="21">
                        <td width="12%"><b>Components</b></td>
                        <%   String sc = "", cs = "";
                            List<ApmComponentIssues> listc = aci.findByIssueId(no);
                            for (ApmComponentIssues listl : listc) {
                                cs = listl.getComponentId().getComponentName();
                                sc = sc + cs + ',';

                            }
                            if ((sc.length() > 2) && (sc.charAt(sc.length() - 1) == ',')) {
                                sc = sc.substring(0, (sc.length() - 1));
                            }
                        %>
                        <td  align="left"><b></b><%=sc%></td>
                            <td  width="12%"><B>Escalation</B></td>
                                                       
                                                      <td colspan="3"  width="30%">
                                                        <%if (escalation!=null && escalation.equalsIgnoreCase("yes")) {%>
                                                    
                                                    <input type="checkbox" name="escalation" checked="checked" value="yes" disabled="disabled"/>
                                                    <%} else {%>
                                                    <input type="checkbox" name="escalation" value="yes" disabled="disabled"/>
                                                    <%}%>
                                                    </td>
                    </tr> 
                    <%
                        String[][] crIdDetails = IssueDetails.getCRIDS(no);
                        if (crIdDetails.length == 0) {
                        } else {%>
                    <tr  style="font-weight: bold;" id="crrow" ><td>CR ID</td><td class="crnormal" onclick="openEdit();" style="cursor: pointer;color:  #3333cc;" title="Expand All">View CRID(<%=crIdDetails.length%>)</td><td  class="credit" colspan="2" onclick="openNormal();" title="Collapse All" style="cursor: pointer;">CR ID Description</td><td  class="credit" >Created On</td><td  class="credit" >Status</td><td  class="credit" >Created By</td></tr>
                    <%

                        for (int i = 0; i < crIdDetails.length; i++) {
                            if (crIdDetails[i][0] != null) {
                                String key = crIdDetails[i][0].trim();
                                String desc = crIdDetails[i][1].trim();
                                String createdBy = crIdDetails[i][3].trim();
                                String createdOn = crIdDetails[i][4].trim();
                                String crstatus = crIdDetails[i][5].trim();

                                if (i % 2 == 0) {%>
                    <tr class="credit"  style="background-color:#FFFFFF;"  >  
                        <%} else {%>
                    <tr class="credit" style="background-color:#E8EEF7" >
                        <%}%>

                        <td ><%=key%></td>
                        <td  colspan="2"><%=desc%></td>
                        <td ><%=createdOn%></td>
                        <td ><%=crstatus%></td>
                        <td >
                            <%if (!createdBy.equalsIgnoreCase("Nil")) {%>
                            <%=member.get(Integer.valueOf(createdBy))%>
                            <%} else {%>
                            Nil
                            <% }%></td>
                    </tr>

                    <% }
                            }
                        }
                        if (category.equalsIgnoreCase("SAP Project")) {
                    %>

                    <%
                        if (phase != null) {
                    %>

                    <tr height="21">
                        <td width="12%"><b>Phase</b></td>
                        <td colspan="5" align="left"><B></B><%=phase%></td>
                    </tr>
                    <%
                        }
                        if (subphase != null) {
                    %>
                    <tr height="21">
                        <td width="12%"><b>Sub Phase</b></td>
                        <td colspan="5" align="left"><B></B><%=subphase%></td>
                    </tr>
                    <%
                        }
                        if (subsubphase != null) {
                    %>
                    <tr height="21">
                        <td width="12%"><b>Sub Sub Phase</b></td>
                        <td colspan="5" align="left"><B></B><%=subsubphase%></td>
                    </tr>
                    <%
                        }
                        if (subsubsubphase != null) {
                    %>
                    <tr height="21">
                        <td width="12%"><b>Sub Sub Sub Phase</b></td>
                        <td colspan="5" align="left"><B></B><%=subsubsubphase%></td>
                    </tr>
                    <%
                        }
                    %>

                    <%
                        }
                    %>
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
                    <%
                        if (rating != null) {
                    %>
                    <tr height="21">
                        <td width="12%"><b>Rating</b></td>
                        <td colspan="5" align="left"><B></B><%=rating%></td>
                    </tr>
                    <%
                        }
                        if (feedback != null) {
                    %>
                    <tr height="21">
                        <td width="12%"><b>Feedback</b></td>
                        <td colspan="5" align="left"><B></B><%=feedback%></td>
                    </tr>
                    <%
                        }
                    %>
                    <%
                        try {

                    %>
                    <tr><td colspan="6">
                            <table style="border-collapse: collapse;border: 1px #000;">
                                <tbody>
                                    <%                                                                                      logger.info("Status  -->" + iss);
                                        logger.info("Category -->" + category);
                                        int status = TestCasePlan.selectStatusId(iss, category);
                                        logger.info("Status Id -->" + status);
                                        boolean show = false;
                                        if (category.equalsIgnoreCase("SAP Project")) {
                                            if (status >= 13) {
                                                show = true;
                                            }
                                        } else {
                                            if (status >= 12) {
                                                show = true;
                                            }
                                        }

                                        if (noOfTestCases > 0) {
                                            if (show) {
                                    %>
                                    <tr bgcolor="#C3D9FF" width="80%">
                                        <td width="20%"><b>Functionality</b></td>
                                        <td width="22%"><b>Description</b></td>
                                        <td width="20%"><b>Expected Result</b></td>
                                        <td width="10%"><b>Status</b></td>
                                    </tr>
                                    <%    } else {
                                    %>

                                    <tr bgcolor="#C3D9FF" width="80%">
                                        <td width="8%"><b>TestCaseId</b></td>
                                        <td width="20%"><b>Functionality</b></td>
                                        <td width="22%"><b>Description</b></td>
                                        <td width="20%"><b>Expected Result</b></td>
                                        <td width="10%"><b>Createdby</b></td>
                                    </tr>
                                    <%        }
                                        int k = 1;
                                        TqmIssuetestcases testcases;
                                        String ptcid = null, func = null, desc = null, reslt = null, project = null, created = null;
                                        String link = null, tcStatus = null;
                                        int statusid = 1;
                                        String[] testCaseStatus = {"Yet to Test", "Not Applicable", "Not Run", "Failed", "Passed"};
                                        if (show) {
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
                                            String func1 = null, fun_substr = null;
                                            int funclen = func.length();
                                            index = 0;
                                            if (funclen >= 30) {
                                                logger.info("Start" + func);
                                                func1 = func.substring(index, index + 30);
                                                funclen = funclen - 30;
                                                while ((funclen / 30) >= 1) {
                                                    func1 = func1.concat(nextline);
                                                    index = index + 30;
                                                    fun_substr = func.substring(index, index + 30);
                                                    func1 = func1.concat(fun_substr);
                                                    funclen = funclen - 30;
                                                    logger.info("Start" + func1);
                                                }
                                                index = index + 30;
                                                func1 = func1.concat(nextline);
                                                func1 = func1.concat(func.substring(index));
                                            } else {
                                                func1 = func.substring(index);
                                                logger.info("Else" + func1);
                                            }
                                            logger.info("test case" + func1);
                                            index = 0;
                                            String desc1 = null, desc_substr = null;
                                            int desclen = desc.length();
                                            if (desclen >= 30) {
                                                desc1 = desc.substring(index, index + 30);
                                                desclen = desclen - 30;
                                                while ((desclen / 30) >= 1) {
                                                    desc1 = desc1.concat(nextline);
                                                    index = index + 30;
                                                    desc_substr = desc.substring(index, index + 30);
                                                    desc1 = desc1.concat(desc_substr);
                                                    desclen = desclen - 30;
                                                }
                                                index = index + 30;
                                                desc1 = desc1.concat(nextline);
                                                desc1 = desc1.concat(desc.substring(index));
                                            } else {
                                                desc1 = desc.substring(index);
                                            }
                                            String reslt1 = null, reslt_substr = null;
                                            int resltlen = reslt.length();
                                            index = 0;
                                            if (resltlen >= 30) {
                                                reslt1 = reslt.substring(index, index + 30);
                                                resltlen = resltlen - 30;
                                                while ((resltlen / 30) >= 1) {
                                                    reslt1 = reslt1.concat(nextline);
                                                    index = index + 30;
                                                    reslt_substr = reslt.substring(index, index + 30);
                                                    reslt1 = reslt1.concat(reslt_substr);
                                                    resltlen = resltlen - 30;
                                                }
                                                index = index + 30;
                                                reslt1 = reslt1.concat(nextline);
                                                reslt1 = reslt1.concat(reslt.substring(index));
                                            } else {
                                                reslt1 = reslt.substring(index);
                                            }


                                    %>
                                    <%                                                                                      if ((k % 2) != 0) {
                                    %>
                                    <tr bgcolor="white" height="22">
                                        <%                } else {
                                        %>

                                    <tr bgcolor="#E8EEF7" height="22">
                                        <%                    }
                                            if (show) {
                                                //                   logger.info("In TCE Status");
                                        %>
                                        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>" width="30%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(func1)%></p></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>" width="40%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(desc1)%></p></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>" width="30%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(reslt1)%></p></td>
                                        <td>

                                            <%=tcStatus%>
                                            <input type="hidden" name="ptcid" id="ptcid" value="<%=ptcid%>"/>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td><%=ptcid%></td>

                                        <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>" width="30%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(func1)%></p></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>" width="40%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(desc1)%></p></td>
                                        <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>" width="30%"><p style="word-wrap:break-word;"><%=StringUtil.encodeHtmlTag(reslt1)%></p></td>
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

                </table>

                <table width="100%" bgcolor="C3D9FF">
                    <tr>
                        <td><input type="hidden" name="customer" value="<%=cus%>" /></td>
                        <td><input type="hidden" name="project" value="<%=pro%>" /></td>
                        <td><input type="hidden" name="version" value="<%=ver%>" /></td>
                        <td><input type=hidden name="module" value="<%=mod%>" /></td>
                        <td><input type="hidden" name="type" value="<%=typ%>" /></td>
                        <td><input type="hidden" name="sev" value="<%=sev%>" /></td>
                        <td><input type="hidden" name="pri" value="<%=pri%>" /></td>
                        <td><input type="hidden" name="creby" value="<%=creby%>" /></td>
                        <td><input type="hidden" name="creon" value="<%=dateString%>" /></td>
                        <td><input type="hidden" name="modon" value="<%= dateString1%>" /></td>
                        <td><input type="hidden" name="sub" value="<%=sub%>" /></td>

                    </tr>
                </table>


                <%
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    if (flag == true) {
                        if (!url.equals("continental-corporation.com")) {

                            ps = c.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,status,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate,priority,severity from issuecomments where issueid=? order by comment_date asc");
                            ps.setString(1, no);
                            rs_comments = ps.executeQuery();

                            if (rs_comments != null) {

                                rs_comments.next();
                %>
                <table width="100%" class="bordertable" style="border-collapse:collapse;">
                    <tr>
                        <th class="bordertable" align="center" >Commented By</th>
                        <th class="bordertable" align="center" >TimeStamp</th>
                        <th class="bordertable" align="center" style="width: 35%;">Comments History</th>
                        <th class="bordertable" align="center">S</th>
                        <th class="bordertable" align="center">P</th>
                        <th class="bordertable" align="center">Status</th>
                        <th class="bordertable" align="center">Commented To</th>
                        <th class="bordertable" align="center">Due Date</th>
                    </tr>
                    <%
                        do {
                            String priority = rs_comments.getString("priority");
                            String severity = rs_comments.getString("severity");

                            if (priority != null) {
                                priority = priority.substring(0, priority.indexOf("-"));
                            } else {
                                priority = "NA";
                            }
                            if (severity != null) {
                                severity = severity.substring(0, severity.indexOf("-"));
                            } else {
                                severity = "NA";
                            }
                            String commentedby = GetProjectMembers.getUserName(rs_comments.getString("commentedby"));
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = rs_comments.getString("commentedto");
                            if (!commentedto.equals("Nil")) {
                                commentedto = GetProjectMembers.getUserName(rs_comments.getString("commentedto"));
                                commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                            }
                            String duedate = rs_comments.getString("duedate");
                            if (duedate == null) {
                                duedate = "NA";
                            }%>

                    <tr style="height: 21px; ">

                        <td class="bordertable" align="left" width="10%"><%=commentedby%></td>
                        <td class="bordertable" align="left" width="13%"><%= rs_comments.getString("commentdate")%><%=" "%><%= rs_comments.getTime("comment_date")%></td>
                        <td class="bordertable" align="justify" width="21%"><%= rs_comments.getString(4)%></td>
                        <td class="bordertable" align="justify" width="2%"><%=severity%></td>
                        <td class="bordertable" align="justify" width="2%"><%=priority%></td>
                        <td class="bordertable" align="left" width="9%"><%= rs_comments.getString(5)%></td>
                        <td class="bordertable" align="left" width="10%"><%= commentedto%></td>
                        <td class="bordertable" align="left" width="8%"><%= duedate%></td>
                    </tr>

                    <%
                        } while (rs_comments.next());
                    %>
                    <tr align="right" >
                        <td colspan="3" style="border: 0px "><input type="button" name="print" value="Print"
                                                                    onclick="javascript:window.print();" /><input type="button"
                                                                    name="Close" value="Close" onclick="javascript:KillBrowser();" /></td>
                    </tr>
                </table>
                <%
                                    }
                                }
                            }
                        }
                    } catch (Exception e) {

                        logger.error(e.getMessage());

                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (rs3 != null) {
                            rs3.close();
                        }
                        if (result != null) {
                            result.close();
                        }
                        if (result1 != null) {
                            result1.close();
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
                        if (rs7 != null) {
                            rs7.close();
                        }
                        if (rs_comments != null) {
                            rs_comments.close();
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
                        if (stmt3 != null) {
                            stmt3.close();
                        }
                        if (stmt4 != null) {
                            stmt4.close();
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
                        if (state != null) {
                            state.close();
                        }
                        if (state1 != null) {
                            state1.close();
                        }
                        if (c != null) {
                            c.close();
                        }
                    }
                %>
                <br>
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
            </center>
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
</BODY>
<script type="text/javascript">
    $("#cke_pastebin").removeAttr("style");
</script>
</HTML>

