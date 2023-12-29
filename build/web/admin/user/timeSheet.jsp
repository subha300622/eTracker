<%-- 
    Document   : timeSheet
    Created on : Nov 6, 2009, 7:37:00 PM
    Author     : Administrator
--%>
<%@page import="com.eminentlabs.crm.CRMSearchBean"%>
<%@page import="com.eminent.timesheet.TimesheetIssue"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
    <%@ page import="org.apache.log4j.Logger,com.eminent.timesheet.CreateTimeSheet,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmPtcm"%>
    <%@ page import="java.sql.*, dashboard.*,com.eminent.customer.CustomerUtil"%>
    <%@ page import="java.util.HashMap,com.eminent.resource.ResourceUtil"%>
    <%@ page import="pack.eminent.encryption.*,com.eminent.tqm.TestCasePlan"%>
    <%@ page import="com.eminent.util.*,com.eminent.tqm.TqmTestcaseexecutionresult"%>
    <%@ page import="java.util.*, java.text.*, com.pack.*"%>
    <%
        //	response.setHeader("Cache-Control","no-cache");
        //	response.setHeader("Cache-Control","no-store");
        //	response.setDateHeader("Expires", 0);
        // 	response.setHeader("Pragma","no-cache");
        //Configuring log4j properties
        Logger logger = Logger.getLogger("TimeSheet");

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("=========================Session Expired======================");
    %>
    <jsp:forward page="SessionExpired.jsp"></jsp:forward>
    <%
            //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
        }

    %>

    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">

    <script type="text/javascript">

        function trim(str) {
            while (str.charAt(str.length - 1) == " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) == " ")
                str = str.substring(1, str.length);
            return str;
        }

        function monthSelection() {

            var date = 1;
            var startMonth = 7;
            var startYear = 2008;

            var startRange = new Date(startYear, startMonth, date);

            var month = document.getElementById("month").value;
            var year = document.getElementById("year").value;
            var userId = document.getElementById("userId").value;
            var selectedValue = new Date(year, month, date);
            var current_date = new Date();
            if (selectedValue >= startRange && selectedValue <= current_date) {
                location = 'timeSheet.jsp?month=' + month + '&year=' + year + '&userId=' + userId;
            } else {
                alert("You can view your TimeSheet from Aug 2008 to Current Month");
            }
        }
        function timeSheetApproval() {
            var accomLength = CKEDITOR.instances.accomplishments.getData().length;
            if (accomLength <= 0) {
                alert('Please enter your accomplishment of this month');
                CKEDITOR.instances.accomplishments.focus();
                return false;
            }
            if (accomLength > 1000) {
                alert('Accomplishment should not be greater than 1000 Characters');
                CKEDITOR.instances.accomplishments.focus();
                return false;
            }

            var lrngLength = CKEDITOR.instances.learning.getData().length;
            if (lrngLength <= 0) {
                alert('Please enter your learnings of this month');
                CKEDITOR.instances.learning.focus();
                return false;
            }
            if (lrngLength > 1000) {
                alert('Learnings should not be greater than 1000 Characters');
                CKEDITOR.instances.learning.focus();
                return false;
            }

            var planLength = CKEDITOR.instances.plan.getData().length;
            if (planLength <= 0) {
                alert('Please enter your plan for next month');
                CKEDITOR.instances.plan.focus();
                return false;
            }
            var suggLength = CKEDITOR.instances.suggestion.getData().length;
            if (suggLength > 1000) {
                alert('Plan should not be greater than 1000 Characters');
                CKEDITOR.instances.suggestion.focus();
                return false;
            }
            var hardLength = CKEDITOR.instances.hardship.getData().length;
            if (hardLength > 1000) {
                alert('Plan should not be greater than 1000 Characters');
                CKEDITOR.instances.hardship.focus();
                return false;
            }
            if (planLength > 1000) {
                alert('Plan should not be greater than 1000 Characters');
                CKEDITOR.instances.plan.focus();
                return false;
            }


            document.getElementById("timeSheet").style.visibility = 'hidden';
            disableSubmit();

        }
        function setFocus()
        {
            document.theForm.accomplishments.focus();
        }
    </script>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <META NAME="Generator" CONTENT="EditPlus">
    <META NAME="Author" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Description" CONTENT="">
    <link id="noscript_css" rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/eminentech support files/noscript.css" />
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
</head>

<BODY>

    <%!
        String start, end, timeSheetId;
        int i, year, month, timeSheetMonth, timeSheetYear;
        String url = null;
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




    <jsp:useBean id="tsu" class="com.eminent.timesheet.TimeSheetUtil"></jsp:useBean>

    <%!
        int userid_curri, age, rowcount;
        String workeduserid;
        int maxday = 30;
                        %>

    <%
        int userid = (Integer) session.getAttribute("uid");
        String user = request.getParameter("userId");
        int userId = 104;
        if (user != null) {
            userId = Integer.parseInt(user);
        }
        String timeSheetid = request.getParameter("userTimesheetid");
        String accomplishments = request.getParameter("accomplishments");
        String learning = request.getParameter("learning");
        String hardship = request.getParameter("hardship");
        String suggestion = request.getParameter("suggestion");
        String plan = request.getParameter("plan");
        String msg = null;
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();

        try {

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
            int timeSheetMonth = Integer.valueOf(selectMonth);
            if (timeSheetMonth > 9) {
                timeSheetId = "T" + timeSheetMonth + selectYear + request.getParameter("userId");
            } else {
                timeSheetId = "T" + "0" + timeSheetMonth + selectYear + request.getParameter("userId");
            }
            List<String> tsheetissues = new ArrayList<String>();
            List<TimesheetIssue> tsheetTotalissues = tsu.findIssuesByTimesheetId(timeSheetId);
            for (TimesheetIssue timesheetIssue : tsheetTotalissues) {
                if (timesheetIssue.getWorkstatus() == 0) {
                    tsheetissues.add(timesheetIssue.getIssueid());
                }
            }
            logger.info("timeSheetId" + timeSheetId);
            //        logger.info("Selected Month"+selectMonth);
            year = 0;
            month = 0;

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

            String selectedStartDate = year + "-" + (month + 1) + "-" + "01" + " 00:00:00";
            String selectedEndDate = year + "-" + (month + 1) + "-" + maxday + " 23:59:59";

            DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            java.util.Date stDate = (java.util.Date) format.parse(selectedStartDate);
            java.util.Date edDate = (java.util.Date) format.parse(selectedEndDate);

            String issueDetails[][] = IssueDetails.displayIssues(userId, start, end, "Closed");
            List<String> currMonthIssues = IssueDetails.currentMonthclosed(userId, start, end);
            rowcount = issueDetails.length;
            List<CRMSearchBean> accDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Account");
            List<CRMSearchBean> oppDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Opportunity");
            List<CRMSearchBean> leadDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Lead");
            List<CRMSearchBean> conDetails = CustomerUtil.displayCRMIssues(userId, start, end, "Contact");
            String rrDetails[][] = ResourceUtil.displayRRIssues(userId, start, end);
            String timeSheet[][] = CustomerUtil.displayTimesheet(userId, start, end);
            String leaveRequest[][] = CustomerUtil.displayLeave(userId, start, end);

            String name = GetProjectMembers.getUserName(user) + "'s";
    %>

    <div align="center">
        <center>
            <br>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#E8EEF7">
                    <td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
                                                                        COLOR="#0000FF"> <b> <%=name%> TimeSheet for the Month of </b></font><FONT
                            SIZE="3" COLOR="#0000FF"> </FONT>
                        <select name="month" id="month">
                            <%

                                for (int k = 0; k < monthSelect.size(); k++) {
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
                        <input type="button" value="Submit" onclick="monthSelection()"><input type="hidden" name="userId" id="userId" value="<%=userId%>"></td>

                </tr>
            </table>
            <br>
            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat sdftimestamp = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");

                String mail = (String) session.getAttribute("theName");

                if (mail != null) {
                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                }
                if (url.equals("eminentlabs.net")) {
            %>
            <%
                    timeSheetMonth = 0;
                    timeSheetYear = 0;

                    Calendar timeSheetCal = new GregorianCalendar();

                    timeSheetCal.add(timeSheetCal.MONTH, -1);

                    int assignedto = (Integer) session.getAttribute("uid");
                    timeSheetMonth = timeSheetCal.get(timeSheetCal.MONTH);
                    timeSheetYear = timeSheetCal.get(timeSheetCal.YEAR);

                    timeSheetId = "T";
                    if (timeSheetMonth > 9) {
                        timeSheetId = timeSheetId + timeSheetMonth + timeSheetYear + assignedto;
                    } else {
                        timeSheetId = timeSheetId + "0" + timeSheetMonth + timeSheetYear + assignedto;
                    }
                    logger.info("Manipulated Timesheet" + timeSheetId);

                }

                String selectedPeriod = monthSelect.get(month) + " " + year;
                if (accDetails.size() > 0 || oppDetails.size() > 0 || leadDetails.size() > 0 || conDetails.size() > 0) {

            %>
            <table width="100%" bgcolor="" border="0">
                <tr bgcolor="#D8D8D8" align="left"><td colspan="7"><b>CRM Block</b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('crm', 150);
                                        return false" style="text-decoration: none;color: black" class="trigger" title="CRM" >The total <b style="color: blue">CRM Worked Issues</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=(conDetails.size() + leadDetails.size() + oppDetails.size() + accDetails.size())%>.</a>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td>
                        <div id="crm" class="hide_me" >
                            <table border="0" width="100%">
                                <%
                                    if (conDetails.size() > 0) {
                                %>
                                <tr align="left"><td colspan="7"><b>CRM Contacts</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="25%"><font><b>Name</b></font></td>
                                    <td width="25%"><font><b>Company</b></font></td>
                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>
                                </tr>
                                <% try {
                                        int s = 0;
                                        String age = "NA", assignedto = "NA", dueDate = "NA";
                                        for (CRMSearchBean bean : conDetails) {
                                            age = "NA";
                                            assignedto = "NA";
                                            dueDate = "NA";
                                            if (bean.getCreatedon() != null) {
                                                age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                                age = ((Integer) CustomerUtil.getAge(age)).toString();
                                            }
                                            if (bean.getAssingedTo() != null) {
                                                assignedto = GetName.getUserName(bean.getAssingedTo());
                                                assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                            } else {
                                                assignedto = "NA";
                                            }
                                            if (bean.getDuedate() != null) {
                                                dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                            }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%
                                                    }
                                                } catch (Exception e) {
                                                    logger.error(e.getMessage());
                                                }
                                            }
                                            if (leadDetails.size() > 0) {
                                        %>
                                <tr align="left"><td colspan="7"><b>CRM Leads</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="20%"><font><b>Name</b></font></td>
                                    <td width="13%"><font><b>Company</b></font></td>

                                    <td width="12%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Assigned To</b></font></td>
                                    <td width="13%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>

                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : leadDetails) {
                                        age = "NA";
                                        assignedto = "NA";
                                        dueDate = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }
                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%
                                                }
                                            }
                                            if (oppDetails.size() > 0) {
                                        %>
                                <tr align="left" align="left"><td colspan="7"><b>CRM Opportunity</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left">
                                    <td width="25%"><font><b>Opportunity Name</b></font></td>
                                    <td width="20%"><font><b>Stage</b></font></td>
                                    <td width="15%"><font><b>Probability</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="15%"><font><b>CloseDate</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>
                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : oppDetails) {
                                        age = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        } else {
                                            age = "NA";
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        dueDate = "NA";
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }

                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getRating()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%
                                                }
                                            }
                                            if (accDetails.size() > 0) {
                                        %>
                                <tr align="left"><td colspan="7"><b>CRM Account</b></td></tr>
                                <tr bgColor="#C3D9FF" align="left" >
                                    <td width="25%"><font><b>Account Name</b></font></td>
                                    <td width="20%"><font><b>Billing State</b></font></td>
                                    <td width="15%"><font><b>Type</b></font></td>
                                    <td width="15%"><font><b>Assigned To</b></font></td>
                                    <td width="15%"><font><b>Due Date</b></font></td>
                                    <td width="13%" align="center"><font><b>Age</b></font></td>


                                </tr>
                                <%
                                    int s = 0;
                                    String age = "NA", assignedto = "NA", dueDate = "NA";
                                    for (CRMSearchBean bean : accDetails) {
                                        age = "NA";
                                        if (bean.getCreatedon() != null) {
                                            age = sdf.format(dateConversion.parse(bean.getCreatedon()));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();
                                        } else {
                                            age = "NA";
                                        }
                                        if (bean.getAssingedTo() != null) {
                                            assignedto = GetName.getUserName(bean.getAssingedTo());
                                            assignedto = assignedto.substring(0, assignedto.indexOf(" ") + 2);
                                        } else {
                                            assignedto = "NA";
                                        }
                                        dueDate = "NA";
                                        if (bean.getDuedate() != null) {
                                            dueDate = sdf.format(dateConversion.parse(bean.getDuedate()));
                                        }

                                %>
                                <tr bgcolor="<%=(s % 2) != 0 ? "white" : "#E8EEF7"%>" align="left"><td><%=bean.getName()%></td><td><%=bean.getCompany()%></td><td><%=bean.getEmail()%></td><td><%=assignedto%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%
                                                }

                                            }
                                        %>
                            </table>
                        </div>

                    </td>
                </tr>

            </table>
            <%}%>

            <table width="100%" height="23">
                <tr align="left"><td width="100%" colspan="11" bgcolor="#D8D8D8"><b> APM Block</b></td></tr>

                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('apm', 150);
                                        return false" style="text-decoration: none;color: black" class="trigger" title="APM" >The total <b style="color: blue">APM Closed Issues</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=rowcount%>.</a>
                                    </b></td>
                                <td align="right" width="25">Severity</td>
                                <td align="right" width="25" bgcolor="#FF0000">S1</td>
                                <td align="right" width="25" bgcolor="#FF9900">S2</td>
                                <td align="right" width="25" bgcolor="#FFFF00">S3</td>
                                <td align="right" width="25" bgcolor="#33FF33">S4</td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr><td>
                        <div id="apm" class="hide_me" >
                            <table border="0" width="100%">

                                <TR bgcolor="#C3D9FF" align="left">
                                    <td width="6%" TITLE="Co-Ordination/Work"><font><b>C/W</b></font></td>
                                    <td width="1%" TITLE="Severity"><font><b>S</b></font></td>
                                    <td width="9%"><font><b>Issue No</b></font></td>
                                    <td width="3%" TITLE="Priority"><font><b>P</b></font></td>
                                    <td width="10%"><font><b>Project</b></font></td>
                                    <td width="7%"><font><b>Module</b></font></td>
                                    <td width="25%"><font><b>Subject</b></font></td>
                                    <td width="9%"><font><b>Status</b></font></td>
                                    <td width="8%"><font><b>Due Date</b></font></td>
                                    <td width="9%"><font><b>AssignedTo</b></font></td>
                                    <td width="7%"><font><b>Refer</b></font></td>
                                    <td width="5%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></td>
                                </TR>

                                <%
                                    int duedateexceeded = 0, exlnt = 0, good = 0, avrg = 0, ndimp = 0;
                                    int curMonthClosed = 0;
                                    for (i = 0; i < rowcount; i++) {

                                        String iss = issueDetails[i][0];
                                        if (currMonthIssues.contains(iss)) {
                                            curMonthClosed++;
                                        }
                                    }
                                    if (curMonthClosed > 0) {%>
                                <tr bgcolor="#C3D9FF"><td colspan="12">Current Month Worked And Closed Issues = <%=curMonthClosed%> </td></tr>
                                <% }
                                    int j = 1;
                                    for (i = 0; i < rowcount; i++) {

                                        String iss = issueDetails[i][0];
                                        if (currMonthIssues.contains(iss)) {
                                            j++;
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
                                                module = module.substring(0, 7) + "...";
                                            }
                                            if (sub.length() > 42) {
                                                sub = sub.substring(0, 42) + "...";
                                            }
                                            if (rating == null) {
                                                rating = "NA";
                                            }
                                            int current = Integer.parseInt(assignedTo);
                                            String p = "NA";
                                            if (pri != null) {
                                                p = pri.substring(0, 2);
                                            }

                                            assignedTo = member.get(current);

                                            session.setAttribute("theissno", iss);

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
                                            logger.info("Processing data........" + i);

                                            //                                  age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                                            logger.info("Calculated time........" + i);
                                            //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                            age = CustomerUtil.getIssueAge(create, status, dateString1);
                                            if ((j % 2) != 0) {
                                %>
                                <tr bgcolor="#E8EEF7" height="23" align="left">
                                    <%
                                    } else {
                                    %>

                                <tr bgcolor="white" height="23" align="left">
                                    <%
                                        }
                                    %>

                                    <td width="6%"  >
                                        <%if (tsheetissues.contains(iss)) {%>
                                        <input type="radio" name="prev<%=j%>" value="<%=iss%>c" checked style="vertical-align: middle; margin: 0px;"/>
                                        <input type="radio" name="prev<%=j%>" value="<%=iss%>w"  style="vertical-align: middle; margin: 0px;"/>
                                        <%} else {%>
                                        <input type="radio" name="prev<%=j%>" value="<%=iss%>c"  style="vertical-align: middle; margin: 0px;"/>
                                        <input type="radio" name="prev<%=j%>" value="<%=iss%>w" checked style="vertical-align: middle; margin: 0px;"/>
                                        <%}%>
                                    </td>
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
                                    <td width="9%" TITLE="<%= type%>"><a
                                            HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                            </font></a></td>
                                    <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
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
                                    <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                 size="1" color="#000000"><%=module%></font></td>
                                    <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                            <%
                                                String color = "";
                                                logger.info("Closed issue rating-->" + status);
                                                if (status.equalsIgnoreCase("Closed")) {
                                                    logger.info("Closed issue rating-->" + rating);
                                                    if (rating.equalsIgnoreCase("Excellent")) {
                                                        color = "#336600";
                                                        exlnt++;
                                                    } else if (rating.equalsIgnoreCase("Good")) {
                                                        color = "#33CC66";
                                                        good++;
                                                    } else if (rating.equalsIgnoreCase("Average")) {
                                                        color = "#CC9900";
                                                        avrg++;
                                                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                        color = "#CC0000";
                                                        ndimp++;
                                                    }
                                                    if (feedback == null) {
                                                        feedback = "";
                                                    }
                                                } else {
                                                    feedback = "";
                                                }

                                            %>

                                    <td width="9%" bgcolor="<%=color%>" title="<%=feedback%>"onclick="showPrint('<%=iss%>');" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                                             size="1" color="#000000"><%= status%> </font></td>
                                            <%

                                                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                                                    duedateexceeded++;
                                            %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                    </td>
                                    <%
                                    } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                        duedateexceeded++;
                                    %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                    </td>
                                    <%
                                    } else {
                                    %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                    </td>
                                    <%
                                        }
                                    %>
                                    <td width="9%" title="Created By <%=GetName.getUserName(createdBy)%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                                        </font></td>
                                        <%
                                            int fileCount = IssueDetails.displayFiles(iss);
                                            if (fileCount > 0) {%>
                                    <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                         size="1" color="#000000"><A HREF="<%=request.getContextPath()%>/issueUpdateFile.jsp?issueid=<%=iss%>">ViewFiles(<%=fileCount%>)</A></font></td>
                                                <%} else {%>
                                    <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                         size="1" color="#000000">No Files</font></td>
                                            <%}%>
                                    <td width="5%" align=center><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age%></font>
                                    </td>
                                </tr>

                                <%
                                        }
                                    }
                                    if ((rowcount - curMonthClosed) > 0) {%>
                                <tr><td colspan="12" bgcolor="#C3D9FF">Previous Month Worked And Closed Issues = <%=rowcount - curMonthClosed%> </td></tr>
                                <% }
                                    j = 1;
                                    for (i = 0; i < rowcount; i++) {

                                        String iss = issueDetails[i][0];
                                        if (!currMonthIssues.contains(iss)) {
                                            j++;
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
                                                module = module.substring(0, 7) + "...";
                                            }
                                            if (sub.length() > 42) {
                                                sub = sub.substring(0, 40) + "...";
                                            }
                                            if (rating == null) {
                                                rating = "NA";
                                            }
                                            int current = Integer.parseInt(assignedTo);
                                            String p = "NA";
                                            if (pri != null) {
                                                p = pri.substring(0, 2);
                                            }

                                            assignedTo = member.get(current);

                                            session.setAttribute("theissno", iss);

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
                                            //                  logger.info("Processing data........"+i);

                                            //                                  age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                                            //                      logger.info("Calculated time........"+i);
                                            //                           //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                            age = CustomerUtil.getIssueAge(create, status, dateString1);
                                            if ((j % 2) != 0) {
                                %>
                                <tr bgcolor="#E8EEF7" height="23" align="left">
                                    <%
                                    } else {
                                    %>

                                <tr bgcolor="white" height="23" align="left">
                                    <%
                                        }
                                    %>

                                    <td width="6%">
                                        <%if (tsheetissues.contains(iss)) {%>
                                        <input type="radio" name="curr<%=j%>" value="<%=iss%>c" checked style="vertical-align: middle; margin: 0px;"/>
                                        <input type="radio" name="curr<%=j%>" value="<%=iss%>w" style="vertical-align: middle; margin: 0px;"/>
                                        <%} else {%>
                                        <input type="radio" name="curr<%=j%>" value="<%=iss%>c"  style="vertical-align: middle; margin: 0px;"/>
                                        <input type="radio" name="curr<%=j%>" value="<%=iss%>w" checked style="vertical-align: middle; margin: 0px;"/>
                                        <%}%>
                                    </td>
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
                                    <td width="9%" TITLE="<%= type%>"><a
                                            HREF="${pageContext.servletContext.contextPath}/admin/user/WorkedIssueDetails.jsp?issueno=<%=iss%>"> <font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                            </font></a></td>
                                    <td width="3%"><font face="Verdana, Arial, Helvetica, sans-serif"
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
                                    <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                 size="1" color="#000000"><%=module%></font></td>
                                    <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                            <%

                                                String color = "";
                                                //                    logger.info("Closed issue rating-->"+status);
                                                if (status.equalsIgnoreCase("Closed")) {
                                                    //                      logger.info("Closed issue rating-->"+rating);
                                                    if (rating.equalsIgnoreCase("Excellent")) {
                                                        color = "#336600";
                                                        exlnt++;
                                                    } else if (rating.equalsIgnoreCase("Good")) {
                                                        color = "#33CC66";
                                                        good++;
                                                    } else if (rating.equalsIgnoreCase("Average")) {
                                                        color = "#CC9900";
                                                        avrg++;
                                                    } else if (rating.equalsIgnoreCase("Need Improvement")) {
                                                        color = "#CC0000";
                                                        ndimp++;
                                                    }
                                                    if (feedback == null) {
                                                        feedback = "";
                                                    }
                                                } else {
                                                    feedback = "";
                                                }


                                            %>

                                    <td width="9%" bgcolor="<%=color%>" title="<%=feedback%>" onclick="showPrint('<%=iss%>');" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                                              size="1" color="#000000"><%= status%> </font></td>
                                            <%

                                                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                                                    duedateexceeded++;
                                            %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                    </td>
                                    <%
                                    } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                        duedateexceeded++;
                                    %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                    </td>
                                    <%
                                    } else {
                                    %>
                                    <td width="8%" title="Last Modified On <%= dateString1%>"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                    </td>
                                    <%
                                        }
                                    %>
                                    <td width="9%" title="Created By <%=member.get(Integer.parseInt(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=assignedTo%>
                                        </font></td>
                                        <%
                                            int fileCount = IssueDetails.displayFiles(iss);
                                            if (fileCount > 0) {%>
                                    <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                         size="1" color="#000000"><A HREF="<%=request.getContextPath()%>/issueUpdateFile.jsp?issueid=<%=iss%>">ViewFiles(<%=fileCount%>)</A></font></td>
                                                <%} else {%>
                                    <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                         size="1" color="#000000">No Files</font></td>
                                            <%}%>
                                    <td width="5%" align=center><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= age%></font>
                                    </td>
                                </tr>

                                <%}
                                    }
                                    if (rowcount > 0) {
                                %>
                                <tr align="left" bgcolor="#E8EEF7"><td colspan="12">Number of Due Date exceeded issues:    <%=duedateexceeded%></td></tr>
                                <tr align="left" bgcolor=""><td colspan="7">Number of Closed Issues with Rating:</td></tr>
                                <tr align="left" bgcolor="#E8EEF7"><td colspan="2">Excellent</td><td><%=exlnt%></td><td>Good</td><td><%=good%></td><td>Average:</td><td><%=avrg%></td><td>Need Improvement</td><td colspan="4"><%=ndimp%></td></tr>

                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>


            <table width="100%">
                <%
                    try {
                        List l = TestCasePlan.getTestCases(userId, stDate, edDate);
                        int noOfRecords = l.size();
                        if (noOfRecords > 0) {
                %>

                <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> TQM Block</b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('tqm', 150);
                                        return false" style="text-decoration: none;color: black" class="trigger" title="TQM" >The total <b style="color: blue">TQM Worked Test Cases</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=noOfRecords%>.
                                        </b></a></td>

                        </table>
                    </td>
                </tr>
                <tr><td>
                        <div id="tqm" class="hide_me" >
                            <table border="0" width="100%">
                                <tr bgcolor="#C3D9FF" align="left">
                                    <td width="8%"><b>TestCaseId</b></td>
                                    <td width="15%"><b>Project</b></td>
                                    <td width="20%"><b>Functionality</b></td>
                                    <td width="22%"><b>Description</b></td>
                                    <td width="20%"><b>Expected Result</b></td>
                                    <td width="10%"><b>Createdby</b></td>
                                    <td width="10%"><b>Status</b></td>
                                </tr>
                                <%
                                    int k = 1;
                                    HashMap statusMap = TestCasePlan.getTescaseStatus();
                                    for (Iterator i = l.iterator(); i.hasNext(); k++) {
                                        TqmTestcaseexecutionresult rslt = (TqmTestcaseexecutionresult) i.next();

                                        String ptcid = rslt.getPtcid().getPtcid();
                                        String func = rslt.getPtcid().getFunctionality();
                                        String desc = rslt.getPtcid().getDescription();
                                        String reslt = rslt.getPtcid().getExpectedresult();
                                        String project = GetProjects.getProjectName(((Integer) rslt.getPtcid().getPid()).toString());
                                        //      String created      =   "NA";
                                        String created = GetProjectManager.getUserName(rslt.getPtcid().getCreatedby());
                                        String status = (String) statusMap.get(rslt.getStatusid());

                                        //           if(ptcid=="Q12052010002"){
                                        logger.info("PTC IC-->" + ptcid);
                                        logger.info("Fuction-->" + func);
                                        logger.info("Desc-->" + desc);

                                        //         }
                                        java.util.Date date = rslt.getPtcid().getCreatedon();
                                        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                                        String requestedOn = sdfs.format(date);

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
                                        logger.info("Result-->" + reslt);
                                        logger.info("Project-->" + project);
                                        logger.info("Created-->" + created);

                                        if ((k % 2) != 0) {
                                %>
                                <tr bgcolor="white" height="22" align="left">
                                    <%
                                    } else {
                                    %>

                                <tr bgcolor="#E8EEF7" height="22" align="left">
                                    <%
                                        }
                                    %>
                                    <td><a href="<%=request.getContextPath()%>/admin/tqm/viewPTC.jsp?ptcID=<%=ptcid%>"><%=ptcid%></a></td>
                                    <td><%=project%></td>
                                    <td title="<%=StringUtil.encodeHtmlTag(funcTitle)%>"><%=StringUtil.encodeHtmlTag(func)%></td>
                                    <td title="<%=StringUtil.encodeHtmlTag(descTitle)%>"><%=StringUtil.encodeHtmlTag(desc)%></td>
                                    <td title="<%=StringUtil.encodeHtmlTag(rsltTitle)%>"><%=StringUtil.encodeHtmlTag(reslt)%></td>
                                    <td><%=created%></td>
                                    <td><%=status%></td>
                                </tr>



                                <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        logger.error(e.getMessage());
                                    }

                                %>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>


            <%    try {

                    if (rrDetails.length > 0) {
            %>
            <table width="100%">
                <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> ERM Block</b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('erm', 150);
                                        return false" style="text-decoration: none;color: black" class="trigger" title="ERM" >The total <b style="color: blue">ERM Worked Resource Requests</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=rrDetails.length%>.
                                        </b></a></td>

                        </table>
                    </td>
                </tr>
                <tr><td><div id="erm" class="hide_me" >
                            <table>
                                <tr bgcolor="#C3D9FF" height="9" align="left">
                                    <td width="10%"><font><b>Request ID</b></font></td>
                                    <td width="10%"><font><b>Project</b></font></td>
                                    <td width="7%"><font><b>Team</b></font></td>
                                    <td width="12%"><font><b>RequestedBy</b></font></td>
                                    <td width="10%"><font><b>Position</b></font></td>
                                    <td width="10%"><font><b>Expertise</b></font></td>
                                    <td width="5%"><font><b>Experience</b></font></td>
                                    <td width="5%"><font><b>Status</b></font></td>
                                    <td width="12%"><font><b>AssignedTo</b></font></td>
                                    <td width="8%"><font><b>Due Date</b></font></td>
                                    <td width="3%" align="center"><font><b>Age</b></font></td>


                                </tr>

                                <%
                                    for (int s = 0; s < rrDetails.length; s++) {
                                        String one = rrDetails[s][0];
                                        String two = rrDetails[s][1];
                                        String three = rrDetails[s][2];
                                        String four = rrDetails[s][3];
                                        String five = rrDetails[s][4];
                                        String six = rrDetails[s][5];
                                        String seven = rrDetails[s][6];
                                        String eight = rrDetails[s][7];
                                        String requestedBy = rrDetails[s][8];
                                        String assignedTo = rrDetails[s][9];
                                        String createdOn = rrDetails[s][10];
                                        String age = "NA";
                                        if (createdOn != null) {
                                            age = sdf.format(dateConversion.parse(createdOn));
                                            age = ((Integer) CustomerUtil.getAge(age)).toString();

                                        }

                                        //           seven               = GetName.getUserName(seven);
                                        String dueDate = "NA";
                                        if (eight != null) {
                                            dueDate = sdf.format(dateConversion.parse(eight));
                                        }

                                        assignedTo = GetName.getUserName(assignedTo);
                                        requestedBy = GetName.getUserName(requestedBy);
                                        String color = "";
                                        if ((s % 2) != 0) {
                                            color = "white";
                                        } else {
                                            color = "#E8EEF7";
                                        }
                                %>
                                <tr bgcolor="<%=color%>" align="left"><td><%=one%></td><td><%=two%></td><td><%=three%></td><td><%=requestedBy.substring(0, requestedBy.indexOf(" ") + 2)%></td><td><%=four%></td><td><%=five%></td><td><%=six%></td><td><%=seven%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td><td><%=dueDate%></td><td align="center"><%=age%></td></tr>
                                        <%
                                                    }
                                                }

                                            } catch (Exception e) {
                                                logger.error(e.getMessage());
                                            }

                                        %>
                            </table></div></td></tr>
            </table>

            <%    try {

                    if (timeSheet.length > 0) {
            %>
            <table width="100%">
                <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> Timesheet Block</b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('timesheet', 150);
                                        return false" style="text-decoration: none;color: black" class="trigger" title="ERM" >The total <b style="color: blue">ERM Timesheets Evaluated</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=timeSheet.length%>.
                                        </b></a></td>

                        </table>
                    </td>
                </tr>
                <tr><td><div id="timesheet" class="hide_me" >
                            <table width="100%">
                                <tr bgcolor="#C3D9FF" height="9" align="left">
                                    <td width="15%"><font><b>Timesheet ID</b></font></td>
                                    <td width="20%"><font><b>RequestedBy</b></font></td>
                                    <td width="15%"><font><b>RequestedOn </b></font></td>
                                    <td width="15%"><font><b>Period </b></font></td>
                                    <td width="15%"><font><b>Approval Status</b></font></td>
                                    <td width="20%"><font><b>AssignedTo</b></font></td>


                                </tr>

                                <%
                                    for (int s = 0; s < timeSheet.length; s++) {
                                        String timesheetId = timeSheet[s][0];
                                        String owner = timeSheet[s][1];
                                        String approvalStatus = timeSheet[s][2];
                                        String assignedTo = timeSheet[s][3];
                                        String requestedOn = timeSheet[s][4];

                                        String period = timesheetId.substring(1, timesheetId.length() - 3);
                                        String month = timesheetId.substring(1, 3);
                                        String year = timesheetId.substring(3, 7);
                                        String timesheetPeriod = monthSelect.get(Integer.parseInt(month)) + " " + year;

                                        String requestDate = "NA";
                                        if (requestedOn != null) {
                                            requestDate = sdf.format(dateConversion.parse(requestedOn));
                                        }
                                        String status = "Yet To Approve";
                                        if (approvalStatus != null) {
                                            status = approvalStatus;
                                        }

                                        assignedTo = GetName.getUserName(assignedTo);
                                        owner = GetName.getUserName(owner);
                                        String color = "";
                                        if ((s % 2) != 0) {
                                            color = "white";
                                        } else {
                                            color = "#E8EEF7";
                                        }
                                %>
                                <tr bgcolor="<%=color%>" align="left"><td><%=timesheetId%></td><td><%=owner.substring(0, owner.indexOf(" ") + 2)%></td><td><%=requestDate%></td><td><%=timesheetPeriod%></td><td><%=status%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td></tr>
                                        <%
                                                    }
                                                }

                                            } catch (Exception e) {
                                                logger.error(e.getMessage());
                                            }

                                        %>
                            </table></div></td></tr>
            </table>

            <%    try {

                    if (leaveRequest.length > 0) {
            %>
            <table width="100%">
                <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> Leave Approval Management </b></td></tr>
                <tr height="10">
                    <td colspan="11">
                        <table width="100%">
                            <tr height="10">
                                <td align="left" width="100%"><a href="#" onclick="collapse('leave', 150);
                                            return false" style="text-decoration: none;color: black" class="trigger" title="LAM" >The total <b style="color: blue">LAM Leave Request</b> for the month of <b style="color: blue"><%=monthSelect.get(month)%> <%=year%></b> are <b style="color: blue"> <%=leaveRequest.length%>.
                                        </b></a></td>

                        </table>
                    </td>
                </tr>
                <tr><td><div id="leave" class="hide_me" >
                            <table width="100%">
                                <tr bgcolor="#C3D9FF" height="9" align="left">
                                    <td width="15%"><font><b>Leave Type</b></font></td>
                                    <td width="20%"><font><b>RequestedBy</b></font></td>
                                    <td width="10%"><font><b>From Date </b></font></td>
                                    <td width="10%"><font><b>To Date </b></font></td>
                                    <td width="15%"><font><b>Approval Status</b></font></td>
                                    <td width="15%"><font><b>AssignedTo</b></font></td>
                                    <td width="15%"><font><b>Approver</b></font></td>
                                    <td width="20%"><font><b>Requested On</b></font></td>
                                    <td width="20%"><font><b>Approved On</b></font></td>

                                </tr>

                                <% HashMap<Integer, String> hm = new HashMap();
                                    hm.put(0, "Yet to Approve");
                                    hm.put(1, "Approved");
                                    hm.put(-1, "Rejected");
                                    hm.put(-2, "Cancelled");
                                    String fDate = "NA";
                                    String tDate = "NA";
                                    String requestDate = "NA";
                                    String modifiedDate = "NA";
                                    String status = "Yet To Approve";

                                    for (int s = 0; s < leaveRequest.length; s++) {
                                        fDate = "NA";
                                        tDate = "NA";
                                        requestDate = "NA";
                                        modifiedDate = "NA";
                                        status = "Yet To Approve";
                                        String type = leaveRequest[s][0];
                                        String requester = leaveRequest[s][1];
                                        String approvalStatus = leaveRequest[s][2];
                                        String fromDate = leaveRequest[s][3];
                                        String toDate = leaveRequest[s][4];
                                        String requestedOn = leaveRequest[s][5];
                                        String assignedTo = leaveRequest[s][6];
                                        String approver = leaveRequest[s][7];
                                        String modifiedOn = leaveRequest[s][8];

                                        if (requestedOn != null) {
                                            fDate = sdf.format(dateConversion.parse(fromDate));
                                        }
                                        if (requestedOn != null) {
                                            tDate = sdf.format(dateConversion.parse(toDate));
                                        }
                                        if (requestedOn != null) {
                                            requestDate = sdftimestamp.format(timestamp.parse(requestedOn));
                                        }

                                        if (approvalStatus != null) {
                                            status = approvalStatus;
                                        }
                                        if (modifiedOn != null && !approvalStatus.equals("0")) {
                                            modifiedDate = sdftimestamp.format(timestamp.parse(modifiedOn));
                                        }

                                        assignedTo = GetName.getUserName(assignedTo);
                                        requester = GetName.getUserName(requester);
                                        if (approver != null) {
                                            approver = member.get(Integer.parseInt(approver));
                                        } else {
                                            approver = "NA";
                                        }
                                        String color = "";
                                        if ((s % 2) != 0) {
                                            color = "white";
                                        } else {
                                            color = "#E8EEF7";
                                        }

                                %>
                                <tr bgcolor="<%=color%>" align="left"><td><%=type%></td><td><%=requester.substring(0, requester.indexOf(" ") + 2)%></td><td><%=fDate%></td><td><%=tDate%></td><td><%=hm.get((Integer) Integer.parseInt(approvalStatus))%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td><td><%=approver%></td><td><%=requestDate%></td><td><%=modifiedDate%></td></tr>
                                        <%
                                                }%></table></div></td></tr>
            </table><br/>
            <%}

                } catch (Exception e) {
                    logger.error(e.getMessage());
                }

            %>
            <table width="100%">
                <%        float present = 0f;
                    float wDays = 0f;
                    float leaveDays = 0f;
                    leaveDays = CustomerUtil.getLeavedays(userId, start, end);
                    float presentDays = maxday - leaveDays;
                    java.util.Date startDate = sdf.parse(start);
                    java.util.Date endDate = sdf.parse(end);
                    int day = cal.get(Calendar.DAY_OF_MONTH);
                    if ((new java.util.Date()).compareTo(endDate) < 0) {
                        present = day - leaveDays;
                    } else {
                        present = presentDays;
                    }
                    if (month != currentMonth) {
                        wDays = maxday;
                    } else {
                        endDate = new java.util.Date();
                        wDays = day;
                    }
                    Set<java.util.Date> holidayDatesList = new HashSet<java.util.Date>();
                    List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(startDate, endDate);
                    if (!holidaysList.isEmpty()) {
                        for (Holidays holday : holidaysList) {
                            holidayDatesList.add(holday.getHolidayDate());
                        }
                    }
                    logger.info(".size()" + holidayDatesList);
                    wDays = wDays - holidayDatesList.size();
                    present = present - holidayDatesList.size();
                %>
                <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="6" ><b> Leave Approval Management </b></td></tr>
                <tr bgcolor="#E8EEF7" align="left"><td colspan="2">No of Working Days:   <b><%= wDays%></b></td><td colspan="2">Leave Taken:     <b>
                            <%
                                if (leaveDays > 0) {
                            %>
                            <a href="<%=request.getContextPath()%>/leaveTaken.jsp?period=<%=selectedPeriod%>&start=<%=start%>&end=<%=end%>&userId=<%=userId%>"><%=leaveDays%></a>
                            <%} else {%>
                            <%=leaveDays%>
                            <%}%>

                        </b></td><td colspan="2">Present:     <b><%=present%></b> Days</td></tr>
            </table>




            <%
                } catch (Exception e) {
                    logger.error("Exception:" + e);
                    logger.error(e.getMessage());
                }


            %>
        </center>
    </div>
    <script type="text/javascript">

        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }
    </script>
</BODY>
</HTML>




