<%@page import="com.eminent.issue.ApmTsAttachment"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<jsp:useBean id="viewBPM" class="com.eminentlabs.userBPM.ViewBPM"></jsp:useBean>
<jsp:useBean id="amac" class="com.eminent.issue.controller.ApmTestStepAttachmentController"></jsp:useBean>
<%
    String tcId = request.getParameter("tcId");
    int userId = (Integer) session.getAttribute("userid_curr");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    LinkedHashMap teststep = ViewBPM.getTS(Integer.parseInt(tcId));
    HashMap tstepTypes = ViewBPM.getTSTypes(Integer.parseInt(tcId));
    // LinkedHashMap teststep = GetProjectMembers.sortHashMapByKeys(tstep, true);
    String tsName = "";
    if (teststep.size() > 0) {
        Collection set = teststep.keySet();
        Iterator ite = set.iterator();
        int tsCount = 0;

        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String nameoftc = (String) teststep.get(key);
            String tsType = "";
            String tsTypeColor = "";
            if (tstepTypes.get(key) != null) {
                tsType = (String) tstepTypes.get(key);
                if (!tsType.equalsIgnoreCase("SAP")) {
                    tsTypeColor = "red";
                }
            }

            tsCount = ViewBPM.getTestScriptCount(key);
            List<IssueFormBean> list = viewBPM.getTestScriptIssues(key);
            // List<ApmTsAttachment> att = amac.viewDocuments(key);
            if (tsCount == 0) {
                tsName = tsName + "<li id='ts" + key + "' class='tsMap expandable'><div class='treeclass' onclick='javascript:viewTSC(" + key + ")'></div><a href='#'  onclick='javascript:viewTSC(" + key + ");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue" + key + "' value='" + nameoftc + "'> <input type='hidden' id='tsType" + key + "' value='" + tsType + "'> <span id='tsspan" + key + "' style='color:" + tsTypeColor + ";'>" + nameoftc + "</span> (<span id='tsrcount" + key + "'>" + tsCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    tsName = tsName + "   <span  onclick='javascript:editts(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletets" + key + "' onclick='javascript:deleteTS(" + key + "," + tcId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upts'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downts'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/file_attach.png'/ title='Add File' onclick='tStepAttachFile(" + key + ")'></span>";
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view_attach.png'/ title='View Files' onclick='viewFilesByTSID(" + key + ")'></span>";
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/create.jpeg'/ title='Create Issue' onclick='tStepCtreateIssue(" + key + ")'></span>";
                if (!list.isEmpty()) {
                    tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view.png'/ title='View Issues' onclick='viewIssueByTSID(" + key + ")'></span>";
                }
                if (userId == 104) {
                    tsName = tsName + " <span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/link.png'/ title='View Issues'  onclick='viewIssueTS(" + key + ")'></span>";
                }
                tsName = tsName + "</li>";
            } else {
                tsName = tsName + "<li id='ts" + key + "' class='tsMap expandable'><div class='treeclass' onclick='javascript:viewTSC(" + key + ")'></div><a href='#'  onclick='javascript:viewTSC(" + key + ");return false;' style='margin-left:3px;'><b>Business Step:</b><input type='hidden' id='tsvalue" + key + "' value='" + nameoftc + "'> <input type='hidden' id='tsType" + key + "' value='" + tsType + "'> <span id='tsspan" + key + "' style='color:" + tsTypeColor + ";'>" + nameoftc + "</span> (<span id='tsrcount" + key + "'>" + tsCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    tsName = tsName + "<span  onclick='javascript:editts(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='upts'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downts'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/file_attach.png'/ title='Add File' onclick='tStepAttachFile(" + key + ")'></span>";
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view_attach.png'/ title='View Files' onclick='viewFilesByTSID(" + key + ")'></span>";
                tsName = tsName + "<span><img style='position: realtive;cursor:pointer;margin-left:10px;height:12px;' src='/eTracker/images/create.jpeg' title='Create Issue' onclick='tStepCtreateIssue(" + key + ")'/></span>";
                if (!list.isEmpty()) {
                    tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/view.png'/ title='View Issues' onclick='viewIssueByTSID(" + key + ")'></span>";
                }
                if (userId == 104) {
                    tsName = tsName + "<span><img style='position: realtive;cursor:pointer; height:12px;margin-left:10px;' src='/eTracker/images/link.png'/ title='View Issues'  onclick='viewIssueTS(" + key + ")'></span>";
                }
                tsName = tsName + "</li>";
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            tsName = "<ul>" + tsName + "<li class='lastts'><a href='#' onclick='javascript:showTS(" + tcId + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Business Step</a></li></ul>";
        } else {
            tsName = "<ul>" + tsName + "</ul>";
        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            tsName = "<ul><li class='lastts'><a href='#' onclick='javascript:showTS(" + tcId + ");return false;' style='margin-left:0px;color:#C0C0C0;'> Add Business Step</a></li></ul>";
        } else {
            tsName = "<ul></ul>";
        }
    }
    out.print(tsName);
%>
