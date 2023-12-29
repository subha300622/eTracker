<%-- 
    Document   : updateSC
    Created on : Jun 16, 2012, 8:25:58 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String scId    =   request.getParameter("scId");
    String scName       =   request.getParameter("scName");
    String scType       =   request.getParameter("scType");
    if(scType==""){
        scType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateSC(Integer.parseInt(scId),scName,scType);
    

%>
