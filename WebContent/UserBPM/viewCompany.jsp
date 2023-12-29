<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String client = request.getParameter("client");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    String userId = ((Integer) session.getAttribute("userid_curr")).toString();
    String IT = "1156";
    String hr = "1176";
    String mailids = "ckcsons.com";
    String pid = request.getParameter("pid");
    LinkedHashMap companyMap = ViewBPM.getCompany(Integer.parseInt(client));
//    LinkedHashMap company = GetProjectMembers.sortHashMapByKeys(companyMap, true);
    String compName = "";
    if (companyMap.size() > 0) {
        Collection set = companyMap.keySet();
        Iterator ite = set.iterator();
        while (ite.hasNext()) {
            int key = (Integer) ite.next();
            int bpCount = ViewBPM.getBPCount(key);
            if (mailids.contains(url)) {
                if (hr.contains(userId)) {
                    if (key == 138) {
                        bpCount = bpCount - 1;
                    }
                } else if (key == 138) {
                    bpCount = bpCount - 1;
                } else if (key == 139) {
                    bpCount = bpCount - 1;
                } else {
                }
            }

            String nameofcomp = (String) companyMap.get(key);
            if (bpCount == 0) {
                compName = compName + "<li id='c" + key + "' class='compMap expandable'> <div class='treeclass' onclick='javascript:viewBP(" + key + ")'></div><a href='#'  onclick='javascript:viewBP(" + key + ");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue" + key + "' value='" + nameofcomp + "'> <span id='cspan" + key + "'>" + nameofcomp + "</span> (<span id='bpcount" + key + "'>" + bpCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    compName = compName + "<span  onclick='javascript:editc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span><span  id='deletec" + key + "' onclick='javascript:deleteCompany(" + key + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='./images/close.png'/></span>&nbsp;<a href='javascript:void(0)' class='upcom'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downcom'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                compName = compName + "</li>";
            } else {
                compName = compName + "<li id='c" + key + "' class='compMap expandable'> <div class='treeclass' onclick='javascript:viewBP(" + key + ")'></div><a href='#'  onclick='javascript:viewBP(" + key + ");return false;' style='margin-left:0px;'><b>Company:</b><input type='hidden' id='cvalue" + key + "' value='" + nameofcomp + "'> <span id='cspan" + key + "'>" + nameofcomp + "</span> (<span id='bpcount" + key + "'>" + bpCount + "</span>) </a>";
                if (url.equalsIgnoreCase("eminentlabs.net")) {
                    compName = compName + "<span  onclick='javascript:editc(" + key + ");'><img style='position: realtive;cursor:pointer;' src='./images/edit.png'/></span>&nbsp;<a href='javascript:void(0)' class='upcom'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;<a href='javascript:void(0)' class='downcom'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a>";
                }
                compName = compName + "</li>";
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            compName = "<ul class='tree'>" + compName + "<li class='lastcompany'><a href='#' onclick='javascript:showCompany(" + pid + ");return false;' style='margin-left:0px;color:#C0C0C0;'>Add Company</a></li></ul>";
        } else {
            compName = "<ul class='tree'>" + compName + "</ul>";

        }

    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            compName = "<ul><li class='lastcompany'><a href='#' onclick='javascript:showCompany(" + pid + ");return false;' style='margin-left:0px;color:#C0C0C0;'>Company: Add Company</a></li></ul>";
        }else {
            compName = "<ul class='tree'>" + compName + "</ul>";

        }
    }
    out.print(compName);
%>
