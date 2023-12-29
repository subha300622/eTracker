<%-- 
    Document   : sendMailMom
    Created on : 27 May, 2016, 12:08:27 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"></jsp:useBean>
<%
    mmc.sendMailMomajax(request);
    out.print("true");
%>


