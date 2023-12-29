<%-- 
    Document   : alreadyModuleExist
    Created on : 11 May, 2016, 10:23:29 AM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="Aemc" class="com.pack.controller.AdminEditModuleController"></jsp:useBean>
<%
    String message = Aemc.alreadyExitsModule(request);
    out.print(message);
%>
