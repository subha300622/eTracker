<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String bpId = request.getParameter("bpId");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    LinkedHashMap mProcess = ViewBPM.getMP(Integer.parseInt(bpId));
    HashMap mPType = ViewBPM.getMPType(Integer.parseInt(bpId));
   // LinkedHashMap mainProcess = GetProjectMembers.sortHashMapByKeys(mProcess, true);
    String mpName = "";
    if (mProcess.size() > 0) {
        Collection set = mProcess.keySet();
        Iterator ite = set.iterator();
        int spCount = 0;
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String nameofmp = (String) mProcess.get(key);
            String mpType = "";
            String mpTypeColor = "";
            if (mPType.get(key) != null) {
                mpType = (String) mPType.get(key);
                if (!mpType.equalsIgnoreCase("SAP")) {
                    mpTypeColor = "red";
                }
            }
            spCount = ViewBPM.getSPCount(key);
            if (spCount == 0) {
                mpName = mpName + "<li id='mp" + key + "' class='mpMap expandable'><div class='treeclass'  onclick='javascript:viewSP(" + key + ")'></div><a href='#'  onclick='javascript:viewSP(" + key + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + key + "' value='" + nameofmp + "'><input type='hidden' id='mpType" + key + "' value='" + mpType + "'><span id='mpspan" + key + "' style='color:" + mpTypeColor + ";'>" + nameofmp + "</span> (<span id='spcount" + key + "'>" + spCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    mpName = mpName + "<span  onclick='javascript:editmp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletemp" + key + "' onclick='javascript:deleteMP(" + key + "," + bpId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upmp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downmp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                mpName = mpName + "  </li>";
            } else {
                mpName = mpName + "<li id='mp" + key + "' class='mpMap expandable'><div class='treeclass'  onclick='javascript:viewSP(" + key + ")'></div><a href='#'  onclick='javascript:viewSP(" + key + ");return false;'  ><b>Main Process:</b> <input type='hidden' id='mpvalue" + key + "' value='" + nameofmp + "'><input type='hidden' id='mpType" + key + "' value='" + mpType + "'><span id='mpspan" + key + "' style='color:" + mpTypeColor + ";'>" + nameofmp + "</span> (<span id='spcount" + key + "'>" + spCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    mpName = mpName + "<span  onclick='javascript:editmp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='upmp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downmp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                mpName = mpName + "  </li>";
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            mpName = "<ul>" + mpName + "<li class='lastmp'><a href='#' onclick='javascript:showMP(" + bpId + ");return false;' style='color:#C0C0C0;'> Add Main Process</a></li></ul>";
        }else{
            mpName = "<ul>" + mpName + "</ul>";
        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            mpName = "<ul><li class='lastmp'><a href='#' onclick='javascript:showMP(" + bpId + ");return false;' style='margin-left:0px;color:#C0C0C0;'    ><b>Main Process:</b>  Add Main Process</a></li></ul>";
        }else{
            mpName = "<ul></ul>";
        }
    }
    out.print(mpName);
%>
