<%-- 
    Document   : fileAttachIssue
    Created on : 28 Jun, 2015, 2:06:59 PM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="afc" class="com.eminent.issue.controller.AttachFileController"/>
<%    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
long startTime = System.currentTimeMillis(); //fetch starting time
    while (false || (System.currentTimeMillis() - startTime) < 1000) {
        // do something
    }
    afc.updateImageinComment(request, pageContext.getServletContext());
    if ("success".equalsIgnoreCase(afc.getMessage())) {
        String i = "";
        for (String image : afc.getFileList()) {
            i = i + "<img src='https://www.eminentlabs.net/eTracker/Etracker_AttachedFiles/" + image + "'/><br/>";
        }
        out.print(afc.getMessage() + "@@@" + i);
    } else {
        out.print(afc.getMessage());
    }
%>
