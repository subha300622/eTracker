<%-- 
    Document   : mailAdd
    Created on : 27 Jun, 2017, 10:40:04 AM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController"/>
<%mmc.addMailContentToDB(request);
    if (mmc.getMessage() != "") {
        out.print(mmc.getMessage());
    }
    response.sendRedirect("../user/mailMaintance.jsp?message=" + mmc.getMessage());
%>
