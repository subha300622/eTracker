<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger,pack.eminent.encryption.*,com.pack.SessionCounter,java.util.*,com.eminent.util.*,java.text.SimpleDateFormat"%>
<%
    Logger logger = Logger.getLogger("ViewUser");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=05042019" type="text/css" rel=STYLESHEET>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">

    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>

    <script language="JavaScript">

        function printpost(post)

        {
            pp = window.open('./profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }

        var form = 'showusers' //form name

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

        function ValidateForm(dml, chkName)
        {
            len = dml.elements.length;
            var i = 0;
            for (i = 0; i < len; i++)
            {
                if ((dml.elements[i].name == chkName) && (dml.elements[i].checked == 1))
                    return true
            }
            alert("Please select at least one record to be disabled")
            return false;
        }



    </script>

</head>
<body>
    <%@ page import="java.sql.*"%>
    <%!
        int requestpage, pageone, pageremain, rowcount;
        static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra, value;
        String start, end;
        private static HashMap<Integer, String> hm = new HashMap<Integer, String>();

        static {

            hm.put(0, "Jan");
            hm.put(1, "Feb");
            hm.put(2, "Mar");
            hm.put(3, "Apr");
            hm.put(4, "May");
            hm.put(5, "Jun");
            hm.put(6, "Jul");
            hm.put(7, "Aug");
            hm.put(8, "Sep");
            hm.put(9, "Oct");
            hm.put(10, "Nov");
            hm.put(11, "Dec");

        }
    %>
    <%
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId == 4) {
    %>
    <jsp:useBean id="Admin" class="com.pack.AdminBean" />
    <jsp:useBean id="CalculateIssue" class="com.pack.CalculateIssueValue" />
    <%@ include file="../header.jsp"%>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left"><font size="4" COLOR="#0000FF"><b>View User
                    </b> </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
            <td border="1" align="right"><font size="4" COLOR="#0000FF">
                </font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <%
        HashMap<String, Integer> valueTable = GetValues.checkValue();
        int bug = valueTable.get("bug");
        int enhancement = valueTable.get("enhancement");
        int newtask = valueTable.get("newtask");

        String pageToDisplay = null;
        String pageToView = null;

        if (bug == 0) {
            pageToDisplay = "bug";
        } else if (enhancement == 0) {
            pageToDisplay = "enhancement";
        } else if (newtask == 0) {
            pageToDisplay = "newtask";
        }

        if (bug > 0) {
            pageToView = "bug";
        } else if (enhancement > 0) {
            pageToView = "enhancement";
        } else if (newtask > 0) {
            pageToView = "newtask";
        }

        Connection connection = null;
        Statement sta = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            if (connection != null) {
                Admin.callProccedure(connection);
                sta = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                // rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,USERID,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON,CLOSEDISSUECOUNT(USERID) as closedCount,substr(emp_id,0,1) as empid from users where roleid>1 order by empid asc,closedCount desc,value desc");
                String sql = "SELECT DISTINCT USERID, FIRSTNAME,LASTNAME,COMPANY,EMAIL,MOBILE,PHONE,TEAM,VALUE,LASTLOGGEDON,(select count(issueid) from closedissue where COMMENTER=userid and COMMENTERTO=userid) as closedCount,substr(emp_id,0,1) as empid from users where roleid>1  and EMAIL='%@eminentlabs.net' order by empid,closedCount desc,value desc ";
                rs = sta.executeQuery(sql);

    %>



    <TABLE width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/MyTimeSheet/viewTimesheetStatus.jsp">View Timesheet Status</a>&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </TABLE>
    <br>
    <table width=100% id="user" class="tablesorter">

        <thead>
            <tr class="tablesorter-ignoreRow" >
                <td class="pager" colspan="6" style="background-color: white">
                    <span class="pagedisplay"></span>
                </td>
                <td colspan="3" style="background-color: white">
                    <div class="pager"><nav class="left"> # per page: <a href="#">10</a> | <a href="#" >25</a> | <a href="#">50</a>|<a href="#" class="current">100</a>
                        </nav> 
                        <nav class="right"> <span class="prev"> <img
                                    src="<%=request.getContextPath()%>/images/prev.png" /> Prev&nbsp; </span> <span
                                class="pagecount"></span> &nbsp;<span class="next">Next <img
                                    src="<%=request.getContextPath()%>/images/next.png" /> </span> </nav></div>
                </td>
            </tr>
            <tr bgColor="#C3D9FF" height="9">
                <th width="22%" ><font><b>Name</b></font></th>
                <th width="5%" class="filter-select filter-match" data-placeholder="Select a Team"><font><b>Team</b></font></th>
                <th width="5%" data-placeholder="Try >=, <=,=,!= "><font><b>Active</b></font></th>
                <th width="5%" data-placeholder="Try >=, <=,=,!= "><font><b>Worked</b></font></th>
                <th width="5%" data-placeholder="Try >=, <=,=,!= " title="Effort Estimated In Hrs"><font><b>Estimated</b></font></th>
                <th width="5%" data-placeholder="Try >=, <=,=,!= "><font><b>Closed</b></font></th>
                <th width="20%" <font><b>Company</b></font></th>
                <th width="23%" ><font><b>Email</b></font></th>
                <th width="10%" ><font><b>Mobile</b></font></th>
            </tr>
        </thead> 
        <tbody> 



            <%            HashMap<Integer, String> member = GetProjectMembers.showUsers();
                //calculating start and end date of this month
                Calendar cal = new GregorianCalendar();

                int year = cal.get(Calendar.YEAR);
                int month = cal.get(Calendar.MONTH);
                int maxday = cal.getActualMaximum(cal.DAY_OF_MONTH);

                Calendar timesheetCalendar = new GregorianCalendar();
                timesheetCalendar.add(Calendar.MONTH, -1);

                int timesheetMonth = timesheetCalendar.get(Calendar.MONTH);;
                int timesheetYear = timesheetCalendar.get(Calendar.YEAR);;

                int newYear = year;
                int sMonth = month - 2;
                if (month == 0) {
                    sMonth = 11;
                    newYear = newYear - 1;
                }
                if (month == 1) {
                    sMonth = 12;
                    newYear = newYear - 1;
                }
                String times = "";
                if (timesheetMonth > 9) {
                    times = "T" + (timesheetMonth) + timesheetYear;
                } else {
                    times = "T0" + (timesheetMonth) + timesheetYear;
                }

                logger.info("Year" + year);
                logger.info("Month Name" + hm.get(month));
                logger.info("times" + times);
                logger.info("MAX DAY of MOnth" + maxday);
                start = "1" + "-" + hm.get(month) + "-" + year;
                end = maxday + "-" + hm.get(month) + "-" + year;
                logger.info("Start Date" + start);
                logger.info("End Date" + end);
                HashMap tsList = CreateTimeSheet.getTimeSheet(times);
                logger.info("tsList.size()" + tsList.size());
                Map<Integer, Integer> activeIssuesCount = Admin.getActiveIssueCountByUserwise();
                Map<Integer, Integer> workedIssuesCount = Admin.getWorkedIssueCountByUserwise(start, end);
                Map<Integer, Float> estimateValue = Admin.getEstimatedValue();
                Map<Integer, String> getUserInvolvedProjects = Admin.getProjectInvolvedByUser();
                UserPerformance up = Admin.getUserPerformance();
                String color = "";
                int i = 0;
                if (rs != null) {
                    while (rs.next()) {
                        color = "";
                        String lastLoggedOn = "NA";
                        String fname = rs.getString("firstname");
                        String lname = rs.getString("lastname");
                        String company = rs.getString("company");
                        String email = rs.getString("email");
                        String mobile = rs.getString("mobile");
                        String team = rs.getString("team");
                        int userId = rs.getInt("userid");
                        Timestamp loggedon = rs.getTimestamp("lastloggedon");
                        int closedcount = rs.getInt("CLOSEDCOUNT");
                        if (loggedon != null) {
                            lastLoggedOn = new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(loggedon);
                        }

                        String url = null;
                        if (email != null) {
                            url = email.substring(email.indexOf("@") + 1, email.length());
                        }
            %>
            <tr  height="9">
                <td width="22%" title="Last Logged On :<%=lastLoggedOn%>"><input type="checkbox" name="approve" value="<%= userId%>">
                    <%if (url.equalsIgnoreCase("eminentlabs.net")) {
                            if (up.getCurrentMonthLeast().contains(userId)) {
                                color = "yellow";
                            }
                            if (up.getThreeMonthsLeast().contains(userId) || up.getMinCount().contains(userId)) {
                                color = "red";
                            }
                            if (up.getThreeMonthsTop().contains(userId) || up.getMaxCount().contains(userId)) {
                                color = "green";
                            }
                            if (up.getCurrentMonthTop().contains(userId)) {
                                color = "#0080ff";
                            }
                            if (tsList.containsKey(userId)) {
                    %>
                    <img src="<%=request.getContextPath()%>/images/tick.png" title="Timesheet assigned to <%=member.get(tsList.get(userId))%>">
                    <%} else {%>
                    <img src="<%=request.getContextPath()%>/images/remove.gif" title="Timesheet not yet submitted">
                    <%}
                        }%>
                    <A HREF="edituser.jsp?emailID=<%=email%>">

                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000" style="background-color: <%=color%>"> <%= StringUtil.encodeHtmlTag(fname)%>&nbsp;<%= StringUtil.encodeHtmlTag(lname)%></font></A></td>
                <td width="5%" 
                    TITLE="Projects Involved:<%
                        if (getUserInvolvedProjects.containsKey(userId)) {
                    %>
                    <%=getUserInvolvedProjects.get(userId)%>
                    <%} else {%>
                    NA
                    <%}
                    %>
                    "><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=team%></font></td>
                <td width="5%" align='center'><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><a href="<%= request.getContextPath()%>/admin/dashboard/chartForUsers.jsp?userId=<%= userId%>">
                            <%
                                if (activeIssuesCount.containsKey(userId)) {
                            %>
                            <%=activeIssuesCount.get(userId)%>

                            <%} else {%>
                            0
                            <%}
                            %>
                        </a></font></td>
                <td width="5%" align='center'><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><a href="<%= request.getContextPath()%>/admin/user/UserPerformanceChart.jsp?userId=<%= userId%>">
                            <%
                                if (workedIssuesCount.containsKey(userId)) {
                            %>
                            <%=workedIssuesCount.get(userId)%>

                            <%} else {%>
                            0
                            <%}
                            %></a></font></td>
                <td width="5%" align='center' ><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">  <%
                    if (estimateValue.containsKey(userId)) {
                        %>
                        <%=estimateValue.get(userId)%>

                        <%} else {%>
                        0.0
                        <%}
                        %>
                    </font></td>
                <td width="5%" align='center' ><font	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><a href="<%= request.getContextPath()%>/MyTimeSheet/ClosedIssues.jsp?userId=<%= userId%>"><%=closedcount%></a></font></td>
                <td width="20%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(company)%></font></td>
                <td width="23%" title="Reset Password"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email)%></font></td>
                <td width="10%"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= mobile%></font></td>


            </tr>

            <%i++;
                            }
                        }
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {
                    //      Admin.close();
                    if (rs != null) {
                        rs.close();
                    }
                    if (sta != null) {
                        sta.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }

                    //		logger.debug("Closing JDBC Resources");
                }
            %>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="9" style="background-color: #c3d9ff;">
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

</form>
<%
} else {
%>

<BR>
<table align="center">
    <tr align="center" ><td><font color="red">You are not authorized to access this page.</font></td></tr>
</table>
<%
    }
%>

<SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
<script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>


<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
<script type="text/javascript">




        $(document).ready(function () {

            var $table = $('#user'),
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
            $("#user").tablesorter({
                theme: 'blue',
// hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
// initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                widgetOptions: {
                    // extra css class applied to the table row containing the filters & the inputs within that row
                    filter_cssFilter: 'tablesorter-filter',
                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,
                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: false,
                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: false,
                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,
                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,
                    // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    // Add select box to 4th column (zero-based index)
                    // each option has an associated function that returns a boolean
                    // function variables:
                    // e = exact text from cell
                    // n = normalized value returned by the column parser
                    // f = search filter input value
                    // i = column index
                    filter_functions: {
                    },
                    filter_formatter: {
                    }

                }

            }).tablesorterPager({
//target the pager markup - see the HTML block below
                container: $pager,
                size: 10,
                output: 'Displaying {startRow} - {endRow} of {filteredRows}'
            });
            $('#user').trigger('pageSize', 100);
        });
        $(".resetPass").click(function (e) {
            $('.pass_message').remove();
            $("#type").val("");
            $("#password").val("");
            $("#conpassword").val("");
            $('#overlay').fadeOut('fast', 'swing');
            $('#MDApopup').fadeOut('fast', 'swing');
            var customerNumber = $.trim($(this).attr("id"));
            if (customerNumber.length > 0) {
                customerNumber = customerNumber.substring(4);
            }
            var uName = $.trim($(this).attr('uName'));
            $(".popupHeading").html("Reset password for " + uName + "<input type='hidden' id='customerNumber' value='" + customerNumber + "'/> ");
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#MDApopup').fadeIn('fast', 'swing');
        });
        function closeIssuePopup() {
            $("#popupHeading").html("");
            $(".pwdtxt").hide();
            $("#type").val("");
            $("#password").val("");
            $("#confirmPassword").val("");
            $('#overlay').fadeOut('fast', 'swing');
            $('#MDApopup').fadeOut('fast', 'swing');
        }
        $("#resetPassword").click(function (e) {
            $('.pass_message').remove();

            var customerNumber = $("#customerNumber").val();
            var type = $("#type").val();
            var newPassword = $("#password").val();
            newPassword = $.trim(newPassword);
            var confirmPassword = $("#conpassword").val();
            confirmPassword = $.trim(confirmPassword);
            var count = 0;
            if (type.length == 0) {
                $("<span class='pass_message' style='color:red'>Please select type</span>").insertAfter('#type');
                count++;
            } else {
                if (type === "manual") {
                    if (newPassword.length < 6 || newPassword.length > 15) {
                        $("<span class='pass_message' style='color:red'>Please enter password</span>").insertAfter('#password');
                        count++;
                    } else {
                        if (newPassword == confirmPassword) {

                        } else {
                            $("<span class='pass_message' style='color:red'>Passwords mismatch</span>").insertAfter("#conpassword");
                            count = 1;
                        }
                    }
                } else {
                    newPassword = "";
                }
            }
            if (count === 0) {
                $.ajax({
                    url: '<%= request.getContextPath()%>/admin/user/resetPasswordForUser.jsp',
                    data: {userid: customerNumber, type: type, password: newPassword, random: Math.random(1, 10)},
                    async: false,
                    type: 'POST',
                    success: function (responseText, statusTxt, xhr) {
                        if (statusTxt === "success") {
                            var result = $.trim(responseText);
                            if (result == "success") {
                                $('#overlay').fadeOut('fast', 'swing');
                                $('#MDApopup').fadeOut('fast', 'swing');
                                $("<span class='pass_message'><image src='<%= request.getContextPath()%>/images/tick.png'/></span>").insertAfter('#user' + customerNumber);
                                $("div.pwdtxt").hide();
                            } else {
                                $("<span class='pass_message' style='color:red'>Something went worng." + result + "</span>").insertAfter("#resetPassword");
                            }
                        }
                    }});
            }
        });
        $(document).on("change", "#type", function () {
            $('.pass_message').remove();
            var type = $.trim($(this).val());
            type = $.trim(type);
            if (type.length > 0) {

                if (type === "auto") {
                    $(".pwdtxt").hide();
                } else if (type === "manual") {
                    $(".pwdtxt").show();
                }
            }

        });
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
    .tablesorter-blue tbody tr.odd > td {
        background-color: #E8EEF7;
    }
    .tablesorter-blue tbody tr.even > td {
        background-color: white;
    }
</style>
</body>
</html>