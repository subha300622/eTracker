<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String bpId    =   request.getParameter("bpId");
    String mpName       =   request.getParameter("mpName");
    String cMpType       =   request.getParameter("cMpType");
    String mpTypeColor="";
    if(cMpType==""){
        cMpType=null;
    }
    else if(!cMpType.equalsIgnoreCase("SAP")){
        mpTypeColor="red";
    }
    int createdBy           =   (Integer)session.getAttribute("uid");
    int mpId        =   CreateBPM.createMP(Integer.parseInt(bpId),mpName,createdBy,cMpType);
    String newListItem  ="<li id='mp"+mpId+"' class='mpMap expandable'><div class='treeclass'  onclick='javascript:viewSP("+mpId+")'></div><a href='#'  onclick='javascript:viewSP("+mpId+");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" +mpId+ "' value='" +mpName+ "'><input type='hidden' id='mpType" +mpId+ "' value='" +cMpType+ "'><span id='mpspan"+mpId+"' style='color:"+mpTypeColor+";'>" +mpName+ "</span> (<span id='spcount"+mpId+"'>0</span>) </a><span  onclick='javascript:editmp("+mpId+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletemp"+mpId+"' onclick='javascript:deleteMP("+mpId+","+bpId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upmp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downmp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
    out.print(newListItem);


%>