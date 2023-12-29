<%-- 
    Document   : updateVT
    Created on : Jun 16, 2012, 8:33:05 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.userBPM.UpdateBPM"%>
<%
    String vtId    =   request.getParameter("vtId");

    String vtName         =   request.getParameter("editvtname");
    String leadModule     =   request.getParameter("editlead");
    String impactModule   =   request.getParameter("editimpact");
    String type           =   request.getParameter("edittype");
    String classification =   request.getParameter("editcalssification");
    String priority       =   request.getParameter("editpriority");
    String vtType       =   request.getParameter("vtType");
    if(vtType==""){
        vtType=null;
    }
    int updatedBy           =   (Integer)session.getAttribute("uid");
    UpdateBPM.updateVT(Integer.parseInt(vtId),vtName,vtType,leadModule,impactModule,type,classification,priority);
    

%>

