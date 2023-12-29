<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String spId = request.getParameter("spId");

    LinkedHashMap scenarioMap = ViewBPM.getSC(Integer.parseInt(spId));
    HashMap scenarioTypes = ViewBPM.getSCTypes(Integer.parseInt(spId));
  //  LinkedHashMap scenario = GetProjectMembers.sortHashMapByKeys(scenarioMap, true);
    String scName = "";
    if (scenarioMap.size() > 0) {
        Collection set = scenarioMap.keySet();
        Iterator ite = set.iterator();
        int vtCount = 0;
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String nameofsc = (String) scenarioMap.get(key);
            String scType = "";
            String scTypeColor = "";
            if (scenarioTypes.get(key) != null) {
                scType = (String) scenarioTypes.get(key);
                if (!scType.equalsIgnoreCase("SAP")) {
                    scTypeColor = "red";
                }
            }
            vtCount = ViewBPM.getVTCount(key);
            if (vtCount == 0) {
                scName = scName + "<li id='sc" + key + "' class='scMap expandable'><div class='treeclass' onclick='javascript:viewVT(" + key + ")'></div><a href='#'  onclick='javascript:viewVT(" + key + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + key + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + key + "' value='" + scType + "'> <span id='scspan" + key + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + key + "'>" + vtCount + "</span>) </a>";
                if (url.equals("eminentlabs.net")) {
                    scName = scName + "<span  onclick='javascript:editsc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesc" + key + "' onclick='javascript:deleteSC(" + key + "," + spId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upsc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downsc'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                scName = scName + "</li>";
            } else {
                if (url.equals("eminentlabs.net")) {
                    scName = scName + "<li id='sc" + key + "' class='scMap expandable'><div class='treeclass' onclick='javascript:viewVT(" + key + ")'></div><a href='#'  onclick='javascript:viewVT(" + key + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + key + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + key + "' value='" + scType + "'> <span id='scspan" + key + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + key + "'>" + vtCount + "</span>) </a><span  onclick='javascript:editsc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upsc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downsc'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
                } else {
                    scName = scName + "<li id='sc" + key + "' class='expandable'><div class='treeclass' onclick='javascript:viewVT(" + key + ")'></div><a href='#'  onclick='javascript:viewVT(" + key + ");return false;' style='margin-left:3px;'><b>Scenario:</b><input type='hidden' id='scvalue" + key + "' value='" + nameofsc + "'> <input type='hidden' id='scType" + key + "' value='" + scType + "'> <span id='scspan" + key + "' style='color:" + scTypeColor + ";'>" + nameofsc + "</span>  (<span id='vtcount" + key + "'>" + vtCount + "</span>) </a></li>";

                }

            }

        }
        if (url.equals("eminentlabs.net")) {
            scName = "<ul>" + scName + "<li class='lastsc'><a href='#' onclick='javascript:showSC(" + spId + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Scenario</a><a href='./uploadExcel.jsp?spId=" + spId + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' > Upload Scenario  </a></li></ul>";
        } else {
            scName = "<ul>" + scName + "</ul>";
        }
    } else {
        if (url.equals("eminentlabs.net")) {

            scName = "<ul><li class='lastsc'><a href='#' onclick='javascript:showSC(" + spId + ");return false;' style='margin-left:0px;color:#C0C0C0;'><b>Scenario:</b>  Add Scenario</a><a href='./uploadExcel.jsp?spId=" + spId + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' > Upload Scenario </a></li></ul>";
        } else {
            scName = "<ul></ul>";
        }

    }
    out.print(scName);
%>
