<%-- 
    Document   : updateMP
    Created on : Jun 16, 2012, 6:35:23 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String mpId    =   request.getParameter("mpId");
    String mpName       =   request.getParameter("mpName");
    String mpType       =   request.getParameter("mpType");
    if(mpType==""){
        mpType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateMP(Integer.parseInt(mpId),mpName,mpType);
    

%>

