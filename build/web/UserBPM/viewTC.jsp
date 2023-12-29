<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String vtId = request.getParameter("vtId");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    LinkedHashMap testcase = ViewBPM.getTC(Integer.parseInt(vtId));
    HashMap tcaseTypes = ViewBPM.getTCTypes(Integer.parseInt(vtId));
    //LinkedHashMap testcase = GetProjectMembers.sortHashMapByKeys(tcase, true);
    String tcName = "";
    if (testcase.size() > 0) {
        Collection set = testcase.keySet();
        Iterator ite = set.iterator();
        int tsCount = 0;
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String nameoftc = (String) testcase.get(key);
            String tcType = "";
            String tcTypeColor = "";
            if (tcaseTypes.get(key) != null) {
                tcType = (String) tcaseTypes.get(key);
                if (!tcType.equalsIgnoreCase("SAP")) {
                    tcTypeColor = "red";
                }
            }
            tsCount = ViewBPM.getTSCount(key);
            if (tsCount == 0) {
                tcName = tcName + "<li id='tc" + key + "' class='tcMap expandable'><div class='treeclass' onclick='javascript:viewTS(" + key + ")'></div><a href='#'  onclick='javascript:viewTS(" + key + ");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue" + key + "' value='" + nameoftc + "'> <input type='hidden' id='tcType" + key + "' value='" + tcType + "'> <span id='tcspan" + key + "' style='color:" + tcTypeColor + ";'>" + nameoftc + "</span>  (<span id='tscount" + key + "'>" + tsCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    tcName = tcName + "<span  onclick='javascript:edittc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletetc" + key + "' onclick='javascript:deleteTC(" + key + "," + vtId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='uptc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downtc'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                tcName = tcName + "</li>";
            } else {
                tcName = tcName + "<li id='tc" + key + "' class='tcMap expandable'><div class='treeclass' onclick='javascript:viewTS(" + key + ")'></div><a href='#'  onclick='javascript:viewTS(" + key + ");return false;' style='margin-left:3px;'><b>Business Case:</b><input type='hidden' id='tcvalue" + key + "' value='" + nameoftc + "'> <input type='hidden' id='tcType" + key + "' value='" + tcType + "'> <span id='tcspan" + key + "' style='color:" + tcTypeColor + ";''>" + nameoftc + "</span>  (<span id='tscount" + key + "'>" + tsCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    tcName = tcName + "<span  onclick='javascript:edittc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='uptc'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downtc'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                tcName = tcName + "</li>";
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            tcName = "<ul>" + tcName + "<li class='lasttc'><a href='#' onclick='javascript:showTC(" + vtId + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Business Case</a></li></ul>";
        }else{
            tcName = "<ul>" + tcName + "</ul>";
        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            tcName = "<ul><li class='lasttc'><a href='#' onclick='javascript:showTC(" + vtId + ");return false;' style='margin-left:0px;color:#C0C0C0;'>  Add Business Case</a></li></ul>";
        }else{
           tcName = "<ul></ul>"; 
        }
    }
    out.print(tcName);
%>
