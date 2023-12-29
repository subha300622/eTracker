<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String mpId = request.getParameter("mpId");

    LinkedHashMap sProcess = ViewBPM.getSP(Integer.parseInt(mpId));
    HashMap sPTypes = ViewBPM.getSPType(Integer.parseInt(mpId));
   // LinkedHashMap subProcess = GetProjectMembers.sortHashMapByKeys(sProcess, true);
    String spName = "";
    if (sProcess.size() > 0) {
        Collection set = sProcess.keySet();
        Iterator ite = set.iterator();
        int scCount = 0;
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String nameofsp = (String) sProcess.get(key);
            String spType = "";
            String spTypeColor = "";
            if (sPTypes.get(key) != null) {
                spType = (String) sPTypes.get(key);
                if (!spType.equalsIgnoreCase("SAP")) {
                    spTypeColor = "red";
                }

            }
            scCount = ViewBPM.getSCCount(key);
            if (scCount == 0) {
                spName = spName + "<li id='sp" + key + "' class='spMap expandable'><div class='treeclass' onclick='javascript:viewSC(" + key + ")'></div><a href='#'  onclick='javascript:viewSC(" + key + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + key + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + key + "' value='" + spType + "'> <span id='spspan" + key + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + key + "'>" + scCount + "</span>) </a>";
                if (url.equals("eminentlabs.net")) {
                    spName = spName + " <span  onclick='javascript:editsp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span id='deletesp" + key + "' onclick='javascript:deleteSP(" + key + "," + mpId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upsp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downsp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                spName = spName + "</li>";
            } else {
                if (url.equals("eminentlabs.net")) {
                    spName = spName + "<li id='sp" + key + "' class='spMap expandable'><div class='treeclass' onclick='javascript:viewSC(" + key + ")'></div><a href='#'  onclick='javascript:viewSC(" + key + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + key + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + key + "' value='" + spType + "'> <span id='spspan" + key + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + key + "'>" + scCount + "</span>) </a><span  onclick='javascript:editsp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span title='Download Sub Process'>  <a href='/eTracker/UserBPM/downloadTree.jsp?spId=" + key + "' target='_blank'><img style='border:none;position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/down.png'/></a></span>&nbsp;<a href='javascript:void(0)' class='upsp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downsp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a></li>";
                } else {
                    spName = spName + "<li id='sp" + key + "' class='spMap expandable'><div class='treeclass' onclick='javascript:viewSC(" + key + ")'></div><a href='#'  onclick='javascript:viewSC(" + key + ");return false;' style='margin-left:0px;'><b>Sub Process:</b><input type='hidden' id='spvalue" + key + "' value='" + nameofsp + "'> <input type='hidden' id='spType" + key + "' value='" + spType + "'> <span id='spspan" + key + "' style='color:" + spTypeColor + ";'>" + nameofsp + "</span>  (<span id='sccount" + key + "'>" + scCount + "</span>) </a></li>";

                }
            }

        }
        if (url.equals("eminentlabs.net")) {
            spName = "<ul>" + spName + "<li class='lastsp'><a href='#' onclick='javascript:showSP(" + mpId + ");return false;' style='margin-left:0px;color:#C0C0C0;'>  Add Sub Process</a></li></ul>";
        }
        else{
            spName = "<ul>" + spName + "</ul>";
        }
    } else {

//        if(url.equals("eminentlabs.net")){
//            spName    =   "<ul><li class='lastsp'><a href='#' onclick='javascript:showSP("+mpId+");return false;' style='margin-left:0px;color:#C0C0C0;' ><b>Sub Process:</b>  Add Sub Process</a><a href='./uploadExcel.jsp?mpId="+mpId+"'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' >Upload Sub Process</a></li></ul>";
//       }else{
//            spName    =   "<ul><li class='lastsp'><a href='#' onclick='javascript:showSP("+mpId+");return false;' style='margin-left:0px;color:#C0C0C0;' ><b>Sub Process:</b>  Add Sub Process</a></li></ul>";
//
//       }
        if (url.equals("eminentlabs.net")) {
            spName = "<ul><li class='lastsp'><a href='#' onclick='javascript:showSP(" + mpId + ");return false;' style='margin-left:0px;color:#C0C0C0;' ><b>Sub Process:</b>  Add Sub Process</a></li></ul>";
        }else{
            spName = "<ul></ul>";
        }
    }
    out.print(spName);
%>
