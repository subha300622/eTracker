<%-- 
    Document   : getSubIssues
    Created on : 12 May, 2020, 3:59:12 PM
    Author     : vanithaalliraj
--%>

<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetAge"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="dashboard.CheckDate"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="com.eminent.issue.Issue"%>
<%@page import="java.util.List"%>

    <%        Map<String, Integer> lastAsigneeAgeList = new HashMap();
        Map<String, Integer> fileCountList = new HashMap();
                HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
                String mainIssue =request.getParameter("mainIssue");
        String issueDetails[][] = IssueDetails.getSubIssues(mainIssue);
        String totalissuenos = "";
        for (int i = 0; i < issueDetails.length; i++) {
            totalissuenos = totalissuenos + "'" + issueDetails[i][0] + "',";
        }

        if (totalissuenos.contains(",")) {
            totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
            lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
            fileCountList = IssueDetails.displayFilesCount(totalissuenos);
        }
    %>
    <td colspan="10" > <span style="background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;">This list shows <%=issueDetails.length%> sub issues of <%=mainIssue%></span>
    <table width="100%" height="23" >
        <tr bgcolor="#C3D9FF" height="21">
            <th class="header severity "style="background-color: #C3D9FF;" width="3%" TITLE="Severity"><div class="some-handle"></div><font><b>S</b></font></th>
            <th class="header issueNo" width="16%"><font><b>Sub Issue No</b></font></th>
            <th class="header priority "  width="2%" TITLE="Priority"><div class="some-handle"></div><font><b>P</b></font></th>
            <th class="header module " width="7%"><div class="some-handle"></div><font><b>Module</b></font></th>
            <th class="header subject " width="28%"><div class="some-handle"></div><font><b>Subject</b></font></th>
            <th class="header status " width="11%"><div class="some-handle"></div><font><b>Status</b></font></th>
            <th class="header dueDate "  width="10%"><div class="some-handle"></div><font><b>Due Date</b></font></th>
            <th class="header assignedTo " width="11%"><div class="some-handle"></div><font><b>AssignedTo</b></font></th>
            <th class="header refer " width="8%"><div class="some-handle"></div><font><b>Refer</b></font></th>
            <th class="header age " width="4%" TITLE="In Days"><div class="some-handle"></div><font><b>Age</b></font></th>

        </tr>

        <%
            int k = 0, age = 0;
           
                for (int i = 0; i < issueDetails.length; i++) {

                    String assignedTo = issueDetails[i][10];
                    int assi = Integer.parseInt(assignedTo);
                    k++;
                    String iss = issueDetails[i][0];
                    String project1 = issueDetails[i][1];
                    String type = issueDetails[i][2];
                    String status = issueDetails[i][3];
                    String sub = issueDetails[i][4];
                    String subject = issueDetails[i][4];
                    String desc = issueDetails[i][5];
                    String pri = issueDetails[i][6];
                    String sev = issueDetails[i][7];
                    String createdBy = issueDetails[i][8];
                    String createdOn = issueDetails[i][9];

                    String modifiedOn = issueDetails[i][11];
                    String dueDateFormat = issueDetails[i][12];
                    String rating = issueDetails[i][13];
                    String feedback = issueDetails[i][14];
                    String module = issueDetails[i][15];

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
                    age = Integer.valueOf(issueDetails[i][16]);
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

                    String bgcolor = "";
                    if (sev.equals(s1)) {
                        bgcolor = "#FF0000";
                    } else if (sev.equals(s2)) {
                        bgcolor = "#FF9900";
                    } else if (sev.equals(s3)) {
                        bgcolor = "#FFFF00";
                    } else if (sev.equals(s4)) {
                        bgcolor = "#00FF40";
                    }
                    if ((k % 2) == 0) {

        %>
        <tr class="zebraline"  height="23" id="main<%=iss%>">
            <%                } else {
            %>

        <tr class="zebralinealter" height="23" id="main<%=iss%>">
            <%                    }
            %>


            <td class="severity" width="3%" bgcolor="<%=bgcolor%>">

            </td>
            <td class="issueNo" width="16%" TITLE="<%= type%>">
                

                <A
                    HREF="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=iss%>"> <font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                    </font></A></td>
            <td class="priority" width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                  size="1" color="#000000"><%= p%> </font></td>

            <td class="module" title="<%=fullModule%>" style="width: 7%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
            <td class="subject" id="<%=iss%>tab"  style="width: 28%;" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><span id="<%=iss%>span"><%= sub%></span></font><div class="issuetooltip" id="<%=iss%>"><%= desc%></div>
                <input id="<%=iss%>sub" type="hidden" value="<%=subject%>"/>
            </td>

            <td class="status" width="11%" onclick="showPrint('<%=iss%>');" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                           size="1" color="#000000"><%= status%> </font></td>
                <%

                    if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                %>
            <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
            %>
            <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
            </td>
            <%
            } else {
            %>
            <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
            </td>
            <%
                }
            %>
            <td class="assignedTo" width="11%" title="Created By <%= member.get(Integer.parseInt(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                </font></td>
                <%
                    int fileCount = 0;
                    if (fileCountList.get(iss) != null) {
                        fileCount = fileCountList.get(iss);
                    }
                    if (fileCount > 0) {%>
            <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                               size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                    <%} else {%>
            <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                               size="1" color="#000000">No Files</font></td>
                <%}


                %>
            <td class="age" title="<%=lastAsigneeAge%>" style="width:4%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
        </tr>
        <%}%>
    </tbody>
</table>
    <br>
    </td>
    
