<%-- 
    Document   : eminentCreatedIssue
    Created on : Nov 23, 2009, 8:02:26 PM
    Author     : Administrator
--%>



<%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet"%>
<%@ page import="java.sql.*, dashboard.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="com.eminent.util.*"%>
<%@ page import="java.util.*, java.text.*, com.pack.*"%>

<%

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("eminentCreatedIssues");
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
        <script type="text/javascript">
            function monthSelection() {

                var date = 1;
                var startMonth = 7;
                var startYear = 2008;

                var startRange = new Date(startYear, startMonth, date);

                var month = document.getElementById("month").value;
                var year = document.getElementById("year").value;
                var selectedValue = new Date(year, month, date);
                var current_date = new Date();
                if (selectedValue >= startRange && selectedValue <= current_date) {
                    document.getElementById('button').value = 'Processing';
                    document.getElementById('button').disabled = true;
                    var chartType = document.getElementById("chartType").value;
                    if (chartType == "Open") {
                        location = 'eminentOpenIssues.jsp?month=' + month + '&year=' + year;
                    } else if (chartType == "Worked") {
                        location = 'eminentWorkedIssues.jsp?month=' + month + '&year=' + year;
                    } else if (chartType == "Created") {
                        location = 'eminentCreatedIssues.jsp?month=' + month + '&year=' + year;
                    } else {
                        location = 'eminentClosedIssues.jsp?month=' + month + '&year=' + year;
                    }
                } else {
                    alert("You can view Created Issues from Aug 2008 to Current Month");
                }
            }
            function timeSheetApproval() {
                document.getElementById("timeSheet").style.visibility = 'hidden';
                location = 'timeSheet.jsp?timeSheetId=' + timeSheetid + "'";
            }
        </script>
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
        <jsp:useBean id="mic" class="com.eminent.issue.controller.ModuleIssuesChart"></jsp:useBean>
        <%!
            Connection connection;
            Statement state, state1;
            PreparedStatement psforissuedetails;
            ResultSet result;
            ResultSet rs;
            String start, end, timeSheetId;
            int i, year, month, timeSheetMonth, timeSheetYear;
            private static HashMap<Integer, String> monthSelect = new HashMap<Integer, String>();

            static {

                monthSelect.put(0, "Jan");
                monthSelect.put(1, "Feb");
                monthSelect.put(2, "Mar");
                monthSelect.put(3, "Apr");
                monthSelect.put(4, "May");
                monthSelect.put(5, "Jun");
                monthSelect.put(6, "Jul");
                monthSelect.put(7, "Aug");
                monthSelect.put(8, "Sep");
                monthSelect.put(9, "Oct");
                monthSelect.put(10, "Nov");
                monthSelect.put(11, "Dec");

            }
        %>

        <jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>



        <%@ include file="/header.jsp"%>




        <jsp:useBean id="MyIssue" class="com.pack.UpdateIssueBean"></jsp:useBean>

        <%!
            int requestpage, pageone, pageremain, rowcount;
            static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
            int userid_curri, age;
            HashMap hm;
            String workeduserid;
        %>

        <%
            //Statement stmt=null;
            PreparedStatement pt = null, pt1 = null, pt2 = null, ps = null;
            ResultSet rs1 = null, rs2 = null, rs3 = null;
            int userId = (Integer) session.getAttribute("uid");
            String timeSheetid = request.getParameter("timeSheetId");

            try {

                connection = MakeConnection.getConnection();

                if (hm == null) {
                    hm = MyIssue.showUsers(connection);
                }

                logger.debug("SIZE:" + hm.size());

                if (request.getParameter("userId") == null) {
                    workeduserid = (String) session.getAttribute("WorkedIssueUser");
                } else {
                    workeduserid = request.getParameter("userId");
                    session.setAttribute("WorkedIssueUser", workeduserid);
                }
        //		logger.info("worked User:"+workeduserid);

                //calculating start and end date of this month
                Calendar cal = new GregorianCalendar();
                int currentYear = cal.get(Calendar.YEAR);
                int currentMonth = cal.get(Calendar.MONTH);
                int currentDay = cal.get(Calendar.DAY_OF_MONTH);

                String selectYear = request.getParameter("year");
                String selectMonth = request.getParameter("month");
                String projectId = request.getParameter("pid");
                if (projectId == null) {
                    projectId = (String) session.getAttribute("pid");
                } else {
                    session.setAttribute("pid", projectId);
                }
        //        logger.info("Selected Year"+selectYear);
        //        logger.info("Selected Month"+selectMonth);
                year = 0;
                month = 0;
                int maxday = 30;
                if (selectYear == null || selectYear.equals("")) {
                    year = currentYear;
                    month = cal.get(Calendar.MONTH);
                    maxday = cal.get(Calendar.DAY_OF_MONTH);
                } else {
                    year = Integer.parseInt(selectYear);
                    month = Integer.parseInt(selectMonth);

                    Calendar cale = Calendar.getInstance();
                    cale.set(year, month, 1);
                    maxday = cale.getActualMaximum(Calendar.DATE);
                }
         //       logger.info("Year"+year);
                //       logger.info("Month"+monthSelect.get(month));

                //       logger.info("MAX DAY of MOnth"+maxday);
                start = "1" + "-" + monthSelect.get(month) + "-" + year;
                end = maxday + "-" + monthSelect.get(month) + "-" + year;

                String selectedStartDate = "01-" + (month + 1) + "-" + year + " 00:00:00";
                String selectedEndDate = maxday + "-" + (month + 1) + "-" + year + " 23:59:59";

        //        logger.info("Selected Start Date"+selectedStartDate);
        //        logger.info("Selected End Date"+selectedEndDate);
                String issueDetails[][] = IssueDetails.displayEminentIssues("Created", start, end, projectId);
                rowcount = issueDetails.length;


        %>

        <div align="center">
            <center>
                <br>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2" bgcolor="#E8EEF7">
                        <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                            COLOR="#0000FF"> <b> My TimeSheet for the Month of </b></font><FONT
                                SIZE="3" COLOR="#0000FF"> </FONT>
                            <select name="month" id="month">
                                <%                             for (int k = 0; k < monthSelect.size(); k++) {
                                        if (k == month) {
                                %>
                                <option value='<%=k%>' selected><%=monthSelect.get(k)%></option>
                                <%
                                } else {
                                %>
                                <option value='<%=k%>'><%=monthSelect.get(k)%></option>
                                <%
                                        }

                                    }
                                %>

                            </select>

                            <%
                                ArrayList<Integer> selectYears = new ArrayList<Integer>();
                                int startYear = 2008;

                                while (startYear <= currentYear) {
                                    selectYears.add(startYear);
                                    startYear++;
                                }
                            %>

                            <select name='year' id='year' >
                                <%
                                    for (int k = 0, selected = 2008; k < selectYears.size(); k++, selected++) {
                                        if (selected == year) {
                                %>
                                <option value='<%=selectYears.get(k)%>' selected><%=selectYears.get(k)%></option>
                                <%
                                } else {
                                %>
                                <option value='<%=selectYears.get(k)%>'><%=selectYears.get(k)%></option>
                                <%
                                        }

                                    }

                                %>
                            </select>
                            <select name='chartType' id='chartType' >

                                <%for (String type : mic.getChartTypeList()) {%>
                                <%if (type.equalsIgnoreCase("Created")) {%>
                                <option value="<%=type%>" selected=""><%=type%></option>
                                <%} else {%>   
                                <option value="<%=type%>"><%=type%></option>
                                <%}
                                }%>
                            </select>
                            <input type="button" id="button" value="Submit" onclick="monthSelection()"></td>
                        <td style="text-align: right;"><a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=month%>&year=<%=year%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=month%>&year=<%=year%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a   href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=month%>&year=<%=year%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=month%>&year=<%=year%>">Day Wise</a></td>
                    </tr>
                </table>
                <br>

                <table width="100%">
                    <tr height="10">
                        <td align="left" width="100%"><b><%=GetProjects.getProjectName(projectId).replace(":", " v")%></b> created issue in the month of <b><%=monthSelect.get(month)%> <%=year%></b> is listed below. Total created issues are <b> <%=rowcount%>.
                            </b></td>
                        <TD align="right" width="25">Severity</td>
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
                        <TD width="13%"><font><b>Project</b></font></TD>
                        <TD width="7%"><font><b>Module</b></font></TD>
                        <TD width="25%"><font><b>Subject</b></font></TD>
                        <TD width="9%"><font><b>Status</b></font></TD>
                        <TD width="9%"><font><b>Due Date</b></font></TD>
                        <TD width="13%"><font><b>Assigned To</b></font></TD>
                        <TD width="7%"><font><b>Refer</b></font></TD>

                    </TR>


                    <%
                        for (i = 0; i < rowcount; i++) {

                            String iss = issueDetails[i][0];
                            String project1 = issueDetails[i][1];
                            String type = issueDetails[i][2];
                            String status = issueDetails[i][3];
                            String sub = issueDetails[i][4];
                            String desc = issueDetails[i][5];
                            String pri = issueDetails[i][6];
                            String sev = issueDetails[i][7];
                            String createdBy = issueDetails[i][8];
                            String createdOn = issueDetails[i][9];
                            String assignedTo = issueDetails[i][10];
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

                            assignedTo = GetName.getUserName(assignedTo);
                            assignedTo = assignedTo.substring(0, assignedTo.indexOf(" ") + 2);

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
            //                        logger.info("Processing data........"+i);

               //                                     age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                            //                         logger.info("Calculated time........"+i);
                            //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                            if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="#E8EEF7" height="23">
                        <%
                        } else {
                        %>

                    <tr bgcolor="white" height="23">
                        <%
                            }
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
                                HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                </font></A></td>
                        <td width="1%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><%= p%> </font></td>
                                <%

                                    if (project1.length() < 15) {
                                %>
                        <td width="13%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1%></font></td>
                                <%
                                } else {
                                %>
                        <td width="13%"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0, 15) + "..."%></font></td>
                                <%
                                    }
                                %>
                        <td width="9%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%> </font></td>
                        <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                <%
                                    String color = "";
                                    logger.info("Rating for issue " + iss + " is " + rating);
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
                                    logger.info("Color for this issue" + color);
                                %>
                        <td width="9%" title="<%=feedback%>" bgcolor="<%=color%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                        size="1" ><%= status%> </font></td>
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
                        <td width="13%" title="Created By <%=GetName.getUserName(createdBy)%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                            </font></td>
                            <%
                    int fileCount = IssueDetails.displayFiles(iss);
                    if (fileCount > 0) {%>
                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#"
                                                        >ViewFiles(<%=fileCount%>)</A></font></td>
                                    <%} else {%>
                        <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                             size="1" color="#000000">No Files</font></td>
                                <%}%>

                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            logger.error("Exception:" + e);
                        } finally {

                            if (connection != null) {
                                connection.close();

                            }
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


