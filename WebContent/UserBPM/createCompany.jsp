<%@page import="com.eminentlabs.userBPM.ViewBPM"%>
<%@page import="com.eminentlabs.userBPM.CreateBPM"%>
<%
    String companyName = request.getParameter("company");
    String pid = request.getParameter("pid");
    String srcComp = request.getParameter("srcCompany").trim();
    int createdBy = (Integer) session.getAttribute("uid");
    int compId = CreateBPM.createCompany(companyName, Integer.parseInt(pid), createdBy, srcComp);
    int bpCount = ViewBPM.getBPCount(compId);
    //   String newListItem1  ="<li id='c"+compId+"' class='expandable'> <div class='treeclass' onclick='javascript:viewBP("+compId+")'></div><a href='#'  onclick='javascript:viewBP("+compId+")' style='margin-left:0px;'><b>Company:</b> "+companyName +" </a></li>";

    String newListItem = "<li id='c" + compId + "' class='compMap expandable'> <div class='treeclass' onclick='javascript:viewBP(" + compId + ")'></div><a href='#'  onclick='javascript:viewBP(" + compId + ");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue" + compId + "' value='" + companyName + "'> <span id='cspan" + compId + "'>" + companyName + "</span> ";
    if (bpCount == 0) {
        newListItem += "(<span id='bpcount" + compId + "'>0</span>) </a><span  onclick='javascript:editc(" + compId + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletec" + compId + "' onclick='javascript:deleteCompany(" + compId + "," + pid + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upcom'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downcom'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
    } else {
        newListItem += "(<span id='bpcount" + compId + "'>" + bpCount + "</span>) </a><span  onclick='javascript:editc(" + compId + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='upcom'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downcom'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
    }

    out.print(newListItem);
%>

