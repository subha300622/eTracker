<%-- 
    Document   : getAlltageIssue
    Created on : 24 Jun, 2016, 9:35:08 AM
    Author     : admin
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="tic" class="com.eminent.tags.TagIssueController"/>
<%
    List<String> listTagIssue = tic.getIssueByTagId(request);
    String issueIds = "";
    if (listTagIssue.isEmpty()) {
    } else {
        int i = 0;
        for (String issue : listTagIssue) {
            if (i == 0) {
                issueIds = issue;
                i = 1;
            } else {
                issueIds = issueIds + "," + issue;
            }

        }
    }
    out.print(issueIds);
%>
