<%-- 
    Document   : getTSCNo
    Created on : Jul 4, 2012, 9:51:34 PM
    Author     : Tamilvelan
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String  tsId   =   request.getParameter("tsId");
    int testScriptCount =   ViewBPM.getTestScriptCount(Integer.parseInt(tsId));
    if(testScriptCount>0){
        
    }
    out.print(testScriptCount);
%>

