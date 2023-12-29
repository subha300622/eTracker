<%-- 
    Document   : deleteTC
    Created on : Jun 19, 2012, 1:09:54 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tcId    =   request.getParameter("tcId");
    UpdateBPM.deleteTC(Integer.parseInt(tcId));
    
%>
