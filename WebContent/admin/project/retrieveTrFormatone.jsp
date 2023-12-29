<%-- 
    Document   : retrieveTrFormatone
    Created on : 23 Jun, 2016, 3:49:51 PM
    Author     : EMINENT
--%>



<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="trdc" class="com.eminent.issue.controller.TRDisplayController"/>
<%trdc.doAction(request);
    if (trdc.getTotalTrFormat() != "") {
        out.print(trdc.getTotalTrFormat());
}
   
%>

