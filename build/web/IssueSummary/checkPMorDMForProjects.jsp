<%-- 
    Document   : checkPMorDMForProjects
    Created on : 3 Apr, 2019, 3:52:20 PM
    Author     : QSERVER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="isc" class="com.eminent.issue.controller.IssueSearchController"/>
<%out.print(isc.checkPMorDMForProjects(request));%>
