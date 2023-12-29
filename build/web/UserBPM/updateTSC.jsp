<%-- 
    Document   : updateTSC
    Created on : Jan 07, 2015, 11:33:29 AM
    Author     : Muthuraja
--%>


<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String tscId = request.getParameter("tscId");
    String tscName = request.getParameter("tscName");
    String tscResult = request.getParameter("tscResult");
    String ptcId = request.getParameter("ptcId");

    int updatedBy = (Integer) session.getAttribute("uid");
    UpdateBPM.updatePTC(ptcId, tscName, tscResult);
    UpdateBPM.updateTSC(Integer.parseInt(tscId), tscName, tscResult);


%>

