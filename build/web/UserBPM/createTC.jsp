<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String vtId    =   request.getParameter("vtId");
    String tcName       =   request.getParameter("tcName");
    String tcType       =   request.getParameter("cTcType");
    int createdBy           =   (Integer)session.getAttribute("uid");
    String tcTypeColor="";
    if(tcType==""){
        tcType=null;
    }
   else if(!tcType.equalsIgnoreCase("SAP")){
        tcTypeColor="red";
    }
    int tcId        =   CreateBPM.createTC(Integer.parseInt(vtId),tcName,createdBy,tcType);
    String newListItem  ="<li id='tc"+tcId+"' class='tcMap expandable'> <div class='treeclass' onclick='javascript:viewTS("+tcId+")'></div><a href='#'  onclick='javascript:viewTS("+tcId+")' style='margin-left:0px;'><b>Business Case:</b><input type='hidden' id='tcvalue"+tcId+"' value='" +tcName+ "'><input type='hidden' id='tcType"+tcId+"' value='" +tcType+ "'> <span id='tcspan"+tcId+"' style='color:"+tcTypeColor+";'>"+tcName +"</span> (<span id='tscount"+tcId+"'>0</span>) </a><span  onclick='javascript:edittc("+tcId+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletetc"+tcId+"' onclick='javascript:deleteTC("+tcId+","+vtId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='uptc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downtc'>Down</a></li>";
    out.print(newListItem);
%>
