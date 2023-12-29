<%-- 
    Document   : alreadyExistEmail
    Created on : 9 Mar, 2016, 12:55:30 PM
    Author     : admin
--%>
<%@page import="com.eminentlabs.erm.ErmAjaxValidtion" %>
<%
 
    String flag = ErmAjaxValidtion.alreadyexitsErmEmail(request);
    out.println(flag);
%>