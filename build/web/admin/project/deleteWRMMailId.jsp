<%-- 
    Document   : deleteWRMMailId
    Created on : 22 Aug, 2019, 3:14:12 PM
    Author     : Muthu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <jsp:useBean id="mwd" class="com.eminentlabs.wrm.controller.WrmMailMaintenanceController"></jsp:useBean>
<%
    String res = mwd.deleteWRMMailId(request);
    out.print(res);
%>

