<%@page import="com.pack.StringUtil"%>
<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>Comment History</title>
        <base target="_blank"/>
        <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=1.4" type="text/css" rel=STYLESHEET>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/component.css?test=2" />
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
    </head>
    <body bgcolor="#ffffee">

        <%
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

                //Configuring log4j properties
                Logger logger = Logger.getLogger("comments");

                Connection connection = null;
                PreparedStatement st = null;
                ResultSet rs = null;

                try {
                    connection = MakeConnection.getConnection();
                    st = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments,status,commentedto,to_char(duedate,'dd-Mon-yyyy') as duedate,priority,severity from issuecomments where issueid=? order by comment_date asc");
                    st.setString(1, request.getParameter("issueId"));
                    rs = st.executeQuery();

                    if (rs.next()) {
            %>
            <div class="component subdivContainer"> 
                <table  class="overflow-y bordertable" id="materialTable" style="border-collapse:collapse;" >
                    <thead>  
                        <tr>
                            <th class="bordertable"  style="width: 10%;" align="center">CommentedBy</th>
                            <th class="bordertable"  style="width: 10%;"align="center">TimeStamp</th>
                            <th class="bordertable"  align="center">Comments History</th>
                            <th class="bordertable"  style="width: 2%;"align="right">S</th>
                            <th class="bordertable" style="width: 2%;" align="right">P</th>
                            <th class="bordertable" style="width: 10%;" align="center">Status</th>
                            <th class="bordertable" style="width: 10%;" align="center">CommentedTo</th>
                            <th class="bordertable" style="width: 10%;" align="center">Due Date</th>
                        </tr>
                    </thead>  <tbody>
                        <%
                            do {
                                String priority = rs.getString("priority");
                                String severity = rs.getString("severity");

                                if (priority != null) {
                                    priority = priority.substring(0, priority.indexOf("-"));
                                } else {
                                    priority = "NA";
                                }
                                if (severity != null) {
                                    severity = severity.substring(0, severity.indexOf("-"));
                                } else {
                                    severity = "NA";
                                }

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
                        <tr style="height: 21px;">

                            <td align="left"><%=commentedby%></td>
                            <td align="left"><%= rs.getString("commentdate")%><%=" "%><%= rs.getTime("comment_date")%></td>
                            <td align="left" style="max-width:25%;" ><%= rs.getString(4)%></td>
                            <td align="right" ><%=severity%></td>
                            <td align="right" ><%=priority%></td>
                            <td align="left"><%= rs.getString(5)%></td>
                            <td align="left"><%= commentedto%></td>
                            <td align="left"><%= duedate%></td>
                        </tr>

                        <%
                            } while (rs.next());
                        %>
                    </tbody> </table>
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

            </div> 
        </body>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
        <script src="<%=request.getContextPath()%>/javaScript/jquery.stickyheader.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>

        <script type="text/javascript">
            $("#cke_pastebin").removeAttr("style");
        </script>
        <style type="text/css">
            tr{
                height: 21px;
            }
        </style>
    </html>
    
