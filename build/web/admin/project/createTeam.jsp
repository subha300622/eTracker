<%-- 
    Document   : createTeam
    Created on : Jun 24, 2014, 12:17:03 PM
    Author     : E0288
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"/>
<%atc.doAction(request);
    if (atc.getTotalTeams() != "") {
        out.print(atc.getTotalTeams());
}
%>
