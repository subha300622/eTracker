<%-- 
    Document   : fileAttachIssue
    Created on : 28 Jun, 2015, 2:06:59 PM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="afc" class="com.eminentlabs.erm.ERMAttachFileController"/>
<%long startTime = System.currentTimeMillis(); //fetch starting time
    while (false || (System.currentTimeMillis() - startTime) < 1000) {
    // do something
    }
    afc.setAll(request, pageContext.getServletContext());
    if ("The uploaded file has been saved successfully".equalsIgnoreCase(afc.getMessage())) {
        out.print("<p style='color:#008000;'>" + afc.getMessage() + "</p>");
    } else {
        out.print(afc.getMessage());
    }     
%>
