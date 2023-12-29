<%-- 
    Document   : testExecutionComments
    Created on : 8 Jul, 2010, 11:48:53 AM
    Author     : Tamilvelan
--%>

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@page  import="com.eminent.util.GetProjectMembers,java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TestCasePlan,com.eminent.tqm.TqmTestcaseexecutionresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <title>Comment History</title>
        <LINK title=STYLE
              href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel=STYLESHEET>

        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/component.css?test=1" />
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>  
        <script src="<%=request.getContextPath()%>/javaScript/jquery.stickyheader.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>

    </head>
    <body bgcolor="#ffffee">

        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");

            Logger logger = Logger.getLogger("Test case Comment History");

            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {

        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%    }
            String ptcID = request.getParameter("ptcID");
            String tceId = request.getParameter("tceId");

            logger.info("PTC Id" + ptcID);
            try {
                List result = TestCasePlan.getExecutionResults(ptcID, tceId);
                int size = result.size();
        %>

        <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable">
                <thead>

                    <tr>
                        <th width="8%">CommentedBy</th>
                        <th width="10%">CommentedOn</th>
                        <th width="50%">Comments</th>
                        <th width="10%">Status</th>
                        <th width="8%">CommentedTo</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int k = 1;
                        TqmTestcaseexecutionresult t = null;
                        HashMap statusMap = TestCasePlan.getTescaseStatus();
                        for (Iterator i = result.iterator(); i.hasNext(); k++) {
                            t = (TqmTestcaseexecutionresult) i.next();
                            String comments = t.getComments();
                            String status = (String) statusMap.get(t.getStatusid());
                            Date stamp = t.getCommentedon();
                            String commentedby = GetProjectMembers.getUserName(t.getCommentedby().toString());
                            commentedby = commentedby.substring(0, commentedby.indexOf(" ") + 2);

                            String commentedto = GetProjectMembers.getUserName(t.getCommentedto().toString());
                            commentedto = commentedto.substring(0, commentedto.indexOf(" ") + 2);

                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                            String commentedOn = sdf.format(stamp);


                    %>
                    <%       if ((k % 2) != 0) {
                    %>
                    <tr bgcolor="white" height="22">
                        <%
                        } else {
                        %>

                    <tr bgcolor="#E8EEF7" height="22">
                        <%
                            }
                        %>
                        <td><%=commentedby%></td>
                        <td title='<%=stamp%>'><%=commentedOn%></td>
                        <td title='<%=comments%>'><%=comments%></td>
                        <td title='<%=status%>'><%=status%></td>
                        <td><%=commentedto%></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }

                        if (size < 1) {
                    %>
                    <tr><td colspan="4">No Comments available for this Test Case</td></tr>
                    <%
                            }

                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }
                    %>
                </tbody>

            </table>
        </div>

    </body>
</html>
