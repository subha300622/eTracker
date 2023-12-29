<%-- 
    Document   : deleteSC
    Created on : Jun 19, 2012, 1:08:36 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String scId    =   request.getParameter("scId");
    UpdateBPM.deleteSC(Integer.parseInt(scId));
    
%>