<%-- 
    Document   : apmTeam
    Created on : Jun 23, 2014, 10:47:26 AM
    Author     : E0288
--%>

<%@page import="java.math.BigDecimal"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.issue.ApmComponent"%>
<%@page import="com.eminent.issue.ApmTeam"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("maintainWrmDays");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=1" type="text/css" rel=STYLESHEET>
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
            function incrTeam() {
                var table = document.getElementById('teamtable');
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
                    appre.name = "team";
                    appre.size = "25";
                    appre.maxLength = "12";
                    cell2.appendChild(appre);
                    var sub = document.createElement("img");
                    sub.src = "/eTracker/images/remove.gif";
                    sub.id = "remove";
                    sub.alt = "Remove";
                    sub.onclick = new Function("javascript:decrTeam('id" + rowCount + "');");
                    sub.title = "Remove Team";
                    cell2.appendChild(sub);
                    row1.appendChild(cell1);
                    row1.appendChild(cell2);
                }
            }
            function decrTeam(row) {
                var tables = document.getElementById("teamtable");
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
            var allteams;
            function getAllTeam() {
                xmlhttp = createRequest();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/retrieveAll.jsp?action=retrieve&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                        callbackAllTeam();
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
            }
            function callbackAllTeam() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        allteams = comp;

                    }
                }
            }
            function createTeam() {
                getAllTeam();
                var addedTeams = "";
                var teams = document.getElementsByName('team');
                for (var i = 0; i < teams.length; i++) {
                    if (trim(teams[i].value) === '')
                    {
                        document.getElementById('errormsg').style.display = 'block';
                        teams[i].focus();
                        return false;
                    }
                    for (var j = 0; j < teams.length; j++) {
                        if (i !== j) {
                            if (trim(teams[i].value.toUpperCase()) === trim(teams[j].value.toUpperCase())) {
                                document.getElementById('errormsg').style.display = 'block';
                                teams[j].value = '';
                                teams[j].focus();
                                return false;
                            }
                        }
                    }
                    if (allteams != undefined) {
                        var allteam = allteams.split(",");
                        for (var k = 0; k < allteam.length; k++) {
                            if (trim(allteam[k].toUpperCase()) === trim(teams[i].value.toUpperCase())) {
                                document.getElementById('errormsg').style.display = 'block';
                                teams[i].focus();
                                return false;
                            }
                        }
                    }
                    addedTeams = addedTeams + trim(teams[i].value) + ",";
                }
                if (addedTeams.length > 2) {
                    addedTeams = addedTeams.substring(0, addedTeams.length - 1);
                }
                xmlhttp = createRequest();
                if (xmlhttp !== null) {

                    xmlhttp.open("GET", "/eTracker/admin/project/createTeam.jsp?action=Create&team=" + encodeURIComponent(addedTeams) + "&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                        callbackTeam();
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }

                $('#overlay').fadeOut('fast', 'swing');
                $('#teampopup').fadeOut('fast', 'swing');


            }
            function callbackTeam() {
                $('#overlay').fadeOut('fast', 'swing');
                $('#teampopup').fadeOut('fast', 'swing');
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        $('#apmTeamTable').append(comp);
                    }

                }
            }
            function addTeam() {
                $('#overlay').attr('height', $(window).height());
                $('#overlay').fadeIn('fast', 'swing');
                $('#teampopup').fadeIn('fast', 'swing');
            }
            ;
            function closeTeam() {
                $('#overlay').fadeOut('fast', 'swing');
                $('#teampopup').fadeOut('fast', 'swing');

            }
            function editTeam(editeamid) {
                document.getElementById('teamId').value = editeamid;
                var teamvalue = document.getElementById('teamValue' + editeamid).value;
                document.getElementById('editteam').value = teamvalue;
                $('#overlay').fadeIn('fast', 'swing');
                $('#teamEditpopup').fadeIn('fast', 'swing');
            }
            function closeEditTeam() {
                document.getElementById('editteam').value = '';
                $('#overlay').fadeOut('fast', 'swing');
                $('#teamEditpopup').fadeOut('fast', 'swing');

            }

           function deleteTeam(teamId) {
                getComponentByTeamId(teamId);
            }
            function getComponentByTeamId(teamId) {
                $("#apmComponentTable").find("tr:gt(0)").remove();
                document.getElementById('componentTeamId').value = teamId;
                var componentTeamId = document.getElementById('componentTeamId').value;
                xmlhttp = createRequest();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/retrieveAllone.jsp?componentTeamId=" + componentTeamId + "&action=retrieve&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                var comp = xmlhttp.responseText;
                                allcomponents = comp;
                                var count = allcomponents.length;
                                if (count > 0) {
                                    confirm("Team Deletion is Not Possible");
                                }
                                else if (count <= 0) {
                                    deletion(teamId);
                                }

                            }

                        }
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
            }

            function deletion(teamId) {
                if (confirm("Do you want to delete Team?"))
                {  
                $('#apmteamId' + teamId).remove();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/createTeam.jsp?teamId=" + teamId + "&action=delete&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
            }
        }
            function updateTeam() {
                getAllTeam();
                var teamId = document.getElementById('teamId').value;
                var prevTeam = document.getElementById('teamValue' + teamId).value;
                var teamName = document.getElementById('editteam').value;

                if (trim(teamName) === '')
                {
                    document.getElementById('editcerrormsg').style.display = 'block';
                    document.getElementById('editcname').focus();
                    return false;
                }
               if (allteams != undefined) {
                    var allteam = allteams.split(",");
                    for (var k = 0; k < allteam.length; k++) {
                        if (trim(prevTeam.toUpperCase()) != trim(allteam[k].toUpperCase())) {
                            if (trim(allteam[k].toUpperCase()) == trim(teamName.toUpperCase())) {
                                document.getElementById('editcerrormsg').style.display = 'block';
                                document.getElementById('editteam').focus();
                                return false;
                            }
                        }
                    }
                }
                document.getElementById('teamValue' + teamId).value = teamName;
                document.getElementById('teamName' + teamId).innerHTML = teamName;
                closeEditTeam();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/createTeam.jsp?teamId=" + teamId + "&editteam=" + encodeURIComponent(teamName) + "&action=Update&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
            }
            function updateComponent() {
                getAllComponent();
                var componentId = document.getElementById('componentId').value;
                var componentTeamId=document.getElementById('componentTeamId').value;
                var prevComponent = document.getElementById('componentValue' + componentId).value;
                var componentName = document.getElementById('editcomponent').value;
                    if (trim(componentName) === '')
                {
                    document.getElementById('editcerrormsgs').style.display = 'block';
                    document.getElementById('editcname').focus();
                    return false;
                } 
                if (allcomponents != undefined) {
                    var allcomponent = allcomponents.split(",");
                       for (var k = 0; k < allcomponent.length; k++) {
                              if (trim(prevComponent.toUpperCase()) !== trim(allcomponent[k].toUpperCase())) {
                               if (trim(allcomponent[k].toUpperCase()) === trim(componentName.toUpperCase())) {
                                     document.getElementById('editcerrormsgs').style.display = 'block';
                                  document.getElementById('editcomponent').focus();
                                  return false;
                            }
                        }
                    }
                }
                document.getElementById('componentValue' + componentId).value = componentName;
                document.getElementById('componentName' + componentId).innerHTML = componentName;

                closeEditComponent();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/createComponent.jsp?componentId=" + componentId + "&editcomponent=" + encodeURIComponent(componentName) +"&componentTeamId="+componentTeamId+ "&action=Update&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }

            }

            function callbackAllComponent() {
                $('#overlay').attr('height', $(window).height());
                $('#overlay').fadeIn('fast', 'swing');
                $('#viewComponentpopup').fadeIn('fast', 'swing');
                 var componentTeamId = document.getElementById('componentTeamId').value;

                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                        allcomponents = comp;
                        var count = allcomponents.length;
                        $('#apmComponentTable').append(comp);

                    }


                }
            }
            function editComponent(editcomponentid) {
                document.getElementById('componentId').value = editcomponentid;
                var componentvalue = document.getElementById('componentValue' + editcomponentid).value;
                document.getElementById('editcomponent').value = componentvalue;
                $('#overlay').fadeIn('fast', 'swing');
                $('#componentEditpopup').fadeIn('fast', 'swing');
            }
            function deleteComponent(compId) {
                 document.getElementById('componentId').value = compId;
                      if (xmlhttp !== null) {
                        xmlhttp.open("GET", "/eTracker/admin/project/deleteComponent.jsp?componentId=" + compId + "&action=delete&rand=" + Math.random(1, 10), false);
                        xmlhttp.onreadystatechange = function() {
                             var comp = xmlhttp.responseText;
                             if(comp === "false"){
                                confirm("Deletion is Impossible");
                            }
                            else  
                            {
                                  $('#apmcomponentId' + compId).remove();
                                   
                                }
                        };
                        xmlhttp.send(null);
                    } else {
                        alert('no ajax request');
                    }
                }

            
            function addComponent(teamId) {
                document.getElementById('componentTeamId').value = teamId;

                $('#overlay').attr('height', $(window).height());
                $('#overlay').fadeIn('fast', 'swing');
                $('#componentpopup').fadeIn('fast', 'swing');
            }

            function incrComponent() {
                var table = document.getElementById('componenttable');
                var teamId = document.getElementById('teamId').value;
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
                    appre.name = "component";
                    appre.size = "25";
                    appre.maxLength = "12";
                    cell2.appendChild(appre);
                    var sub = document.createElement("img");
                    sub.src = "/eTracker/images/remove.gif";
                    sub.id = "remove";
                    sub.alt = "Remove";
                    sub.onclick = new Function("javascript:decrComponent('id" + rowCount + "');");
                    sub.title = "Remove Component";
                    cell2.appendChild(sub);
                    row1.appendChild(cell1);
                    row1.appendChild(cell2);
                }

            }
            function decrComponent(row) {
                var tables = document.getElementById("componenttable");
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
            function createComponent() {
                getAllComponent();
                var addedComponents = "";
                var components = document.getElementsByName('component');
                var componentTeamId = document.getElementById('componentTeamId').value;
              for (var i = 0; i < components.length; i++) {
                    if (trim(components[i].value) === '')
                    {
                        document.getElementById('errormsgs').style.display = 'block';
                        components[i].focus();
                        return false;
                    }
                    for (var j = 0; j < components.length; j++) {
                        if (i !== j)
                        {
                           
                            if (trim(components[i].value.toUpperCase()) === trim(components[j].value.toUpperCase())) {
                               //document.writeln("check = " + components[i].value.toUpperCase() + " oth = " + components[j].value.toUpperCase());
                                 document.getElementById('errormsgs').style.display = 'block';
                                components[j].value = '';
                                components[j].focus();
                                return false;
                            }
                        }
                    }
                    var c;
                    if (allcomponents !== undefined) {
                        var allcomponent = allcomponents.split(",");
                        for (var k = 0; k < allcomponent.length; k++) {
                            if (trim(allcomponent[k].toUpperCase()) === trim(components[i].value.toUpperCase())) {
                                c=components[i].value;
                                 document.getElementById('errormsgs').style.display = 'block';
                                 document.getElementById('errormsgs').innerHTML= c +" is Duplicate Element";
                                 components[i].focus();
                                return false;
                            }
                        }
                    }
                    addedComponents = addedComponents + trim(components[i].value) + ",";
                }
                if (addedComponents.length > 2) {
                    addedComponents = addedComponents.substring(0, addedComponents.length - 1);
                }
                xmlhttp = createRequest();
                if (xmlhttp !== null) {

                    xmlhttp.open("GET", "/eTracker/admin/project/createComponent.jsp?componentTeamId=" + componentTeamId + "&component=" + encodeURIComponent(addedComponents) + "&action=create&rand=" + Math.random(1, 10), false);
                    //    xmlhttp.open("GET", "/eTracker/admin/project/createComponent.jsp?action=create&component=" + encodeURIComponent(addedComponents) + "&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                         callbackComponent();
                  };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
                $('#overlay').fadeOut('fast', 'swing');
                $('#componentpopup').fadeOut('fast', 'swing');
            }
            function callbackComponent() {
                if (xmlhttp.readyState === 4)
                {
                    if (xmlhttp.status === 200)
                    {
                        var comp = xmlhttp.responseText;
                          allcomponents=comp;
                       // $('#apmComponentTable').append(comp);
                    }

                }
            }
            function closeComponent() {
                $('#overlay').fadeOut('fast', 'swing');
                $('#componentpopup').fadeOut('fast', 'swing');
           
            }
            function closeViewComponent() {
             
                $('#overlay').fadeOut('fast', 'swing');
                $('#viewComponentpopup').fadeOut('fast', 'swing');
            }

            var allcomponents;
            function getAllComponent() {
                  var componentTeamId = document.getElementById('componentTeamId').value;
                xmlhttp = createRequest();
                if (xmlhttp !== null) {
                 
                       xmlhttp.open("GET", "/eTracker/admin/project/retrieveComponents.jsp?&action=retrieveAll&rand=" + Math.random(1, 10), false);
                       xmlhttp.onreadystatechange = function() {
                        callbackComponent();
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
            }
            function getComponentsByTeamId(teamId) {
                $("#apmComponentTable").find("tr:gt(0)").remove();
                document.getElementById('componentTeamId').value = teamId;
                var componentTeamId = document.getElementById('componentTeamId').value;
               xmlhttp = createRequest();
                if (xmlhttp !== null) {
                    xmlhttp.open("GET", "/eTracker/admin/project/retrieveAllone.jsp?componentTeamId=" + componentTeamId + "&action=retrieve&rand=" + Math.random(1, 10), false);
                    xmlhttp.onreadystatechange = function() {
                        callbackAllComponent();
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }
             }
            function closeEditComponent() {
                document.getElementById('editcomponent').value = '';
                $('#overlay').fadeOut('fast', 'swing');
                $('#componentEditpopup').fadeOut('fast', 'swing');
            }
        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
        <jsp:useBean id="atc" class="com.eminent.issue.controller.ApmTeamController"/>
        <%atc.setAll(request);%>
        <jsp:useBean id="atc1" class="com.eminent.issue.controller.ApmComponentController"/>
          <%atc1.setAll(request);%>
        <div style="width: 100%;background-color: #C3D9FE;font-weight: bold;">Centralized Team Maintenance </div>
        <br/>
        <table width="100%" border="0">
            <tr>
                <td>
                    <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" style="cursor: pointer;font-weight: bold;">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                    <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                    <a href="<%=request.getContextPath()%>/admin/project/maintainIssueCategory.jsp" style="cursor: pointer;">Issue Category</a>
                    <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                   <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  
                </td>
                <td></td>
            </tr>
        </table>
        <br/>
        <div>The below list shows total available teams</div>
        <div  style="width: 100%;">
            <table id="apmTeamTable" style="width: 50%;">
                <tr style="background-color: #C3D9FE;">
                    <td colspan="3" style="text-align: right;"><span style="color: blue;font-weight: bold;cursor: pointer;" onclick="addTeam();">Add Teams</span></td> 
                </tr>
                <tr  style="background-color: #C3D9FE;font-weight: bold;height:21px;">
                    <td style="width: 10%;">Team Id</td>
                    <td style="width: 20%;">Team</td>
                    <td style="width: 20%;">Manage</td>
                </tr>
                <%int i = 0;
                    for (ApmTeam apmTeam : atc.findAllTeams()) {
                        i++;
                        if (i % 2 == 0) {%>
                <tr style="height:21px;" bgcolor="#E8EEF7" id="apmteamId<%=apmTeam.getTeamId()%>">
                    <%} else {%>
                <tr style="height:21px;" id="apmteamId<%=apmTeam.getTeamId()%>">
                    <%}
                    %>

                    <td style="width: 10%;"><%=apmTeam.getTeamId()%></td>
                    <td style="width: 30%;" id="teamName<%=apmTeam.getTeamId()%>"><%=apmTeam.getTeamName()%></td>
                    <td style="width: 40%;">
                        <input type="hidden" name="componentTeamId" id='componentTeamId' value=""/>  
                        <input type="hidden" name="teamValue<%=apmTeam.getTeamId()%>" id="teamValue<%=apmTeam.getTeamId()%>" value="<%=apmTeam.getTeamName()%>"><span onclick="editTeam('<%=apmTeam.getTeamId()%>');" style="color: blue;cursor: pointer; ">Edit</span> || <span onclick="deleteTeam('<%=apmTeam.getTeamId()%>');" style="color: blue;cursor: pointer;">Delete</span> || <span onclick="addComponent('<%=apmTeam.getTeamId()%>');" style="color: blue;cursor: pointer;">Add Components</span> ||<span onclick="getComponentsByTeamId('<%=apmTeam.getTeamId()%>');" style="color: blue;cursor: pointer;">View Components</span> </td></td>
                </tr>
                <%}%>
            </table>
        </div>
        <div id="overlay"></div>
        <div id="teampopup" class="popup">
            <form name="theForm" id="theheForm" method="post" >
                <h3 class="popupHeading">Add Teams</h3>
                <div >
                    <div style="color:red;display: none;" id="errormsg">Please enter the correct team name with out duplicate</div>
                    <p><input type="button"  id="addissue" value="Add Team" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:incrTeam();"> &nbsp;&nbsp;&nbsp;</p>
                    <hr />
                    <!-- Update form action -->
                    <table id="teamtable" >
                        <tr id="id0" style="font-weight: bold;">
                            <td width='25px' >Sl. N</td>
                            <td >Team Name</td>
                        </tr>
                        <tr id="id1" style="height: 20px;">
                            <td width='25px' >1</td>
                            <td colspan="2" id="cellid1">
                                <input type="text" name="team" id='team' size="25" maxlength="50"/>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td colspan="3" align="right">
                                <input type="hidden" name="action" value="Create"/>
                                <input type="button" value="Create Team" onclick='return createTeam(this);'/>
                                <button class="custom-popup-close" onclick="javascript:closeTeam();" type="button">close</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>

        <div id="viewComponentpopup" class="popup"> 
            <h3 class="popupHeading">View Components</h3>
            <br/>
            <div>The below list shows total available components are</div>
            <br/>
            <div class="clear"></div>
            <div class="tableshow">
            <div  style="width: 100%;" class="mid" id="MDAVpopupFiles">
                   <table id="apmComponentTable" style="width: 100%;">
                    <tr  style="background-color:#C3D9FE;font-weight: bold;height:21px;">
                        <td style="width: 20%;">Component Id</td>
                        <td style="width: 20%;">Component</td>
                        <td style="width: 25%;">Manage</td>
                        
                    </tr>
                  <%  int j = 0;
                     String componentTeamId;
             for (ApmComponent apmComponent : atc1.getComponentList()) {
                            j++;
                         if (j % 2 == 0) {
                  %>
                    <tr style="height:21px;" bgcolor="#E8EEF7" id="apmcomponentId<%=apmComponent.getComponentId()%>">
                        <%} else  {%>
                    <tr style="height:21px;" bgcolor="#E8EEF7"  id="apmcomponentId<%=apmComponent.getComponentId()%>">
                        <%}
                        %>
                        <td style="width: 10%;"><%=apmComponent.getComponentId()%></td>
                        <td style="width: 30%;" id="componentName<%=apmComponent.getComponentId()%>"><%=apmComponent.getComponentName()%></td>
                        <td style="width: 40%;">
                            <span onclick="editComponent('<%=apmComponent.getComponentId()%>');" style="color: blue;cursor: pointer; ">Edit</span> || <span onclick="deleteComponent('<%=apmComponent.getComponentId()%>');" style="color: blue;cursor: pointer;">Delete</span> </td></td>
                    </tr>

                    <%}%>

                </table>
            </div> 
                     <button class="custom-popup-close" onclick="javascript:closeViewComponent();" type="button">close</button>
            </div></div>
        <div id="teamEditpopup" class="popup">
            <h3 class="popupHeading">Edit Team</h3>
            <div>
                <div style="color:red;display: none;" id="editcerrormsg">Please enter the correct Team name with out duplicate</div>
                <p>Edit Team Name</p>
                <hr />
                <!-- Update form action -->
                <table>
                    <tr>
                        <td>
                            <label for="pswd">Team Name</label>
                        </td>
                        <td colspan="2">
                            <input type="text" name="editteam" id='editteam' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <input type="hidden" name="teamId" id="teamId" maxlength="50" value=""/>
                            <input type="submit" value="Update Team" onclick='return updateTeam(this);'/>
                           <button class="custom-popup-close" onclick="javascript:closeEditTeam();" type="button">close</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%} else {%>
        <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
        <%}%>

        <div id="overlay"></div>
        <div id="componentpopup" class="popup">
            <form name="theForm" id="theheForm" method="post" >
                <h3 class="popupHeading">Add Components</h3>
                <div >
                    <div style="color:red;display: none;" id="errormsgs"> Please enter the correct Component name with out duplicate..</div>
                    <p><input type="button" id="addissue" value="Add Component" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:incrComponent();"> &nbsp;&nbsp;&nbsp;</p>
                    <hr />
                    <table id="componenttable" >
                        <tr id="id0" style="font-weight: bold;">
                            <td width='25px' >Sl. N</td>
                            <td >Component Name</td>
                        </tr>
                        <tr id="id1" style="height: 20px;">
                            <td width='25px' >1</td>
                            <td colspan="2" id="cellid1">
                                <input type="text" name="component" id='component' size="25" maxlength="50"/>
                                <input type="hidden" name="componentTeamId" id='componentTeamId' value=""/>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td colspan="3" align="right">
                                <input type="hidden" name="action" value="Create"/>
                                <input type="button" value="Create Component" onclick='return createComponent(this);'/>
                              <button class="custom-popup-close" onclick="javascript:closeComponent();" type="button">close</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
        <div id="componentEditpopup" class="popup">
            <h3 class="popupHeading">Edit Component</h3>
            <div>
                <div style="color:red;display: none;" id="editcerrormsgs">Please enter the correct Component name with out duplicate</div>
                <p>Edit Component Name</p>
                <hr />
                <!-- Update form action -->
                <table>
                    <tr>
                        <td>
                            <label for="pswd">Component Name</label>
                        </td>
                        <td colspan="2">
                            <input type="text" name="editcomponent" id='editcomponent' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <input type="hidden" name="componentTeamId" id="componentTeamId" value=""/>
                            <input type="hidden" name="componentId" id="componentId" value=""/>
                            <input type="submit" value="Update Component" onclick='return updateComponent(this);'/>
                            <button class="custom-popup-close" onclick="javascript:closeEditComponent();" type="button">close</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </table>
</body>
</html>
