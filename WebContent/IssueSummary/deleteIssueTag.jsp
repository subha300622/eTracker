<%-- 
    Document   : deleteIssueTag
    Created on : 24 Jun, 2016, 10:19:16 AM
    Author     : admin
--%>


<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tic" class="com.eminent.tags.TagIssueController"/>
<%
   String res= tic.deleteTagIssue(request);
    
    out.print(res);
%>
