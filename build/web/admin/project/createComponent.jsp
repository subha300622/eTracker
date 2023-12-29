<%-- 
    Document   : createTeam
    Created on : Jun 24, 2014, 12:17:03 PM
    Author     : E0288
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="atc1" class="com.eminent.issue.controller.ApmComponentController"/>
<%atc1.doAction(request);
    if (atc1.getTotalComponent() != "") {
        out.print(atc1.getTotalComponent());
}
%>
