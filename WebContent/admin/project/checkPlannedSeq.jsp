<%-- 
    Document   : checkPlannedSeq
    Created on : 18 Oct, 2023, 5:26:53 PM
    Author     : Subhashini-ABAP
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mai" class="com.eminent.issue.formbean.MyAsignmentIssues"/>
<%  out.print(mai.checkPlannedIssues(request));
%>
