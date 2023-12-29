<%--
    Document   : testcaseHistory
    Created on : 30 Aug, 2011, 3:20:06 PM
    Author     : Tamilvelan
--%>

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@page  import="com.eminent.tqm.IssueTestCaseUtil,com.eminent.tqm.TqmTestcaseresult,com.eminent.tqm.TqmTestcaseexecutionresult,java.math.BigDecimal,com.eminent.tqm.TestCasePlan,java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
<%@page import="com.pack.StringUtil" %>
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
            String issueId = request.getParameter("issueId");
            logger.info("Issueid" + issueId);
            logger.info("PTC Id" + ptcID);
            List issueComments = IssueTestCaseUtil.issueTestCaseComments(ptcID);
            List total = TestCasePlan.getResults(ptcID);
            int noOfIssue = issueComments.size();
            int noOfPlan = total.size();
            int k = 1;
            try {

        %>
        <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable">
                <thead>

                    <tr>
                        <th width="8%">Commented By</th>
                        <th width="10%">CommentedOn</th>
                        <th width="50%">Comments</th>
                        <th width="10%">Status</th>

                    </tr></thead>
                <tbody>
                    <%                                if (noOfIssue > 0 || noOfPlan > 0) {
                            TqmTestcaseresult issue = null;
                            for (Iterator iterComments = issueComments.iterator(); iterComments.hasNext(); k++) {
                                issue = (TqmTestcaseresult) iterComments.next();
                                String comments = issue.getTestcomments();
                                String status = issue.getTqmtestcasestatus().getStatus();
                                Date stamp = issue.getCommentedon();
                                String commentedby = GetProjectManager.getUserName(issue.getCommentedby().getUserid());
                                logger.info("Comments" + comments);
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
                        <td title="<%=stamp%>"><%=commentedOn%></td>
                        <td title='<%=comments%>'><%=comments%></td>
                        <td title='<%=status%>'><%=status%></td>

                    </tr>
                    <tr>
                        <td colspan="4" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                        }

                        Iterator iter = total.iterator();
                        while (iter.hasNext()) {
                            List result = null;
                            Object[] obj = (Object[]) iter.next();
                            int tceId = ((BigDecimal) obj[0]).intValue();
                            int tepId = ((BigDecimal) obj[1]).intValue();
                            String planName = ((String) obj[2]);
                            logger.info("Plan Name" + planName);
                            result = TestCasePlan.getExecutionResults(ptcID, ((Integer) tceId).toString());
                            int size = result.size();
                            logger.info("No of Comments" + size);
                    %>



                    <tr width="100%" bgcolor="#C3D9FF">
                        <td width="10%"><b>Test Plan Name</b></td>
                        <td width="90%" colspan="3"><b><%=planName%></b></td>


                    </tr>
                    <%
                        k = 1;
                        TqmTestcaseexecutionresult t = null;
                        HashMap statusMap = TestCasePlan.getTescaseStatus();
                        for (Iterator i = result.iterator(); i.hasNext(); k++) {
                            t = (TqmTestcaseexecutionresult) i.next();
                            String comments = t.getComments();
                            String status = (String) statusMap.get(t.getStatusid());
                            Date stamp = t.getCommentedon();
                            String commentedby = GetProjectManager.getUserName(t.getCommentedby());
                            logger.info("Comments" + comments);
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
                        <td title="<%=stamp%>"><%=commentedOn%></td>
                        <td title='<%=comments%>'><%=comments%></td>
                        <td title='<%=status%>'><%=status%></td>

                    </tr>
                    <tr>
                        <td colspan="4" align="center">-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
                    </tr>
                    <%
                                }
                            }
                        }
                        if (noOfIssue < 1 && noOfPlan < 1) {
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
