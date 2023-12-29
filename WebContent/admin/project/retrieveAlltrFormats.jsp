<%-- 
    Document   : retrieveAlltrFormats
    Created on : 23 Jun, 2016, 12:12:33 PM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="trc" class="com.eminent.issue.controller.TRDisplayController"/>
<%trc.doAction(request);
    if (trc.getTotalTrFormats() != "") {
        out.print(trc.getTotalTrFormats());
}
%>
