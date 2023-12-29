<%-- 
    Document   : sendMailToSelectedUsers
    Created on : 28 Jun, 2017, 10:53:22 AM
    Author     : EMINENT
--%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.pack.controller.MailMaintanceController"/>
<%
    mmc.sendMailContentToUsers(request);
    if (mmc.getMessage() != "") {
        System.out.println("mail message is: " + mmc.getMessage());
        out.print(mmc.getMessage());
    }
    response.sendRedirect("../user/gst.jsp?message=" + mmc.getMessage());
%>
