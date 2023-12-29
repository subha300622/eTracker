<%-- 
    Document   : editCrId
    Created on : Feb 5, 2014, 2:55:42 PM
    Author     : E0288
--%>

<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String crId=request.getParameter("crId");
    String crDescription=request.getParameter("crDescription");
    String sno=request.getParameter("sno");
    IssueDetails.editCRID(sno, crId, crDescription);
%>
