<%-- 
    Document   : deleteTSC
    Created on : Jul 3, 2012, 11:28:32 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tscId    =   request.getParameter("tscId");
    UpdateBPM.deleteTSC(Integer.parseInt(tscId));
    
%>
