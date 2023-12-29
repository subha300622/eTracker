<%-- 
    Document   : projectComments
    Created on : 10 Sep, 2010, 2:43:33 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>Comment History</title>
        <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/component.css?test=1" />
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
        <script src="<%=request.getContextPath()%>/javaScript/jquery.stickyheader.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>

    </head>
    <body bgcolor="#ffffee">

        <%
            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {

        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%    }
        %>

        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*, org.apache.log4j.*"%>

<!-- <center><strong><font face="Tahoma" size="2" color="blue">Comment History of Issue ID:<%= request.getParameter("issueid")%></font></strong></center><br>  -->

        <%

            //Configuring log4j properties
            Logger logger = Logger.getLogger("project comments");

            Connection connection = null;
            PreparedStatement st = null;
            ResultSet rs = null;

            try {
                connection = MakeConnection.getConnection();
                st = connection.prepareStatement("select commentedby,to_char(COMMENTEDON,'dd-Mon-yyyy') as commentdate,COMMENTEDON,comments,status from APM_PROJECTCOMMENTS where projectid=? order by commentedon asc");
                st.setString(1, request.getParameter("pid"));
                rs = st.executeQuery();

                if (rs.next()) {
        %>
      <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable"  >
                <thead>
            <tr>
                <th align="center">CommentedBy</th>
                <th align="center">TimeStamp</th>
                <th align="center">Comments History</th>
                <th align="center">Status</th>

            </tr>
                </thead>
            <%
                do {

                    String commentedby = GetProjectMembers.getUserName(rs.getString("commentedby"));
                    commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);
                    logger.info("Commented by" + commentedby);


            %>
            <tbody><tr>
                <td align="left" width="12%"><%=commentedby%></td>
                <td align="left" width="9%"><%= rs.getString("commentdate")%><%=" "%><%= rs.getTime("commentedon")%></td>
                <td align="justify" width="42%"><%= rs.getString("comments")%></td>

                <td align="left" width="9%"><%= rs.getString("status")%></td>

            </tr>
            <tr>
                <td colspan="8" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
            </tr>
            <%
                } while (rs.next());
            %>
            </tbody>
        </table>
      </div>
        <%
        } else {
        %>
        <%= "Nothing to display"%>
        <%
                }
            } catch (Exception e) {
                logger.error(e);
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
    </body>
</html>
