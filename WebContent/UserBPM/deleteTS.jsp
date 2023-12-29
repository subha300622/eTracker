<%-- 
    Document   : deleteTS
    Created on : Jun 19, 2012, 1:10:03 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tsId    =   request.getParameter("tsId");
    UpdateBPM.deleteTS(Integer.parseInt(tsId));
    
%>
