<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="atc1" class="com.eminent.issue.controller.ApmComponentController"/>
<%atc1.doAction(request);
    if (atc1.getTotalComponents() != "") {
        out.print(atc1.getTotalComponents());
}
   
%>