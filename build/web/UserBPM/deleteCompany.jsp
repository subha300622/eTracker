<%-- 
    Document   : deleteCompany
    Created on : Jun 19, 2012, 11:17:19 AM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String cId    =   request.getParameter("cId");
    UpdateBPM.deleteCompany(Integer.parseInt(cId));
    
%>
