<%-- 
    Document   : retrieveAll
    Created on : Jun 24, 2014, 8:37:21 PM
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
