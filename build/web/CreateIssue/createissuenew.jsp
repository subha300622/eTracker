<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<!doctype html public "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("New Issue Creation");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%@page import="java.util.Map"%>
<html xmlns="http://www.w3.org/1999/xhtml">

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <title>eTracker - Eminent Product Development Life Cycle Management</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
        </script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/ckeditor_4.5.9_standard/ckeditor/ckeditor.js"></script>          <script type="text/javascript">                  CKEDITOR.timestamp = '21072016';</script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/javaScript/bp.js?v=1.0" type="text/javascript"></script>

        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
        <style type="text/css">
            ul{list-style: none outside none;padding: 0;margin: 0;margin-top: 4px;background-color: white;}
        </style>
        <script type="text/javascript">
            function showci() {
                $('#overlay').fadeIn('fast', 'swing');
                $('#CIpopup').center().fadeIn('fast', 'swing');

            }
            function closeci() {
                $('#overlay').fadeOut('fast', 'swing');
                var attach = 'false';
                location = '/eTracker/CreateIssue/createissuenew.jsp?treeMapFlag=' + attach;
                $('#CIpopup').center().fadeOut('fast', 'swing');
            }
            function gotoTree() {
                var treeproject = document.getElementById('treeproject').value;
                location = '/eTracker/testMap.jsp?pid=' + treeproject;

            }

        </script>    
        </head>
        <body bgcolor="#FFFFFF">
            <form name="theForm" id="theForm" method="post" onsubmit="return validate();" action="<%=request.getContextPath()%>/CreateIssue/createissueputdb.jsp">
                <%@ page import="java.sql.*,com.eminent.util.VerifiedStatusCheck"%>
                <%@ page language="java"%>
                <%@ include file="../header.jsp"%>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr bgcolor="#C3D9FF">
                        <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Create
                                    Issue </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
                    </tr>
                </table>
                <br/>
                <jsp:useBean id="tpa" class="com.eminent.bpm.TreePrintAccess"></jsp:useBean>
                    <div id="prposIssue"></div>
                    <input type="hidden" name="pChecker" id="pChecker" value="No"/>
                    <br/>
                <%
                    String treeMapcheck = request.getParameter("treeMapFlag");
                    Integer current_userId = (Integer) session.getAttribute("userid_curr");
                    int userId = 0;
                    if (current_userId != null) {
                        userId = current_userId.intValue();
                    }

                    int verifiedExceedIssues = VerifiedStatusCheck.GetExceedIssues(userId);
                    int verifiedIssues = VerifiedStatusCheck.GetIssues(userId);
                    int unapprovedTimesheet = VerifiedStatusCheck.GetTimesheet(userId);
                    if (unapprovedTimesheet > 0) {
                %>
                <center><font SIZE="4" COLOR="red">You have <%=unapprovedTimesheet%> Timesheet(s). Update those Timesheet(s) before creating any issue.</font></center>
                <center><font SIZE="4" COLOR="red">Please <a href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp">click</a> here to view and update Timesheet.</font></center>
                        <%
                        } else if (verifiedExceedIssues > 0) {
                            String query = "select distinct i.issueid, pname as project, subject, description, priority, severity, type, createdon, due_date, modifiedon,createdby,assignedto,s.status,module,rating,feedback from issue i,issuestatus s, project p, modules m where i.issueid = s.issueid and upper(s.status)= 'VERIFIED' and upper(assignedto)= '" + userId + "' and i.pid = p.pid and i.module_id=m.moduleid and p.pid in (select p.pid from project p, userproject up where p.pid = up.pid and userid = " + userId + ") order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                            session.setAttribute("IssueSummaryQuery", query);
                        %>
                <center><font SIZE="4" COLOR="red">You have <%=verifiedExceedIssues%> Verified Issue(s). Update those issue(s) before creating any new one.</font></center>
                <center><font SIZE="4" COLOR="red">Please <a href="<%=request.getContextPath()%>/IssueSummary/IssueSummaryView.jsp">click</a> here to view and update your verified issues.</font></center>
                        <%

                        } else {
                            String flag = request.getParameter("flag");
                            if (flag != null && flag.equalsIgnoreCase("true")) {

                                String issueId = (String) session.getAttribute("theissu");
                                if (issueId == null) {
                                    issueId = request.getParameter("issueId");
                                }

                        %>
                <center><font SIZE="4" COLOR="#0000ff">The issue has
                        been created successfully.Issue id : <%= issueId%></font></center>
                        <%
                            }
                            Map<Long, String> treeProject = tpa.treeProject(userId);
                            long projectId = ProjectFinder.findProjectId(userId);
                        if (!treeProject.isEmpty()) {
                            if (treeMapcheck == null) {%>
                <div id="CIpopup" class="popup" style='border-collapse:collapse;border:1px solid lightblue;'>
                    <h3 class="popupHeading">Please redirect to Tree Map >> Test Step level to Create Issue?</h3>
                    <div>

                        <hr />
                        <!-- Update form action -->

                        <table  style="width: 100%;" >

                            <tr style="height:20px;">
                                <td style="text-align: right;width: 30%;">
                                    <label for="proj" style="font-weight: bold;">Project: </label>
                                </td>
                                <td style="">
                                    <%if (treeProject.size() == 1) {%>
                                    <%

                                        for (Map.Entry<Long, String> entry : treeProject.entrySet()) {
                                    %>
                                    <input type="hidden"  name="treeproject" id='treeproject' value="<%=entry.getKey()%>">
                                        <script type="text/javascript">gotoTree()</script>   
                                        <%}
                                    } else {%>
                                        <select name="treeproject" id='treeproject' onchange="javascript:gotoTree();">
                                            <%

                                                for (Map.Entry<Long, String> entry : treeProject.entrySet()) {
                                                    if (projectId == entry.getKey()) {%>
                                            <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>

                                            <%   } else {
                                            %>
                                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <%}%>
                                </td>

                            </tr>

                            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="button" value="OK" onclick="javascript:gotoTree();"/>
                                </td>
                            </tr>
                        </table>

                    </div>
                </div>
                <script type="text/javascript">
                    showci();
                </script>
                <%treeMapcheck = "true";
                        } else {
                            treeMapcheck = "false";
                        }
                    } else {
                        treeMapcheck = "false";
                    }

                    if (treeMapcheck.equals("false")) {
                        if (verifiedIssues > 0) {
                %>
                <center><FONT SIZE="4" COLOR="#B40404">You have <%=verifiedIssues%> Verified Issue(s). Please update it before due date.</FONT></center>
                        <%
                            }
                            flag = null;
                            Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt6 = null, stmt7 = null, stmt9 = null, stmt10 = null, stmt11 = null;
                            ResultSet rs1 = null, rs2 = null, rs3 = null, rs6 = null, rs7 = null, rs9 = null, rs10 = null, rs11 = null;
                            Connection connection = null;
                            try {
                                connection = MakeConnection.getConnection();
                        %> <br>
                    <div id="creatissueform">
                        <table width="100%" border="0" bgcolor="#E8EEF7" cellspacing="2"
                               cellpadding="2" align="center">
                            <tr>
                                <td height="21" width="20%"><B>
                                        <div id="category1" style="position: relative; visibility: visible">
                                            Project</div>
                                    </B></td>
                                <td height="21" width="20%"><B>
                                        <div id="version1" style="position: relative; visibility: visible">
                                            Found Version</div>
                                    </B></td>
                                <td height="21" width="20%"><b>
                                        <div id="module1" style="position: relative; visibility: visible">Module</div>
                                    </b></td>
                                <td height="21" width="20%"><b>
                                        <div id="type1" style="position: relative; visibility: visible">Type</div>
                                    </b></td>
                            </tr>
                            <tr>


                                <%
                                    stmt1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                                    rs1 = stmt1.executeQuery("SELECT distinct PNAME FROM PROJECT P, USERPROJECT U where USERID = " + userId + " AND P.PID = U.PID AND STATUS != 'Finished' ORDER BY Upper(PNAME) ASC");
                                    rs1.last();
                                    int row = rs1.getRow();
                                    rs1.beforeFirst();

                                %>
                                <td height="21" width="20%"><font size="2"
                                                                  face="Verdana, Arial, Helvetica, sans-serif"> <%                                                                                              String product = "";
                                                                      //For more than one project
                                                                      if (row > 1) {
                                        %>

                                        <select name="product" id="product" size="1"
                                                onChange="javascript:callversion();
                                                        javascript:callmodule();">
                                            <option value="--Select One--" selected>--Select One--</option>
                                            <%
                                                while (rs1.next()) {
                                                    product = rs1.getString(1);
                                            %>
                                            <option value="<%=product%>"><%=product%></option>
                                            <%
                                                }
                                                rs1.close();
                                                stmt1.close();
                                            %>
                                        </select></font></td>

                                <td height="21" width="20%"><font size="2"
                                                                  face="Verdana, Arial, Helvetica, sans-serif">
                                        <select name="version" id="version" size="1"
                                                onChange="javascript:callmodule();">
                                            <option value="--Select One--" selected>--Select One--</option>
                                        </select></font></td>
                                <td height="21" width="20%"><font size="2"
                                                                  face="Verdana, Arial, Helvetica, sans-serif">
                                        <select name="module" id="module" size="1"  onChange="javascript:callduedate();">
                                            <option value="--Select One--" selected>--Select One--</option>
                                            <%
                                                // If there is only one project
                                            } else {
                                                while (rs1.next()) {
                                                    product = rs1.getString(1);

                                            %>
                                            <input type="text" name="product" id="product" value="<%= product%>" readonly>
                                                <%
                                                    }

                                                    rs1.close();
                                                    stmt1.close();
                                                %>
                                                </td>
                                                <%
                                                    //String prod1=request.getParameter("product");
                                                    stmt3 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                                    rs3 = stmt3.executeQuery("SELECT VERSION  FROM PROJECT WHERE PNAME='" + product + "' and status not in ('Finished','Closed','Suspended','End of Life') ORDER BY VERSION");// CORRECT
                                                    String version = "";
                                                    rs3.last();
                                                    row = rs3.getRow();
                                                    rs3.beforeFirst();
                                                    if (row > 1) {
                                                %>
                                                <td height="21" width="20%"><font size="2"
                                                                                  face="Verdana, Arial, Helvetica, sans-serif"> <select
                                                            name="version" id="version" size="1"
                                                            onChange="javascript:callmodule();">
                                                            <option value="--Select One--" selected>--Select One--</option>
                                                            <%
                                                                if (rs3 != null) {
                                                                    while (rs3.next()) {
                                                                        version = rs3.getString(1);

                                                            %>
                                                            <option value="<%=version%>"><%=version%></option>
                                                            <%
                                                                    }
                                                                }
                                                                rs3.close();
                                                                if (stmt3 != null) {
                                                                    stmt3.close();
                                                                }

                                                            %>

                                                        </select></font></td>
                                                <td height="21" width="20%"><font size="2"
                                                                                  face="Verdana, Arial, Helvetica, sans-serif">
                                                        <select name="module" id="module" size="1" onChange="javascript:callduedate();">
                                                            <option value="--Select One--" selected>--Select One--</option>
                                                            <%                                                                                    } else {
                                                                // Only one Project and Version
                                                                while (rs3.next()) {
                                                                    version = rs3.getString(1);

                                                            %>
                                                            <td>
                                                                <input type="text" name="version" id="version" value="<%= version%>" readonly>
                                                            </td>
                                                            <%
                                                                }

                                                                rs3.close();
                                                                stmt3.close();
                                                            %>
                                                            <td height="21" width="20%"><font size="2"
                                                                                              face="Verdana, Arial, Helvetica, sans-serif"> <%
                                                                                                  //String ver=request.getParameter("version");
                                                                                                  stmt6 = connection.createStatement();
                                                                                                  rs6 = stmt6.executeQuery("SELECT MODULES.MODULE FROM MODULES, PROJECT WHERE PNAME='" + product + "' and version='" + version + "' and modules.pid=project.pid GROUP BY Modules.MODULE order by upper(module)");
                                                                    %>
                                                                    <select name="module" id="module" size="1" onChange="javascript:callduedate();">
                                                                        <option value="--Select One--" selected>--Select One--</option>
                                                                        <%
                                                                            if (rs6 != null) {
                                                                                while (rs6.next()) {
                                                                                    String module = rs6.getString(1);

                                                                        %>
                                                                        <option value="<%=module%>"><%=module%></option>
                                                                        <%
                                                                                        }
                                                                                    }
                                                                                    rs6.close();
                                                                                    if (stmt6 != null) {
                                                                                        stmt6.close();
                                                                                    }

                                                                                }
                                                                            }


                                                                        %>
                                                                    </select></td>
                                                            <td height="21" width="20%">
                                                                <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
                                                                    <%                                                                                                String type1 = "Bug";
                                                                        String type2 = "Enhancement";
                                                                        String type3 = "New Task";
                                                                        String type = "";
                                                                    %>
                                                                    <select name="type" size="1">

                                                                        <%
                                                                            if (type1.equals(request.getParameter("type"))) {
                                                                                type = type1;
                                                                        %>
                                                                        <option value="<%=type%>" selected><%=type%></option>
                                                                        <%
                                                                        } else {
                                                                            type = type1;
                                                                        %>
                                                                        <option value="<%=type%>"><%=type%></option>
                                                                        <%
                                                                            }
                                                                            if (type2.equals(request.getParameter("type"))) {
                                                                                type = type2;
                                                                        %>
                                                                        <option value="<%=type%>" selected><%=type%></option>
                                                                        <%
                                                                        } else {
                                                                            type = type2;
                                                                        %>
                                                                        <option value="<%=type%>"><%=type%></option>
                                                                        <%
                                                                            }
                                                                            if (type3.equals(request.getParameter("type"))) {
                                                                                type = type3;
                                                                        %>
                                                                        <option value="<%=type%>" selected><%=type%></option>
                                                                        <%
                                                                        } else {
                                                                            type = type3;
                                                                        %>
                                                                        <option value="<%=type%>"><%=type%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select></td>
                                                            </tr>
                                                            <tr></tr>
                                                            <tr></tr>
                                                            <tr></tr>
                                                            <tr>


                                                                <td height="21" width="20%"><b>
                                                                        <div id="severity1" style="position: relative; visibility: visible">Severity</div>
                                                                    </b></td>
                                                                <td height="21" width="20%"><b>
                                                                        <div id="priority1" style="position: relative; visibility: visible">Priority</div>
                                                                    </b></td>
                                                                <td height="21" width="20%"><b>
                                                                        <div id="dueDate" style="position: relative; visibility: visible">Due
                                                                            Date</div>
                                                                    </b></td>
                                                            </tr>
                                                            <tr>






                                                                <%
                                                                    String severity1 = "S1- Fatal";
                                                                    String severity2 = "S2- Critical";
                                                                    String severity3 = "S3- Important";
                                                                    String severity4 = "S4- Minor";
                                                                    String severity = "";
                                                                %>
                                                                <td height="21" width="20%"><font size="2"
                                                                                                  face="Verdana, Arial, Helvetica, sans-serif"> <SELECT
                                                                            NAME="severity" id="severity" size="1" onChange="javascript:callduedate();">
                                                                            <%
                                                                                if (severity3.equals(request.getParameter("severity"))) {
                                                                                    severity = severity3;
                                                                            %>
                                                                            <option value="<%=severity%>" selected><%=severity%></option>
                                                                            <%
                                                                            } else {
                                                                                severity = severity3;
                                                                            %>
                                                                            <option value="<%=severity%>"><%=severity%></option>
                                                                            <%
                                                                                }
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
                                                                <td height="21" width="20%"><font size="2"
                                                                                                  face="Verdana, Arial, Helvetica, sans-serif"> <SELECT
                                                                            NAME="priority" id="priority" size="1" onChange="javascript:callduedate();">
                                                                            <%
                                                                                if (priority3.equals(request.getParameter("priority"))) {
                                                                                    priority = priority3;
                                                                            %>
                                                                            <option value="<%=priority%>" selected><%=priority%></option>
                                                                            <%
                                                                            } else {
                                                                                priority = priority3;
                                                                            %>
                                                                            <option value="<%=priority%>"><%=priority%></option>
                                                                            <%
                                                                                }
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
                                                                <td><input type="text" id="date" name="date" maxlength="10" size="14" 
                                                                           readonly /><a href="javascript:NewCal('date','ddMMyyyy')" > <img
                                                                            src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                                                                            width="16" height="16" alt="Pick a date" ></a></td>

                                                            </tr>
                                                            </table>

                                                            <table width="100%"  bgcolor="#E8EEF7"  align="center">
                                                                <!--	<tr></tr>
                                                                        <tr></tr>
                                                                        <tr></tr>
                                                                        <tr></tr>
                                                                        <tr></tr>
                                                                        <tr></tr>-->
                                                                <tr>
                                                                    <td >
                                                                        <b><div id="subject1" style="position: relative; visibility: visible">Subject</div></b>
                                                                    </td>


                                                                    <%
                                                                        String subject = request.getParameter("subject");
                                                                        if (subject == null) {
                                                                            subject = "";
                                                                        }
                                                                    %>
                                                                    <td style="position: relative; visibility: visible;width:700px;"><input type="text" name="subject" size="91" maxlength="100" value="<%=subject%>" /></td>

                                                                </tr>
                                                                <tr>

                                                                </tr>

                                                                <tr>
                                                                    <td  ><b>
                                                                            <div id="description1" style="position: relative; visibility: visible">Description</div>
                                                                        </b></td>


                                                                    <%
                                                                        String description = request.getParameter("description");
                                                                        if (description == null) {
                                                                            description = "Found in build: <br> Detailed Issue Description:<br> Related issue:";
                                                                        }
                                                                    %>
                                                                    <td >
                                                                        <textarea
                                                                            name="description" id="description" wrap="physical" cols="84" rows="4"
                                                                            onKeyDown="textCounter(document.theForm.description, document.theForm.remLen1, 4000);"
                                                                            onKeyUp="textCounter(document.theForm.description, document.theForm.remLen1, 4000);"><%=description%></textarea>
                                                                        <script type="text/javascript">

                                                                            CKEDITOR.replace('description');
                                                                            var editor_data = CKEDITOR.instances.description.getData();
                                                                            CKEDITOR.instances["description"].on("instanceReady", function ()
                                                                            {
                                                                                //set keyup event
                                                                                this.document.on("keyup", updateTextArea);
                                                                                //and paste event
                                                                                this.document.on("paste", updateTextArea);

                                                                            });

                                                                            function updateTextArea()
                                                                            {
                                                                                //    alert(document.getElementById('description').value);
                                                                                CKEDITOR.tools.setTimeout(function ()
                                                                                {
                                                                                    var desc = CKEDITOR.instances.description.getData();
                                                                                    var leng = desc.length;
                                                                                    editorTextCounter(leng, document.theForm.remLen1, 4000);

                                                                                }, 0);
                                                                            }
                                                                        </script>
                                                                    </td>
                                                                    <td  align="left">
                                                                        <input readonly type="text" name="remLen1" size="3" maxlength="3" value="4000"/>characters left
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
                                                                    <td ><b>
                                                                            <div id="rootcause1" style="position: relative; visibility: visible">Root
                                                                                Cause</div>
                                                                        </b></td>

                                                                    <%
                                                                        String rootCause = request.getParameter("rootCause");
                                                                        if (rootCause == null) {
                                                                            rootCause = "If you know the root cause  type in";
                                                                        }
                                                                    %>
                                                                    <td ><input type="text" name="rootCause" id="rootCause"
                                                                                size="91" maxlength="110" value="<%= rootCause%>" onclick="javascript:clearRootCause();" onblur="javascript:popRootCause();" /></td>
                                                                </tr>
                                                                <tr>

                                                                </tr>

                                                                <tr>
                                                                    <td><b>
                                                                            <div id="expectedresult1"
                                                                                 style="position: relative; visibility: visible">Expected Result</div>
                                                                        </b></td>

                                                                    <%
                                                                        String expectedResult = request.getParameter("expectedResult");
                                                                        if (expectedResult == null) {
                                                                            expectedResult = "";
                                                                        }
                                                                    %>

                                                                    <td ><font size="2"
                                                                               face="Verdana, Arial, Helvetica, sans-serif">

                                                                            <textarea
                                                                                name="expectedResult" id="expectedResult" wrap="physical" cols="84" rows="2"
                                                                                onKeyDown="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000);"
                                                                                onKeyUp="textCounter(document.theForm.expectedResult, document.theForm.remLen2, 2000);"><%= expectedResult%></textarea>

                                                                        </font></td>
                                                                    <script type="text/javascript">
                                                                        CKEDITOR.replace('expectedResult', {height: 100});
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
                                                                    <td  align="left"><input readonly type="text"
                                                                                             name="remLen2" size="3" maxlength="3" value="2000"/>characters
                                                                        left</td>
                                                                </tr>
                                                                <tr>

                                                                </tr>
                                                            </table>
                                                            </div>
                                                            <div id="creatissueforma">
                                                                <table width="100%"  bgcolor="#E8EEF7" align="center">
                                                                    <tr>
                                                                        <td align="center">
                                                                            <input type="submit" id="submit" name="submit" value="Submit"/>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>


                                                            <%
                                                                        } catch (Exception e) {
                                                                            logger.error("Exception:" + e);
                                                                        } finally {
                                                                            if (connection != null) {
                                                                                connection.close();
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            %>
                                                            </form>
                                                            <script  type="text/javascript">
                                                                function check(searchpg)
                                                                {
                                                                    var x = document.getElementById("issueno").value;
                                                                    searchpg.action = 'MyIssueView1.jsp?issno=' + x;
                                                                    searchpg.submit();
                                                                }
                                                            </script>

                                                            <script  type="text/javascript">
                                                                //    CKEDITOR.instances['description'].on('focus',function() {
                                                                //        alert('in description focus')
                                                                //       if (trim(CKEDITOR.instances.description.getData()) == "Found in build: <br> Detailed Issue Description:<br> Related issue:")
                                                                //        {
                                                                //            CKEDITOR.instances.description.setData('');
                                                                //        }
                                                                //    });
                                                                //    CKEDITOR.instances.description.on( 'blur', function() {
                                                                //          alert('in description blur')
                                                                //       if (trim(CKEDITOR.instances.description.getData()) == "")
                                                                //        {
                                                                //            CKEDITOR.instances.description.setData( 'Found in build: <br> Detailed Issue Description:<br> Related issue:' );
                                                                //        }
                                                                //    });
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
                                                                function textCounter(field, cntfield, maxlimit)
                                                                {
                                                                    if (field.value.length > maxlimit)
                                                                    {
                                                                        field.value = field.value.substring(0, maxlimit);
                                                                        if (maxlimit === 4000)
                                                                            alert('Description size is exceeding 4000 characters');
                                                                        else
                                                                            alert('Expected Result size is exceeding 2000 characters');
                                                                    } else
                                                                        cntfield.value = maxlimit - field.value.length;
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
                                                                function setFocus() {
                                                                    document.theForm.customer.focus();
                                                                }


                                                                function callversion() {
                                                                    xmlhttp = createRequest();

                                                                    if (xmlhttp !== null) {

                                                                        var product = document.getElementById('product').value;
                                                                        var url = "<%=request.getContextPath()%>/CreateIssue/VersionDetails.jsp";
                                                                        url = url + "?product=" + product;
                                                                        url = url + "&rand=" + Math.random();

                                                                        xmlhttp.onreadystatechange = callbackversion;
                                                                        xmlhttp.open("GET", url, false);
                                                                        xmlhttp.send(null);



                                                                    }
                                                                }

                                                                function callbackversion() {

                                                                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {


                                                                        var name = xmlhttp.responseText;

                                                                        var result = xmlhttp.responseText.split(";");
                                                                        var results = result[1].split(",");
                                                                        objLinkList = eval(document.getElementById("version"));
                                                                        objLinkList.length = 0;
                                                                        for (i = 0; i < results.length - 1; i++) {
                                                                            objLinkList.length++;
                                                                            objLinkList[i].text = results[i];
                                                                            objLinkList[i].value = results[i];
                                                                        }
                                                                    }
                                                                }

                                                                function callmodule() {
                                                                    xmlhttp = createRequest();
                                                                    if (xmlhttp !== null) {

                                                                        var product = document.theForm.product.value;
                                                                        var version = document.theForm.version.value;
                                                                        xmlhttp.open("GET", "<%= request.getContextPath()%>/CreateIssue/ModuleDetails.jsp?product=" + product + "&version=" + version + "&rand=" + Math.random(1, 10), false);
                                                                        xmlhttp.onreadystatechange = callbackmodule;
                                                                        xmlhttp.send(null);
                                                                    }
                                                                }

                                                                function callbackmodule() {

                                                                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {

                                                                        var name = xmlhttp.responseText;
                                                                        var result = xmlhttp.responseText.split(";");
                                                                        var results = result[1].split(",");
                                                                        objLinkList = eval(document.getElementById("module"));
                                                                        objLinkList.length = 0;
                                                                        for (i = 0; i < results.length - 1; i++) {
                                                                            objLinkList.length++;
                                                                            objLinkList[i].text = results[i];
                                                                            objLinkList[i].value = results[i];
                                                                        }

                                                                    }
                                                                }
                                                                function callduedate() {
                                                                    xmlhttp = createRequest();
                                                                    if (xmlhttp !== null) {

                                                                        var product = document.getElementById("product").value;
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
                                                                var prDate = '';
                                                                function prposalCheck() {
                                                                    xmlhttp = createRequest();
                                                                    if (xmlhttp !== null) {

                                                                        var product = document.getElementById("product").value;
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

                                                                function isDuedateCorrect() {
                                                                    xmlhttp = createRequest();
                                                                    if (!xmlhttp && typeof XMLHttpRequest !== 'undefined') {
                                                                        xmlhttp = new XMLHttpRequest();
                                                                    }
                                                                    if (xmlhttp !== null) {

                                                                        var dueDate = theForm.date.value;
                                                                        xmlhttp.open("GET", "<%= request.getContextPath()%>/eTracker/CreateIssue/dueDateCheck.jsp?dueDate=" + dueDate + "&rand=" + Math.random(1, 10), true);
                                                                        xmlhttp.onreadystatechange = dueDateAlert;
                                                                        xmlhttp.send(null);
                                                                    }
                                                                }


                                                                function dueDateAlert() {
                                                                    if (xmlhttp.readyState === 4) {
                                                                        if (xmlhttp.status === 200) {

                                                                            var due = xmlhttp.responseText.split(",");
                                                                            var flag = due[1];

                                                                            if (flag !== 'correct') {

                                                                                alert("Due Date should be less than Project End Date (" + flag + ").Please contact your Project Manager");

                                                                                theForm.date.value = "";


                                                                            }

                                                                        }
                                                                    }
                                                                }




                                                                function printpost(post)
                                                                {
                                                                    pp = window.open('profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                                                                    pp.focus();
                                                                }
                                                                function trim(str)
                                                                {
                                                                    while (str.charAt(str.length - 1) === " ")
                                                                        str = str.substring(0, str.length - 1);
                                                                    while (str.charAt(0) === " ")
                                                                        str = str.substring(1, str.length);
                                                                    return str;
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

                                                                function validate()
                                                                {
                                                                    if (document.getElementById('product').value === "--Select One--")
                                                                    {
                                                                        alert("Please select the Project Name");
                                                                        document.theForm.product.focus();
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
                                                                    if (trim(CKEDITOR.instances.description.getData()) === "")
                                                                    {
                                                                        alert("Please Enter the Description");
                                                                        CKEDITOR.instances.description.focus();
                                                                        return false;
                                                                    }
                                                                    if (CKEDITOR.instances.description.getData().length > 4000)
                                                                    {
                                                                        alert(" Description exceeds 4000 character");
                                                                        CKEDITOR.instances.description.focus();
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

                                                                    var pIssues = '';
                                                                    function displayAlertPrposalIssues() {
                                                                        var product = document.getElementById("product").value;
                                                                        var version = document.getElementById("version").value;
                                                                        var module = document.getElementById("module").value;
                                                                        var severity = document.getElementById("severity").value;
                                                                        var priority = document.getElementById("priority").value;
                                                                        var orgDueDate = document.theForm.date.value;
                                                                        xmlhttp.open("GET", "<%= request.getContextPath() %>/CreateIssue/prposeAlert.jsp?product=" + product + "&version=" + version + "&module=" + module + "&severity=" + severity + "&priority=" + priority + "&pDate=" + prDate + "&orgDueDate=" + orgDueDate + "&rand=" + Math.random(1, 10), false);
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
                                                                                document.getElementById("creatissueforma").innerHTML = "<table align=\"center\"><tr><td ><input type=\"submit\" name=\"submit\" id=\"submit\"  value=\"Confirm  & Submit\" onclick=\"proposalOk()\"/></td><td>" +
                                                                                        "<input type=\"button\" value=\"Cancel\" onclick=\"proposalNotOk()\"/></td></tr></table>";
                                                                            }
                                                                        }
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

                                                                    disableSubmit();
                                                                }
                                                            </script>
                                                            </body>
                                                            </html>
