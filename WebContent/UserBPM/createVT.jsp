<%-- 
    Document   : createVT
    Created on : 30 Oct, 2011, 6:28:43 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String scId           =   request.getParameter("scId");
    String vtName         =   request.getParameter("vtName");
    String leadModule     =   request.getParameter("leadModule");
    String impactModule   =   request.getParameter("impactModule");
    String classification =   request.getParameter("classification");
    String type           =   request.getParameter("type");
    String priority       =   request.getParameter("priority");
    String vtType       =   request.getParameter("cVtType");
    int createdBy           =   (Integer)session.getAttribute("uid");
    String  vtTypeColor="";
    if(vtType==""){
        vtType=null;
    }
   else if(!vtType.equalsIgnoreCase("SAP")){
        vtTypeColor="red";
    }
    int vtId              =   CreateBPM.createVT(Integer.parseInt(scId),vtName,Integer.parseInt(leadModule),Integer.parseInt(impactModule),classification,type,priority,createdBy,vtType);
    String newListItem  ="<li id='vt"+vtId+"' class='vtMap expandable'> <div class='treeclass' onclick='javascript:viewTC("+vtId+")'></div><a href='#'  onclick='javascript:viewTC("+vtId+")' style='margin-left:0px;'><b>Variant:</b><input type='hidden' id='vtvalue"+vtId+"' value='" +vtName+ "'> <input type='hidden' id='vtType"+vtId+"' value='" +vtType+ "'> <span id='vtspan"+vtId+"' style='color:"+vtTypeColor+";'> "+vtName +"</span> (<span id='tccount"+vtId+"'>0</span>)</a> <span id='editspan"+vtId+"'  onclick='javascript:editvt("+vtId+","+leadModule+","+impactModule+",&#39;"+classification+"&#39;,&#39;"+type+"&#39;,&#39;"+priority+"&#39;,&#39;"+impactModule+"&#39;);'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span id='deletevt"+vtId+"' onclick='javascript:deleteVT("+vtId+","+scId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upvt'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downvt'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a></li>";
    out.print(newListItem);
%>