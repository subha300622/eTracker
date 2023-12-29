<%@page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*, com.pack.StringUtil"%>
<%@ page import="java.util.HashMap,java.text.SimpleDateFormat"%>
<%@ page import="pack.eminent.encryption.*,com.eminent.util.*, dashboard.CheckDate"%>





<%
    session.setAttribute("forwardpage", "/admin/dashboard/displayIssue.jsp");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("displayIssue");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }

%>

<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    </HEAD>

    <style fprolloverstyle>
        A:hover {
            color: #FF0000;
            font-weight: bold
        }
    </style>
    <BODY BGCOLOR="#FFFFFF">

        <%@ include file="/header.jsp"%>





        <div align="center">
            <center>

                <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
                    <tr border="2">
                        <td border="1" align="left" width="75%"><font size="4"
                                                                      COLOR="#0000FF"><b>Issue(s) based on your selection are
                                    listed below </b></font><FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
                    </tr>
                </table>

                <%
                    if (request.getParameter("issuestatus") != null && request.getParameter("issuestatus").equalsIgnoreCase("yes")) {
                %>

                <table width="100%" align=center border="0" bgcolor="#E8EEF7">
                    <tr>
                        <td align=center><FONT SIZE="4" COLOR="#0000ff">You have
                                updated the issue Successfully : </FONT> <%
                                    String no = (String) session.getAttribute("theissu");


                                %> <FONT SIZE="4" COLOR="#0000FF"><%=no%></FONT></td>
                    </tr>
                </table>
                <%
                } else {
                %> <br>
                <%
                    }
                %> <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" /> <%!
                    int requestpage, pageone, pageremain, rowcount, age;
                    static int totalpage, pagemanipulation, presentpage, extra, issuenofrom, issuenoto;
                    int userid_curri, absolte;
                    HashMap hm;

                                                %> <%
                                Connection connection = null;
                                ResultSet rs = null;
                                PreparedStatement ps = null;
                                session.setAttribute("dashBoard", "users");

                                //int count =0;
                                try {
                                    connection = MakeConnection.getConnection();
                                    logger.debug("Connection:" + connection);

                                    //hm = new HashMap<Integer,String>();
                                    hm = MyIssue.getUser(connection);
                                    logger.info("SIZE:" + hm.size());

                                    if (connection != null) {
                                        String userId = null;
                                        String status = null;
                                        String priority = null;
                                        String currentUser = null;

                                        if (request.getParameter("issuestatus") == null) {

                                            userId = request.getParameter("userId");
                                            status = request.getParameter("status");
                                            priority = request.getParameter("priority");
                                            currentUser = request.getParameter("currentUser");

                                            boolean flag = false;

                                            if (userId == null) {

                                                flag = true;

                                                userId = (String) session.getAttribute("chartForUserId");
                                                status = (String) session.getAttribute("chartForStatus");
                                                priority = (String) session.getAttribute("chartForPriority");
                                                currentUser = (String) session.getAttribute("chartForCurrentUser");

                                            }

                                            if (flag == false) {

                                                session.setAttribute("chartForUserId", userId);
                                                session.setAttribute("chartForStatus", status);
                                                session.setAttribute("chartForPriority", priority);
                                                session.setAttribute("chartForCurrentUser", currentUser);
                                            }

                                        } else {

                                            userId = (String) session.getAttribute("chartForUserId");
                                            status = (String) session.getAttribute("chartForStatus");
                                            priority = (String) session.getAttribute("chartForPriority");
                                            currentUser = (String) session.getAttribute("chartForCurrentUser");

                                        }

                                        // invoking the Query() of MyIssueBean
                                        logger.debug("RequestedUserID:" + userId);
                                        if (status.equalsIgnoreCase("Performance QA")) {
                                            status = "Performance Testing";
                                        }
                                        if (status.equalsIgnoreCase("Customizing Req")) {
                                            status = "Customizing Request";
                                        }
                                        absolte = 0;
                                        String query = "";

                                        if (Integer.parseInt(currentUser) == 104) {
                                            query = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status = ? and assignedto = ? and priority = ?  and i.pid = p.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                                            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            ps.setString(1, status);
                                            ps.setString(2, userId);
                                            ps.setString(3, priority);

                                        } else {
                                            ps = connection.prepareStatement("select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status = ? and assignedto = ? and priority = ?  and i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid=? intersect select k.pid from userproject k where k.userid=?) order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            ps.setString(1, status);
                                            ps.setString(2, userId);
                                            ps.setString(3, priority);
                                            ps.setString(4, userId);
                                            ps.setString(5, currentUser);
                                        }

                                        rs = ps.executeQuery();
                                        rs.last();
                                        rowcount = rs.getRow();
                                        rs.beforeFirst();
                                        if (rowcount == 0) {
                                            response.sendRedirect("./admin/dashboard/chartForUsers.jsp");

                                        }

                                        pageone = rowcount / 15;
                                        pageremain = rowcount % 15;

                                        logger.debug("Total No of records:" + rowcount);
                                        if (pageremain > 0) {
                                            totalpage = pageone + 1;
                                        } else {
                                            totalpage = pageone;
                                        }
                                        logger.debug("Total no of pages" + totalpage);
                                        try {
                                            String requestpag = request.getParameter("manipulation");
                                            logger.debug("Requested page" + requestpag);
                                            if (requestpag != null) {
                                                requestpage = Integer.parseInt(requestpag);
                                                if (requestpage == 1) {
                                                    presentpage = 1;
                                                    issuenofrom = 1;
                                                    issuenoto = issuenofrom + 14;
                                                    if (issuenoto > rowcount) {
                                                        extra = issuenoto - rowcount;
                                                        issuenoto = issuenoto - extra;
                                                    }
                                                    rs.beforeFirst();
                                                    logger.debug("Requested page First" + presentpage);
                                                }
                                                if (requestpage == 2) {
                                                    presentpage = presentpage - 1;
                                                    if (presentpage <= 0) {
                                                        presentpage = 1;
                                                    }
                                                    if (presentpage == 1) {
                                                        rs.beforeFirst();
                                                        issuenofrom = 1;
                                                        issuenoto = issuenofrom + 14;
                                                        if (issuenoto > rowcount) {
                                                            extra = issuenoto - rowcount;
                                                            issuenoto = issuenoto - extra;
                                                        }
                                                    } else {
                                                        issuenofrom = ((presentpage - 1) * 15 + 1);
                                                        absolte = issuenofrom - 1;
                                                        rs.absolute(issuenofrom - 1);
                                                        issuenoto = issuenofrom + 14;
                                                        if (issuenoto > rowcount) {
                                                            extra = issuenoto - rowcount;
                                                            issuenoto = issuenoto - extra;
                                                        }
                                                    }
                                                    logger.debug("Requested page Previous" + presentpage);
                                                }
                                                if (requestpage == 3) {
                                                    presentpage = presentpage + 1;
                                                    if (presentpage >= totalpage) {
                                                        presentpage = totalpage;
                                                    }
                                                    issuenofrom = ((presentpage - 1) * 15 + 1);
                                                    absolte = issuenofrom - 1;
                                                    rs.absolute(issuenofrom - 1);
                                                    logger.debug("Requested page Next" + presentpage);
                                                    issuenoto = issuenofrom + 14;
                                                    if (issuenoto > rowcount) {
                                                        extra = issuenoto - rowcount;
                                                        issuenoto = issuenoto - extra;
                                                    }
                                                }
                                                if (requestpage == 4) {

                                                    presentpage = totalpage;
                                                    logger.debug("Requested page Last" + presentpage);
                                                    issuenofrom = ((presentpage - 1) * 15 + 1);
                                                    absolte = issuenofrom - 1;
                                                    rs.absolute(issuenofrom - 1);
                                                    issuenoto = issuenofrom + 14;
                                                    if (issuenoto > rowcount) {
                                                        extra = issuenoto - rowcount;
                                                        issuenoto = issuenoto - extra;
                                                    }
                                                }
                                            } else {
                                                presentpage = 1;
                                                issuenofrom = 1;
                                                rs.beforeFirst();
                                                issuenoto = issuenofrom + 14;
                                                if (issuenoto > rowcount) {
                                                    extra = issuenoto - rowcount;
                                                    issuenoto = issuenoto - extra;
                                                }
                                            }
                                        } catch (Exception e) {
                                            logger.error("Exception:" + e);
                                        }
                %>


                <table width="100%" height="15">
                    <tr>
                        <%
                            if (rowcount == 0) {
                        %>
                        <td align="left" width="100%">Displaying Issues&nbsp;<b><%= "0"%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>with
                            status <b><%= status%></b> and priority <b><%= priority%></b></td>
                            <%
                            } else {
                            %>
                        <td align="left" width="100%">Displaying Issues&nbsp;<b><%= issuenofrom%>&nbsp;-&nbsp;<%= issuenoto%></b>&nbsp;of&nbsp;<b><%= rowcount%></b>
                            with status <b><%= status%></b> and priority <b><%= priority%></b></td>
                            <%
                                }
                            %>



                        <TD align="right" width="25" height="10">Severity</td>
                        <TD align="right" width="25" height="10" bgcolor="#FF0000">S1</TD>
                        <TD align="right" width="25" height="10" bgcolor="#DF7401">S2</TD>
                        <TD align="right" width="25" height="10" bgcolor="#F7FE2E">S3</TD>
                        <TD align="right" width="25" height="10" bgcolor="#04B45F">S4</TD>
                    </tr>

                </table>
                <br>
                <TABLE width="100%">
                    <TR bgColor="#C3D9FF" height="18">
                        <TD width="1%" TITLE="Severity"><font><b>S</b></font></TD>
                        <TD width="10%"><font><b>Issue No</b></font></TD>
                        <TD width="10%"><font><b>Project</b></font></TD>
                        <TD width="8%"><font><b>Module</b></font></TD>
                        <TD width="30%"><font><b>Subject</b></font></TD>
                        <TD width="8%"><font><b>Due Date</b></font></TD>
                        <TD width="9%"><font><b>Modified On</b></font></TD>
                        <TD width="13%"><font><b>Created By</b></font></TD>
                        <TD width="8%"><font><b>Refer</b></font></TD>
                        <TD width="3%" TITLE="In Days" ALIGN="CENTER"><font><b>Age</b></font></TD>
                    </TR>

                    <%
                        if (rs != null) {
                            String totalissuenos = "";
                            for (int i = 1; i <= 15; i++) {
                                if (rs.next()) {

                                    totalissuenos = totalissuenos + "'" + rs.getString("issueid").trim() + "',";
                                }
                            }
                            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                            if (totalissuenos.contains(",")) {
                                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                            }
                            if (absolte != 0) {
                                rs.absolute(absolte);
                            } else {
                                rs.beforeFirst();
                            }
                            for (int i = 1; i <= 15; i++) {
                                if (rs.next()) {

                                    String project = rs.getString("project");
                                    String module = rs.getString("module");
                                    String iss = rs.getString("issueid");
                                    String severity = rs.getString("severity");
                                    String createdBy = rs.getString("createdby");
                                    String sub = rs.getString("subject");
                                    if (sub.length() > 42) {
                                        sub = sub.substring(0, 42) + "...";
                                    }
                                    String desc = rs.getString("description");

                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                    Date dueDateFormat = rs.getDate("due_date");
                                    String dueDate = "NA";
                                    if (dueDateFormat != null) {
                                        dueDate = sdf.format(dueDateFormat);
                                    }
                                    String fullModule = module;
                                    if (module.length() > 10) {
                                        module = module.substring(0, 10) + "...";
                                    }
                                    String type = rs.getString("type");
                                    Date modified = rs.getDate("modifiedon");
                                    String modifiedon = "NA";
                                    if (modified != null) {
                                        modifiedon = sdf.format(modified);
                                    }

                                    Date created = rs.getDate("createdon");

                                    String createdon = "NA";
                                    if (created != null) {
                                        createdon = sdf.format(created);
                                    }
                                    age = GetAge.getIssueAge(createdon, status, modifiedon);
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
                                    int selectedUser = Integer.parseInt(userId);

                                    String result = (String) hm.get(selectedUser);
                                    logger.info("SELECTED EMPLOYEE:" + selectedUser + "::" + result);

                                    String s1 = "S1- Fatal";
                                    String s2 = "S2- Critical";
                                    String s3 = "S3- Important";
                                    String s4 = "S4- Minor";


                    %>


                    <%            if ((i % 2) != 0) {
                    %>
                    <tr bgcolor="white" height="21">
                        <%
                        } else {
                        %>

                    <tr bgcolor="#E8EEF7" height="21">
                        <%
                            }
                        %>

                        <%
                            if (severity.equals(s1)) {
                        %>
                        <td  bgcolor="#FF0000"></td>
                        <%
                        } else if (severity.equals(s2)) {
                        %>
                        <td  bgcolor="#DF7401"></td>
                        <%
                        } else if (severity.equals(s3)) {
                        %>
                        <td  bgcolor="#F7FE2E"></td>
                        <%
                        } else if (severity.equals(s4)) {
                        %>
                        <td  bgcolor="#04B45F"></td>
                        <%
                            }
                            int roleId = (Integer) session.getAttribute("Role");

                            if (roleId == 1) {
                        %>
                        <td  TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><a
                                    href="<%= request.getContextPath()%>/admin/dashboard/UpdateIssueview.jsp?issueNo=<%=iss%>"><%= iss%></a></font></td>

                        <%
                        } else {
                        %>
                        <td  TITLE="<%= type%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><a
                                    href="<%= request.getContextPath()%>/Issuesummaryview.jsp?issueid=<%=iss%>"><%= iss%></a></font></td>
                                <%
                                    }
                                %>
                        <td ><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= project%></font></td>
                        <td width="8%" title="<%=fullModule%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= module%></font></td>
                        <td id="<%=iss%>tab" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><div class="issuetooltip" id="<%=iss%>"><%= desc%></div><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= sub%></font></td>
                                <%

                                    if ((!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                                   size="1" color="RED"><%= dueDate%></font></td>
                                <%
                                } else {
                                %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                                   size="1" color="#000000"><%= dueDate%></font></td>
                                <%
                                    }

                                    int originator = Integer.parseInt(createdBy);

                                    String creator = (String) hm.get(originator);


                                %>

                        <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                                   size="1" color="#000000"><%= modifiedon%> </font></td>
                        <td><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= creator%>
                            </font></td>



                        <%

                            int count1 = 0;
                            if (fileCountList.containsKey(iss)) {
                                count1 = fileCountList.get(iss);
                            }
                            if (count1 > 0) {
                        %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"> <A onclick="viewFileAttachForIssue('<%=iss%>');" href="#"
                                                                                                             >ViewFiles(<%=count1%>)</A></font></td>
                                    <%
                                    } else {
                                    %>
                        <td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
                                <%
                                    }
                                %>
                        <td  align=center title="<%=age%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=lastAsigneeAge%></font>
                        </td>

                        <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </TABLE>
                <%
                            }
                        }
                    } catch (Exception e) {
                        logger.error("Exception:" + e);
                        //System.err.println(e);
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }

                        if (ps != null) {
                            ps.close();
                        }
                        logger.debug("closing jdbc resources in finally block");
                        if (connection != null && !connection.isClosed()) {
                            connection.close();
                        }
                    }
                %> <%
                    if (rowcount > 0) {
                        if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
                            logger.debug("Caught in 1");
                %> <%
                } else if (request.getParameter("manipulation") == null) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=3">Next</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=4">Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("4")) {
                    logger.debug("Caught in 2");
                %>
                <table align=right>
                    <tr>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=1">First</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=2">Previous</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("1")) {
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=3">Next</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=4">Last</a></td>
                    </tr>
                </table>
                <%
                } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
                    logger.debug("Caught in 3");
                %>
                <table align=right>
                    <tr>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=1">First</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=2">Previous</a></td>
                        <td>Next</td>
                        <td>Last</td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("3")) {
                    logger.debug("Caught in 4");
                %>
                <table align=right>
                    <tr>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=1">First</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=2">Previous</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=3">Next</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=4">Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
                    logger.debug("Caught in 5");
                %>
                <table align=right>
                    <tr>
                        <td>First</td>
                        <td>Previous</td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=3">Next</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=4">Last</a></td>
                    </tr>
                </table>
                <%

                } else if (request.getParameter("manipulation").equals("2")) {
                    logger.debug("Caught in 6");
                %>
                <table align=right>
                    <tr>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=1">First</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=2">Previous</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=3">Next</a></td>
                        <td><a href="<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?manipulation=4">Last</a></td>
                    </tr>
                </table>
                <%

                        }
                    }


                %>
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
