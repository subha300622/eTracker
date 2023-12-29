<%-- 
    Document   : updateSP
    Created on : Jun 16, 2012, 7:41:23 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String spId    =   request.getParameter("spId");
    String spName       =   request.getParameter("spName");
    String spType       =   request.getParameter("spType");
    if(spType==""){
        spType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateSP(Integer.parseInt(spId),spName,spType);
    

%>
