<%-- 
    Document   : deleteSP
    Created on : Jun 19, 2012, 1:07:31 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String spId    =   request.getParameter("spId");
    UpdateBPM.deleteSP(Integer.parseInt(spId));
    
%>