<%-- 
    Document   : updateBP
    Created on : Jun 12, 2012, 11:32:22 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String bpId    =   request.getParameter("bpId");
    String bpName       =   request.getParameter("bpName");
    String bpType       =   request.getParameter("bpType");
    if(bpType==""){
        bpType=null;
    }
    int createdBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateBP(Integer.parseInt(bpId),bpName,bpType);
    

%>
