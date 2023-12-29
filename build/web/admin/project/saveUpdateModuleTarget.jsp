<%-- 
    Document   : saveUpdateModuleTarget
    Created on : 31 May, 2016, 12:39:54 PM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="vmc" class="com.pack.controller.ViewModulesController"/>
<%
    String res = vmc.saveUpdateModuleTarget(request);
    out.print(res);
%>
