<%-- 
    Document   : checkIssueMOM
    Created on : Oct 1, 2013, 2:49:43 PM
    Author     : E0288
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.eminentlabs.mom.*"%>
<%
    String message = " ";
    String issueid = request.getParameter("issueid");
    boolean flag = MoMUtil.checkClosedIssue(issueid);
    if (flag == true) {
        message = "Issue already closed";
    }
    out.print(message);
%>