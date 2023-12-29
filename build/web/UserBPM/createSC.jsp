<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String spId    =   request.getParameter("spId");
    String scName       =   request.getParameter("scName");
    String scType       =   request.getParameter("cScType");
    int createdBy       =   (Integer)session.getAttribute("uid");
    String scTypeColor="";
    if(scType==""){
        scType=null;
    }
   else if(!scType.equalsIgnoreCase("SAP")){
        scTypeColor="red";
    }
    
    int createdSC       =   CreateBPM.createSC(Integer.parseInt(spId),scName,createdBy, scType);
    String newListItem ="<li id='sc"+createdSC+"' class='scMap expandable'> <div class='treeclass' onclick='javascript:viewVT("+createdSC+")'></div><a href='#'  onclick='javascript:viewVT("+createdSC+")' style='margin-left:0px;'><b>Scenario:</b> <input type='hidden' id='scvalue"+createdSC+"' value='" +scName+ "'> <input type='hidden' id='scType"+createdSC+"' value='" +scType+ "'><span id='scspan"+createdSC+"' style='color:"+scTypeColor+";'>" +scName+ "</span> (<span id='vtcount"+createdSC+"'>0</span>) </a><span  onclick='javascript:editsc("+createdSC+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletesc"+createdSC+"'  onclick='javascript:deleteSC("+createdSC+","+spId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span> &nbsp;&nbsp;<a href='javascript:void(0)' class='upsc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downsc'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a> </li>";
    out.print(newListItem);
%>
