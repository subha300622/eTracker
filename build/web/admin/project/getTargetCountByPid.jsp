<%-- 
    Document   : getTargetCountByPid
    Created on : 31 May, 2016, 1:00:45 PM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="vmc" class="com.pack.controller.ViewModulesController"/>
<%
    vmc.getAllEditProject(request);
    out.print(vmc.getTotalNoOFTarget());
%>
