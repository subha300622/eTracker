<%-- 
    Document   : testComments
    Created on : 11 Mar, 2010, 6:28:45 PM
    Author     : ADAL
--%>

<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@page  import="java.sql.Timestamp,java.text.SimpleDateFormat,com.eminent.tqm.TqmUtil,com.eminent.tqm.TqmTestcaseresult, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.util.*,org.apache.log4j.*"%>
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
            try {
                List result = TqmUtil.getPtcResults(ptcID, issueId);
                int size = result.size();
        %>
        <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable"  >
                <thead>

                    <tr width="100%">
                        <th width="8%">Commented By</th>

                        <th width="10%">CommentedOn</th>
                        <th width="50%">Comments</th>
                        <th width="10%">Status</th>

                    </tr>
                </thead><tbody>
                    <%
                        int k = 1;
                        for (Iterator i = result.iterator(); i.hasNext(); k++) {
                            TqmTestcaseresult t = (TqmTestcaseresult) i.next();
                            String comments = t.getTestcomments();
                            String status = t.getTqmtestcasestatus().getStatus();
                            Timestamp stamp = t.getCommentedon();
                            String commentedby = t.getCommentedby().getFirstname();

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
                        <td title="<%=comments%>"><%=comments%></td>
                        <td title="<%=status%>"><%=status%></td>

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
                </tbody> </table>
        </div>

    </body>
</html>
