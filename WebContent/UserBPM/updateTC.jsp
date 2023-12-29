<%-- 
    Document   : updateTC
    Created on : Jun 16, 2012, 8:33:14 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tcId    =   request.getParameter("tcId");
    String tcName       =   request.getParameter("tcName");
    String tcType       =   request.getParameter("tcType");
    if(tcType==""){
        tcType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateTC(Integer.parseInt(tcId),tcName, tcType);
    

%>

