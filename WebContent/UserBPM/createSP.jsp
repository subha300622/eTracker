<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String mpId    =   request.getParameter("mpId");
    String spName       =   request.getParameter("spName");
    String spType       =   request.getParameter("cSpType");
    String spTypeColor="";
    if(spType==""){
        spType=null;
    }
   else if(!spType.equalsIgnoreCase("SAP")){
        spTypeColor="red";
    }
    int createdBy           =   (Integer)session.getAttribute("uid");
    int sp      =   CreateBPM.createSP(Integer.parseInt(mpId),spName,createdBy,spType);
    String newListItem  ="<li id='sp"+sp+"' class='spMap expandable'> <div class='treeclass' onclick='javascript:viewSC("+sp+")'></div><a href='#'  onclick='javascript:viewSC("+sp+")' style='margin-left:0px;'><b>Sub Process:</b> <input type='hidden' id='spvalue" +sp+ "' value='" +spName+ "'> <input type='hidden' id='spType" +sp+ "' value='" +spType+ "'><span id='spspan"+sp+"' style='color:"+spTypeColor+";'>" +spName+ "</span> (<span id='sccount"+sp+"'>0</span>) </a><span  onclick='javascript:editsp("+sp+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletesp"+sp+"' onclick='javascript:deleteSP("+sp+","+mpId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span></a>&nbsp;<a href='javascript:void(0)' class='upsp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downsp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
    out.print(newListItem);


%>
