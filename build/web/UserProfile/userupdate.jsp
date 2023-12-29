<%@ page import="java.sql.*,pack.eminent.encryption.*, org.apache.log4j.*"%>
<%@ page import="org.apache.commons.codec.language.*"%>
<%@ page autoFlush="true" buffer="1094kb"%> 

<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<jsp:useBean id="UserUpdate" class="com.pack.UserUpdateBean" />
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
    </HEAD>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type=text/css rel=STYLESHEET>

    <BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
          marginwidth="0">
        <form action="updateusersuccess.jsp" method="post" name="theForm">
            <table width="100%" bgcolor="#EEEEEE" valign="right" height="5%"
                   border="0">

                <tr>
                    <td border="0" align="left" width="800"><b> <font size="3"
                                                                      COLOR="#0000FF"> Current User:</font></b> <b><FONT SIZE="3"
                                                                           COLOR="#0000FF"><b>&nbsp;<%=session.getAttribute("fName")%>&nbsp;
                                    <%=session.getAttribute("lName")%> </b></FONT></b></td>



                    <td width="6%" align="center" border="1"><font size="2"
                                                                   face="Verdana, Arial, Helvetica, sans-serif"> <A
                                HREF="<%= request.getContextPath()%>/logout.jsp" target="_parent">Logout</A>
                        </font></td>

                </tr>

            </table>
            <%@ include file="../header.jsp"%> <%!
                Connection connection = null;
                         %> <%

                   //Configuring log4j properties
                        Logger logger = Logger.getLogger("userupdate");

                        String name = (String) session.getAttribute("Name");;
                        try {
                            connection = MakeConnection.getConnection();

                            if (connection != null) {

                                if (UserUpdate.Query(connection, name).equals(Encryption.encrypt(request.getParameter("password")))) {
            %> <jsp:forward page="edituser1.jsp" /> <%
                                           } else {
            %> <jsp:forward page="getpasswd.jsp">
                <jsp:param name="getpwd" value="false" />
            </jsp:forward> <%
                        }
                    }
                } catch (Exception e) {
                    logger.error("Exception", e);
                } finally {
                    if (connection != null) {
                        connection.close();
                    }
                }


            %>
        </form>
    </BODY>
</HTML>
