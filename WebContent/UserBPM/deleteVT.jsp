<%-- 
    Document   : deleteVT
    Created on : Jun 19, 2012, 1:09:09 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String vtId    =   request.getParameter("vtId");
    UpdateBPM.deleteVT(Integer.parseInt(vtId));
    
%>