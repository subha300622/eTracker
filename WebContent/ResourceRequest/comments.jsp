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

            //Configuring log4j properties
            Logger logger = Logger.getLogger("comments");

            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {

        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%    }
        %>

        <%@ page
            import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*, org.apache.log4j.*"%>

<!-- <center><strong><font face="Tahoma" size="2" color="blue">Comment History of Issue ID:<%= request.getParameter("issueid")%></font></strong></center><br>  -->

            <%
                Connection connection = null;
                PreparedStatement st = null;
                ResultSet rs = null;
                GetName g = null;

                try {
                    connection = MakeConnection.getConnection();
                    st = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,status,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate from rr_comments where resourceid=? order by comment_date asc");
                    st.setString(1, request.getParameter("requestid"));
                    rs = st.executeQuery();

                    if (rs.next()) {
            %>
         <div class="component subdivContainer"> 
             <table  class="overflow-y " id="materialTable">
                 <thead>
                <tr>
                    <th align="center">Commented By</th>
                    <th align="center">TimeStamp</th>
                    <th align="center">Comments History</th>
                    <th align="center">Status</th>
                    <th align="center">Commented To</th>
                    <th align="center">Due Date</th>
                </tr>
                 </thead>
                 <tbody>
                <%
                    do {
                        String commentedby = GetProjectMembers.getUserName(rs.getString("commentedby"));
                        commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                        String commentedto = rs.getString("commentedto");
                        if (!commentedto.equals("Nil")) {
                            commentedto = GetProjectMembers.getUserName(rs.getString("commentedto"));
                            commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                        }
                        String duedate = rs.getString("duedate");
                        if (duedate == null) {
                            duedate = "NA";
                        }

                %>
                <tr>
                    <td align="left" width="12%"><%=commentedby%></td>
                    <td align="left" width="9%"><%= rs.getString("commentdate")%><%=" "%><%= rs.getTime("comment_date")%></td>
                    <td align="justify" width="46%"><%= rs.getString(4)%></td>
                    <td align="left" width="9%"><%= rs.getString(5)%></td>
                    <td align="left" width="12%"><%= commentedto%></td>
                    <td align="left" width="12%"><%= duedate%></td>
                </tr>
                <tr>
                    <td colspan="6" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
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