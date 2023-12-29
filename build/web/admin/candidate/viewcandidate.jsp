<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*"%>
<%@page import="com.eminent.util.GetProjectMembers" %>
<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("viewcandidate");

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
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</TITLE>
    <script language="JavaScript">
        function printpost(post)
        {
            pp = window.open('./profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
        }

        function check(searchCandidate) {
            if ((searchCandidate.candidateName.value == null) || (searchCandidate.candidateName.value == ""))
            {
                alert("Please Enter String to Search ")
                searchCandidate.candidateName.focus()
                return false
            }
            return true
        }

        /** Function To Set Focus On The First Name Field In The Form */

        function setFocus() {
            document.searchCandidate.candidateName.focus();
        }

        window.onload = setFocus;
    </script>
</head>
<body>
    <%@ page import="java.sql.*"%>
    <%!
        int requestpage, pageone, pageremain, rowcount;
        static int totalpage, pagemanipulation, presentpage, issuenofrom, issuenoto, extra;
    %>
    <%@ include file="/header.jsp"%>


    <form name="searchCandidate" onsubmit="return check(this);"
          action="searchCandidate.jsp">
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr>
                <td align="left"><font size="4" COLOR="#0000FF"><b>Applicant
                            Administration</b> </font>
                    <!--		<td align="center"><b>Search:</b></td>
                                    <td align="left"><input type="text" name="candidateName"
                                            maxlength="20" size="15"></td>
                                    <td align="left"><input type="submit" name="submit"
                                            value="Search"></td>
                                    <td align="left"><input type="reset" name="reset" value="Reset">
                                    </td>
                                    <td align="right"
                                            title="Upload all the applicants with any status to excel"><font
                                            size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Export
                                    to <a
                                            href="<%=request.getContextPath()%>/admin/candidate/excelForViewCandidate.jsp"
                                            target="_blank">Excel</a></b></font></td>-->

            </tr>
        </table>
    </form>
    <%--<%@ include file="statusHeader.jsp"%>--%>

    <%
        String filePath = request.getSession().getServletContext().getInitParameter("upload-resume");
        String filePathone = request.getSession().getServletContext().getInitParameter("upload-user-photo");

        session.setAttribute("forwardpage", "/admin/candidate/viewcandidate.jsp");
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            connection = MakeConnection.getConnection();
            logger.debug("Connection has been created:" + connection);

            if (connection != null) {
                st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rs = st.executeQuery("SELECT APPLICANT_ID,FIRSTNAME,LASTNAME,MOBILE,CURRENT_LOCATION,REFERENCE_EMPID,REGISTEREDON,UG,PG,AREA_OF_EXPERTISE,SAP_EXP_YR,SAP_EXP_MON,TOTAL_EXP_YR,TOTAL_EXP_MON,ASSIGNEDTO FROM ERM_APPLICANT WHERE APPLICANT_STATUS=2 ORDER BY SAP_EXP_YR DESC, SAP_EXP_MON DESC, TOTAL_EXP_YR DESC, TOTAL_EXP_MON DESC");
                rs.last();
                int rowcount = rs.getRow();
                logger.debug("Total No of records:" + rowcount);
                rs.beforeFirst();
                pageone = rowcount / 15;
                pageremain = rowcount % 15;

                if (pageremain > 0) {
                    totalpage = pageone + 1;
                } else {
                    totalpage = pageone;
                }
                try {
                    String requestpag = request.getParameter("manipulation");
                    logger.debug("Requested Page:" + requestpag);
                    if (requestpag != null) {
                        requestpage = Integer.parseInt(requestpag);
                        if (requestpage == 1) {
                            presentpage = 1;
                            rs.beforeFirst();
                            logger.debug("Requested page First" + presentpage);
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
                            logger.debug("Requested page Prev" + presentpage);
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
                    logger.error("Exception:" + e);
                }
                if (request.getParameter("newcontact") != null) {
    %>

    <table width="100%" align=center border="0" bgcolor="E8EEF7">
        <tr>
            <td align=center><FONT SIZE="4" COLOR="#33CC33">New
                    Contact has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("email")%></FONT>
            </td>
        </tr>
    </table>
    <%
        }
    %>

    <table width="100%" align=center border="0" >
        <tr>
            <td>

                <a href="viewUnscreened.jsp">View Unscreended Candidates</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="viewRejected.jsp">View Rejected Candidates</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="viewScreening.jsp">View Screening Candidates</a>   &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="viewcandidate.jsp"><b>View Shortlisted Candidates</b></a>
            </td>
        </tr>
    </table>
    <TABLE width="100%" border="0">
        <tr>
            <%
                if (rowcount == 0) {
            %>
            <td>Displaying&nbsp;<%= "0"%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
            <%
            } else {
            %>
            <td>Displaying&nbsp;<%=issuenofrom%>&nbsp;- <%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b> shortlisted candidates.</td>
            <%
                }
            %>
        </tr>
    </TABLE>
    <br>

    <table width=100%>
        <TR bgColor="#C3D9FF" height="9">
            <TD width="5%"><font><b>Ap ID</b></font></TD>
            <TD width="16%"><font><b>Name</b></font></TD>
            <TD width="15%"><font><b>Employer</b></font></TD>
            <TD width="7%"><font><b>Mobile</b></font></TD>
            <TD width="7%"><font><b>Location</b></font></TD>
            <TD width="4%"><font><b>Ref ID</b></font></TD>
            <TD width="6%"><font><b>Education</b></font></TD>
            <TD width="5%"><font><b>Skills</b></font></TD>
            <TD width="5%"><font><b>Total Exp</b></font></TD>
            <TD width="4%"><font><b>SAP Exp</b></font></TD>
            <TD width="7%"><font><b>Resume</b></font></TD>
            <TD width="11%"><font><b>Assigned To</b></font></TD>
        </TR>

        <%
            String apid = "";
            String fname = "", lname = "", ug = "", pg = "", email = "", mobile = "", area = "", dob = "", atta = "";
            PreparedStatement ps = connection.prepareStatement("select CURRENT_EMPLOYER from ERM_APPLICANT_EXPERIENCE where APPLICANT_ID=? ORDER BY EXPERIENCE_ID ASC");
            ResultSet rsEmp = null;
            String employer = null;
            if (rs != null) {
                for (int i = 1; i <= 15; i++) {
                    if (rs.next()) {
                        apid = rs.getString("APPLICANT_ID");

                        ps.setString(1, apid);
                        rsEmp = ps.executeQuery();
                        if (rsEmp != null) {
                            if (rsEmp.next()) {
                                employer = rsEmp.getString("CURRENT_EMPLOYER");
                            } else {
                                employer = "NA";
                            }
                        }

                        fname = rs.getString("FIRSTNAME");
                        if (fname == null) {
                            fname = "";
                        }
                        lname = rs.getString("LASTNAME");
                        if (lname == null) {
                            lname = "";
                        }
                        mobile = rs.getString("MOBILE");
                        if (mobile == null) {
                            mobile = "nil";
                        }
                        String refId = rs.getString("REFERENCE_EMPID");
                        ug = rs.getString("ug");
                        if (ug == null) {
                            ug = "";
                        }

                        pg = rs.getString("pg");
                        if (pg == null) {
                            pg = "";
                        }
                        if (!pg.equals("")) {
                            pg = "," + pg;
                        }
                        email = rs.getString("CURRENT_LOCATION");
                        if (email == null) {
                            email = "";
                        }
                        area = rs.getString("AREA_OF_EXPERTISE");
                        if (area == null) {
                            area = "nil";
                        }

                        String t = "00000";

                        int totExpYears = rs.getInt("TOTAL_EXP_YR");
                        int totExpMonths = rs.getInt("TOTAL_EXP_MON");

                        //String totExp = totExpYears+"Y"+"  "+totExpMonths+"M";
                        int sapExpYears = rs.getInt("SAP_EXP_YR");
                        int sapExpMonths = rs.getInt("SAP_EXP_MON");
                        String assigned = rs.getString("assignedto");
                        //String sapExp = sapExpYears+"Y"+"  "+sapExpMonths+"M";

                        atta = null;
                        if (t.equalsIgnoreCase("000000")) {
                            final String id = apid;
                            File dir = new File(filePath);
                            atta = apid + ".doc";
                            FilenameFilter filter = new FilenameFilter() {
                                @Override
                                public boolean accept(File dir, String name) {
                                    return name.startsWith(id);
                                }
                            };
                            String[] children = dir.list(filter);
                            if (children == null) {
                            } else {
                                for (String file : children) {
                                    atta = file;
                                }
                            }

                        } else {
                            final String id = apid;
                            File dir = new File(filePath);
                            atta = apid + ".doc";
                            FilenameFilter filter = new FilenameFilter() {
                                @Override
                                public boolean accept(File dir, String name) {
                                    return name.startsWith(id);
                                }
                            };
                            String[] children = dir.list(filter);
                            if (children == null) {
                            } else {
                                for (String file : children) {
                                    atta = file;
                                }
                            }
                        }
                        if (atta == null) {
                            atta = "nil";
                        }
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
            <td><font face="Verdana, Arial, Helvetica, sans-serif"
                      size="1" color="#000000"><A
                        HREF="viewdetails.jsp?apid=<%=apid%>"><%= apid%></A></font></td>
                        <%
                            String fullname = fname + " " + lname;
                            if ((fullname.length()) < 25) {
                        %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(fullname)%></font></td>
                    <%
                    } else {
                    %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= fullname.substring(0, 25) + "..."%></font></td>
                    <%
                        }
                        if ((employer.length()) < 20) {
                    %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(employer)%></font></td>
                    <%
                    } else {
                    %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= employer.substring(0, 20) + "..."%></font></td>
                    <%
                        }

                    %>

            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(mobile)%></font></td>
                    <%
                        if ((email.length()) < 25) {
                    %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email)%></font></td>
                    <%
                    } else {
                    %>
            <td><font
                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0, 25) + "..."%></font></td>
                    <%
                        }
                    %>
            <td title="<%= GetProjectMembers.getUserNameByEid(refId)%>"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                              size="1" color="#000000"><%= refId%></font></td>
                    <%
                        String education = ug;
                        if (!pg.equals("")) {
                            education = education + ", " + pg;
                        }
                        if (education.equals(", ")) {
                            education = "Nil";
                        }
                        if ((education.length()) < 8) {
                    %>
            <td><font face="Verdana, Arial, Helvetica, sans-serif"
                      size="1" color="#000000"><%= StringUtil.encodeHtmlTag(education)%></font></td>
                    <%
                    } else {
                    %>
            <td><font face="Verdana, Arial, Helvetica, sans-serif"
                      size="1" color="#000000"><%= education.substring(0, 8) + "..."%></font></td>
                    <%
                        }
                        if ((area.length()) < 10) {
                    %>
            <td><font face="Verdana, Arial, Helvetica, sans-serif"
                      size="1" color="#000000"><%= StringUtil.encodeHtmlTag(area)%></font></td>
                    <%
                    } else {
                    %>
            <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                       size="1" color="#000000"><%= area.substring(0, 10) + "..."%></font></td>
                    <%
                        }
                    %>
            <td width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><%= totExpYears%>Y&nbsp;&nbsp;<%= totExpMonths%>M</font></td>
            <td width="7%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                 size="1" color="#000000"><%= sapExpYears%>Y&nbsp;&nbsp;<%= sapExpMonths%>M</font></td>
                    <%

                        if (atta.length() < 9) {

                    %>
            <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                       size="1" color="#000000"><a
                        href="<%=request.getContextPath()%>/Resumes/<%=atta%>"
                        target="_blank"><%=atta%></a></font></td>
                    <%
                    } else {
                    %>
            <td ><font face="Verdana, Arial, Helvetica, sans-serif"
                       size="1" color="#000000"><a
                        href="<%=request.getContextPath()%>/Resume/<%=atta%>"
                        target="_blank"><%=atta.substring(0, 9) + "..."%></a></font></td>

            <%
                }
            %>
            <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= GetProjectMembers.getUserName(assigned)%></font></td>                                            
        </tr>
        <%
                    }
                }
            }
            if (request.getParameter("manipulation") == null && (rowcount / 16 == 0)) {
        %>
        <!--	<table align=right>
                        <tr>
                                <td>First</td>
                                <td>Prev</td>
                                <td>Next</td>
                                <td>Last</td>
                        </tr>
                </table>-->
        <%
        } else if (request.getParameter("manipulation") == null) {
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href=viewcandidate.jsp?manipulation=3>Next</a></td>
                <td><a href=viewcandidate.jsp?manipulation=4>Last</a></td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("1")) {
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href=viewcandidate.jsp?manipulation=3>Next</a></td>
                <td><a href=viewcandidate.jsp?manipulation=4>Last</a></td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("4")) {
        %>
        <table align=right>
            <tr>
                <td><a href=viewcandidate.jsp?manipulation=1>First</a></td>
                <td><a href=viewcandidate.jsp?manipulation=2>Prev</a></td>
                <td>Next</td>
                <td>Last</td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("3") && issuenoto == rowcount) {
        %>
        <table align=right>
            <tr>
                <td><a href=viewcandidate.jsp?manipulation=1>First</a></td>
                <td><a href=viewcandidate.jsp?manipulation=2>Prev</a></td>
                <td>Next</td>
                <td>Last</td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("3")) {
        %>
        <table align=right>
            <tr>
                <td><a href=viewcandidate.jsp?manipulation=1>First</a></td>
                <td><a href=viewcandidate.jsp?manipulation=2>Prev</a></td>
                <td><a href=viewcandidate.jsp?manipulation=3>Next</a></td>
                <td><a href=viewcandidate.jsp?manipulation=4>Last</a></td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("2") && issuenofrom == 1) {
        %>
        <table align=right>
            <tr>
                <td>First</td>
                <td>Prev</td>
                <td><a href=viewcandidate.jsp?manipulation=3>Next</a></td>
                <td><a href=viewcandidate.jsp?manipulation=4>Last</a></td>
            </tr>
        </table>
        <%
        } else if (request.getParameter("manipulation").equals("2")) {
        %>
        <table align=right>
            <tr>
                <td><a href=viewcandidate.jsp?manipulation=1>First</a></td>
                <td><a href=viewcandidate.jsp?manipulation=2>Prev</a></td>
                <td><a href=viewcandidate.jsp?manipulation=3>Next</a></td>
                <td><a href=viewcandidate.jsp?manipulation=4>Last</a></td>
            </tr>
        </table>
        <%
                    }
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
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
                logger.debug("Closing JDBC Resources");
            }
        %>
    </table>
</body>
</html>