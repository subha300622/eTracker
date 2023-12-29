<%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*,org.apache.log4j.*,java.util.HashMap"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>Comment History</title>
        <LINK title=STYLE	href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"	type="text/css" rel=STYLESHEET>

        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/component.css?test=1" />
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
        <script src="<%=request.getContextPath()%>/javaScript/jquery.stickyheader.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>

    </head>
    <body bgcolor="#ffffee">
        <%
            Logger logger = Logger.getLogger("Customer Comment");

            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {

        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%    }

            String name = (String) session.getAttribute("name");
            String category = (String) session.getAttribute("category");
            logger.info("Category in comments" + category);
            int id = 0;
            if (category.equalsIgnoreCase("contact")) {
                id = Integer.parseInt(request.getParameter("contactId"));
            }
            if (category.equalsIgnoreCase("lead")) {
                id = Integer.parseInt(request.getParameter("leadId"));
            }
            if (category.equalsIgnoreCase("opportunity")) {
                id = Integer.parseInt(request.getParameter("opportunityId"));
            }
            if (category.equalsIgnoreCase("account")) {
                id = Integer.parseInt(request.getParameter("accountId"));
            }
            HashMap<String, Integer> hm = CommentHistoryReference.getReferences(category, id);
        %>

        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*"%>
        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />
        <!-- 
        <center><strong><font face="Tahoma" size="2"
                color="blue">Comment History for <%= name%></font></strong></center>
        <br>
        -->
        <%
            Connection connection = null;
            PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null;
            ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
            int contact_reference = hm.get("contact");
            int lead_reference = hm.get("lead");
            int opportunity_reference = hm.get("opportunity");
            int account_reference = hm.get("account");

            try {
                connection = MakeConnection.getConnection();


        %>
        <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable">
                <%                            if (category.equalsIgnoreCase("contact") || contact_reference > 0) {

                        ps = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,rating,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from contact_comments where contactid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps.setInt(1, contact_reference);

                        rs = ps.executeQuery();
                        rs.last();
                        int rowcount = rs.getRow();
                        rs.beforeFirst();
                        if (rowcount > 0) {
                %>
                <thead> <tr>
                        <th>CommentedBy</th>
                        <th>TimeStamp</th>
                        <th>Comment History of Contact</th>
                        <th>Rating</th>
                        <th>CommentedTo</th>
                        <th>Due Date</th>
                    </tr></thead>
                <tbody>
                    <%
                        }

                        while (rs.next()) {
                            String commentedby = GetProjectMembers.getUserName(rs.getString("commentedby"));
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = rs.getString("commentedto");
                            if (!(commentedto == null)) {
                                commentedto = GetProjectMembers.getUserName(rs.getString("commentedto"));
                                commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                            } else {
                                commentedto = "NA";
                            }
                            String duedate = rs.getString("duedate");
                            if (duedate == null) {
                                duedate = "NA";
                            }
                            String rating = rs.getString("rating");
                            if (rating == null) {
                                rating = "NA";
                            }
                    %>
                    <tr>
                        <td align="center" width="12%"><%=commentedby%></td>
                        <td align="center" width="9%"><%= rs.getString("commentdate")%><%=" "%><%= rs.getTime("comment_date")%></td>
                        <td align="justify" width="50%"><%= rs.getString(4)%></td>
                        <td align="center" width="5%"><%= rating%></td>
                        <td align="left" width="12%"><%= commentedto%></td>
                        <td align="left" width="12%"><%= duedate%></td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }%>
                </tbody>
                <% }
                    if (category.equalsIgnoreCase("lead") || lead_reference > 0) {

                        ps1 = connection.prepareStatement("select commentedby,lead_status,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from lead_comments where leadid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps1.setInt(1, lead_reference);

                        rs1 = ps1.executeQuery();
                        rs1.last();
                        int rowcount = rs1.getRow();
                        rs1.beforeFirst();
                        if (rowcount > 0) {
                %>
                <thead> <tr>
                        <th>CommentedBy</th>
                        <th>TimeStamp</th>
                        <th>Comments History of Lead</th>
                        <th>Status</th>
                        <th>CommentedTo</th>
                        <th>Due Date</th>
                    </tr></thead>
                <tbody>
                    <%
                        }

                        while (rs1.next()) {
                            String commentedby = GetProjectMembers.getUserName(rs1.getString("commentedby"));
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = rs1.getString("commentedto");
                            if (!(commentedto == null)) {
                                commentedto = GetProjectMembers.getUserName(rs1.getString("commentedto"));
                                commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                            } else {
                                commentedto = "NA";
                            }
                            String duedate = rs1.getString("duedate");
                            if (duedate == null) {
                                duedate = "NA";
                            }

                            String status = rs1.getString("lead_status");
                            if (status == null) {
                                status = "NA";
                            }
                    %>
                    <tr>
                        <td align="center" width="12%"><%=commentedby%></td>
                        <td align="center" width="9%"><%= rs1.getString("commentdate")%><%=" "%><%= rs1.getTime("comment_date")%></td>
                        <td align="justify" width="50%"><%= rs1.getString(5)%></td>
                        <td align="center" width="5%"><%= status%></td>
                        <td align="left" width="12%"><%= commentedto%></td>
                        <td align="left" width="12%"><%= duedate%></td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }%>
                </tbody>
                <%}
                    if (category.equalsIgnoreCase("opportunity") || opportunity_reference > 0) {

                        ps2 = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,stage,comments,to_char(duedate,'dd-Mon-yyyy') as duedate,commentedto from opportunity_comments where opportunityid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps2.setInt(1, opportunity_reference);

                        rs2 = ps2.executeQuery();
                        rs2.last();
                        int rowcount = rs2.getRow();
                        rs2.beforeFirst();
                        if (rowcount > 0) {
                %>
                <thead> <tr>
                        <th>CommentedBy</th>
                        <th>TimeStamp</th>
                        <th>Comment History of Opportunity</th>
                        <th>Stage</th>
                        <th>CommentedTo</th>
                        <th>Due Date</th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        }

                        while (rs2.next()) {
                            String commentedby = GetProjectMembers.getUserName(rs2.getString("commentedby"));
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = rs2.getString("commentedto");
                            if (commentedto != null) {
                                commentedto = GetProjectMembers.getUserName(commentedto);
                                commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                            } else {
                                commentedto = "NA";
                            }
                            String duedate = rs2.getString("duedate");
                            if (duedate == null) {
                                duedate = "NA";
                            }
                    %>
                    <tr>
                        <td align="center" width="12%"><%=commentedby%></td>
                        <td align="center" width="9%"><%= rs2.getString("commentdate")%><%=" "%><%= rs2.getTime("comment_date")%></td>
                        <td align="justify" width="50%"><%= rs2.getString(5)%></td>
                        <td align="center" width="5%"><%= rs2.getString("stage")%></td>
                        <td align="left" width="12%"><%= commentedto%></td>
                        <td align="left" width="12%"><%= duedate%></td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">----------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }%>
                </tbody>
                <%  }
                    if (category.equalsIgnoreCase("account") || account_reference > 0) {

                        ps3 = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate from account_comments where accountid=? order by comment_date asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ps3.setInt(1, account_reference);

                        rs3 = ps3.executeQuery();
                        rs3.last();
                        int rowcount = rs3.getRow();
                        rs3.beforeFirst();
                        if (rowcount > 0) {
                %>
                <thead> <tr>
                        <th>CommentedBy</th>
                        <th>TimeStamp</th>
                        <th colspan=2>Comment History of Account</th>
                        <th>CommentedTo</th>
                        <th>Due Date</th>
                    </tr></thead><tbody>
                    <%
                        }

                        while (rs3.next()) {
                            String commentedby = GetProjectMembers.getUserName(rs3.getString("commentedby"));
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = rs3.getString("commentedto");
                            if (commentedto != null) {
                                commentedto = GetProjectMembers.getUserName(commentedto);
                                commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);
                            } else {
                                commentedto = "NA";
                            }
                            String duedate = rs3.getString("duedate");
                            if (duedate == null) {
                                duedate = "NA";
                            }
                    %>
                    <tr>
                        <td align="center" width="12%"><%=commentedby%></td>
                        <td align="center" width="9%"><%= rs3.getString("commentdate")%><%=" "%><%= rs3.getTime("comment_date")%></td>
                        <td align="justify" width="55%" colspan=2><%= rs3.getString(4)%></td>
                        <td align="left" width="12%"><%= commentedto%></td>
                        <td align="left" width="12%" ><%= duedate%></td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">----------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }%>
                </tbody>

                <%  }

                %>
            </table>
        </div>
        <%                    } catch (Exception e) {
            e.printStackTrace();
                logger.error(e.getMessage());
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                if (connection != null) {
                    connection.close();
                    logger.info("connection closed");
                }
                if (connection.isClosed()) {
                    logger.info("Connection is Closed");
                } else {
                    logger.info("Connection not Closed");
                }
            }
        %>
    </body>
</html>
