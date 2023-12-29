<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String scId = request.getParameter("scId");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    LinkedHashMap variant = ViewBPM.getVT(Integer.parseInt(scId));
    //LinkedHashMap variant = GetProjectMembers.sortHashMapByKeys(variantMap, true);
    String vtName = "";
    if (variant.size() > 0) {
        HashMap variantMapTypes = ViewBPM.getVTTypes(Integer.parseInt(scId));
        HashMap variantDetails = ViewBPM.displayVTDetails(Integer.parseInt(scId));
        Collection set = variant.keySet();
        Iterator ite = set.iterator();
        int tcCount = 0;

        while (ite.hasNext()) {

            int key = (Integer) ite.next();
            String nameofvt = (String) variant.get(key);
            String vtType = "";
            String vtTypeColor = "";
            if (variantMapTypes.get(key) != null) {
                vtType = (String) variantMapTypes.get(key);
                if (!vtType.equalsIgnoreCase("SAP")) {
                    vtTypeColor = "red";
                }
            }
            String lead = (String) variantDetails.get(key + "lead");
            String impact = (String) variantDetails.get(key + "impact");
            String classification = (String) variantDetails.get(key + "classification");
            String type = (String) variantDetails.get(key + "type");
            String priority = (String) variantDetails.get(key + "priority");
            String vttype = (String) variantDetails.get(key + "vttype");

            tcCount = ViewBPM.getTCCount(key);
            if (tcCount == 0) {
                vtName = vtName + "<li id='vt" + key + "' class='vtMap expandable'><div class='treeclass' onclick='javascript:viewTC(" + key + ")'></div><a href='#'  onclick='javascript:viewTC(" + key + ");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue" + key + "' value='" + nameofvt + "'> <input type='hidden' id='vtType" + key + "' value='" + vtType + "'> <span id='vtspan" + key + "' style='color:" + vtTypeColor + ";'>" + nameofvt + "</span>  (<span id='tccount" + key + "'>" + tcCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    vtName = vtName + "<span id='editspan" + key + "'  onclick='javascript:editvt(" + key + "," + lead + "," + impact + ",&#39;" + classification + "&#39;,&#39;" + type + "&#39;,&#39;" + priority + "&#39;,&#39;" + vttype + "&#39;);'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletevt" + key + "' onclick='javascript:deleteVT(" + key + "," + scId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upvt'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downvt'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                vtName = vtName + "</li>";
            } else {

                vtName = vtName + "<li id='vt" + key + "' class='vtMap expandable'><div class='treeclass' onclick='javascript:viewTC(" + key + ")'></div><a href='#'  onclick='javascript:viewTC(" + key + ");return false;' style='margin-left:3px;'><b>Variant:</b><input type='hidden' id='vtvalue" + key + "' value='" + nameofvt + "'> <input type='hidden' id='vtType" + key + "' value='" + vtType + "'> <span id='vtspan" + key + "' style='color:" + vtTypeColor + ";'>" + nameofvt + "</span>  (<span id='tccount" + key + "'>" + tcCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    vtName = vtName + "<span id='editspan" + key + "'  onclick='javascript:editvt(" + key + "," + lead + "," + impact + ",&#39;" + classification + "&#39;,&#39;" + type + "&#39;,&#39;" + priority + "&#39;,&#39;" + vttype + "&#39;);'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;&nbsp;<a href='javascript:void(0)' class='upvt'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='downvt'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                vtName = vtName + "</li>";
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            vtName = "<ul>" + vtName + "<li class='lastvt'><a href='#' onclick='javascript:showVT(" + scId + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Variant</a></li></ul>";
        }else{
            vtName = "<ul>" + vtName + "</ul>";
        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            vtName = "<ul><li class='lastvt'><a href='#' onclick='javascript:showVT(" + scId + ");return false;' style='margin-left:0px;color:#C0C0C0;'><b>Variant:</b>  Add Variant</a></li></ul>";
        }else{
            vtName = "<ul></ul>" ;
        }
    }
    out.print(vtName);
%>
