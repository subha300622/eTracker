<%@page import="org.apache.log4j.Logger"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%Logger logger = Logger.getLogger("issueUpdateFile");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META http-equiv=Content-Type content="text/htmlcharset=windows-1252">
        <META http-equiv=Expires content=-1>
        <META http-equiv=Pragma content=no-cache>
        <META http-equiv=Cache-Control content=no-cache>
        <LINK title=STYLE href="eminentech support files/main_ie.css"
              type=text/css rel=STYLESHEET>
        <style type="text/css">
            TH {
                font-weight:  bold;
                font-size:  11px;
                background:#000099;
                color:  white;
                font-family:  Arial, Helvetica;
                text-align:  left;
            }
        </style>
    </HEAD>

    <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*"%>
    <%@ page language="java"%>

    <BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
          marginwidth="0">
        <table width="100%" valign="right" height="5%" border="0">
            <tr>
                <td border="0" align="left" width="800"><b><font size="3"
                                                                 COLOR="#0000FF"> Welcome</font></b> <FONT SIZE="3" COLOR="#0000FF">
                        <b><%=session.getAttribute("fName")%>&nbsp;<%=session.getAttribute("lName")%>,
                        </b></FONT> <FONT SIZE="2" COLOR="#00CC00"> <b><%=session.getAttribute("company")%>
                        </b></FONT></td>

                <td width="15%" border="1" align="center"><font size="2"
                                                                face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                            SRC="<%=request.getContextPath()%>/images/New.jpg" ALT="New Features"
                            width="25" height="15" align="middle">&nbsp;&nbsp;<a 
                            href="<%=request.getContextPath()%>/newFeatures.jsp">New Features</a></font></td>
                <td width="8%" border="1" align="center"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                            SRC="<%=request.getContextPath()%>/images/update.gif" ALT="about"
                            width="20" height="21" align="middle">&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/help.jsp ">Help</a></font></td>
                <td width="8%" border="1" align="center"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                            SRC="<%=request.getContextPath()%>/images/help.gif" ALT="about"
                            width="20" height="21" align="middle">&nbsp;&nbsp;<a
                            href="javascript:detail() ">About</a></font></td>
                <td width="8%" border="1" align="center"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                            SRC="<%=request.getContextPath()%>/images/profile.jpeg" ALT="profile"
                            width="17" height="18" align="middle">&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/UserProfile/profile.jsp">Profile</a></font>
                </td>

                <td width="8%" align="center" border="1"><font size="2"
                                                               face="Verdana, Arial, Helvetica, sans-serif"> <IMG
                            SRC="<%=request.getContextPath()%>/images/logout.gif" ALT="logout"
                            width="20" height="21" align="middle">&nbsp;&nbsp;<A
                            HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A></font>
                </td>
            </tr>
        </table>
        <br>


        <div align="center">
            <center>


                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr border="2" bgcolor="#C3D9FF">
                        <td border="1" align="left" width="100%"><font size="4"
                                                                       COLOR="#0000FF"><b>Attached Files </b></font> <FONT SIZE="3"
                                                                                COLOR="#0000FF"></FONT></td>
                    </tr>
                    <tr>
                        <td height="10"></td>
                    </tr>
                </table>
                <br>


                <table bgColor=#E8EEF7 align="center" width="100%">
                    <TBODY>
                        <jsp:useBean id="MyIssue" class="com.pack.MyIssueBean" />
                        <tr>
                            <th>Attached On</th>
                            <th>Owner</th>
                            <th>File Name</th>
                            <th>Issue Status</th>
                        </tr>


                        <%
                            Connection connection = null;
                            ResultSet rs3 = null;
                            Statement st = null;
                            try {
                                connection = MakeConnection.getConnection();

                                if (connection != null) {
                                    String filename = null;
                                    String attachdate = null, owner = null;
                                    String status = null;
                                    String name = null;
                                    String theissuno = request.getParameter("issueid");

                                    int count1 = 1;

                                    st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);//ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                                    rs3 = st.executeQuery("select fileid,filename,attacheddate,owner,issuestatus from fileattach where issueid='" + theissuno + "' ");//changed
                                    if (rs3 != null) {
                                        while (rs3.next()) {
                                            filename = rs3.getString("filename");
                                            Date attach = rs3.getDate("attacheddate");
                                            status = rs3.getString("issuestatus");
                                            String stamp = rs3.getString("attacheddate");

                                            Time t = rs3.getTime("attacheddate");

                                            owner = rs3.getString("owner");

                                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                            if (attach != null) {
                                                attachdate = sdf.format(attach);
                                            } else {
                                                attachdate = "NA";
                                            }
                                            count1++;
                                            if (owner != null) {
                                                name = GetProjectManager.getUserName(Integer.parseInt(owner));
                                            } else {
                                                name = "NA";
                                            }
                                            if (status == null) {
                                                status = "NA";
                                            }
                                            ServletContext context = pageContext.getServletContext();
                                            String filePath = context.getInitParameter("file-upload");
                        %>
                        <tr>

                                <td  width="14%"><%=attachdate%><%=" "%> <%if (t != null) {
                                    out.print(t);
                                }%></td>

                            <td  width="17%"><%=name%></td>
                            <td height="10"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">
                                    <a href="Etracker_AttachedFiles/<%=filename%>" target="_blank"><%=filename%></a></font>
    <!--                                <a href="<%=filePath%><%=filename%>" target="_blank"><%=filename%></a></font>-->
                            </td>
                            <td><%=status%></td>
                        </tr>
                        <%
                                }
                            }
                            if (count1 == 1) {
                        %>
                    <td width="12%" height="10" align="center">
                        <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No
                            Files are Attached</font></td>
                            <%
                                        }
                                    }
                                } catch (Exception e) {
                                    logger.error(e.getMessage());
                                } finally {
                                    //		rs3.close();
                                    if (rs3 != null) {
                                        rs3.close();
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
                <br>
                <br>
                <P></P>
                <P></P>
            </center>
        </div>
    </BODY>
</HTML>
