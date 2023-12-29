<%-- 
    Document   : moduleHandler
    Created on : 28 Sep, 2015, 3:06:59 PM
    Author     : EMINENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="amac" class="com.eminent.issue.controller.ApmModuleAttachmentController"/>
<%long startTime = System.currentTimeMillis(); //fetch starting time
    while (false || (System.currentTimeMillis() - startTime) < 1000) {
    // do something
    }
    amac.setAll(request, pageContext.getServletContext());
    if ("The uploaded file has been saved successfully".equalsIgnoreCase(amac.getMessage())) {
        out.print("<p style='color:#008000;'>" + amac.getMessage() + "</p>");
    } else {
        out.print(amac.getMessage());
    }
%>