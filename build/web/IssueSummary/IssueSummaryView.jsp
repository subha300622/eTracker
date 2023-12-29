<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminent.tags.Tags"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.controller.ViewMomController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.eminentlabs.mom.IssuesTask"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.tags.TagController"%>
<!DOCTYPE html>
<html>
    <%
        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
    <%@ include file="../header.jsp"%>
    <%
        response.setHeader("session.cache_limiter", "private");
    %>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
    <meta name="ProgId" content="FrontPage.Editor.Document">
    <meta http-equiv="Content-Language" content="en-us">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=030420190954" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter2.js?test=10" type="text/javascript"></script>

    <LINK title=STYLE href="<%= request.getContextPath()%>/multiple-select.css" type="text/css" rel="STYLESHEET">

    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
        .error2{
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }

        var form = 'search' //form name

        function SetChecked(val, chkName)
        {
            dml = document.forms[form];
            len = dml.elements.length;
            var i = 0;
            for (i = 0; i < len; i++)
            {
                if (dml.elements[i].name == chkName)
                {
                    dml.elements[i].checked = val;
                }
            }
        }

    </script>

</head>
<body bgcolor="#FFFFFF">
    <jsp:useBean id="tagc" class="com.eminent.tags.TagController"/>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.text.*"%>
    <%@ page import="java.sql.Date,pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate,com.pack.UpdateIssueBean"%>
    <%@ page import="org.apache.log4j.*, com.pack.StringUtil"%>
    <%@ page import="java.util.HashMap,java.text.SimpleDateFormat"%>
    <%
        String team = (String) session.getAttribute("team");

        String issueHistory = (String) session.getAttribute("issueHistory");
        String issueRating = (String) session.getAttribute("issueRating");
        if (issueHistory == null || issueHistory.isEmpty() || issueHistory.equalsIgnoreCase("")) {
            issueHistory = "no";
        }
        EscalationDAO escalationDAO = new EscalationDAOImpl();
        List<String> escalationIssues = escalationDAO.AllEscalations(0);
        String escColor = "#000000";
        String mail = (String) session.getAttribute("theName");
        String url = null;
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
    %>
    <%@ page language="java"%>
    <div align="center">
        <center>
            <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#C3D9FF">
                <tr border="2">
                    <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>
                            APM Issues Search Result </b></font> <FONT SIZE="3" COLOR="#0000FF"></FONT></td>

                    <% if (issueHistory.equalsIgnoreCase("no")) {%>
                    <td style="float: right;margin-right: 10px;min-width: 200px;">
                        <div>
                            <label><B>Select Tags :</B></label>
                            <span class="selectTag">
                                <select  name="tagnames" id="tagnames" >
                                    <option value="" selected="">Select</option>
                                    <%
                                        tagc.getAllTagsByUser(request);
                                        if (tagc.getTagList() == null || tagc.getTagList().isEmpty()) {
                                        } else {
                                            for (Tags tag : tagc.getTagList()) {

                                    %>
                                    <option value="<%=tag.getTagId()%>" ><%=tag.getTagName()%></option>
                                    <%
                                            }
                                        }

                                    %> 
                                </select> </span>
                            <span style="color: blue;font-weight: bold;cursor: pointer;position: " onclick="addTag();">AddTag</span>
                        </div>
                    </td><%}%>
                    <td border="1" align="right" style="width: 10%;"><font size="2"
                                                                           face="Verdana, Arial, Helvetica, sans-serif">Export to <a href="javascript:void(0)" onclick="ExportToExcel()" >Excel</a></font></td>


                </tr>
            </table>


            <%!
                int rowcount, age;
                int userid_curri, absolte;
                HashMap hm;
                List<String> allissueNo = new ArrayList<String>();
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       %>
            <jsp:useBean id="MyIssue" class="com.pack.UpdateIssueBean"></jsp:useBean>
            <form id='search' method="post" action="<%=request.getContextPath()%>/IssueSummary/IssueSummarySave.jsp">

                <%
                    String query1 = null;
                    query1 = (String) session.getAttribute("IssueSummaryQuery");

                    String query_name = (String) session.getAttribute("query_name");
                    String buttonvalue = "Save My Search";
                    if (query_name != null) {
                        buttonvalue = "Update My Search";
                    }

                    HashMap<Integer, String> member = GetProjectMembers.showUsersSName();

                    if (issueHistory.equalsIgnoreCase("yes")) {
                        Map<Integer, String> esplusers = GetProjectMembers.getAllEminentMembers();
                        Map<String, List<IssueHistory>> issuesHistoryMap = IssueDetails.checkIssueHistory(query1, member);

                        if (issuesHistoryMap.size() > 0) {
                %>


                <span style="float: left"> This list shows <b>1 </b>-<b> <%=issuesHistoryMap.size()%>  </b> of <b><%=issuesHistoryMap.size()%> </b>  issues  history search by you .</span>
                <%} else {%>
                <span style="float: left"> No issues  history search by you .</span>

                <%}%>
                <br/> <TABLE  id="searchTable" class="tablesorter" style="border: 1px solid #C3D9FF;border-collapse: collapse; float: left;min-width: 1024px;">
                    <% int maxlenght = 1;
                        for (Map.Entry<String, List<IssueHistory>> entrySet : issuesHistoryMap.entrySet()) {
                            if (entrySet.getValue().size() > maxlenght) {
                                maxlenght = entrySet.getValue().size();
                            }
                        }%>

                    <tr>
                        <th style="border: 1px solid #C3D9FF;color: #191910;font-size: 13px;text-align: center">Issue No</th>
                        <th colspan="<%=maxlenght%>" style="border: 1px solid #C3D9FF;color: #191910;font-size: 13px;">Day History</th>
                    </tr>
                    <%   for (Map.Entry<String, List<IssueHistory>> entrySet : issuesHistoryMap.entrySet()) {
                            int j = 0;
                            for (IssueHistory ish : entrySet.getValue()) {
                                if (j > 0) {%>
                    <%}%>

                    <%j++;
                        }%>

                    <tr>
                        <td rowspan="2" style="border:2px solid #C3D9FF;">
                            <A HREF="javascript:showPrint('<%=entrySet.getKey()%>')">
                                <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                                      color="#0033FF"> <%=entrySet.getKey()%> </font></A></td>
                        <td style="border: 1px solid #C3D9FF;width: 150px;">With ESPL</td>
                        <td style="border: 1px solid #C3D9FF;width: 150px;">With Customer</td>
                        <td style="border: 1px solid #C3D9FF;width: 150px;">Total Age</td>

                        <%int i = 0, tot = 0, espl = 0, customer = 0;
                            for (IssueHistory ish : entrySet.getValue()) {
                                if (ish.getDays() > 0) {
                                    tot = tot + ish.getDays();%>
                        <%if (esplusers.containsKey(ish.getUserId())) {
                                espl = espl + ish.getDays();%>
                        <%} else {
                            customer = customer + ish.getDays();%>
                        <%}%>
                        <td style="border: 1px solid #C3D9FF;width: 150px;"><%=ish.getUserName()%></td>
                        <%}%>

                        <%i++;
                            }%>

                    </tr>
                    <tr style="height: 21px;" > 
                        <td style="border: 1px solid #C3D9FF; min-width: 130px;">


                            <span style="font-weight: bold;font-size: 13px;text-align: center;"><%=espl%></span>
                        </td>
                        <td style="border: 1px solid #C3D9FF; min-width: 130px;">


                            <span style="font-weight: bold;font-size: 13px;text-align: center;"><%=customer%></span>
                        </td>
                        <td style="border: 1px solid #C3D9FF; min-width: 130px;">


                            <span style="font-weight: bold;font-size: 13px;text-align: center;"><%=tot%></span>
                        </td>
                        <%
                            for (IssueHistory ish : entrySet.getValue()) {%>
                        <%if (ish.getDays() > 0) {%>
                        <td style="border: 1px solid #C3D9FF; min-width: 130px;">


                            <span style="font-weight: bold;font-size: 13px;"><%=ish.getDays()%></span>
                        </td>
                        <%}%>
                        <%
                            }%>

                    </tr>

                    <%  }    %>  
                </table>

                <%    } else {
                %>


                <%                    Integer userId = (Integer) session.getAttribute("userid_curr");
                    session.setAttribute("forwardpage", "/IssueSummary/IssueSummaryView.jsp");

                    Logger logger = Logger.getLogger("IssueSummaryView");
                    List<String> wrmIssues = new ArrayList<String>();
                    DateFormat sdfa = new SimpleDateFormat("dd-MMM-yyyy");
                    String momDate = sdfa.format(new java.util.Date());
                    wrmIssues = ViewMomController.momTotalWrmIssues(momDate);
                    Connection connection = null;
                    Statement stmt1 = null;
                    ResultSet rs1 = null;
                    String s1 = "S1- Fatal";
                    String s2 = "S2- Critical";
                    String s3 = "S3- Important";
                    String s4 = "S4- Minor";

                    try {

                        connection = MakeConnection.getConnection();

                        absolte = 0;
                        logger.info("Generated Query" + query1);
                        stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs1 = stmt1.executeQuery(query1);//PARTIAL CHANGED
                        rs1.last();
                        int rowcount = rs1.getRow();

                        if (issueRating == null || issueRating.isEmpty() || issueRating.equalsIgnoreCase("") || issueRating.equalsIgnoreCase("no")) {


                %>

                <table width="100%">
                    <tr height="10">
                        <td align="left" width="30%"></td>
                        <td width="30%">
                            <div><input type="button" id="agreedIssues" value="Agreed Issue"><span id="errormsg"></span></div>

                        </td>
                        <td width="30%">
                            <div><input type="button" id="addIssueToTag" value="Add Issue In Tag"><span id="errormsg"></span></div>

                        </td>

                        <td colspan="6" align="right"><a
                                href="javascript:SetChecked(1,'notchecked')"><font
                                    face="Arial, Helvetica, sans-serif" size="2">Select All</font></a>&nbsp;&nbsp;<a
                                href="javascript:SetChecked(0,'notchecked')"><font
                                    face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
                        <td align="right" width="25">Severity</td>
                        <TD align="right" width="25" bgcolor="#FF0000">S1</TD>
                        <TD align="right" width="25" bgcolor="#DF7401">S2</TD>
                        <TD align="right" width="25" bgcolor="#F7FE2E">S3</TD>
                        <TD align="right" width="25" bgcolor="#04B45F">S4</TD>
                    </tr>
                </table>
                <table width="100%">

                    <tr height="10">

                        <td class="pager" width="65%">
                            <span class="pagedisplay">Total no of Issues <b><%=rowcount%></b> searched by you</span>
                        </td>
                        <td width="35%">
                            <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                </nav> 
                                <nav class="right"> <span class="prev"> <img
                                            src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                        class="pagecount"></span> &nbsp;<span class="next">Next <img
                                            src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>

                        </td>
                    </tr>
                </table>
                <br>
                <TABLE width="100%" id="searchTable" class="tablesorter">
                    <thead>

                        <TR bgcolor="#C3D9FF" height="21">
                            <TH width="1%" TITLE="Severity" class="header"><font><b>S</b></font></TH>
                            <TH width="10%" class="header"><font><b>Issue No</b></font></TH>
                            <TH width="2%" class="header" TITLE="Priority"><font><b>P</b></font></TH>
                            <TH width="10%" class="header"><font><b>Project</b></font></TH>
                            <TH width="7%" class="header"><font><b>Module</b></font></TH>
                            <TH width="29%" class="header"><font><b>Subject</b></font></TH>
                            <TH width="10" class="header"><font><b>Status</b></font></TH>
                            <TH width="7%" class="header"><font><b>Due Date</b></font></TH>
                            <TH width="10%" class="header"><font><b>AssignedTo</b></font></TH>
                            <TH width="8%" class="header"><font><b>Refer</b></font></TH>
                            <TH width="3%" class="header sorter-digit" TITLE="In Days" ALIGN="CENTER" ><b>Age</b></TH>
                        </TR>
                    </thead>
                    <%         String projects = "";
                        rs1.beforeFirst();
                        if (rs1 != null) {
                            String totalissuenos = "";
                            while (rs1.next()) {
                                totalissuenos = totalissuenos + "'" + rs1.getString("issueid").trim() + "',";
                            }
                            Map<String, Integer> lastAsigneeAgeList = new HashMap();
                            Map<String, Integer> fileCountList = new HashMap();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            }

                            if (absolte != 0) {
                                rs1.absolute(absolte);
                            } else {
                                rs1.beforeFirst();
                            }
                            int i = 0;
                            while (rs1.next()) {
                                i++;
                                escColor = "#000000";
                                String issueid = rs1.getString("issueid");
                                session.setAttribute("theissno", issueid);
                                String project = rs1.getString("project");
                                if (!projects.contains(project)) {
                                    projects += project;
                                }
                                if (escalationIssues.contains(issueid) && url.equals("eminentlabs.net")) {
                                    escColor = "red";
                                }
                                String module = rs1.getString("module");
                                String severity1 = rs1.getString("severity");
                                String assignedto1 = rs1.getString("assignedto");
                                String assignedto2 = "";
                                if (assignedto1 != null) {
                                    assignedto2 = member.get(Integer.valueOf(assignedto1));
                                }
                                String type = rs1.getString("type");
                                String status = rs1.getString("status");
                                String priority = rs1.getString("priority");
                                int typ = rs1.getInt("createdby");
                                String rating = rs1.getString("rating");
                                String feedback = rs1.getString("feedback");
                                String createdBy = (String) member.get(new Integer(typ));
                                String p = "NA";
                                if (priority != null) {
                                    p = priority.substring(0, 2);
                                }
                                String fullModule = module;
                                if (module.length() > 10) {
                                    module = module.substring(0, 10) + "...";
                                }
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                Date dueDateFormat = rs1.getDate("due_date");
                                String dueDate = "NA";
                                if (dueDateFormat != null) {
                                    dueDate = sdf.format(dueDateFormat);
                                }

                                Date created = rs1.getDate("createdon");
                                String createdon = "NA";
                                if (created != null) {
                                    createdon = sdf.format(created);
                                }

                                Date modifiedon1 = rs1.getDate("modifiedon");

                                String dateString1 = sdf.format(modifiedon1);

                                age = GetAge.getIssueAge(createdon, status, dateString1);
                                int lastAsigneeAge = 1;
                                if (lastAsigneeAgeList.containsKey(issueid)) {

                                    lastAsigneeAge = lastAsigneeAgeList.get(issueid);
                                }
                                if (lastAsigneeAge == 1) {
                                    lastAsigneeAge = age;
                                }
                                if (lastAsigneeAge == 0) {
                                    lastAsigneeAge = lastAsigneeAge + 1;
                                }
                                String type1 = rs1.getString("type");
                                String status1 = rs1.getString("status");

                                String subject1 = rs1.getString("subject");
                                if (subject1.length() > 42) {
                                    subject1 = subject1.substring(0, 42) + "...";
                                }
                                String desc = rs1.getString("description");
                    %>

                    <%
                        if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="22">
                        <%
                        } else {
                        %>
                    <tr class="zebraline" height="22">
                        <%
                            }
                        %>

                        <% if (severity1.equals(s1)) {%>
                        <td width="1%" bgcolor="#FF0000"></td>
                        <%} else if (severity1.equals(s2)) {%>
                        <td width="1%" bgcolor="#DF7401"></td>
                        <%} else if (severity1.equals(s3)) {%>
                        <td width="1%" bgcolor="#F7FE2E"></td>
                        <%} else if (severity1.equals(s4)) {%>
                        <td width="1%" bgcolor="#04B45F"></td>
                        <%}%>
                    <input type="hidden" name="projects" id="projects" value="<%=projects%>"/>

                    <input type="hidden" id="sorton" name="sorton"/>
                    <input type="hidden" id="sort_method" name="sort_method"/>
                    <td width="10%" TITLE="<%= type%>"><input type="checkbox" name="check[]" class="checkIssue"  value="<%=issueid%>" id="notchecked" />

                        <%-- <A HREF="<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=issueid%>">--%><a href="javascript:callissue('<%=issueid%>')" style="visibility: visible"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF">
                            <%=issueid%><%if (wrmIssues.contains(issueid)) {
                            %><img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/> 
                            <%}%></font></A></td>
                    <td width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                         size="1" color="#000000"><%= p%></font></td>

                    <td width="12%" class="proj"><font  face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project%></font></td>
                    <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                    <td style="color: <%=escColor%>" id="<%=issueid%>tab" onmouseover="xstooltip_show('<%=issueid%>', '<%=issueid%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueid%>');" ><%= subject1%>
                        <div class="issuetooltip" id="<%=issueid%>"><%= desc%></div>
                    </td>
                    <%
                        String color = "";

                        if (status1.equalsIgnoreCase("Closed")) {
                            if (rating != null) {
                                if (rating.equalsIgnoreCase("Excellent")) {
                                    color = "#336600";

                                } else if (rating.equalsIgnoreCase("Good")) {
                                    color = "#33CC66";

                                } else if (rating.equalsIgnoreCase("Average")) {
                                    color = "#CC9900";

                                } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                    color = "#CC0000";

                                }
                            }

                        }
                        if (feedback == null) {
                            feedback = "";
                        }
                    %>
                    <td width="10%" bgcolor="<%=color%>" title="<%=feedback%>" onclick="showPrint('<%=issueid%>');" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= status1%></font></td>


                    <%
                        if ((status1 != null) && (!status1.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && CheckDate.getFlag(dueDate) == true) {
                    %><td width="7%" title="Last Modified On <%= dateString1%>">
                        <font face="Verdana, Arial, Helvetica, sans-serif"
                              size="1" color="RED"><%= dueDate%></font></td>
                        <%
                        } else if ((status1.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                        %>
                    <td width="7%" title="Last Modified On <%= dateString1%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                    </td>
                    <%
                    } else {
                    %>
                    <td width="9%" title="Last Modified On <%= dateString1%>">
                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1"
                              color="#000000"><%= dueDate%></font>
                    </td>
                    <%
                        }
                    %>
                    <td width="10%" title="Created By <%= createdBy%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= assignedto2%></font></td>
                        <%
                            int count1 = 0;
                            if (fileCountList.containsKey(issueid)) {
                                count1 = fileCountList.get(issueid);
                            }

                            if (count1 > 0) {
                        %>
                    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=issueid%>');" href="#">ViewFiles(<%=count1%>)</A></font></td>
                            <%
                            } else {
                            %>
                    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                        <%
                            }
                        %>
                    <td width="3%" align="center" title="<%=lastAsigneeAge%>"><%=age%></td>
                    </tr>

                    <%

                        }
                    %>

                    <%
                    %>
                    <tfoot>
                        <tr>
                            <td colspan="10">
                                <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                    </nav> 
                                    <nav class="right"> <span class="prev"> <img
                                                src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                            class="pagecount"></span> &nbsp;<span class="next">Next <img
                                                src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                            </td>
                        </tr>
                    </tfoot>
                </table>

                <%                            }

                } else {
                %>
                <table width="100%">
                    <tr height="10">
                        <td class="pager" width="65%">
                            <span class="pagedisplay">Total no of Issues <b><%=rowcount%></b> searched by you</span>
                        </td>
                        <td width="35%">
                            <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                </nav> 
                                <nav class="right"> <span class="prev"> <img
                                            src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                        class="pagecount"></span> &nbsp;<span class="next">Next <img
                                            src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                        </td>
                    </tr>
                </table>
                <br>
                <TABLE width="100%" id="searchTable" class="tablesorter">
                    <thead>
                        <TR bgcolor="#C3D9FF" height="21">
                            <TH width="10%" class="header"><font><b>Issue #</b></font></TH>
                            <TH width="10%" class="header"><font><b>Type</b></font></TH>
                            <TH width="10%" TITLE="Severity" class="header"><font><b>Severity</b></font></TH>
                            <TH width="10%" class="header" TITLE="Priority"><font><b>Priority</b></font></TH>
                            <TH width="10%" class="header"><font><b>Rating</b></font></TH>
                            <TH width="15%" class="header"><font><b>Customer</b></font></TH>
                            <TH width="15%" class="header"><font><b>Created By</b></font></TH>
                            <TH width="10" class="header"><font><b>Created On</b></font></TH>
                            <TH width="10%" class="header"><font><b>Modified On</b></font></TH>
                        </TR>
                    </thead>
                    <%
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                        rs1.beforeFirst();
                        if (rs1 != null) {
                            int i = 0;
                            while (rs1.next()) {
                                i++;
                                Date created = rs1.getDate("createdon");
                                String createdon = "NA";
                                if (created != null) {
                                    createdon = sdf.format(created);
                                }
                                if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="22">
                        <%
                        } else {
                        %>
                    <tr class="zebraline" height="22">
                        <%
                            }
                        %>
                        <td width="10%"> <a href="javascript:callissue('<%=rs1.getString("issueid")%>')" style="visibility: visible"><font  face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF">
                                <%=rs1.getString("issueid")%></font></a></td>
                        <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= rs1.getString("type")%></font></td>
                            <% if (rs1.getString("severity").equals(s1)) {%>
                        <td width="10%" bgcolor="#FF0000"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=rs1.getString("severity")%></font></td>
                            <%} else if (rs1.getString("severity").equals(s2)) {%>
                        <td width="10%" bgcolor="#DF7401"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=rs1.getString("severity")%></font></td>
                            <%} else if (rs1.getString("severity").equals(s3)) {%>
                        <td width="1%" bgcolor="#F7FE2E"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=rs1.getString("severity")%></font></td>
                            <%} else if (rs1.getString("severity").equals(s4)) {%>
                        <td width="10%" bgcolor="#04B45F"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=rs1.getString("severity")%></font></td>
                            <%}%>
                    <input type="hidden" id="sorton" name="sorton"/>
                    <input type="hidden" id="sort_method" name="sort_method"/>
                    <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= rs1.getString("priority")%></font></td>
                    <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= rs1.getString("rating")%></font></td>
                    <td width="12%"><font  face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= rs1.getString("project")%></font></td>                   
                    <td width="10%"> <font face="Verdana, Arial, Helvetica, sans-serif" size="1"><%= (String) member.get(rs1.getInt("createdby"))%></font></td>
                    <td width="10%"> <font face="Verdana, Arial, Helvetica, sans-serif" size="1"><% if (rs1.getDate("createdon") == null) {%>NA<% } else {%><%=sdf.format(rs1.getDate("createdon"))%><%}%></font></td>
                    <td width="10%"> <font face="Verdana, Arial, Helvetica, sans-serif" size="1"><% if (rs1.getDate("modifiedon") == null) {%>NA<% } else {%><%= sdf.format(rs1.getDate("modifiedon"))%><%}%></font></td>
                    </tr>
                    <%  }
                    %>
                    <tfoot>
                        <tr>
                            <td colspan="10">
                                <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                                    </nav> 
                                    <nav class="right"> <span class="prev"> <img
                                                src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                            class="pagecount"></span> &nbsp;<span class="next">Next <img
                                                src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <%}
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            logger.error("Exception:" + e);
                            logger.error(e.getMessage());
                        } finally {
                            if (rs1 != null) {
                                rs1.close();
                            }
                            if (stmt1 != null) {
                                stmt1.close();
                            }
                            if (connection != null) {
                                connection.close();
                            }
                            session.removeAttribute("issueHistory");
                            session.removeAttribute("issueRating");
                        }

                        session.removeAttribute("issueRating");
                    }
                %>
                <div class="clear"></div>
                <div class="clear"></div>
                <table> 
                    <tr>
                        <td><input type="hidden" name="querystring" id="querystring" value="<%=query1%>">
                        </td>
                        <td><input type="hidden" name="issuedayHistory" id="querystring" value="<%=issueHistory%>">
                        <td><input type="hidden" name="issueRating" id="querystring" value="<%=issueRating%>">
                        </td>
                        <td><input type="submit" name="submit" value="<%=buttonvalue%>">
                        </td>

                    </tr>
                </table>
            </form>

        </center>

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


        <div id="overlay"></div>
        <div id="tagpopup" class="popup">
            <h3 class="popupHeading">Add Tag</h3>
            <div>
                <div class="inputDiv">  <div style="color:red;" id="errortagmsg"></div>
                    <div style="color:green;" id="tagmsg"></div>
                </div>
                <br/>
                <div class="inputDiv">
                    <label style="text-align: left;float: left;width: 100px;">Enter Tag Name:</label>  <span><input type="text" name="tag" id="tag" size="25" maxlength="50" style="width: 200px;height: 21px"/></span> 
                </div>
                <div class="clear"></div>
                <div  class="inputDiv">
                    <label style="text-align: left;float: left;width: 100px;">Tag Type:</label> 
                    <span><Select id="tagType" style="width: 200px;height: 21px">
                            <option value="0">Individual tag</option>
                            <option  value="1">Common tag</option>
                        </select>
                    </span>
                </div>
                <div  class="inputDiv" >
                    <label style="text-align: left;float: left;width: 100px;">Select user:</label> 
                    <Select id="userdeshBorad" multiple="">
                        <%
                            HashMap<Integer, String> deshBordUser = tagc.getAllDeshBoradUser();
                            if (deshBordUser == null || deshBordUser.isEmpty()) {

                            } else {
                                for (Map.Entry<Integer, String> entrySet : deshBordUser.entrySet()) {


                        %>
                        <option value="<%=entrySet.getKey()%>"><%=entrySet.getValue()%></option>
                        <%}
                            }%>
                    </select>

                </div>
                <div  class="inputDiv">
                    <input type="hidden" name="action" value="Create"/>
                    <input type="button" value="Create Tag" id="createTag" style="width: 100px"/>
                    <button class="custom-popup-close" onclick="javascript:closeTag();" type="button">close</button>
                </div>
            </div>
        </div>
    </div>

    <iframe id="txtArea1" style="display:none"></iframe>
    <script type="text/javascript">


        function addTag() {
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#tagpopup').fadeIn('fast', 'swing');
            $('#tag').val('');
            $("span.error2").remove();
            enableTagSubmit();
        }
        function closeTag() {
            $('#overlay').fadeOut('fast', 'swing');
            $('#tagpopup').fadeOut('fast', 'swing');
            getAllTag();
        }

        $('#createTag').click(function () {

            $("span.error2").remove();
            var tag = $.trim($('#tag').val());
            var tagType = $.trim($("#tagType").val());
            var user = [];
            $("#userdeshBorad option:selected").each(function () {
                user.push($(this).val());
            });
            var count = 0;
            disableTagSubmit();
            if (tag.length == 0) {
                $("<span class='error2'>Please enter tag name </span>").insertAfter("#errortagmsg");
                $("#tagnames").focus();
                count = 1;
            } else if (tag.length > 20) {
                $("<span class='error2'>Please enter tag name less than 20 characters</span>").insertAfter("#errortagmsg");
                $("#tagnames").focus();
                count = 1;
            } else if (tagType == 0) {
                if (user.length > 0) {
                    $("<span class='error2'>You can not select user for this tag type</span>").insertAfter("#errortagmsg");
                    $("#userdeshBorad").focus();
                    count = 1;
                }
            } else if (tagType == 1) {
                var v = user.length;
                if (user.length === 0) {
                    $("<span class='error2'>Please select user for this tag type</span>").insertAfter("#errortagmsg");
                    $("#userdeshBorad").focus();
                    count = 1;
                }
            }

            if (count === 0) {
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/project/checkuniqueTag.jsp',
                    data: {tag: tag, tagType: tagType, random: Math.random(1, 10)},
                    async: true,
                    type: 'GET',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {

                            var result = $.trim(responseText);
                            if (result == "true") {
                                createTag();
                            } else if (result == "false") {
                                $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                                enableTagSubmit();
                            } else if (result == "falseChangeType") {
                                if (tagType == 1) {
                                    $("<span class='error2'>select Individual tag </span>").insertAfter("#errortagmsg");
                                    enableTagSubmit();
                                } else {
                                    $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                                    enableTagSubmit();
                                }
                            }
                        }
                    }
                });
            } else {
                enableTagSubmit();
            }
        });
        function createTag() {
            var tag = $('#tag').val();
            var Create = 'Create';
            var tagType = $("#tagType option:selected").val();
            var user = [];
            $("#userdeshBorad option:selected").each(function () {
                user.push($(this).val());
            });
            var userid = "";
            for (var i = 0, n = user.length; i < n; i++) {
                userid += user[i] + ",";
            }
            userid = userid.substr(0, userid.length - 1);
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/project/createTag.jsp',
                data: {tag: tag, tagType: tagType, userid: userid, action: Create, random: Math.random(1, 10)},
                async: true,
                type: 'Post',
                success: function (responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {
                        var result = $.trim(responseText);
                        if (result == "true") {
                            $("<span class='error2' style='color:green'>Tag create successfully.</span>").insertAfter("#tagmsg");
                        } else {
                            $("<span class='error2'>Already exists.</span>").insertAfter("#errortagmsg");
                        }
                    } else {
                        $("<span class='error2'>Please Try/Again</span>").insertAfter("#errortagmsg");
                    }
                }
            });
            enableTagSubmit();
        }
        $('#tagnames').change(function () {
            var tagid = $("#tagnames option:selected").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/IssueSummary/getAlltageIssue.jsp',
                data: {tagid: tagid, random: Math.random(1, 10)},
                async: true,
                type: 'GET',
                success: function (responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {
                        var result = $.trim(responseText);
                        if (result != "") {
                            var allissue = result;
                            var issuearr = allissue.split(',');
                            $(".checkIssue").each(function () {
                                var notmatch = "false";
                                for (var i = 0; i < issuearr.length; i++) {
                                    if (issuearr[i] === $(this).val()) {
                                        $(this).prop("checked", true);
                                        $(this).attr("id", $(this).val() + "checked");
                                        $(this).removeAttr("style");
                                        notmatch = "true";
                                    }
                                }
                                if (notmatch == "false") {
                                    $(this).prop("checked", false);
                                    $(this).attr("id", 'notchecked');
                                }
                            });
                        } else {
                            $(".checkIssue").each(function () {
                                $(this).prop("checked", false);
                                $(this).attr("id", 'notchecked');
                            });
                        }
                    }
                }
            });
        });
        function getAllTag() {
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/project/retrieveAlltags.jsp',
                data: {random: Math.random(1, 10)},
                async: true,
                type: 'GET',
                success: function (responseText, statusTxt, xhr) {
                    if (statusTxt === "success") {
                        var result = $.trim(responseText);
                        //  $(".selectTag").html('');
                        //  $(".selectTag").html(result);
                        $("#tagnames").html('');
                        $("#tagnames").html(result);
                    }
                }
            });
        }

        $('#addIssueToTag').click(function () {
            $('span.error2').remove();
            var selected = [];
            $(".checkIssue:checked").each(function () {
                selected.push($(this).val());
            });
            var tag = $("#tagnames option:selected").val();
            if (selected.length == 0) {
                $("<span class='error2'>Select at least one issue</span>").insertAfter("#addIssueToTag");
            } else if (isNaN(parseInt(tag))) {
                $("<span class='error2'>Select a tag </span>").insertAfter("#addIssueToTag");
                $("#tagnames").focus();
            } else {
                var issueids = "";
                for (var i = 0, n = selected.length; i < n; i++) {
                    issueids += selected[i] + ",";
                }

                var create = 'Create';
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/project/createTagIssue.jsp',
                    data: {action: create, tagId: tag, issueId: issueids, random: Math.random(1, 10)},
                    async: true,
                    type: 'Post',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            $("<span class='error2' style='color:green'>Issue add successfully </span>").insertAfter("#addIssueToTag");
                            $(".checkIssue:checked").each(function () {
                                $(this).attr("id", $(this).val() + "checked");
                            });
                        } else {
                            $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                        }
                    }
                });
            }
        });
        $(".checkIssue").click(function () {
            $('span.error2').remove();
            var currThis = $(this);
            var tag = $("#tagnames option:selected").val();
            var issueId = $(this).val();
            var id = $(currThis).attr("id");
            if (tag != "") {
                if (id == "notchecked") {
                } else {
                    if (!$(this).is(':checked')) {
                        $.ajax({
                            url: '<%=request.getContextPath()%>/IssueSummary/deleteIssueTag.jsp',
                            data: {tagId: tag, issueId: issueId, random: Math.random(1, 10)},
                            async: true,
                            type: 'Post',
                            success: function (responseText, statusTxt, xhr) {
                                if (statusTxt === "success") {
                                    var result = $.trim(responseText);
                                    if (result == "true") {
                                        $("<span class='error2' style='color:green'>Issue delete successfully</span>").insertAfter("#addIssueToTag");
                                        $(currThis).prop("checked", false);
                                        $(this).attr("id", 'notchecked');
                                    } else {
                                        $(currThis).prop("checked", true);
                                        $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                                        $(this).attr("id", $(this).val() + "checked");
                                    }
                                } else {
                                    $(currThis).prop("checked", true);
                                    $("<span class='error2'>Please Try/Again</span>").insertAfter("#addIssueToTag");
                                    $(this).attr("id", $(this).val() + "checked");
                                }
                            }
                        });
                    }
                }
            }
        });
        function ExportToExcel() {
            var headerSortDown = $('.tablesorter-headerAsc').text();
            var headerSortUp = $(".tablesorter-headerDesc").text();
            var issueHistory = "<%=issueHistory%>";
            var issueRating = "<%=issueRating%>";
            //   var headerSortDown = $(".headerSortDown").text();
            // var headerSortUp = $(".headerSortUp").text();
            window.open("<%=request.getContextPath()%>/IssueSummary/exportexcelIssueSummary.jsp?headerSortUp=" + headerSortUp + "&headerSortDown=" + headerSortDown + "&issueHistory=" + issueHistory + "&issueRating=" + issueRating, '_blank');
        }


        function disableTagSubmit() {
            document.getElementById('createTag').value = 'Processing';
            document.getElementById('createTag').disabled = true;
            return true;
        }
        function enableTagSubmit() {
            document.getElementById('createTag').value = 'Create Tag';
            document.getElementById('createTag').disabled = false;
        }

        $('#agreedIssues').click(function () {
            $('span.error2').remove();
            var selected = [];
            $(".checkIssue:checked").each(function () {
                selected.push($(this).val());
            });
            var pro = "";
            if (selected.length == 0) {
                $("<span class='error2'>Select at least one issue</span>").insertAfter("#agreedIssues");
            } else {
                $('#searchTable').find('tr').each(function () {
                    if ($(this).find('input[type="checkbox"]').is(':checked')) {
                        pro += $(this).find('td.proj').text() + ",";
                    }
                });
                $.ajax({
                    url: '<%=request.getContextPath()%>/IssueSummary/checkPMorDMForProjects.jsp',
                    data: {project: pro, random: Math.random(1, 10)},
                    async: true,
                    type: 'Post',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            if (result == "true") {
                                var issueids = "";
                                for (var i = 0, n = selected.length; i < n; i++) {
                                    issueids += selected[i] + ",";
                                }

                                $.ajax({
                                    url: '<%=request.getContextPath()%>/IssueSummary/addAgreedIssues.jsp',
                                    data: {issues: issueids, random: Math.random(1, 10)},
                                    async: true,
                                    type: 'Post',
                                    success: function (responseText, statusTxt, xhr) {
                                        if (statusTxt === "success") {
                                            var result = $.trim(responseText);
                                            if (result == "success") {
                                                $("<span class='error2' style='color:green'>Issue add successfully </span>").insertAfter("#agreedIssues");
                                                $(".checkIssue:checked").each(function () {
                                                    $(this).attr("id", $(this).val() + "checked");
                                                });
                                            } else {
                                                $("<span class='error2'>" + result + "</span>").insertAfter("#agreedIssues");
                                            }
                                        } else {
                                            $("<span class='error2'>Please Try/Again</span>").insertAfter("#agreedIssues");
                                        }
                                    }
                                });
                            } else if (result === "failure") {
                                $("<span class='error2'>Please Try/Again</span>").insertAfter("#agreedIssues");
                            } else {
                                $("<span class='error2'>" + result + "</span>").insertAfter("#agreedIssues");
                            }

                        } else {
                            $("<span class='error2'>Please Try/Again</span>").insertAfter("#agreedIssues");
                        }
                    }
                });
            }

        });
    </script>


    <style>
        .ms-drop input[type="checkbox"] {
            float: left;
        }
        .ms-drop ul > li label {
            font-weight: bold;
            white-space: nowrap;
            text-align: left;
            float: left;
        }
        .checkIssue{
            visibility: visible;
        }
    </style>
    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>

    <script type="text/javascript">
        $('#userdeshBorad').multipleSelect({
            filter: true,
            maxHeight: 150,
            width: 200
        });
        $.tablesorter.addParser({
            id: "ddMMMyy",
            is: function (s) {
                return false;
            },
            format: function (s, table) {
                var from = s.split("-");
                var year = "20" + from[2];
                var mon = from[1];
                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                return new Date(year, month, from[0]).getTime() || '';
            },
            type: "numeric"
        });
        $(document).ready(function ()
        {
//                  $("#searchTable").tablesorter({
//                 widgets: ['zebra'],
//                 widgetZebra: {css: ['zebraline', 'zebralinealter']},
//                 // change the multi sort key from the default shift to alt button 
//                 sortMultiSortKey: 'altKey',
//                 headers: {
//                 7: {// <-- replace 6 with the zero-based index of your column
//                 sorter: 'ddMMMyy'
//                 }
//                 }
//                 });



            var $table = $('#searchTable'),
                    $pager = $('.pager');
            $.tablesorter.customPagerControls({
                table: $table, // point at correct table (string or jQuery object)
                pager: $pager, // pager wrapper (string or jQuery object)
                pageSize: '.left a', // container for page sizes
                currentPage: '.right a', // container for page selectors
                ends: 2, // number of pages to show of either end
                aroundCurrent: 5, // number of pages surrounding the current page
                link: '<a href="#" class="pagerno">{page}</a>', // page element; use {page} to include the page number
                currentClass: 'current', // current page class name
                adjacentSpacer: ' | ', // spacer for page numbers next to each other
                distanceSpacer: ' \u2026 ', // spacer for page numbers away from each other (ellipsis &amp;hellip;)
                addKeyboard: true                      // add left/right keyboard arrows to change current page
            });
            // initialize tablesorter & pager
            $table.tablesorter({
                cssInfoBlock: "tablesorter-ignoreRow",
                widgets: ['zebra'],
                widgetOptions: {
                    zebra: ["zebraline", "zebralinealter"]
                },
                //  change the multi sort key from the default shift to alt button
                sortMultiSortKey: 'altKey',
                headers: {
                    7: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }
                }
            }).tablesorterPager({
                //target the pager markup - see the HTML block below
                container: $pager,
                size: 10,
                output: 'Displaying Issues&nbsp;<b>{startRow} - {endRow}</b> of <b>{filteredRows}</b> issues searched by you'

            });
            $('#searchTable').trigger('pageSize', 100);
        });
        function callissue(issueid) {
            var team = '<%=team%>';
            var mail = '<%=url%>';
            var d = new Date();
            var n = d.getHours();
            var sorton;
            var sort_method;
            var headerSortDown = $('.tablesorter-headerAsc').text();
            var headerSortUp = $(".tablesorter-headerDesc").text();
            if (headerSortDown.length > 0) {
                sorton = headerSortDown;
                sort_method = "headerSortDown";
            } else if (headerSortUp.length > 0) {
                sorton = headerSortUp;
                sort_method = "headerSortUp";
            }

            document.getElementById("sorton").value = sorton;
            document.getElementById("sort_method").value = sort_method;

            if (mail === 'eminentlabs.net') {
                if (n > 8 && n < 18) {
                    var result;
                    $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                        data: {issueid: issueid, random: Math.random(1, 10)},
                        async: true,
                        type: 'GET',
                        success: function (data) {
                            result = $.trim(data);
                        }, complete: function () {
                            if (result === '') {
                                location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MySearches&planSeq=yes';
                            } else {
                                alert(result);
                            }
                        }
                    });
                } else {
                    location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MySearches&planSeq=yes';
                }
            } else {
                location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MySearches&planSeq=yes';
            }
        }

    </script>
    <style>
        .pager a.current {
            color: #0080ff;
            font-weight: 800;
        }

        .pager a {
            text-decoration: none;
            color: black;
        }
    </style>
</body>
</html>
