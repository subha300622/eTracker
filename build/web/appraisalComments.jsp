<%-- 
    Document   : appraisalComments
    Created on : Dec 20, 2011, 5:04:49 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.eminentlabs.appraisal.ErmAppraisalComment,java.util.List,com.eminentlabs.appraisal.AppraisalUtil,java.util.Iterator" %>
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

        <%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.GetProjectManager, org.apache.log4j.*"%>



        <%
            //Configuring log4j properties
            Logger logger = Logger.getLogger("comments");

            try {


        %>
        <div class="component subdivContainer"> 
            <table  class="overflow-y " id="materialTable">
                <thead>
                    <tr>
                        <th align="center">CommentedBy</th>
                        <th align="center">TimeStamp</th>
                        <th align="center">Comments History</th>
                        <th align="center">Status</th>
                        <th align="center">CommentedTo</th>

                    </tr>
                </thead>
                <tbody>
                    <%    int k = 1;
                        int appraisalId = Integer.parseInt(request.getParameter("appId"));
                        List comments = AppraisalUtil.viewAppraisalComments(appraisalId);
                        String color = "white";
                        ErmAppraisalComment appraisalComment = null;
                        int commentStatusId = 0;
                        if (comments.size() > 0) {
                            for (Iterator commentIterator = comments.iterator(); commentIterator.hasNext(); k++) {
                                appraisalComment = (ErmAppraisalComment) commentIterator.next();
                                if ((k % 2) != 0) {
                                    color = "white";
                                } else {
                                    color = "#E8EEF7";
                                }
                                java.util.Date commentedOn = appraisalComment.getCommentedOn();
                                String commentedTime = "NA";
                                if (commentedOn != null) {
                                    commentedTime = new java.text.SimpleDateFormat("dd MMM yyyy HH:mm:ss").format(commentedOn);
                                }
                                commentStatusId = appraisalComment.getStatus();

                    %>

                    <tr bgcolor="<%=color%>">
                        <td><%=GetProjectManager.getUserName(appraisalComment.getCommentedBy())%></td>
                        <td><%=commentedTime%></td>
                        <td><%=appraisalComment.getComments()%></td>
                        <td><%=AppraisalUtil.getAppraisalStatus(commentStatusId)%></td>
                        <td><%=GetProjectManager.getUserName(appraisalComment.getCommentedTo())%></td>

                    </tr>
                    <%
                            commentStatusId = 0;
                        }
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
            }


        %>
    </body>
</html>
