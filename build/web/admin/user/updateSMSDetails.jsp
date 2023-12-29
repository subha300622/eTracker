<%-- 
    Document   : updateSMSDetails
    Created on : 27 Jun, 2017, 3:07:50 PM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController"/>
<%
    mmc.updateMailContent(request);
    if (mmc.getMessage() != "") {
       
        out.print(mmc.getMessage());
    }
    response.sendRedirect("../user/gst.jsp?message=" + mmc.getMessage());
%>
