<%-- 
    Document   : addAgreedIssues
    Created on : 5 Apr, 2019, 10:52:20 AM
    Author     : QSERVER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="isc" class="com.eminent.issue.controller.IssueSearchController"/>
<%out.print(isc.updateAgreedIssues(request));%>
