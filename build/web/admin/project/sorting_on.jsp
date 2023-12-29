<%-- 
    Document   : sorting_on
    Created on : 3 Aug, 2016, 12:19:30 PM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mi" class="com.eminent.issue.formbean.MyIssues"/>
<%
    mi.sorting_method(request,response);
     if (mi.getIssue() != "") {
        out.print(mi.getIssue());
        
     }

%>
