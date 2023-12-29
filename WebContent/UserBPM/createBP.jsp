<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String companyId    =   request.getParameter("company");
    String bpName       =   request.getParameter("bpName");
    String cBpType       =   request.getParameter("cBpType");
    String typeColor="";
    if(cBpType==""){
        cBpType=null;
    }
   else if(!cBpType.equalsIgnoreCase("SAP")){
        typeColor="red";
    }
    int createdBy           =   (Integer)session.getAttribute("uid");
    int bpId            =   CreateBPM.createBP(Integer.parseInt(companyId),bpName,createdBy,cBpType);
    String newListItem ="<li id='bp"+bpId+"' class='bpMap expandable'> <div class='treeclass' onclick='javascript:viewMP("+bpId+")'></div><a href='#'  onclick='javascript:viewMP("+bpId+");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" +bpId+ "' value='" +bpName+ "'><input type='hidden' id='bpType" +bpId+ "' value='" +cBpType+ "'> <span id='bpspan" + bpId + "' style='color:"+typeColor+";'>" +bpName+ "</span> (<span id='mpcount"+bpId+"'>0</span>) </a><span  onclick='javascript:editbp(" + bpId + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletebp"+bpId+"' onclick='javascript:deleteBP("+bpId+","+companyId+");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upbp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downbp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
    out.print(newListItem);
  

%>
