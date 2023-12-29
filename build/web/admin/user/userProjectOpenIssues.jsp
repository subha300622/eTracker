<%-- 
    Document   : userProjectOpenIssues
    Created on : 17 Nov, 2014, 11:21:49 AM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>
<%@ page import="com.eminent.issue.formbean.LastAssginForm"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("UserOpenIssues");
    

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    </HEAD>

    <BODY>

        <%!    Connection connection;
            Statement state, state1;
            PreparedStatement psforissuedetails;
            ResultSet result;
            ResultSet rs;
            String start, end, timeSheetId;

        %>

        <jsp:useBean id="RightsSetup" scope="page"
                     class="com.pack.RightsSetupBean" />
        <jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>



        <%@ include file="/header.jsp"%>




            <div align="center">
                <center>
                    <br>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr border="2" bgcolor="#E8EEF7">
                            <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                                COLOR="#0000FF"> <b> User Assigned Issues  </b></font><FONT
                                    SIZE="3" COLOR="#0000FF"> </FONT>


                        </tr>
                    </table>
                    <br>
                <%!    int userid_curri, age, rowcount;
                    String workeduserid;
                    String assignmentType = "";
                                                                                                %>

                <%
                    String query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                    String mail = (String) session.getAttribute("theName");
                    String url = null;
                    if (mail != null) {
                        url = mail.substring(mail.indexOf("@") + 1, mail.length());
                    }
                    String selectedUser = "";
                    if (request.getParameter("userId") != null) {
                        selectedUser = request.getParameter("userId");
                    }
                    HashMap<Integer, String> member = GetProjectMembers.showUsersSName();

                    int currentUser = (Integer) session.getAttribute("uid");
                    String for_ward = "/admin/user/userProjectOpenIssues.jsp?userId=" + selectedUser;

                    try {
                        if (url.equalsIgnoreCase("eminentlabs.net")) {
                            String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + selectedUser + "' intersect select k.pid from userproject k where k.userid='" + currentUser + "')";
                            if (currentUser == 104) {
                                extendedQuery = "";

                            }
                            String backlog = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date < sysdate-1 " + extendedQuery + "order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                            String currentWeek = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual)" + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                            String nextWeek = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+1 from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual)" + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                            String afterTwoWeeks = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+8 from dual) " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                            String all = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                            int bCount = UserIssueCount.getAssignmentWithTypeCount(backlog);
                            int cuCount = UserIssueCount.getAssignmentWithTypeCount(currentWeek);
                            int nxCount = UserIssueCount.getAssignmentWithTypeCount(nextWeek);
                            int atCount = UserIssueCount.getAssignmentWithTypeCount(afterTwoWeeks);
                            int alCount = UserIssueCount.getAssignmentWithTypeCount(all);
                            if (bCount > 0) {
                                assignmentType = "backlog";
                            } else if (cuCount > 0) {
                                assignmentType = "currentWeek";
                            } else if (cuCount > 0) {
                                assignmentType = "nextWeek";
                            } else if (cuCount > 0) {
                                assignmentType = "afterTwoWeeks";
                            }
                            if (request.getParameter("assignmentType") != null) {
                                assignmentType = request.getParameter("assignmentType");
                            }

                            if (assignmentType.equalsIgnoreCase("backlog")) {
                                query = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date < sysdate-1 ";
                            } else if (assignmentType.equalsIgnoreCase("currentWeek")) {
                                query = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) ";
                            } else if (assignmentType.equalsIgnoreCase("nextWeek")) {
                                query = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+1 from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+7 from dual)";
                            } else if (assignmentType.equalsIgnoreCase("afterTwoWeeks")) {
                                query = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser + " and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+8 from dual) ";
                            } else {
                                query = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module, ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + selectedUser;
                            }
                            session.setAttribute("forwardpage", for_ward + "&assignmentType=" + assignmentType);
                %>
                <table width="100%" border="0">
                    <tr height="10" >
                        <td align="left" colspan="10"><a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?assignmentType=backlog&userId=<%=selectedUser%>"><%if (assignmentType.equalsIgnoreCase("backlog")) {%><b style="color: blue;">Backlog(<%=bCount%>)</b><%} else {%>Backlog(<%=bCount%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?assignmentType=currentWeek&userId=<%=selectedUser%>"><%if (assignmentType.equalsIgnoreCase("currentWeek")) {%><b style="color: blue;">Current Week(<%=cuCount%>)</b><%} else {%>Current Week(<%=cuCount%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?assignmentType=nextWeek&userId=<%=selectedUser%>"><%if (assignmentType.equalsIgnoreCase("nextWeek")) {%><b style="color: blue;">Next Week(<%=nxCount%>)</b><%} else {%>Next Week(<%=nxCount%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?assignmentType=afterTwoWeeks&userId=<%=selectedUser%>"><%if (assignmentType.equalsIgnoreCase("afterTwoWeeks")) {%><b style="color: blue;">After two weeks(<%=atCount%>)</b><%} else {%>After two weeks(<%=atCount%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?assignmentType=all&userId=<%=selectedUser%>"><%if (assignmentType.equalsIgnoreCase("all")) {%><b style="color:blue;">All(<%=alCount%>)<%} else {%>All(<%=alCount%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
                <% }

                    //		logger.info("worked User:"+workeduserid);
                    //        logger.info("Selected Start Date"+selectedStartDate);
                    //        logger.info("Selected End Date"+selectedEndDate);
                    String issueDetails[][] = IssueDetails.userAssignedIssues(((Integer) currentUser).toString(), selectedUser, query);
                    rowcount = issueDetails.length;
                %>



                <table width="100%">
                    <tr height="10">
                        <td align="left" width="100%">This list shows <b><%=rowcount%></b> <%=assignmentType%> issues assigned to <%=GetProjectManager.getUserName(Integer.parseInt(selectedUser))%>.</td>
                        <TD align="right" width="25">Severity</TD>
                        <TD align="right" width="25" bgcolor="#FF0000">S1</TD>
                        <TD align="right" width="25" bgcolor="#FF9900">S2</TD>
                        <TD align="right" width="25" bgcolor="#FFFF00">S3</TD>
                        <TD align="right" width="25" bgcolor="#33FF33">S4</TD>
                    </tr>
                </table>
                <br>
                <table width="100%" height="23">
                    <TR bgcolor="#C3D9FF">
                        <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                        <TD width="9%"><font><b>Issue No</b></font></TD>
                        <TD width="1%" TITLE="Priority"><font><b>P</b></font></TD>
                        <TD width="10%"><font><b>Project</b></font></TD>
                        <TD width="10%"><font><b>Module</b></font></TD>
                        <TD width="29%"><font><b>Subject</b></font></TD>
                        <TD width="9%"><font><b>Status</b></font></TD>
                        <TD width="9%"><font><b>Due Date</b></font></TD>
                        <TD width="13%"><font><b>CreatedBy</b></font></TD>
                        <TD width="7%"><font><b>Refer</b></font></TD>
                        <TD width="5%" TITLE="In Days"><font><b>Age</b></font></TD>

                    </TR>

                    <%
                        String totalissuenos = "";
                        for (int i = 0; i < rowcount; i++) {
                            totalissuenos = totalissuenos + "'" + issueDetails[i][0].trim() + "',";
                        }
                        Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                        Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                        List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
                        if (totalissuenos.contains(",")) {
                            totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                            lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                            fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            lastAssign = IssueDetails.lastAssign();
                        }
                        for (int i = 0; i < rowcount; i++) {

                            String iss = issueDetails[i][0];
                            String project1 = issueDetails[i][1];
                            String type = issueDetails[i][2];
                            String status = issueDetails[i][3];
                            String sub = issueDetails[i][4];
                            String desc = issueDetails[i][5];
                            String pri = issueDetails[i][6];
                            String sev = issueDetails[i][7];
                            String createdBy = issueDetails[i][8];
                            if (createdBy != null) {
                                createdBy = member.get(Integer.valueOf(createdBy));
                            }
                            String createdOn = issueDetails[i][9];
                            String assignedTo = issueDetails[i][10];
                            String modifiedOn = issueDetails[i][11];
                            String dueDateFormat = issueDetails[i][12];
                            String module = issueDetails[i][13];
                            age = Integer.valueOf(issueDetails[i][14]);
                            String fullModule = module;
                            if (module.length() > 10) {
                                module = module.substring(0, 10) + "...";
                            }
                            if (sub.length() > 42) {
                                sub = sub.substring(0, 42) + "...";
                            }

                            int current = Integer.parseInt(assignedTo);
                            String p = "NA";
                            if (pri != null) {
                                p = pri.substring(0, 2);
                            }

                            session.setAttribute("theissno", iss);
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                            SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

                            String dueDate = "NA";
                            if (dueDateFormat != null) {
                                dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                            }

                            String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                            String create = sdf.format(dateConversion.parse(createdOn));

                            String s1 = "S1- Fatal";
                            String s2 = "S2- Critical";
                            String s3 = "S3- Important";
                            String s4 = "S4- Minor";
//                            logger.info("Processing data........" + i);

                            int lastAsigneeAge = 1;
                            if (lastAsigneeAgeList.containsKey(iss)) {
                                lastAsigneeAge = lastAsigneeAgeList.get(iss);
                            }
                            if (lastAsigneeAge == 1) {
                                lastAsigneeAge = age;
                            }
                            if (lastAsigneeAge == 0) {
                                lastAsigneeAge = lastAsigneeAge + 1;
                            }

                            String lastAssignee = "";
                            String lastModifliedOn = "N/A";

                            for (LastAssginForm lastAssignForm : lastAssign) {
                                if (iss.equals(lastAssignForm.getIssueId())) {
                                    lastAssignee = lastAssignForm.getLastAssigneeName();
                                    lastModifliedOn = lastAssignForm.getLastModifiedOn();
                                }
                            }

                            //                                     age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                            //                         logger.info("Calculated time........"+i);
                            //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                            if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="#E8EEF7" height="23">
                        <%                } else {
                        %>

                    <tr bgcolor="white" height="23">
                        <%                    }
                        %>


                        <% if (sev.equals(s1)) {%>
                        <td width="1%" bgcolor="#FF0000"></td>
                        <%} else if (sev.equals(s2)) {%>
                        <td width="1%" bgcolor="#FF9900"></td>
                        <%} else if (sev.equals(s3)) {%>
                        <td width="1%" bgcolor="#FFFF00"></td>
                        <%} else if (sev.equals(s4)) {%>
                        <td width="1%" bgcolor="#00FF40"><br>
                        </td>
                        <%}%>
                        <td width="9%" TITLE="<%= type%>"><A
                                HREF="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=iss%>"> <font
                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                </font></A></td>
                        <td width="1%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= p%> </font></td>
                                <%

                                    if (project1.length() < 15) {
                                %>
                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1%></font></td>
                                <%
                                } else {
                                %>
                        <td width="10%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0, 15) + "..."%></font></td>
                                <%
                                    }
                                %>
                        <td width="10%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                        <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>

                        <td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= status%> </font></td>
                                <%

                                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                %>
                        <td width="9%" title="Last Modified On <%= dateString1%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                        </td>
                        <%
                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                        %>
                        <td width="9%" title="Last Modified On <%= dateString1%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                        </td>
                        <%
                        } else {
                        %>
                        <td width="9%" title="Last Modified On <%= dateString1%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                        </td>
                        <%
                            }
                        %>
                        <td width="13%" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000" title="Assignedby <%=lastAssignee%> at <%=lastModifliedOn%>"><%=createdBy%>
                            </font></td>
                            <%
                                int fileCount = 0;
                                if (fileCountList.containsKey(iss)) {
                                    fileCount = fileCountList.get(iss);
                                }
                                if (fileCount > 0) {%>
                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                                    <%} else {%>
                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000">No Files</font></td>
                                <%}%>
                        <td title="<%=age%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=lastAsigneeAge%></font></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            logger.error("Exception:" + e);
                        }

                    %>
                </table>

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
</HTML>

