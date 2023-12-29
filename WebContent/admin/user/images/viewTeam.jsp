<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%
                //Configuring log4j properties

    Logger logger = Logger.getLogger("View Team");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<%!
    int requestpage, pageone, pageremain, rowcount, pid;
    static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
%>
<%@ page import="com.pack.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
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




    <body>

        <jsp:include page="/header.jsp" />

        <table cellpadding="0" cellspacing="0" width="100%">

            <tr border="2" bgcolor="#F5F5F5">

                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Project Administration</b></font> <FONT
                        SIZE="3" COLOR="#0000FF"> </FONT></td>

            </tr>
            <%
                if (request.getParameter("status") != null) {
            %>
            <tr>
                <td align=center><b><FONT SIZE="4" COLOR="#33CC33">You
                            have successfully Removed the Team Member : </FONT> <FONT SIZE="4"
                                                                                  COLOR="#0000FF"> <%= request.getParameter("status")%></FONT><b></td>
                            </tr>
                            <%
                                }
                            %>
                            </table>

                            <br>

                            <%
                                int pid1 = 0;
                                int mid = 0;
                                String module = "";
                                String pname1 = "";
                                Connection connection = null;
                                Statement st = null;
                                ResultSet rs = null;

                                try {

                                    connection = MakeConnection.getConnection();
                                    if (connection != null) {
                                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        rs = st.executeQuery("select * from team");
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
                                        logger.debug("Total No of Pages:" + totalpage);
                                        try {
                                            String requestpag = request.getParameter("manipulation");
                                            logger.debug("Requested Page:" + requestpag);
                                            if (requestpag != null) {
                                                logger.info("request p" + requestpag);
                                                requestpage = Integer.parseInt(requestpag);
                                                logger.info("request p no" + requestpage);
                                                if (requestpage == 1) {
                                                    presentpage = 1;
                                                    rs.beforeFirst();
                                                    logger.debug("Present Page:" + presentpage);
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
                                                    logger.debug("Requested page Previous" + presentpage);
                                                }
                                                if (requestpage == 3) {
                                                    presentpage = presentpage + 1;
                                                    if (presentpage >= totalpage) {
                                                        presentpage = totalpage;
                                                    }
                                                    issuenofrom = ((presentpage - 1) * 15 + 1);
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
                                            logger.error("Exception in View Teams:" + e);
                                        }


                            %>

                            <%    if (rowcount > 0) {
                            %>

                            <table width="100%" border="0">
                                <tr>

                                    <td align="left" width="100%">This list shows all the <b><%=rowcount%></b>
                                        Team Members for the Project.</td>
                                    <td align="left" width="25%">Team Members</td>
                                    <TD align="right" width="25" height="10"><%=issuenofrom%></td>
                                    <TD align="right" width="25" height="10">-</td>
                                    <TD align="right" width="25" height="10"><%=issuenoto%></td>

                                </tr>


                            </table>

                            <br>
                            <table width=100%>

                                <TR bgcolor="#C3D9FF" height="21">
                                    <TD width="12%"><font><b>Team ID</b></font></TD>

                                    <TD width="22%"><font><b>Team</b></font></TD>

                                </tr>
                                <%
                                    int userid = 0;
                                    String first = "";
                                    String last = "";
                                    String full = "";
                                    String email = "";
                                    String team = "";
                                    if (rs != null) {
                                        for (int i = 1; i <= 15; i++) {
                                            if (rs.next()) {

                                                first = rs.getString("teamid");

                                                team = rs.getString("teamname");

                                                if ((i % 2) != 0) {
                                %>
                                <tr bgcolor="white" height="21">
                                    <%
                                    } else {
                                    %>

                                <tr bgcolor="#E8EEF7" height="21">
                                    <%
                                        }
                                    %>

                                    <td width="12%"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= userid%></font>
                                    </td>
                                    <td width="22%"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= full%></font>
                                    </td>

                                    <td width="22%"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= team%></font>
                                    </td>

                                    <td width="22%"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email%></font>
                                    </td>
                                    <td width="22%"><font
                                            face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">
                                            <A HREF="deleteTeam.jsp?userid=<%=userid%>&pid=<%=pid%>">Remove</A> </font></td>
                                </tr>
                                <%
                                                }
                                            }
                                        }
                                    }
                                } else {
                                %>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <br>
                                <center>
                                    <h3><b>No Teams are available!</b></h3>
                                </center>
                                <%
                                        }

                                    } catch (Exception e) {
                                        logger.error("Exception in View Teams:" + e);
                                    } finally {
                                        if (rs != null) {
                                            rs.close();
                                        }
                                        
                                        if (st != null) {
                                            st.close();
                                        }
                                       

                                        if (connection != null) {
                                            connection.close();
                                        }
                                    }

                                %>

                            </table>



                            <%    logger.info("row count" + rowcount);
                                if (rowcount > 0) {
                                    if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
                            %>

                            <%
                            } else if (request.getParameter("manipulation") == null) {
                            %>
                            <table align=right>
                                <tr>
                                    <td>First</td>
                                    <td>Previous</td>
                                    <td><a href=viewTeam.jsp?manipulation=3&pid=<%=pid%>>Next</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=4&pid=<%=pid%>>Last</a></td>
                                </tr>
                            </table>
                            <%

                            } else if (request.getParameter("manipulation").equals("4")) {
                            %>
                            <table align=right>
                                <tr>
                                    <td><a href=viewTeam.jsp?manipulation=1&pid=<%=pid%>>First</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=2&pid=<%=pid%>>Previous</a></td>
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
                                    <td>Prev</td>
                                    <td><a href=viewTeam.jsp?manipulation=3&pid=<%=pid%>>Next</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=4&pid=<%=pid%>>Last</a></td>
                                </tr>
                            </table>
                            <%
                            } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
                            %>
                            <table align=right>
                                <tr>
                                    <td><a href=viewTeam.jsp?manipulation=1&pid=<%=pid%>>First</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=2&pid=<%=pid%>>Previous</a></td>
                                    <td>Next</td>
                                    <td>Last</td>
                                </tr>
                            </table>
                            <%

                            } else if (request.getParameter("manipulation").equals("3")) {
                            %>
                            <table align=right>
                                <tr>
                                    <td><a href=viewTeam.jsp?manipulation=1&pid=<%=pid%>>First</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=2&pid=<%=pid%>>Previous</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=3&pid=<%=pid%>>Next</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=4&pid=<%=pid%>>Last</a></td>
                                </tr>
                            </table>
                            <%

                            } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
                            %>
                            <table align=right>
                                <tr>
                                    <td>First</td>
                                    <td>Previous</td>
                                    <td><a href=viewTeam.jsp?manipulation=3&pid=<%=pid%>>Next</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=4&pid=<%=pid%>>Last</a></td>
                                </tr>
                            </table>
                            <%

                            } else if (request.getParameter("manipulation").equals("2")) {
                            %>
                            <table align=right>
                                <tr>
                                    <td><a href=viewmodules.jsp?manipulation=1&pid=<%=pid%>>First</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=2&pid=<%=pid%>>Previous</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=3&pid=<%=pid%>>Next</a></td>
                                    <td><a href=viewTeam.jsp?manipulation=4&pid=<%=pid%>>Last</a></td>
                                </tr>
                            </table>
                            <%

                                    }
                                }


                            %>
                            <br>
                            </body>

                            <BR>
                            </html>