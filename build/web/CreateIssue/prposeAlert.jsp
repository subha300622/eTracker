<%-- 
    Document   : prposeAlert
    Created on : Nov 19, 2013, 11:19:39 AM
    Author     : E0288
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
     String project =   request.getParameter("product").trim();
     String module  =   request.getParameter("module");
     String version  =   request.getParameter("version").trim();
     String severity  =   request.getParameter("severity");
     String priority  =   request.getParameter("priority");
     
     String pid           =   GetProjects.getProjectId(project+":"+version);
     String moduleId=ProjectFinder.getModuleId(project, version, module);
     HashMap resolutioDays=IssueDetails.getResolutionDays();
     String sev = severity.substring(0, severity.indexOf("-")).trim();
     String prio = priority.substring(0, severity.indexOf("-")).trim();
     String finalval = prio + sev;
     int days =(Integer) resolutioDays.get(finalval);
     String prposalIssues[][]= IssueDetails.prposalIssues(Integer.valueOf(pid), moduleId, days);
     String totalPrIssues=";";
     for(int i=0;i<prposalIssues.length;i++){
        String issueno=prposalIssues[i][0];
        String  dued=prposalIssues[i][5];
        String  subject=prposalIssues[i][6];
        String  oldDuedate=prposalIssues[i][7];
        totalPrIssues=totalPrIssues+issueno+","+oldDuedate+","+dued+","+subject+";";
        
     }
     out.println(totalPrIssues);
     
%>