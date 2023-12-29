<%-- 
    Document   : createTS
    Created on : 30 Oct, 2011, 8:11:05 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String tcId    =   request.getParameter("tcId");
    String tsName       =   request.getParameter("tsName");
    String tsType       =   request.getParameter("cTsType");
    int createdBy           =   (Integer)session.getAttribute("uid");
    String tsTypeColor="";
    if(tsType==""){
        tsType=null;
    }
   else if(!tsType.equalsIgnoreCase("SAP")){
        tsTypeColor="red";
    }
    int tsId        =   CreateBPM.createTS(Integer.parseInt(tcId),tsName,createdBy, tsType);
    String newListItem  ="<li id='ts"+tsId+"' class='tsMap expandable'> <div class='treeclass' onclick='javascript:viewTSC("+tsId+")'></div><a href='#'  onclick='javascript:viewTSC("+tsId+")' style='margin-left:0px;'><b>Business Step:</b> <input type='hidden' id='tsvalue"+tsId+"' value='" +tsName+"'><input type='hidden' id='tsType"+tsId+"' value='" +tsType+"'><span id='tsspan"+tsId+"' style='color:"+tsTypeColor+";'>"+tsName +"</span>(<span id='tscount"+tsId+"'>0</span>) </a><span onclick='javascript:editts("+tsId+");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletets"+tsId+"' onclick='javascript:deleteTS("+tsId+","+tcId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue("+tsId+")'></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/file_attach.png'/ title='Add File' onclick='tStepAttachFile(" + tsId + ")'></span><span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view_attach.png'/ title='View Files' onclick='viewFilesByTSID(" + tsId + ")'></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upts'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downts'>Down</a></li>";
    out.print(newListItem);
%>