<%-- 
    Document   : deleteBP
    Created on : Jun 19, 2012, 1:00:06 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String bpId    =   request.getParameter("bpId");
    UpdateBPM.deleteBP(Integer.parseInt(bpId));
    
%>
