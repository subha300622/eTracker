<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger,pack.eminent.encryption.*,dashboard.*"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("ViewProject");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html ">
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
</head>
<%@ page import="java.sql.*"%>
<%!
    int requestpage, pageone, pageremain, rowcount;
    static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
%>
<jsp:useBean id="Admin" class="com.pack.AdminBean" />
<jsp:useBean id="GetName" class="com.eminent.util.GetName" />
<body>
    <%@ include file="/header.jsp"%>

    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4"
                                                           COLOR="#0000FF"><b>Project Administration</b></font> <FONT SIZE="3"
                                                                           COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br>
    <%
        int roleId = (Integer) session.getAttribute("Role");
        if (roleId == 1) {
            Connection connection = null;
            Statement st1 = null, st2 = null;
            PreparedStatement ps = null;
            ResultSet rs = null, rs1 = null, rs2 = null;
            int pid = 9999;
            String product = null;
            String version = null;
            String platform = null;
            String projectMan = null;
            String customer = null;
            String startdate = null;
            String enddate = null;
            String phase = null;
            String totalhours = null;
            int rowcount = 0;
            String[] status = {"To be started", "Work in progress", "Finished"};
            String dbStatus = null;
            String percentageDone = null;
            int sumIssues = 0;
            int sumClosed = 0;
            int openIssues=0;
             String escColor = "#000000";
  EscalationDAO escalationDAO = new EscalationDAOImpl();
    List<Integer> escalateProjects = escalationDAO.escalationProejctList();
        
            try {
                connection = MakeConnection.getConnection();
                logger.debug("Connection:" + connection);
                if (connection != null) {

                    {
                        rs = Admin.ViewProject(connection);
                        rs.last();
                        rowcount = rs.getRow();
                        rs.beforeFirst();

                        pageone = rowcount / 15;
                        pageremain = rowcount % 15;
                        if (pageremain > 0) {
                            totalpage = pageone + 1;
                        } else {
                            totalpage = pageone;
                        }
                        logger.debug("Total No of pages:\t" + totalpage);
                        try {
                            String requestpag = request.getParameter("manipulation");
                            if (requestpag != null) {
                                requestpage = Integer.parseInt(requestpag);
                                if (requestpage == 1) {
                                    presentpage = 1;
                                    rs.beforeFirst();
                                    issuenofrom = 1;
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
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
                                        rs.absolute(issuenofrom - 1);
                                        issuenoto = issuenofrom + 14;
                                        if (issuenoto > rowcount) {
                                            extra = issuenoto - rowcount;
                                            issuenoto = issuenoto - extra;
                                        }
                                    }
                                }
                                if (requestpage == 3) {
                                    presentpage = presentpage + 1;
                                    if (presentpage >= totalpage) {
                                        presentpage = totalpage;
                                    }
                                    issuenofrom = ((presentpage - 1) * 15 + 1);
                                    rs.absolute(issuenofrom - 1);
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                                if (requestpage == 4) {
                                    presentpage = totalpage;
                                    issuenofrom = ((presentpage - 1) * 15 + 1);
                                    rs.absolute(issuenofrom - 1);
                                    issuenoto = issuenofrom + 14;
                                    if (issuenoto > rowcount) {
                                        extra = issuenoto - rowcount;
                                        issuenoto = issuenoto - extra;
                                    }
                                }
                            } else {
                                presentpage = 1;
                                if (rowcount > 0) {
                                    issuenofrom = 1;
                                } else {
                                    issuenofrom = 0;
                                }
                                rs.beforeFirst();
                                issuenoto = issuenofrom + 14;
                                if (issuenoto > rowcount) {
                                    extra = issuenoto - rowcount;
                                    issuenoto = issuenoto - extra;
                                }
                            }
                        } catch (Exception e) {
                            logger.error("Exception in View Project:\t" + e);
                        }
    %>
    <table width="100%" border="0">
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp">MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>
                                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" style="cursor: pointer;">Issue Category</a>

            </td>
            <td></td>
            <td colspan="2" align="right">Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
        </tr>
    </table>
    <br>
    <table width=100%>
        <tr bgColor="#C3D9FF" height="21">
            <!--<TD width="6%" height="10" bgcolor="#0033FF"><font color="#FFFFFF">PID</font></TD>-->
            <TD width="15%"><font><b>Product</b></font></TD>
            <!--<TD width="5%" height="10" bgcolor="#0033FF"><font color="#FFFFFF">Version</font></TD>-->
            <!--<TD width="7%" height="10" bgcolor="#0033FF"><font color="#FFFFFF">Platform</font></TD> -->
            <TD width="13%"><font><b>Project Manager</b></font></TD>
            <TD width="16%"><font><b>Customer</b></font></TD>
            <TD width="8%"><font><b>Start Date</b></font></TD>
            <TD width="8%"><font><b>End Date</b></font></TD>
            <!--<TD width="5%" height="10" ><font color="#FFFFFF">Total Issues</font></TD>-->
            <!--<TD width="4%" height="10" bgcolor="#0033FF"><font color="#FFFFFF">Total Hours</font></TD>-->
            <TD width="13%"><font><b>Status</b></font></TD>
            <TD width="6%"><font><b>% Done</b></font></TD>
            <TD width="9%"><font><b>Modules</b></font></TD>
            <TD width="7%"><font><b>Team</b></font></TD>
            <TD width="5%"><font><b>Manage</b></font></TD>
        </tr>


        <%
            boolean startDateFlag;
            boolean endDateFlag;
            if (rs != null) {
                for (int i = 1; i <= 15; i++) {
                    if (rs.next()) {
                        escColor = "#000000";
                        pid = rs.getInt("pid");
                        if(escalateProjects.contains(pid)){
                           escColor = "red";
                        }
                        st1 = connection.createStatement();
                        rs1 = st1.executeQuery("select count(issueid) from issue where pid = " + pid);
                        while (rs1.next()) {
                            sumIssues = rs1.getInt(1);
                        }
                        st1.close();
                        rs1.close();
                        st2 = connection.createStatement();
                        rs2 = st2.executeQuery("select count(issue.issueid) from issue, issuestatus where status = 'Closed' and issue.issueid = issuestatus.issueid and pid = " + pid);
                        while (rs2.next()) {
                            sumClosed = rs2.getInt(1);
                        }
                        rs2.close();
                        st2.close();
                        openIssues = sumIssues-sumClosed;
                        percentageDone = ArithOperation.calcPercentage(sumIssues, sumClosed);
                        product = rs.getString("pname");
                        platform = rs.getString("platform");
                        projectMan = rs.getString("pmanager");
                        version = rs.getString("version");
                        customer = rs.getString("customer");
                        totalhours = rs.getString("totalhours");
                        startdate = rs.getString("startingdate");
                        enddate = rs.getString("endingdate");
                        dbStatus = rs.getString("status");
                        phase = rs.getString("phase");
                        //                               logger.info("Start Date"+startdate);
                        //                               logger.info("End Date"+enddate);
                        startDateFlag = CheckDate.getFlag(startdate);
                        endDateFlag = CheckDate.getFlag(enddate);

        %>

        <%            if ((i % 2) != 0) {
        %>
        <tr bgcolor="white" height="22">
            <%
            } else {
            %>

        <tr bgcolor="#E8EEF7" height="22">
            <%
                }
            %>


            <!--<td width="6%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= pid%></font>
                                </td>-->
            <td width="15%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><a
                        href="<%= request.getContextPath()%>/admin/dashboard/displayChart.jsp?project=<%= product%>:<%= version%>&phase=<%= phase%>"><%= product + " " + version%></a> (<a  style="color: blue;" href="<%= request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%= pid%>"><b><%=openIssues%></b></a>)</font>
            </td>
            <!--<td width="5%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(version)%></font>
                                </td>
                                <td width="7%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(platform)%></font>
                                </td>
                                <td width="10%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(projectMan)%></font>
                                </td>-->

            <%
                String name = (GetName.getUserName(projectMan));
                String firstname = name.substring(0, name.indexOf(" "));
                if ((firstname.length() <= 20)) {
            %>
            <td width="13%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= firstname%></font></td>
                    <%
                    } else {
                    %>
            <td width="13%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= firstname.substring(0, 20) + "..."%></font></td>
                    <%
                        }
                    %>
            <!--<td width="10%" height="25%" bgcolor="#F5F5F5">
                                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(customer)%></font>
                                    </td>-->

            <%
                if (customer.length() <= 20) {
            %>
            <td width="16%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= customer%></font></td>
                    <%
                    } else {
                    %>
            <td width="16%"><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= customer.substring(0, 20) + "..."%></font></td>
                    <%
                        }
                    %>
            <td width="8%">
                <%
                    if (startDateFlag == true && dbStatus.equalsIgnoreCase("To be started")) {

                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= startdate%></font>

                <%
                } else {
                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= startdate%></font>
                    <%
                        }
                    %>
            </td>
            <td width="8%">
                <%
                    if (endDateFlag == true && !(dbStatus.equalsIgnoreCase("Finished"))) {

                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= enddate%></font>

                <%
                } else {
                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= enddate%></font>
                    <%
                        }
                    %>
            </td>
            <!--                    <td width="5%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=sumIssues%></font>
                                </td>
                                <td width="4%" height="25%" bgcolor="#F5F5F5">
                                    <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= totalhours%></font>
                                </td>-->
            <td width="13%">
                <%

                    if ((startDateFlag == true && dbStatus.equalsIgnoreCase("To be started")) || (endDateFlag == true && !(dbStatus.equalsIgnoreCase("Finished")))) {

                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dbStatus%></font>

                <%
                } else {
                %> <font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%= dbStatus%></font>
                    <%
                        }
                    %>
            </td>
            <td width="6%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="<%=escColor%>"><%= percentageDone%></font></td>
            <td width="9%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="<%=escColor%>"> <A
                        HREF="viewmodules.jsp?pid=<%=pid%>">View</A>&nbsp;|&nbsp;<A
                        HREF="addmodules1.jsp?pid=<%=pid%>">Add</A></font></td>
            <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="<%=escColor%>"> <A HREF="viewTeam.jsp?pid=<%=pid%>">View</A>&nbsp;|&nbsp;<A title="WRM Mail"
                                                                                                          HREF="maintainWRM.jsp?pid=<%=pid%>">WRM</A></font>
            </td>
            <td width="5%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="<%=escColor%>"> <A
                        HREF="editproject.jsp?pid=<%=pid%>">Edit</A></font></td>
        </tr>

        <%
                }
            }
        %>
    </table>
    <%
        }
        if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
    %>

    <%
    } else if (request.getParameter("manipulation") == null) {
    %>
    <table align="right">
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=viewproject.jsp?manipulation=3>Next</a></td>
            <td><a href=viewproject.jsp?manipulation=4>Last</a></td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("1")) {
    %>
    <table align="right">
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=viewproject.jsp?manipulation=3>Next</a></td>
            <td><a href=viewproject.jsp?manipulation=4>Last</a></td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("4")) {
    %>
    <table align="right">
        <tr>
            <td><a href=viewproject.jsp?manipulation=1>First</a></td>
            <td><a href=viewproject.jsp?manipulation=2>Prev</a></td>
            <td>Next</td>
            <td>Last</td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
    %>
    <table align="right">
        <tr>
            <td><a href=viewproject.jsp?manipulation=1>First</a></td>
            <td><a href=viewproject.jsp?manipulation=2>Prev</a></td>
            <td>Next</td>
            <td>Last</td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("3")) {
    %>
    <table align="right">
        <tr>
            <td><a href=viewproject.jsp?manipulation=1>First</a></td>
            <td><a href=viewproject.jsp?manipulation=2>Prev</a></td>
            <td><a href=viewproject.jsp?manipulation=3>Next</a></td>
            <td><a href=viewproject.jsp?manipulation=4>Last</a></td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
    %>
    <table align="right">
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=viewproject.jsp?manipulation=3>Next</a></td>
            <td><a href=viewproject.jsp?manipulation=4>Last</a></td>
        </tr>
    </table>
    <%
    } else if (request.getParameter("manipulation").equals("2")) {
    %>
    <table align="right">
        <tr>
            <td><a href=viewproject.jsp?manipulation=1>First</a></td>
            <td><a href=viewproject.jsp?manipulation=2>Prev</a></td>
            <td><a href=viewproject.jsp?manipulation=3>Next</a></td>
            <td><a href=viewproject.jsp?manipulation=4>Last</a></td>
        </tr>
    </table>
    <%
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Exception in View Project:" + e);
            logger.error(e.getMessage());

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    } else {
    %>
    <BR>
    <table align="center">
        <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
    </table>
    <%
        }
    %>
</body>
</html>