<%-- 
    Document   : AddIssueInTag
    Created on : 1 Jun, 2016, 11:12:23 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tic" class="com.eminent.tags.TagIssueController"/>
<%
    tic.doAction(request);
%>
