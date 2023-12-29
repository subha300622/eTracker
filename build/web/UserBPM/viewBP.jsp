<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String company = request.getParameter("company");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String userId = ((Integer) session.getAttribute("userid_curr")).toString();
    String IT = "1156";
    String hr = "1176,1370";
    String mailids = "ckcsons.com";
    LinkedHashMap  bProcess = ViewBPM.getBP(Integer.parseInt(company));
    HashMap bPTypes = ViewBPM.getBPType(Integer.parseInt(company));
   // LinkedHashMap businessProcess = GetProjectMembers.sortHashMapByKeys(bProcess, true);
    String bpName = "";
    if (bProcess.size() > 0) {
        Collection set = bProcess.keySet();
        Iterator ite = set.iterator();
        int mpCount = 0;
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            String bpType = "";
            String typeColor = "";
            if (bPTypes.get(key) != null) {
                bpType = (String) bPTypes.get(key);
                if (!bpType.equalsIgnoreCase("SAP")) {
                    typeColor = "red";
                }
            }
            String nameofbp = (String) bProcess.get(key);
            boolean flag = false;
            if (mailids.contains(url)) {
                if (hr.contains(userId)) {
                    if (key == 138) {
                        flag = true;
                    }
                } else if (IT.contains(userId)) {
                    flag = true;
                } else if (key == 138 || key == 139) {
                    flag = false;
                } else {
                    flag = true;
                }
            } else {
                flag = true;
            }
            if (flag == true) {

                mpCount = ViewBPM.getMPCount(key);
                if (mpCount == 0) {
                    bpName = bpName + "<li id='bp" + key + "' class='bpMap expandable'> <div class='treeclass' onclick='javascript:viewMP(" + key + ")'></div><a href='#'  onclick='javascript:viewMP(" + key + ");return false;' >  <b>Business Process:</b><input type='hidden' id='bpvalue" + key + "' value='" + nameofbp + "'><input type='hidden' id='bpType" + key + "' value='" + bpType + "'> <span id='bpspan" + key + "' style='color:" + typeColor + ";'>" + nameofbp + "</span> (<span id='mpcount" + key + "'>" + mpCount + "</span>) </a>";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        bpName = bpName + "<span  onclick='javascript:editbp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span><span  id='deletebp" + key + "' onclick='javascript:deleteBP(" + key + "," + company + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upbp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downbp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                    }
                    bpName = bpName + " </li>";
                } else {

                    bpName = bpName + "<li id='bp" + key + "' class='bpMap expandable'> <div class='treeclass' onclick='javascript:viewMP(" + key + ")'></div><a href='#'  onclick='javascript:viewMP(" + key + ");return false;' ><b>Business Process:</b><input type='hidden' id='bpvalue" + key + "' value='" + nameofbp + "'><input type='hidden' id='bpType" + key + "' value='" + bpType + "'> <span id='bpspan" + key + "' style='color:" + typeColor + ";'>" + nameofbp + "</span> (<span id='mpcount" + key + "'>" + mpCount + "</span>) </a>";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        bpName = bpName + "<span  onclick='javascript:editbp(" + key + ");'><img style='position: realtive;cursor:pointer;' src='/eTracker/images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='upbp'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downbp'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                    }
                    bpName = bpName + " </li>";
                }
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            bpName = "<ul>" + bpName + "<li class='lastbp'><a href='#' onclick='javascript:showBP(" + company + ");return false;' style='color:#C0C0C0;'>  Add Business Process</a></li></ul>";
        }else {
            bpName = "<ul >" + bpName + "</ul>";

        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            bpName = "<ul><li class='lastbp'><a href='#' onclick='javascript:showBP(" + company + ");return false;' style='margin-left:0px;color:#C0C0C0;'>  Add Business Process</a></li></ul>";
        }else {
            bpName = "<ul ></ul>";

        }
    }
    out.print(bpName);
%>
