<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java"
         contentType="application/vnd.ms-excel;  "
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">

    </HEAD>


    <BODY BGCOLOR="#FFFFFF">

        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />
        <%
            Connection connection = null;
            Statement state1 = null;
            ResultSet result1 = null, rs = null, rs2 = null;
            int count = 0, rowcount = 0;
            PreparedStatement ps = null;
            Logger logger = Logger.getLogger("MyIssueExcel");
            try {
                connection = MakeConnection.getConnection();
                if (connection != null) {
                    Integer userid_curr = (Integer) session.getAttribute("userid_curr");
                    int userid_curri = userid_curr.intValue();
                    String theissuno;
                    String createdby = String.valueOf(userid_curri);
                    ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and createdby = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ps.setString(1, createdby);
                    rs = ps.executeQuery();
                    rs.last();
                    rowcount = rs.getRow();

                    rs.beforeFirst();


        %>

        <table width="100%" height="15">
            <tr>
                <td align="left" width="100%">Displaying <b><%= rowcount%></b>
                    Issues created by you</td>
                <TD align="right" width="25" height="40">Severity</td>
                <TD align="right" width="25" height="40" bgcolor="#FF0000">S1</TD>
                <TD align="right" width="25" height="40" bgcolor="#FF9900">S2</TD>
                <TD align="right" width="25" height="40" bgcolor="#FFFF00">S3</TD>
                <TD align="right" width="25" height="40" bgcolor="#33FF33">S4</TD>
            </tr>

        </table>



        <TABLE width="100%">
            <TR bgcolor="#0033FF">
                <TD width="1%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">S</font></TD>
                <TD width="11%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Issue No</font></TD>
                <TD width="12%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Project</font></TD>
                <TD width="30%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Subject</font></TD>
                <TD width="10%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Status</font></TD>
                <TD width="16%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">AssignedTo</font></TD>
                <TD width="10%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Priority</font></TD>
                <TD width="10%" height="40" bgcolor="#0033FF"><font
                        color="#FFFFFF">Modified on</font></TD>


            </TR>
        </table>
        <%
            if (rowcount > 0) {
                while (rs.next()) {
                    ++count;
                    String project = (String) rs.getString("project");
                    String iss = (String) rs.getString("issueid");
                    session.setAttribute("theissno", iss);
                    String severity = rs.getString("severity");
                    String pri = rs.getString("priority");
                    String sub = rs.getString("subject");
                    session.setAttribute("subject", sub);
                    String assignedto1 = rs.getString("assignedto");
                    String first = "";
                    String last = "";
                    state1 = connection.createStatement();
                    result1 = state1.executeQuery("Select firstname, lastname from users where userid =" + assignedto1);
                    if (result1 != null) {
                        while (result1.next()) {
                            first = result1.getString("firstname");
                            last = result1.getString("lastname");
                        }
                    }

                    String result = first + " " + last;
                    String s1 = "S1- Fatal";
                    String s2 = "S2- Critical";
                    String s3 = "S3- Important";
                    String s4 = "S4- Minor";
                    String dateString = rs.getString("modifiedon");
                    //					SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
//					String dateString = sdf.format(mod);
                    theissuno = (String) session.getAttribute("theissno");
                    Statement state = connection.createStatement();
                    rs2 = state.executeQuery("select status from issuestatus where issueid='" + theissuno + "' ");
                    if (rs2 != null) {
                        while (rs2.next()) {
                            String sta = rs2.getString("status");
                            session.setAttribute("status", sta);
        %>

        <TABLE width="100%">
            <tr>
                <%
                    if (severity.equals(s1)) {
                %>
                <td width="1%" height="40" bgcolor="#FF0000"></td>
                <%
                } else if (severity.equals(s2)) {
                %>
                <td width="1%" height="40" bgcolor="#FF9900"></td>
                <%
                } else if (severity.equals(s3)) {
                %>
                <td width="1%" height="40" bgcolor="#FFFF00"></td>
                <%
                } else if (severity.equals(s4)) {
                %>
                <td width="1%" height="40" bgcolor="#00FF40"></td>
                <%
                    }
                %>
                <td width="11%" height="40" bgcolor="#F5F5F5"><A
                        HREF="<%=request.getContextPath()%>/MyIssueview.jsp?issueid=<%=iss%>"><font
                            face="Verdana, Arial, Helvetica, sans-serif" size="3" color="#0033FF"><%=iss%>
                        </font></A></td>
                <td width="12%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= project%></font></td>
                <td width="30%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= sub%></font></td>
                <td width="10%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= sta%></font></td>
                <td width="16%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= result%></font></td>
                <td width="10%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= pri%></font></td>
                <td width="10%" height="40" bgcolor="#F5F5F5"><font face="Arial"
                                                                    size="3" color="#000000"><%= dateString%> </font></td>
            </tr>
            <tr></tr>
            <%							}
                                }

                            }
                        }

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {

                    if (result1 != null) {
                        result1.close();
                    }
                    if (rs != null) {
                        rs.close();
                    }
                    //rs3.close();
                    if (rs2 != null) {
                        rs2.close();
                    }
                    if (state1 != null) {
                        state1.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            %>
        </table>


    </BODY>
</HTML>