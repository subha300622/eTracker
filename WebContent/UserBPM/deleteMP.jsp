<%-- 
    Document   : deleteMP
    Created on : Jun 19, 2012, 1:06:40 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String mpId    =   request.getParameter("mpId");
    UpdateBPM.deleteMP(Integer.parseInt(mpId));
    
%>
