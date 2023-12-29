<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*,com.eminent.tqm.TestCasePlan"%>
<%@ page import="java.text.*,com.eminentlabs.erm.ERMUtil"%>
<%@ page import="java.util.HashMap,java.util.List,com.eminent.leaveUtil.*,com.eminent.timesheet.*"%>
<%@ page import="pack.eminent.encryption.*, com.eminent.util.*, dashboard.*, com.pack.*"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>

<%@ include file = "/include files/cacheRemover.jsp" %>
<%
    session.setAttribute("forwardpage", "/MyTimeSheet/myTimeWiseIssues.jsp");
    //Configuring log4j properties

    Logger logger = Logger.getLogger("myTimeWiseIssues");

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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    </HEAD>

    <BODY>

        <%!    Connection connection;
            ResultSet rs;
        %>
        <%@ include file="../header.jsp"%>

        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean"></jsp:useBean>

        <%!    int requestpage, pageone, pageremain, rowcount, age;
            static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
            int userid_curri;
            HashMap<Integer, String> hm;
                    %>

        <%
            //Statement stmt=null;
            PreparedStatement pt = null, pt1 = null, ps = null;
            ResultSet rs1 = null, rs2 = null;
            String assignmentType = "";
            String title = "All";
            Calendar cal = Calendar.getInstance();
            int j = 0;

            int weekOfYear = cal.get(Calendar.WEEK_OF_YEAR);
            String query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            try {
                connection = MakeConnection.getConnection();
                hm = MyIssue.getUser(connection);
                Integer userid_curr = (Integer) session.getAttribute("userid_curr");
                userid_curri = userid_curr.intValue();
                if (request.getParameter("userId") != null) {
                    userid_curri = MoMUtil.parseInteger(request.getParameter("userId"), userid_curri);
                }
                String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + userid_curri + "' intersect select k.pid from userproject k where k.userid='" + userid_curr + "')";
                if (userid_curr == 104) {
                    extendedQuery = "";

                }
                if (request.getParameter("assignmentType") != null) {
                    assignmentType = request.getParameter("assignmentType");
                    session.setAttribute("assignmentType", assignmentType);
                } else {
                    if (session.getAttribute("assignmentType") != null) {
                        assignmentType = (String) session.getAttribute("assignmentType");
                        logger.info("assignmentType value" + session.getAttribute("assignmentType"));
                    } else {
                        logger.info("assignmentType value came wrong");
                    }
                }
                if (assignmentType.equalsIgnoreCase("backlog")) {
                    query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date < sysdate-1 " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                    title = "Backlog";
                } else if (assignmentType.equalsIgnoreCase("currentWeek")) {
                    query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'SATURDAY') from dual) " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                    title = "Current Week";
                } else if (assignmentType.equalsIgnoreCase("nextWeek")) {
                    int start = 1;
                    int end = 7;
                    int weekNumber = 0;
                    if (request.getParameter("weekNumber") != null) {
                        weekNumber = MoMUtil.parseInteger(request.getParameter("weekNumber"), 1);
                        start = ((weekNumber - 3) * 7) + 1;
                        end = start + 7;
                        session.setAttribute("weekNumber", request.getParameter("weekNumber"));
                    } else {
                        if (session.getAttribute("weekNumber") != null) {
                            weekNumber = MoMUtil.parseInteger((String) session.getAttribute("weekNumber"), 1);
                            start = ((weekNumber - 3) * 7) + 1;
                            end = start + 7;
                        } else {
                            logger.info("week number value came wrong");
                        }
                    }
                    query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+" + start + " from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+" + end + " from dual) " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                    title = "Week" + (weekOfYear + (weekNumber - 2));
                    if (weekOfYear + (weekNumber - 2) > 53) {
                        j++;
                        title = "Week" + j;
                    }
                } else {
                    query = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = ? " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                }

                String assignedTo = String.valueOf(userid_curri);
                logger.info("ASSIGNEDTO test:" + assignedTo);

                logger.info(query);
                //String sql="select * from issue where assignedto="+userid_curr1 +" or createdby="+userid_curr1;
                //String sql = "select issue.issueid,project,subject,severity,priority,type,modifiedon,createdby,assignedto,issuestatus.status  from issue left outer join issuestatus on issue.issueid=issuestatus.issueid where issuestatus.owner='"+userid_curr1+"' and issuestatus.status not like 'Closed%' or assignedto='"+userid_curr1+"'";
                //String sql = "select issue.issueid,project,subject,severity,priority,type,modifiedon,createdby,assignedto,issuestatus.status  from issue left outer join issuestatus on issue.issueid=issuestatus.issueid where issuestatus.status not like 'Closed%' and assignedto=? order by modifiedon desc" ;
                ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ps.setInt(1, userid_curri);
                //       ps.setString(1,assignedTo);

                rs1 = ps.executeQuery();
                rs1.last();

                rowcount = rs1.getRow();
                rs1.beforeFirst();


        %>

        <div align="center">

            <center>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr bgColor="#C3D9FF">
                        <td bgcolor="#C3D9FF" align="left" width="100%"><font
                                size="4" COLOR="#0000FF"><b><%=title%> Issues </b></font></td>
                    </tr>
                    <tr >
                        <td > This list shows <%=rowcount%> issue assigned to <b><%=hm.get(userid_curri)%> </b></font></td>
                    </tr>
                </table>
                <br/>
                <TABLE width="100%">
                    <TR bgcolor="#C3D9FF">
                        <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                        <TD width="10%"><font><b>Issue No</b></font></TD>
                        <TD width="2%" TITLE="Priority"><font><b>P</b></font></TD>
                        <TD width="10%"><font><b>Project</b></font></TD>
                        <TD width="7%"><font><b>Module</b></font></TD>
                        <TD width="29%"><font><b>Subject</b></font></TD>
                        <TD width="9%"><font><b>Status</b></font></TD>
                        <TD width="8%"><font><b>Due Date</b></font></TD>
                        <TD width="13%"><font><b>CreatedBy</b></font></TD>
                        <TD width="8%"><font><b>Refer</b></font></TD>
                        <TD width="3%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></TD>
                    </TR>

                    <%

                        if (rs1 != null) {
                            String totalissuenos = "";
                            for (int i = 1; i <= rowcount; i++) {
                                if (rs1.next()) {

                                    totalissuenos = totalissuenos + "'" + rs1.getString("issueid").trim() + "',";
                                }
                            }
                            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            }

                            rs1.beforeFirst();
                            for (int i = 1; i <= rowcount; i++) {
                                if (rs1.next()) {
                                    String issueId = rs1.getString("issueid");
                                    String project1 = rs1.getString("project");
                                    String module = rs1.getString("module");
                                    String sub = rs1.getString("subject");
                                    String sev = rs1.getString("severity");
                                    String priority = rs1.getString("priority");
                                    String desc = rs1.getString("description");
                                    String p = "NA";
                                    if (priority != null) {
                                        p = priority.substring(0, 2);
                                    }
                                    String fullModule = module;
                                    if (module.length() > 10) {
                                        module = module.substring(0, 10) + "..";
                                    }

                                    String type = rs1.getString("type");
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                    Date dueDateFormat = rs1.getDate("due_date");

                                    String dueDate = "NA";
                                    if (dueDateFormat != null) {
                                        dueDate = sdf.format(dueDateFormat);
                                    }

                                    int typ = rs1.getInt("createdby");
                                    String createdBy = hm.get(typ);

                                    String sta = rs1.getString("status");
                                    Date created = rs1.getDate("createdon");

                                    String createdon = "NA";
                                    if (created != null) {
                                        createdon = sdf.format(created);
                                    }

                                    Date modifiedon1 = rs1.getDate("modifiedon");

                                    String dateString1 = sdf.format(modifiedon1);

                                    if (sub.length() > 42) {
                                        sub = sub.substring(0, 42) + "...";
                                    }

                                    age = rs1.getInt("age");
                                    int lastAsigneeAge = 1;
                                    if (lastAsigneeAgeList.containsKey(issueId)) {
                                        lastAsigneeAge = lastAsigneeAgeList.get(issueId);
                                    }
                                    if (lastAsigneeAge == 1) {
                                        lastAsigneeAge = age;
                                    }
                                    if (lastAsigneeAge == 0) {
                                        lastAsigneeAge = lastAsigneeAge + 1;
                                    }

                                    String s1 = "S1- Fatal";
                                    String s2 = "S2- Critical";
                                    String s3 = "S3- Important";
                                    String s4 = "S4- Minor";

                                    if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="white" height="23">
                        <%                } else {
                        %>

                    <tr bgcolor="#E8EEF7" height="23">
                        <%                    }
                        %>


                        <% if (sev.equals(s1)) {%>
                        <td  bgcolor="#FF0000"></td>
                        <%} else if (sev.equals(s2)) {%>
                        <td  bgcolor="#DF7401"></td>
                        <%} else if (sev.equals(s3)) {%>
                        <td  bgcolor="#F7FE2E"></td>
                        <%} else if (sev.equals(s4)) {%>
                        <td  bgcolor="#04B45F"><br/>
                        </td>
                        <%}


                        %>
                        <td  TITLE="<%= type%>">
                            <A HREF="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=issueId%>"> <font
                                    face="Verdana, Arial, Helvetica, sans-serif" size="1"><%=issueId%> </font></A>
                        </td>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= p%></font></td>

                        <%
                            if (project1.length() < 15) {
                        %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1%></font></td>
                                <%
                                } else {
                                %>
                        <td ><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project1.substring(0, 15) + "..."%></font></td>
                                <%
                                    }
                                %>
                        <td width="7%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>

                        <td id="<%=issueId%>tab" onmouseover="xstooltip_show('<%=issueId%>', '<%=issueId%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=issueId%>');" ><div class="issuetooltip" id="<%=issueId%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>

                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sta%></font></td>
                                <%
                                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                %>
                        <td  title="Last Modified On <%= dateString1%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                        </td>
                        <%
                        } else {
                        %>
                        <td  title="Last Modified On <%= dateString1%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                        </td>
                        <%
                            }
                        %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= createdBy%></font>
                        </td>
                        <%

                            int count1 = 0;
                            if (fileCountList.containsKey(issueId)) {
                                count1 = fileCountList.get(issueId);
                            }
                            if (count1 > 0) {
                        %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=issueId%>');" href="#">ViewFiles(<%=count1%>)</A></font></td>
                                    <%
                                    } else {
                                    %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                <%                                    }
                                %>
                        <td align=center title="<%=lastAsigneeAge%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%>
                            </font></td>
                    </tr>
                    <%

                                    }
                                    if (rs2 != null) {
                                        rs2.close();
                                    }
                                    if (pt1 != null) {
                                        pt1.close();
                                    }
                                }
                            }
                            if (rs1 != null) {
                                rs1.close();
                            }
                            if (ps != null) {
                                ps.close();
                            }
                            if (pt != null) {
                                pt.close();
                            }

                        } catch (Exception e) {
                            logger.error("Exception:" + e);
                            logger.error(e.getMessage());
                        } finally {

                            if (connection != null && !connection.isClosed()) {
                                connection.close();

                            }

                        }


                    %>
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
        <SCRIPT language="JavaScript">

<!--

            /** Java Script Function For Trimming A String To Get Only The Required String Input */

            function trim(str) {
                while (str.charAt(str.length - 1) == " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) == " ")
                    str = str.substring(1, str.length);
                return str;
            }

            /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

            function isPositiveInteger(str) {
                var pattern = "E1234567890"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
                            pos = 1;
                            break;
                        }
                    i++;
                }
                while (pos == 1 && i < str.length)
                if (pos == 0)
                    return false;
                return true;
            }
            var dtCh = "/";
            var minYear = 1900;
            var maxYear = 2100;

            function isInteger(s) {
                var i;
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (((c < "0") || (c > "9")))
                        return false;
                }
                return true;
            }

            function stripCharsInBag(s, bag)
            {
                var i;
                var returnString = "";
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (bag.indexOf(c) == -1)
                        returnString += c;
                }
                return returnString;
            }

            function daysInFebruary(year)
            {
                return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
            }
            function DaysArray(n)
            {
                for (var i = 1; i <= n; i++)
                {
                    this[i] = 31
                    if (i == 4 || i == 6 || i == 9 || i == 11) {
                        this[i] = 30
                    }
                    if (i == 2) {
                        this[i] = 29
                    }
                }
                return this
            }

            function isDate(dtStr)
            {
                var daysInMonth = DaysArray(12)
                var pos1 = dtStr.indexOf(dtCh)
                var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
                var strMonth = dtStr.substring(3, 5)
                var strDay = dtStr.substring(1, 3)
                var strYear = dtStr.substring(5, 9)
                strYr = strYear
                if (strDay.charAt(0) == "0" && strDay.length > 1)
                    strDay = strDay.substring(1)
                if (strMonth.charAt(0) == "0" && strMonth.length > 1)
                    strMonth = strMonth.substring(1)
                for (var i = 1; i <= 3; i++)
                {
                    if (strYr.charAt(0) == "0" && strYr.length > 1)
                        strYr = strYr.substring(1)
                }
                month = parseInt(strMonth)
                day = parseInt(strDay)
                year = parseInt(strYr)
                if (strMonth.length < 1 || month < 1 || month > 12)
                {
                    alert("Please enter a valid Month in the Issue No(EDDMMYYYY001)")
                    return false
                }
                if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month])
                {
                    alert("Please enter a valid Day  in the Issue No(EDDMMYYYY001)")
                    return false
                }
                if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear)
                {
                    alert("Please enter a valid Year in the Issue No(EDDMMYYYY001)")
                    return false
                }
                var today = new Date;
                if (parseInt(today.getFullYear()) < year)
                {
                    window.alert("Enter the valid Year in the Issue No(EDDMMYYYY001) ");
                    return false;
                }
                if (parseInt(today.getFullYear()) == year)
                {
                    //           alert(parseInt(today.getMonth())+1+"here"+month)
                    if (month > (parseInt(today.getMonth()) + 1))
                    {
                        window.alert("Enter the valid Month in the Issue No(EDDMMYYYY001) ");
                        return false;
                    }
                    if (month == (parseInt(today.getMonth()) + 1))
                    {
                        //alert(day+"here"+parseInt(today.getDate()));
                        if (day > parseInt(today.getDate()))
                        {
                            window.alert("Enter the valid Day in the Issue No(EDDMMYYYY001) ");
                            return false;
                        }
                    }
                }
                return true
            }

            /** Function To Validate The Input Form Data */

            function fun(theForm) {

                /** This Loop Checks Whether There Is Any Integer Present In The Company Field */

                if (!isPositiveInteger(trim(theForm.issueid.value))) {
                    alert('Enter Issue NO in proper format like EDDMMYYYY001');
                    document.theForm.issueid.value = "";
                    theForm.issueid.focus();
                    return false;
                }

                if (!isDate(trim(theForm.issueid.value))) {
                    document.theForm.issueid.value = "";
                    theForm.issueid.focus();
                    return false;
                }
                if ((trim(theForm.issueid.value).length) < 12) {
                    alert('Size of the Issue No should be 12 characters ');
                    document.theForm.issueid.value = "";
                    theForm.issueid.focus();
                    return false;
                }
                if ((trim(theForm.issueid.value).length) > 12) {
                    alert('Size of the Issue No should be 12 characters ');
                    document.theForm.issueid.value = "";
                    theForm.issueid.focus();
                    return false;
                }

                if ((theForm.issueid.value == null) || (theForm.issueid.value == ""))
                {
                    alert("Please Enter the Issue Number")
                    theForm.issueid.focus()
                    return false
                }
                if (isDate(theForm.issueid.value) == false) {
                    return false
                }
                disableSubmit();
                return true;

            }

            /** Function To Set Focus On The First Name Field In The Form */

            function setFocus() {
                document.theForm.issueid.focus();
            }

            window.onload = setFocus;
            //-->

        </SCRIPT>
                
    </BODY>
</HTML>

