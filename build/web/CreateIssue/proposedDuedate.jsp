<%-- 
    Document   : proposedDuedate
    Created on : Oct 17, 2013, 6:35:25 PM
    Author     : Tamilvelan
--%>
<%@ page import="com.eminent.util.IssueDetails"%>
<%
     String project =   request.getParameter("product").trim();
     String module  =   request.getParameter("module").trim();
     String version  =   request.getParameter("version").trim();
     String severity  =   request.getParameter("severity").trim();
     String priority  =   request.getParameter("priority").trim();
     
     String duedate =   IssueDetails.proposeDuedate(project, module,version,severity,priority);
     duedate=   ";"+duedate+";";
     out.println(duedate);
     
%>