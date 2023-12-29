<%-- 
    Document   : validateReplaceSerialNo
    Created on : 16 Mar, 2015, 10:55:13 AM
    Author     : Muthu
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    //Configuring log4j properties
    Logger logger = Logger.getLogger("File count Issue");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("================Session expired===================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%><jsp:useBean id="afc" class="com.eminentlabs.erm.ERMAttachFileController"></jsp:useBean>
<%    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String applicantId = request.getParameter("applicantId");
    int count = afc.getFileCountByApplicantId(applicantId);
    if (count > 0) {

       
%>
<td id="filesIssue"> <A	onclick="viewFileAttachForApplicant('<%=applicantId%>');" href="#"
                        >ViewFiles(<%=count%>)</A></td>

<%
} else {
%>
<td id="filesIssue" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font></td>
<%
    }
%>