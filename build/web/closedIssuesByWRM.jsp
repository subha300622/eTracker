<%-- 
    Document   : closedIssuesByWRM
    Created on : May 29, 2014, 11:52:56 AM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.util.ProjectPlanUtil"%>
<%@page import="com.eminent.issue.ProjectPlannedIssue"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.util.GetAge"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Logger logger = Logger.getLogger("closedIssuesByWRM");
    HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
    Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
    Map<String, Integer> fileCountList = new HashMap<String, Integer>();
    SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy");
    String project = request.getParameter("pid");
    String wrmparam = request.getParameter("wrmDay");
    Calendar cal = Calendar.getInstance();
    Date plannedOn = cal.getTime();
    String planDate = request.getParameter("planDate");
    if (planDate != null) {
        planDate = com.pack.ChangeFormat.changeDateFormat(planDate.trim());
        plannedOn = sdfs.parse(planDate);
    }
    List<ProjectPlannedIssue> weekWisePlanIssue = ProjectPlanUtil.findByDayAndProjectId(plannedOn, Long.valueOf(project.trim()));
    List<String> planIssues = new ArrayList<String>();
    for (ProjectPlannedIssue ppi : weekWisePlanIssue) {
        if (ppi.getStatus().equalsIgnoreCase(PlanStatus.ACTIVE.getStatus())) {
            planIssues.add(ppi.getIssueId());
        }
    }

    Calendar wrmcal = Calendar.getInstance();
    int day = ProjectFinder.getProjectWRMDay(Integer.valueOf(project));
    if (day == 0) {
        day = 2;
    }
    wrmcal.set(Calendar.DAY_OF_WEEK, day);
    wrmcal.add(Calendar.DATE, -7);
    Date wrmStartDate = wrmcal.getTime();
    if (wrmparam != null) {
        wrmStartDate = sdfs.parse(wrmparam);
    }
    wrmcal.setTime(wrmStartDate);
    wrmcal.add(Calendar.DATE, 7);
    Date wrmEndDate = wrmcal.getTime();
    String closedIssueDetails[][] = IssueDetails.closedIssuesByProject(project);
    List<String> plannedissuenos = MoMUtil.todayPlannedIssues(sdfs.format(plannedOn));
    int wrmClosedCount = 0;
    if (closedIssueDetails != null) {
        for (int i = 0; i < closedIssueDetails.length; i++) {
            String modifiedOn = closedIssueDetails[i][17];
            Date mod = sdfs.parse(modifiedOn);
            if (wrmStartDate.compareTo(mod) * mod.compareTo(wrmEndDate) >= 0) {
                wrmClosedCount++;
            }
        }
        EscalationDAO escalationDAO = new EscalationDAOImpl();
        List<String> escalationIssues = escalationDAO.AllEscalations(Integer.valueOf(project));
        String mail = (String) session.getAttribute("theName");
        String url = null;
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
%>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
<script type="text/javascript">
    $(document).ready(function ()
    {

        $("#closedTable").tablesorter({
            // change the multi sort key from the default shift to alt button 
            sortMultiSortKey: 'altKey',
            headers: {
                6: {// <-- replace 6 with the zero-based index of your column
                    sorter: 'ddMMMyy'
                }
            }
        });
        $("#prevClosedTable").tablesorter({
            // change the multi sort key from the default shift to alt button 
            sortMultiSortKey: 'altKey',
            headers: {
                6: {// <-- replace 6 with the zero-based index of your column
                    sorter: 'ddMMMyy'
                }
            }
        });


    }
    );

</script>
<div id="apm" class="hide_me">
    <div  style="width: 100%;text-align: left;font-weight: bold;color: blue;height: 15px;">Closed issues during WRM Week <%=sdfs.format(wrmStartDate)%> to <%=sdfs.format(wrmEndDate)%> = <%=wrmClosedCount%></div>
    <%if (wrmClosedCount == 0) {%>
    <br/>
    <%}%>
    <%if (wrmClosedCount > 0) {%>
    <table width="100%" height="23" id="closedTable" class="tablesorter">
        <thead>
            <TR bgcolor="#C3D9FF" style="height: 21px;">
                <TH style="background-color: #C3D9FF;" width="3%" TITLE="Severity"><font><b>S</b></font></TH>
                <TH class="header" width="16%"><font><b>Issue No</b></font></TH>
                <TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>
                <TH class="header" width="7%"><font><b>Module</b></font></TH>
                <TH class="header" width="28%"><font><b>Subject</b></font></TH>
                <TH class="header" width="11%"><font><b>Status</b></font></TH>
                <TH class="header" width="10%"><font><b>Due Date</b></font></TH>
                <TH class="header" width="11%"><font><b>AssignedTo</b></font></TH>
                <TH class="header" width="8%"><font><b>Refer</b></font></TH>
                <TH class="header" width="4%" TITLE="In Days"><font><b>Age</b></font></TH>

            </TR>
        </thead>

        <%
            try {
                String closedissuenos = "", escColor = "#000000";
                for (int i = 0; i < closedIssueDetails.length; i++) {
                    closedissuenos = closedissuenos + "'" + closedIssueDetails[i][0] + "',";
                }
                if (closedissuenos.contains(",")) {
                    closedissuenos = closedissuenos.substring(0, closedissuenos.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(closedissuenos);
                    fileCountList = IssueDetails.displayFilesCount(closedissuenos);
                }
                int j = 1;

                for (int i = 0; i < closedIssueDetails.length; i++) {
                    String modified = closedIssueDetails[i][17];
                    Date mod = sdfs.parse(modified);
					escColor = "#000000";
                    if (wrmStartDate.compareTo(mod) * mod.compareTo(wrmEndDate) >= 0) {
                        j++;
                        String iss = closedIssueDetails[i][0];
                        String project1 = closedIssueDetails[i][1];
                        String type = closedIssueDetails[i][2];
                        String status = closedIssueDetails[i][3];
                        String sub = closedIssueDetails[i][4];
                        String desc = closedIssueDetails[i][5];
                        String pri = closedIssueDetails[i][6];
                        String sev = closedIssueDetails[i][7];
                        String createdBy = closedIssueDetails[i][8];
                        String createdOn = closedIssueDetails[i][9];
                        String assignedTo = closedIssueDetails[i][10];
                        String modifiedOn = closedIssueDetails[i][11];
                        String dueDateFormat = closedIssueDetails[i][12];
                        String rating = closedIssueDetails[i][13];
                        String feedback = closedIssueDetails[i][14];
                        String module = closedIssueDetails[i][15];
                        String color = "";
                        if (escalationIssues.contains(iss) && url.equals("eminentlabs.net")) {
                            escColor = "red";
                        }
                        if (status.equalsIgnoreCase("Closed")) {
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

                        assignedTo = member.get(current);

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

                        //                age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                        //                         logger.info("Calculated time........"+i);
                        //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                        int age = Integer.valueOf(closedIssueDetails[i][16]);
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
                        if ((j % 2) != 0) {
        %>
        <tr bgcolor="#E8EEF7" height="23">
            <%                } else {
            %>

        <tr bgcolor="white" height="23">
            <%                    }
            %>


            <% if (sev.equals(s1)) {%>
            <td width="3%" bgcolor="#FF0000"></td>
            <%} else if (sev.equals(s2)) {%>
            <td width="3%" bgcolor="#FF9900"></td>
            <%} else if (sev.equals(s3)) {%>
            <td width="3%" bgcolor="#FFFF00"></td>
            <%} else if (sev.equals(s4)) {%>
            <td width="3%" bgcolor="#00FF40"><br>
            </td>
            <%}%>
            <td width="16%" TITLE="<%= type%>">


                <A
                    HREF="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=iss%>"> <font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                    </font></A><%
                        if (planIssues.contains(iss)) {
                            if (plannedissuenos.contains(iss)) {
                    %>
                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                <%
                } else {
                %>
                <img src="<%=request.getContextPath()%>/images/yt.png" height="14" width="10" title="Customer Priority" style="cursor: pointer;"/>          
                <%
                        }

                    }
                %></td>
            <td width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><%= p%> </font></td>

            <td title="<%=fullModule%>" style="width: 7%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
            <td id="<%=iss%>tab" style="width: 28%;" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= sub%></font></td>

            <td width="11%" bgcolor="<%=color%>" title="<%=feedback%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                             size="1" color="#000000"><%= status%> </font></td>
                <%

                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
            %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else {
            %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
            </td>
            <%
                }
            %>
            <td width="11%" title="Created By <%= member.get(Integer.valueOf(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%=assignedTo%>
                </font></td>
                <%
                    int fileCount = 0;
                    if (fileCountList.get(iss) != null) {
                        fileCount = fileCountList.get(iss);
                    }
                    if (fileCount > 0) {%>
            <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                    <%} else {%>
            <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000">No Files</font></td>
                <%}


                %>
            <td title="<%=lastAsigneeAge%>" style="width: 4%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
        </tr>
        <%
                    }
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
    </table>
    <%}%>

    <div style="width: 100%;text-align: left;font-weight: bold;color: blue;height: 15px;">Remaining Closed Issues = <%=closedIssueDetails.length - wrmClosedCount%></div>
    <%if (closedIssueDetails.length - wrmClosedCount > 0) {%>
    <table width="100%" height="23" id="prevClosedTable" class="tablesorter">
        <thead>
            <TR bgcolor="#C3D9FF" style="height: 21px;">
                <TH style="background-color: #C3D9FF;" width="3%" TITLE="Severity"><font><b>S</b></font></TH>
                <TH class="header" width="16%"><font><b>Issue No</b></font></TH>
                <TH class="header" width="2%" TITLE="Priority"><font><b>P</b></font></TH>
                <TH class="header" width="7%"><font><b>Module</b></font></TH>
                <TH class="header" width="28%"><font><b>Subject</b></font></TH>
                <TH class="header" width="11%"><font><b>Status</b></font></TH>
                <TH class="header" width="10%"><font><b>Due Date</b></font></TH>
                <TH class="header" width="11%"><font><b>AssignedTo</b></font></TH>
                <TH class="header" width="8%"><font><b>Refer</b></font></TH>
                <TH class="header" width="4%" TITLE="In Days"><font><b>Age</b></font></TH>

            </TR>
        </thead>

        <%
            try {
                String closedissuenos = "";
                for (int i = 0; i < closedIssueDetails.length; i++) {
                    closedissuenos = closedissuenos + "'" + closedIssueDetails[i][0] + "',";
                }
                if (closedissuenos.contains(",")) {
                    closedissuenos = closedissuenos.substring(0, closedissuenos.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(closedissuenos);
                    fileCountList = IssueDetails.displayFilesCount(closedissuenos);
                }

                int j = 1;
                for (int i = 0; i < closedIssueDetails.length; i++) {
                    String modified = closedIssueDetails[i][17];
                    Date mod = sdfs.parse(modified);
                    if (wrmStartDate.compareTo(mod) * mod.compareTo(wrmEndDate) < 0) {
                        j++;
                        String iss = closedIssueDetails[i][0];
                        String project1 = closedIssueDetails[i][1];
                        String type = closedIssueDetails[i][2];
                        String status = closedIssueDetails[i][3];
                        String sub = closedIssueDetails[i][4];
                        String desc = closedIssueDetails[i][5];
                        String pri = closedIssueDetails[i][6];
                        String sev = closedIssueDetails[i][7];
                        String createdBy = closedIssueDetails[i][8];
                        String createdOn = closedIssueDetails[i][9];
                        String assignedTo = closedIssueDetails[i][10];
                        String modifiedOn = closedIssueDetails[i][11];
                        String dueDateFormat = closedIssueDetails[i][12];
                        String rating = closedIssueDetails[i][13];
                        String feedback = closedIssueDetails[i][14];
                        String module = closedIssueDetails[i][15];
                        String color = "";

                        if (status.equalsIgnoreCase("Closed")) {
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

                        assignedTo = member.get(current);

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

                        //                age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                        //                         logger.info("Calculated time........"+i);
                        //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                        int age = Integer.valueOf(closedIssueDetails[i][16]);
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
                        if ((j % 2) != 0) {
        %>
        <tr bgcolor="#E8EEF7" height="23">
            <%                } else {
            %>

        <tr bgcolor="white" height="23">
            <%                    }
            %>


            <% if (sev.equals(s1)) {%>
            <td width="3%" bgcolor="#FF0000"></td>
            <%} else if (sev.equals(s2)) {%>
            <td width="3%" bgcolor="#FF9900"></td>
            <%} else if (sev.equals(s3)) {%>
            <td width="3%" bgcolor="#FFFF00"></td>
            <%} else if (sev.equals(s4)) {%>
            <td width="3%" bgcolor="#00FF40"><br>
            </td>
            <%}%>
            <td width="16%" TITLE="<%= type%>">


                <A
                    HREF="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=iss%>"> <font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                    </font></A><%
                        if (planIssues.contains(iss)) {
                            if (plannedissuenos.contains(iss)) {
                    %>
                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                <%
                } else {
                %>
                <img src="<%=request.getContextPath()%>/images/yt.png" height="14" width="10" title="Customer Priority" style="cursor: pointer;"/>          
                <%
                        }

                    }
                %></td>
            <td width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><%= p%> </font></td>

            <td title="<%=fullModule%>" style="width: 7%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
            <td id="<%=iss%>tab" style="width: 28%;" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>

            <td width="11%" bgcolor="<%=color%>" title="<%=feedback%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                             size="1" color="#000000"><%= status%> </font></td>
                <%

                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
            %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else {
            %>
            <td width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
            </td>
            <%
                }
            %>
            <td width="11%" title="Created By <%= member.get(Integer.valueOf(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                </font></td>
                <%
                    int fileCount = 0;
                    if (fileCountList.get(iss) != null) {
                        fileCount = fileCountList.get(iss);
                    }
                    if (fileCount > 0) {%>
            <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                    <%} else {%>
            <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000">No Files</font></td>
                <%}


                %>
            <td title="<%=lastAsigneeAge%>" style="width: 4%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
        </tr>
        <%
                    }
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
    </table>
    <%}%>
</div>
<%}%>
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
