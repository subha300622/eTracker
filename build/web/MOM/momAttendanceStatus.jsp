<%-- 
    Document   : momAttendanceStatus
    Created on : 27 May, 2016, 2:48:02 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"></jsp:useBean>
<%
    mmc.getPreviousAttendance(request);
    out.print("true");
%>
