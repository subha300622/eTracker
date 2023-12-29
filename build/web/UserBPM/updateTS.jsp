<%-- 
    Document   : updateTS
    Created on : Jun 16, 2012, 8:33:29 PM
    Author     : Tamilvelan
--%>


<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tsId    =   request.getParameter("tsId");
    String tsName       =   request.getParameter("tsName");
    String tsType       =   request.getParameter("tsType");
    if(tsType==""){
        tsType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateTS(Integer.parseInt(tsId),tsName, tsType);
    

%>

