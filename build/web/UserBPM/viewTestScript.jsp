<%@page import="java.util.HashMap,java.util.Collection,java.util.Iterator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,com.eminent.util.GetProjectMembers" %>
<%
    String tsId = request.getParameter("tsId");
    String mail = (String) session.getAttribute("theName");
    String url = null;
    if (mail != null) {
        url = mail.substring(mail.indexOf("@") + 1, mail.length());
    }
    LinkedHashMap testscript = ViewBPM.getTestScript(Integer.parseInt(tsId));
    String tsName = "", color = "white";
    int i = 0;
    if (testscript.size() > 0) {
        Collection set = testscript.keySet();
        Iterator ite = set.iterator();
        String testScript = null;
        String expRslt = null;
        String createdBy = null;
        String ptcId = null;
        String tscId = null;
        String uniqueId = null;
        int noOfFiles = 0;
        while (ite.hasNext()) {
            if ((i % 2) != 0) {
                color = "#E8EEF7";
            } else {

                color = "white";

            }
            String key = (String) ite.next();
            String nameoftc = (String) testscript.get(key);

            //upload###upload###Tamilvelan T***Not Run***36681***0
            testScript = nameoftc.substring(0, nameoftc.indexOf("###"));
            expRslt = nameoftc.substring(nameoftc.indexOf("###") + 3, nameoftc.lastIndexOf("###"));
            createdBy = nameoftc.substring(nameoftc.lastIndexOf("###") + 3, nameoftc.indexOf("***") - 2);
            ptcId = nameoftc.substring(nameoftc.indexOf("***") + 3, nameoftc.lastIndexOf("***"));
            tscId = nameoftc.substring(nameoftc.lastIndexOf("***") + 3, nameoftc.lastIndexOf("@@@"));
            noOfFiles = Integer.parseInt(nameoftc.substring(nameoftc.indexOf("@@@") + 3));

            // check test script is added or not 
            int ptcIdCount = ViewBPM.getTECStatus(Integer.parseInt(tscId));
            String testcaseId = "'" + key + "'";
            uniqueId = key + tsId;
            
            if (noOfFiles > 0) {
                if (ptcIdCount == 0) {
                    tsName = tsName + "<tr id='" + tscId + "' style='background-color:" + color + ";'><td style='width:1%;'><div id=" + uniqueId + " onclick=javascript:showComments('" + key + "','" + tsId + "'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div></td><td><input type='hidden' id='tscId' value='" + testScript + "'><a href='javascript:void(0)' class='up'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='down'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a> </td><td id='tdtscvalue" + tscId + "'>" + testScript + " </td><td id='tdtscresult" + tscId + "'>" + expRslt + " </td><td>" + createdBy + "</td>"
                            + "<td>" + ptcId + "<input type='hidden' id='tscvalue" + tscId + "' value='" + testScript + "'><input type='hidden' id='tscresult" + tscId + "' value='" + expRslt + "'><input type='hidden' id='ptcId" + tscId + "' value='" + key + "'>";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        tsName = tsName + "<span id='edittsc" + tscId + "' onclick='javascript:editTSC(" + tscId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/edit.png'/></span>"
                                + "<span id='deletetsc" + tscId + "' onclick='javascript:deleteTSC(" + tscId + "," + tsId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                    }
                    tsName = tsName + "<span onclick='javascript:viewAttachment(&apos;" + key + "&apos;);'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/attach.gif'/></span></td></tr><tr ><td colspan=4 > <div id='ptc" + uniqueId + "'></div></td></tr>";
                } else {
                    tsName = tsName + "<tr id='" + tscId + "' style='background-color:" + color + ";'><td style='width:1%;' ><div id=" + uniqueId + " onclick=javascript:showComments('" + key + "','" + tsId + "'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div></td><td><input type='hidden' id='tscId' value='" + testScript + "'><a href='javascript:void(0)' class='up'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='down'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a> </td><td>" + testScript + " </td><td>" + expRslt + " </td><td>" + createdBy + "</td>"
                            + "<td>" + ptcId + "";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        tsName = tsName + "<span id='deletetsc" + tscId + "' onclick='javascript:deleteTSC(" + tscId + "," + tsId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                    }

                    tsName = tsName + "<span onclick='javascript:viewAttachment(&apos;" + key + "&apos;);'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/attach.gif'/></span></td></tr><tr ><td colspan=4 > <div id='ptc" + uniqueId + "'></div></td></tr>";
                }

                i++;
            } else {
                if (ptcIdCount == 0) {
                    tsName = tsName + "<tr id='" + tscId + "' style='background-color:" + color + ";'><td style='width:1%;'><div id=" + uniqueId + " onclick=javascript:showComments('" + key + "','" + tsId + "'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div></td><td><input type='hidden' id='tscId' value='" + testScript + "'><a href='javascript:void(0)' class='up'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='down'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a> </td><td id='tdtscvalue" + tscId + "'>" + testScript + " </td><td id='tdtscresult" + tscId + "'>" + expRslt + " </td><td>" + createdBy + "</td><td>" + ptcId + ""
                            + "<input type='hidden' id='tscvalue" + tscId + "' value='" + testScript + "'><input type='hidden' id='tscresult" + tscId + "' value='" + expRslt + "'><input type='hidden' id='ptcId" + tscId + "' value='" + key + "'>";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        tsName = tsName + "<span id='edittsc" + tscId + "' onclick='javascript:editTSC(" + tscId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/edit.png'/></span>"
                                + "<span id='deletetsc" + tscId + "' onclick='javascript:deleteTSC(" + tscId + "," + tsId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                    }
                    tsName = tsName + "</td></tr><tr ><td colspan=4 > <div id='ptc" + uniqueId + "'></div></td></tr>";
                } else {
                    tsName = tsName + "<tr id='" + tscId + "' style='background-color:" + color + ";'><td style='width:1%;'><div id=" + uniqueId + " onclick=javascript:showComments('" + key + "','" + tsId + "'); style='margin-left:2px;width:30px;bgcolor:red;' class='treeclass'></div></td>  <td><input type='hidden' id='tscId' value='" + testScript + "'><a href='javascript:void(0)' class='up'><img style='position: realtive;cursor:pointer;' src='./images/up_arrow.png'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' class='down'><img style='position: realtive;cursor:pointer;' src='./images/down_arrow.png'/></a> </td><td>" + testScript + " </td><td>" + expRslt + " </td><td>" + createdBy + "</td><td>" + ptcId + "";
                    if (url.equalsIgnoreCase("eminentlabs.net")) {
                        tsName = tsName + "<span id='deletetsc" + tscId + "' onclick='javascript:deleteTSC(" + tscId + "," + tsId + ");'><img style='position: realtive;cursor:pointer;margin-left:10px;' src='/eTracker/images/close.png'/></span>";
                    }
                    tsName = tsName + "</td></tr><tr ><td colspan=4 > <div id='ptc" + uniqueId + "'></div></td></tr>";
                }

                i++;
            }
        }
        if (url.equalsIgnoreCase("eminentlabs.net")) {
                tsName = "<ul><li class='lasttestscript'><table id='" + tsId + "' class='tscMap' style='border:solid 1px #696969'; style='width:50%'><tr style='background-color: #C3D9FF;'><td style='width:1%;'></td><td></td><td><b>Test Script</b></td><td><b>Expected Result</b></td><td><b>Created By</b></td><td><b>Status</b></td></tr>" + tsName + "<tr><td colspan='2'><a href='#' onclick='javascript:showTSC(" + tsId + ");return false;' style='margin-left:3px;color:#C0C0C0;'> Add Test Script</a></td><td><a href='./uploadTscExcel.jsp?tsId=" + tsId + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' >Upload Test Script</a></td></tr></table></li></ul>";
        } else {
            tsName = "<ul><li class='lasttestscript'><table id='" + tsId + "' style='border:solid 1px #696969'; style='width:50%'><tr style='background-color: #C3D9FF;'><td style='width:1%;'></td><td></td><td><b>Test Script</b></td><td><b>Expected Result</b></td><td><b>Created By</b></td><td><b>Status</b></td></tr>" + tsName + "<tr><td></td><td></td><td></td></tr></table></li></ul>";
        }
    } else {
        if (url.equalsIgnoreCase("eminentlabs.net")) {
            tsName = "<ul><li class='lasttestscript'><a href='#' onclick='javascript:showTSC(" + tsId + ");return false;' style='margin-left:0px;color:#C0C0C0;'> Add Test Script</a><a href='./uploadTscExcel.jsp?tsId=" + tsId + "'  style='margin-left:10px;color:#C0C0C0;text-decoration:none;' >Upload Test Script</a></li></ul>";
        } else {
            tsName = "<ul></ul>";
        }
    }
    out.print(tsName);

%>
