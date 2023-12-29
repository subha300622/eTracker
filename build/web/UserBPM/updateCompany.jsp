<%-- 
    Document   : updateCompany
    Created on : Jun 18, 2012, 8:39:07 AM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String cId    =   request.getParameter("cId");
    String cName       =   request.getParameter("cName");
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateCompany(Integer.parseInt(cId),cName);
    

%>
