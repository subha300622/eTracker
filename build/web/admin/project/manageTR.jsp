<%-- 
    Document   : manageTR
    Created on : 13 Jul, 2015, 12:32:21 PM
    Author     : EMINENT
--%>

<%@page import="java.util.List"%>
<%@page import="com.eminent.issue.ApmTrFormat"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=18072016" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript">
        var xmlhttp = createRequest();
        function trim(str)
        {
            while (str.charAt(str.length - 1) === " ") {
                str = str.substring(0, str.length - 1);
            }
            while (str.charAt(0) === " ") {
                str = str.substring(1, str.length);
            }
            return str;
        }
        function addTrFormat(pid) {
                                        document.getElementById('editerrormsgs').style.display = 'none';

            document.getElementById('TrformatpId').value = pid;
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#trFormatpopup').fadeIn('fast', 'swing');
        }
        function closeTrFormat() {
            $('#overlay').fadeOut('fast', 'swing');
            $('#trFormatpopup').fadeOut('fast', 'swing');

        }
        function incrTrFormat() {
            var table = document.getElementById('trFormattable1');
            var rowCount = table.rows.length;
            if (rowCount < 11) {
                var row1 = table.insertRow(rowCount);
                var idno = rowCount;
                row1.id = "id" + idno;
                var cell1 = document.createElement('td');
                cell1.id = "cellid" + idno;
                cell1.width = "25px";
                var lable1 = document.createTextNode(idno);
                cell1.appendChild(lable1);
                var cell2 = document.createElement('td');
                cell2.align = "left";
                var appre = document.createElement("input");
                appre.name = "trFormat";
                appre.size = "25";
                appre.maxLength = "12";
                cell2.appendChild(appre);

                var x = document.createElement("SELECT");
                x.setAttribute("id", "trType");
                x.name = "trType";
                cell2.appendChild(x);
                var opt = document.createElement('option');
                opt.value = "";
                opt.innerHTML = "Type";
                x.appendChild(opt);

                opt = document.createElement('option');
                opt.value = "0";
                opt.innerHTML = "Numeric";
                x.appendChild(opt);


                opt = document.createElement('option');
                opt.value = "1";
                opt.innerHTML = "Alphanumeric";
                x.appendChild(opt);

                var sub = document.createElement("img");
                sub.src = "/eTracker/images/remove.gif";
                sub.id = "remove";
                sub.alt = "Remove";
                sub.onclick = new Function("javascript:decrTrFormat('id" + rowCount + "');");
                sub.title = "Remove TrFormat";
                cell2.appendChild(sub);
                row1.appendChild(cell1);
                row1.appendChild(cell2);
            }
        }
        function decrTrFormat(row) {
            var tables = document.getElementById("trFormattable1");
            var rows = tables.rows.length;
            var removed = 'false';

            for (var i = 0; i < rows; i++) {
                if (tables.rows[i] != undefined) {
                    if (tables.rows[i].id == row)
                    {
                        tables.deleteRow(i);
                        i--;
                        removed = true;
                    }
                    if (removed == true) {
                        if (i < (rows - 1)) {
                            tables.rows[i].cells[0].innerHTML = i;
                        }
                    }
                }
            }
        }

        var alltrFormats;
        function createTrFormat() {
                            document.getElementById('editerrormsgs').style.display = 'none';

            var addedTrFormats = "", addedTrFormat = "";
            var TrformatpId = document.getElementById('TrformatpId').value;
            var trFormats = document.getElementsByName('trFormat');
            var trTypes = document.getElementsByName('trType');
            getAllTrFormat(TrformatpId);
            for (var i = 0; i < trFormats.length; i++) {
                if (trim(trFormats[i].value) === '')
                {
                    document.getElementById('errormsgtrformat').style.display = 'block';
                    trFormats[i].focus();
                    return false;
                }
                if (trim(trTypes[i].value) === '')
                {
                    document.getElementById('errormsgtrformat').style.display = 'block';
                    trTypes[i].focus();
                    return false;
                }
                for (var j = 0; j < trFormats.length; j++) {
                    if (i !== j) {
                        if (trim(trFormats[i].value.toUpperCase()) === trim(trFormats[j].value.toUpperCase()) && trTypes[i].value === trTypes[j].value) {
                            document.getElementById('errormsgtrformat').style.display = 'block';
                            trFormats[j].value = '';
                            trFormats[j].focus();
                            return false;
                        }
                    }
                }
                var c;
                if (alltrFormats !== undefined) {
                    var alltrFormat = alltrFormats.split(",");
                    for (var k = 0; k < alltrFormat.length; k++) {
                        if (trim(alltrFormat[k].split("-")[0].toUpperCase()) === trim(trFormats[i].value.toUpperCase()) && trim(alltrFormat[k].split("-")[1].toUpperCase()) === trim(trTypes[i].value.toUpperCase())) {
                            c = trFormats[i].value;
                            document.getElementById('errormsgtrformat').style.display = 'block';
                            document.getElementById('errormsgtrformat').innerHTML = c + " is Duplicate Element";
                            trFormats[i].focus();
                            return false;
                        }
                    }
                }
                addedTrFormats = addedTrFormats + (trFormats[i].value) + "-" + (trTypes[i].value) + ",";
                if (trTypes[i].value === "0") {
                    addedTrFormat = addedTrFormat + (trFormats[i].value) + "-Numeric,";
                } else {
                    addedTrFormat = addedTrFormat + (trFormats[i].value) + "-Alphanumeric,";
                }
            }
            if (addedTrFormats.length > 2) {
                addedTrFormats = addedTrFormats.substring(0, addedTrFormats.length - 1);
                addedTrFormat = addedTrFormat.substring(0, addedTrFormat.length - 1);

            }
            var dvalue = document.getElementById('trProjectFormat' + TrformatpId).innerHTML.trim();
            if (dvalue === "") {
                $('#trProjectFormat' + TrformatpId).val(addedTrFormat);
                $('#trProjectFormat' + TrformatpId).append(addedTrFormat);
                // $('#trProjectFormat' + TrformatpId).val(addedTrFormats + "," + dvalue);
            } else {
                    $('#trProjectFormat' + TrformatpId).append("," + addedTrFormat);

            }

            xmlhttp = createRequest();
            if (xmlhttp !== null) {

                xmlhttp.open("GET", "/eTracker/admin/project/createTrFormat.jsp?TrformatpId= " + TrformatpId + "&trFormat= " + encodeURIComponent(addedTrFormats) + "&action=create&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {

                    callbackTrFormat();
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }

            $('#overlay').fadeOut('fast', 'swing');
            $('#trFormatpopup').fadeOut('fast', 'swing');


        }
        function callbackTrFormat() {
            $('#overlay').fadeOut('fast', 'swing');
            $('#trFormatpopup').fadeOut('fast', 'swing');
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var trFormat = xmlhttp.responseText;

                    $('#trFormatTable').append(trFormat);

                }

            }
        }
        var alltrFormats;
        function getAllTrFormat(pid) {
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/admin/project/retrieveAlltrFormats.jsp?TrformatpId=" + pid + "&action=retrieve&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackAllTrFormat();
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }
        }
        function callbackAllTrFormat() {
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var trFormat = xmlhttp.responseText;
                    alltrFormats = trFormat;
                }
            }
        }
        function getTrFormatByPid(editpid) {
            $("#apmTrFormatTable").find("tr:gt(0)").remove();
            document.getElementById('TrformatpId').value = editpid;

            var TrformatpId = document.getElementById('TrformatpId').value;
            xmlhttp = createRequest();
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/admin/project/retrieveTrFormatone.jsp?TrformatpId=" + TrformatpId + "&action=retrieveone&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    callbackAllTrFormats();
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }

        }
        var value1;
        function closeEditTrFormat() {

            document.getElementById('edittrFormat').value = '';
            $('#overlay').fadeOut('fast', 'swing');
            $('#viewComponentpopup').fadeOut('fast', 'swing');
        }
        function callbackAllTrFormats() {
            $('#overlay').attr('height', $(window).height());
            $('#overlay').fadeIn('fast', 'swing');
            $('#viewComponentpopup').fadeIn('fast', 'swing');
            //  var TrformatpId = document.getElementById('TrformatpId').value;

            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var formats = xmlhttp.responseText;
                    alltrFormats = formats;

                    $('#apmTrFormatTable').append(formats);

                }


            }
        }
        function DeleteTrFormat(TrformatpId, pid) {

            var searchString = document.getElementById('trFormats' + TrformatpId).innerHTML + "-" + document.getElementById('trTypes' + TrformatpId).innerHTML;

            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/admin/project/createTrFormat.jsp?TrformatpId=" + TrformatpId + "&action=delete&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {
                    $('#apmTrformatId1' + TrformatpId).remove();
                    var ele = document.getElementById('trProjectFormat' + pid).innerText;
                    searchString = $.trim(searchString);
                    ele = $.trim(ele);
                    ele = ele.replace(searchString, "");
                    ele = $.trim(ele);
                    var lastChar = ele.substr(ele.length - 1);
                    var firstChar = ele.substr(0, 1);
                    ele = ele.replace(", ,", ",");
                    ele = ele.replace(",,", ",");
                    if (lastChar == ',') {
                        ele = ele.substr(0, ele.length - 1);
                    } else if (firstChar == ',') {
                        ele = ele.substr(1, ele.length);
                    } else {

                    }
                    $('#trProjectFormat' + pid).html(ele);
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }
        }
        function editcrid(editTrid, pid) {
                            document.getElementById('editerrormsgs').style.display = 'none';

            document.getElementById('TrformatpId').value = editTrid;
            var TrformatpId = document.getElementById('TrformatpId').value;
            document.getElementById('pid').value = pid;
            var trvalue = document.getElementById('trFormats' + TrformatpId).innerHTML;
            var trtype = document.getElementById('trTypes' + TrformatpId).innerHTML;
            document.getElementById('edittrFormat').value = trvalue;
            $('#edittrType option:contains("' + trtype + '")').prop('selected', true);

            $('#overlay').fadeIn('fast', 'swing');
            $('#trEditpopup').fadeIn('fast', 'swing');
        }

        function updateTrFormat() {

            var pid = document.getElementById('pid').value;
            getAllTrFormat(pid);
            var newFormat = "";
            var TrformatpId = document.getElementById('TrformatpId').value;
            var prevFormat = document.getElementById('trFormats' + TrformatpId).innerHTML;
            var prevTrType = document.getElementById('trTypes' + TrformatpId).innerHTML;
            var currentFormat = document.getElementById('edittrFormat').value;
            var currentTrType = document.getElementById('edittrType').value;
            var prevTrTypeval;
            if (trim(currentFormat) === '')
            {
                document.getElementById('editerrormsgs').style.display = 'block';
                document.getElementById('edittrFormat').focus();
                return false;
            }
            if (prevTrType == "Alphanumeric") {
                prevTrTypeval = "1";
            } else {
                prevTrTypeval = "0";
            }
            if (alltrFormats != undefined) {
                var allFormat = alltrFormats.split(",");

                for (var k = 0; k < allFormat.length; k++) {
                    if (trim(allFormat[k].split("-")[0].toUpperCase()) === trim(currentFormat.toUpperCase()) && currentTrType === allFormat[k].split("-")[1]) {
                        document.getElementById('editerrormsgs').style.display = 'block';
                        document.getElementById('editerrormsgs').innerHTML = currentFormat + " is Duplicate Element";
                        document.getElementById('edittrFormat').focus();
                        return false;
                    }
                }
            }

            currentFormat = trim(currentFormat);
            $('#trFormats' + TrformatpId).val(currentFormat);
            $('#trFormats' + TrformatpId).html(currentFormat);
            if (currentTrType === "0") {
                $('#trTypes' + TrformatpId).val("Numeric");
                $('#trTypes' + TrformatpId).html("Numeric");
                newFormat = currentFormat + "-Numeric";
            } else {
                $('#trTypes' + TrformatpId).val("Alphanumeric");
                $('#trTypes' + TrformatpId).html("Alphanumeric");
                newFormat = currentFormat + "-Alphanumeric";
            }
            var ele = document.getElementById('trProjectFormat' + pid).innerText;
            var elementposition = ele.indexOf(prevFormat + "-" + prevTrType);
            var elementposition1 = ele.indexOf(",", elementposition);
            if (elementposition1 > 0) {
                var updatelement = ele.substring(0, elementposition) + newFormat + ele.substring(elementposition1, ele.length);
            } else {
                var updatelement = ele.substring(0, elementposition) + newFormat;
            }
            $('#trProjectFormat' + pid).html(updatelement);
            currentFormat = currentFormat + "-" + currentTrType;
            if (xmlhttp !== null) {
                xmlhttp.open("GET", "/eTracker/admin/project/createTrFormat.jsp?TrformatpId=" + TrformatpId + "&pid=" + pid + "&edittrFormat=" + encodeURIComponent(currentFormat) + "&action=Update&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = function () {

                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }
            $('#overlay').fadeOut('fast', 'swing');
            $('#trEditpopup').fadeOut('fast', 'swing');

        }
        function closeEditFormat() {
            document.getElementById('edittrFormat').value = '';
            $('#overlay').fadeOut('fast', 'swing');
            $('#trEditpopup').fadeOut('fast', 'swing');

        }
    </script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <br/>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Manage TR Pattern</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp" >WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" style="font-weight: bold;">TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  


            </td>
            <td></td>

        </tr>
    </table>
    <br/>
    <jsp:useBean id="tr" class="com.eminent.issue.controller.TRDisplayController"/>
    <%Map<Integer, String> trType = tr.getTrTypes();%>
    <div id="ApmTrFormatdiv">
        <div id="div1">
            <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/admin/project/manageTR.jsp" onsubmit="disableSubmit();">

                <table id='trFormatTable' style="width: 60%">
                    <tr  height="21" style="font-weight: bold;background-color: #C3D9FF;">
                        <td width="40%">Project</td>
                        <td width="40%">TR Pattern</td>
                        <td width="20%">Manage</td>
                    </tr>
                    <%int i = 0;
                        for (Map.Entry<Long, String> entry : tr.getProjects().entrySet()) {
                            String format = tr.findByPid(entry.getKey());
                            String[] formatSplit = format.split(",");

                            if ((i % 2) != 0) {
                    %>
                    <tr  bgcolor="#E8EEF7" height="21">
                        <%                     } else {
                        %>

                    <tr bgcolor="white" height="21">
                        <%                    }
                            i++;
                        %>

                        <td width="40%" ><input type="hidden" name="pid" value="<%=entry.getKey()%>"> <%=entry.getValue()%><div class="treeclass" onclick="javascript:addTrFormat('<%=entry.getKey()%>');"></div></td>

                        <td width="40%" id="trProjectFormat<%=entry.getKey()%>" > 

                            <%=format%>

                        </td>
                        <td width="20%">    <span onclick="getTrFormatByPid('<%=entry.getKey()%>');" style="color: blue;cursor: pointer; ">Edit</span> </td>
                    </tr>
                    <%}%>
                    <%--   <tr style="text-align: center;"><td colspan="2" ><input type="submit" id="submit" value="Submit"/></td></tr>--%>
                </table></div></div>
</form>
<div id="overlay"></div>
<div id="trFormatpopup" class="popup">
    <form name="theForm" id="theheForm" method="post" >
        <h3 class="popupHeading">Add TR Pattern</h3>
        <div >
            <div style="color:red;display: none;" id="errormsgtrformat">Please enter the correct TR Pattern with out duplicate</div>
            <p><input type="button"  id="addissue" value="Add TR Pattern" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:incrTrFormat();"> &nbsp;&nbsp;&nbsp;</p>
            <hr />
            <table id="trFormattable1" >
                <tr id="id0" style="font-weight: bold;">
                    <td width='25px' >Sl. N</td>
                    <td >TR Pattern</td>
                </tr>
                <tr id="id1" style="height: 20px;">
                    <td width='25px' >1</td>
                    <td colspan="2" id="cellid1">
                        <input type="text" name="trFormat" id='trFormat' size="25" maxlength="50"/>
                        <select name="trType" id="trType">
                            <option value="">Type</option>
                            <%for (Map.Entry<Integer, String> entry : trType.entrySet()) {%>
                            <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                            <%}%>
                        </select>                                
                        <input type="hidden" name="TrformatpId" id='TrformatpId' value=""/>
                    </td>                        
                </tr>
            </table>
            <table>
                <tr>
                    <td colspan="3" align="right">
                        <input type="hidden" name="action" value="Create"/>
                        <input type="button" value="Create TR Pattern" onclick='return createTrFormat(this);'/>
                        <button class="custom-popup-close" onclick="javascript:closeTrFormat();" type="button">close</button>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
<div id="viewComponentpopup" class="popup" style="height:400px"> 
    <h3 class="popupHeading">Edit TR Pattern</h3>
    <br/>
    <div>The below list shows TR Patterns of Projects are</div>
    <br/>
    <div class="clear"></div>
    <div class="tableshow">
        <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
            <table id="apmTrFormatTable" style="width: 100%;">
                <tr style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                    <td  style="width: 20%;">TR Pattern Id</td>
                    <td  style="width: 30%;">TR Pattern</td>
                    <td  style="width: 40%;">TR Type</td>
                    <td style='width: 10%'>Manage</td>
                </tr>
                <%     int j = 0;

                    List<ApmTrFormat> l = tr.findAll();
                    for (ApmTrFormat apmTrFormat : l) {
                %>
                <tr>
                    <td  class="<%=apmTrFormat.getId()%>"><img  src='/eTracker/images/edit.png' onclick="editcrid(<%=apmTrFormat.getPid()%>);" style="cursor: pointer;" ></img><%=apmTrFormat.getId()%></td>
                    <td  style="width: 30%;" id="trFormat<%=apmTrFormat.getId()%>"><%=apmTrFormat.getTrFormat()%></td>                   
                    <td  style="width: 30%;" id="trFormat<%=apmTrFormat.getId()%>"><%=apmTrFormat.getTrType()%></td>                   

                </tr>

                <%}%>
            </table>
        </div> 
        <button class="custom-popup-close" onclick="javascript:closeEditTrFormat();" type="button">close</button>
    </div></div>
<div id="trEditpopup" class="popup">
    <h3 class="popupHeading">Edit TR Pattern</h3>
    <div>
        <div style="color:red;display: none;" id="editerrormsgs">Please enter the correct TR Pattern with out duplicate</div>
        <p>Edit TR Pattern</p>
        <hr />

        <table>
            <tr>
                <td>
                    <label for="pswd">TR Pattern</label>
                </td>
                <td colspan="2">
                    <input type="text" name="edittrFormat" id='edittrFormat' />
                </td>
            </tr>
            <tr>
                <td>
                    <label for="pswd">TR Type</label>
                </td>
                <td colspan="2">
                    <select name="edittrType" id="edittrType">
                        <%for (Map.Entry<Integer, String> entry : trType.entrySet()) {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="right">
                    <input type="hidden" name="pid" id="pid" maxlength="50" value=""/>
                    <input type="hidden" name="trFormatpId" id="trFormatpId" maxlength="50" value=""/>
                    <input type="submit" value="Update TR Pattern" onclick='return updateTrFormat(this);'/>
                    <button class="custom-popup-close" onclick="javascript:closeEditFormat();" type="button">close</button>
                </td>
            </tr>
        </table>
    </div>
</div>


</body>
</html>
