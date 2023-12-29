<%-- 
    Document   : crIdByIssue
    Created on : Feb 6, 2014, 4:32:31 PM
    Author     : E0288
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String issueid=request.getParameter("issueid");
String crDetails[][]=IssueDetails.getCRIDS(issueid);
String totalCrs="";
for(int i=0;i<crDetails.length;i++){
    totalCrs=totalCrs+crDetails[i][0]+",";
}
out.print(totalCrs);
%>